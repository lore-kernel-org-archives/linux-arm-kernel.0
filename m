From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri, 31 Aug 2018 15:36:51 +0200
Subject: [PATCH net-next v3 02/10] net: mvpp2: phylink support
In-Reply-To: <20180827165058.GD30658@n2100.armlinux.org.uk>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
Message-ID: <20180831133651.GB32574@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Mon, Aug 27, 2018 at 05:50:59PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 17, 2018 at 10:29:31AM +0200, Antoine Tenart wrote:
> > +static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
> > +			     const struct phylink_link_state *state)
> > +{
> > +	struct mvpp2_port *port = netdev_priv(dev);
> > +
> > +	/* Check for invalid configuration */
> > +	if (state->interface == PHY_INTERFACE_MODE_10GKR && port->gop_id != 0) {
> > +		netdev_err(dev, "Invalid mode on %s\n", dev->name);
> > +		return;
> > +	}
> > +
> > +	netif_tx_stop_all_queues(port->dev);
> > +	if (!port->has_phy)
> > +		netif_carrier_off(port->dev);
> ...
> > +	/* If the port already was up, make sure it's still in the same state */
> > +	if (state->link || !port->has_phy) {
> > +		mvpp2_port_enable(port);
> > +
> > +		mvpp2_egress_enable(port);
> > +		mvpp2_ingress_enable(port);
> > +		if (!port->has_phy)
> > +			netif_carrier_on(dev);
> > +		netif_tx_wake_all_queues(dev);
> > +	}
> 
> The above appears to cause a problem when testing on a singleshot
> mcbin board - as a direct result of the above, I find that _all_
> the network devices apparently have link, including those which
> have no SFP inserted into the cage.  This results in debian jessie
> hanging at boot for over 1 minute while systemd tries to bring up
> all network devices.

OK, we should fix that. Removing the above code does work for most of
the configurations, including the double shot MacchiatoBin.

> Have you identified a case where mac_config() is called with the
> link up for which a major reconfiguration is required?  mac_config()
> will get called for small reconfigurations such as changing the
> pause parameters (which should _not_ require the queues to be
> restarted) but the link should always be down for major
> reconfigurations such sa changing the PHY interface mode.

With the above code remove one case did not worked anymore: when the
port is configured as a fixed-link because the SFP cage can't be
described and used (on the 7040-db and 8040-db boards). In such cases
phylink is called, mac_config() is called, but link_up() is never
called. I'm not sure this is actually an issue in phylink, but the PPv2
driver should probably take care of this weird case itself (by calling
explicitly link_up()). What do you think?

> mac_config() can also be called when nothing has changed - if we've
> decided to re-run the link state resolve, it can be called with the
> same parameters as previously, especially now that we have polling
> of a GPIO for link state monitoring.  With your code above, this will
> cause mvpp2 to down/up the carrier state every second.

OK, that's bad.

> Note that state->link here is the _future_ state of the link, which
> may change state before the mac_link_up()/down() functions have been
> called - turning the carrier on/off like this will prevent these
> callbacks being made, and the link state being printed by phylink.

OK. Hopefully the fix will drop all use of state->link.


I've made a patch (see below) to stop messing with the carrier link
state in mac_config(), while also fixing the fixed-link handling
directly from within the PPv2 driver. If the patch is OK for you, I'll
sent it upstream to the net tree.

-- >8 --
>From 55ee933e259095d68b9bcae21f69d672e783a813 Mon Sep 17 00:00:00 2001
From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Fri, 31 Aug 2018 14:05:02 +0200
Subject: [PATCH] net: mvpp2: let phylink manage the carrier state

Net drivers using phylink shouldn't mess with the link carrier
themselves and should let phylink manage it. The mvpp2 driver wasn't
following this best practice as the mac_config() function made calls to
change the link carrier state. This led to wrongly reported carrier link
state which, according to Russell, increased a lot the Debian Jessie
boot time as systemd tried to bring up all those interfaces.

This patch fixes this behaviour.

As parts of the driver relied on this misbehaviour from the mac_config()
function, they were fixed as well to call the link_up() function. Also,
the fixed-link configuration relied on the mac_config() function to mess
with the link carrier state. As it does not anymore, if this mode is
used the link_up() function is called explicitly.

Fixes: 4bb043262878 ("net: mvpp2: phylink support")
Reported-by: linux at armlinux.org.uk
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  1 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 27 +++++++++----------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 67b9e81b7c02..c8d2bc23d21d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -613,6 +613,7 @@
 
 /* Port flags */
 #define MVPP2_F_LOOPBACK		BIT(0)
+#define MVPP2_F_FIXED_LINK		BIT(1)
 
 /* Marvell tag types */
 enum mvpp2_tag_type {
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 28500417843e..19d48992f213 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -58,6 +58,8 @@ static struct {
  */
 static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 			     const struct phylink_link_state *state);
+static void mvpp2_mac_link_up(struct net_device *dev, unsigned int mode,
+			      phy_interface_t interface, struct phy_device *phy);
 
 /* Queue modes */
 #define MVPP2_QDIST_SINGLE_MODE	0
@@ -3143,6 +3145,10 @@ static void mvpp2_start_dev(struct mvpp2_port *port)
 
 	if (port->phylink) {
 		phylink_start(port->phylink);
+
+		if (!(port->flags & MVPP2_F_FIXED_LINK))
+			mvpp2_mac_link_up(port->dev, MLO_AN_FIXED,
+					  port->phy_interface, NULL);
 	} else {
 		/* Phylink isn't used as of now for ACPI, so the MAC has to be
 		 * configured manually when the interface is started. This will
@@ -3150,9 +3156,10 @@ static void mvpp2_start_dev(struct mvpp2_port *port)
 		 */
 		struct phylink_link_state state = {
 			.interface = port->phy_interface,
-			.link = 1,
 		};
 		mvpp2_mac_config(port->dev, MLO_AN_INBAND, &state);
+		mvpp2_mac_link_up(port->dev, MLO_AN_INBAND, port->phy_interface,
+				  NULL);
 	}
 
 	netif_tx_start_all_queues(port->dev);
@@ -4495,10 +4502,6 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 		return;
 	}
 
-	netif_tx_stop_all_queues(port->dev);
-	if (!port->has_phy)
-		netif_carrier_off(port->dev);
-
 	/* Make sure the port is disabled when reconfiguring the mode */
 	mvpp2_port_disable(port);
 
@@ -4523,16 +4526,7 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 	if (port->priv->hw_version == MVPP21 && port->flags & MVPP2_F_LOOPBACK)
 		mvpp2_port_loopback_set(port, state);
 
-	/* If the port already was up, make sure it's still in the same state */
-	if (state->link || !port->has_phy) {
-		mvpp2_port_enable(port);
-
-		mvpp2_egress_enable(port);
-		mvpp2_ingress_enable(port);
-		if (!port->has_phy)
-			netif_carrier_on(dev);
-		netif_tx_wake_all_queues(dev);
-	}
+	mvpp2_port_enable(port);
 }
 
 static void mvpp2_mac_link_up(struct net_device *dev, unsigned int mode,
@@ -4691,6 +4685,9 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	if (fwnode_property_read_bool(port_fwnode, "marvell,loopback"))
 		port->flags |= MVPP2_F_LOOPBACK;
 
+	if (fwnode_property_present(port_fwnode, "fixed-link"))
+		port->flags |= MVPP2_F_FIXED_LINK;
+
 	port->id = id;
 	if (priv->hw_version == MVPP21)
 		port->first_rxq = port->id * port->nrxqs;
-- 
2.17.1
