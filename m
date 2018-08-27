From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Aug 2018 17:50:59 +0100
Subject: [PATCH net-next v3 02/10] net: mvpp2: phylink support
In-Reply-To: <20180517082939.14598-3-antoine.tenart@bootlin.com>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
Message-ID: <20180827165058.GD30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 10:29:31AM +0200, Antoine Tenart wrote:
> +static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
> +			     const struct phylink_link_state *state)
> +{
> +	struct mvpp2_port *port = netdev_priv(dev);
> +
> +	/* Check for invalid configuration */
> +	if (state->interface == PHY_INTERFACE_MODE_10GKR && port->gop_id != 0) {
> +		netdev_err(dev, "Invalid mode on %s\n", dev->name);
> +		return;
> +	}
> +
> +	netif_tx_stop_all_queues(port->dev);
> +	if (!port->has_phy)
> +		netif_carrier_off(port->dev);
...
> +	/* If the port already was up, make sure it's still in the same state */
> +	if (state->link || !port->has_phy) {
> +		mvpp2_port_enable(port);
> +
> +		mvpp2_egress_enable(port);
> +		mvpp2_ingress_enable(port);
> +		if (!port->has_phy)
> +			netif_carrier_on(dev);
> +		netif_tx_wake_all_queues(dev);
> +	}

I'm guessing that the above is what is classed as "small fixes"
in the cover letter for this series - as such I didn't look closely
at this patch, but I should have, because this is not a "small fix".
I don't find the above code in previous patches, and I don't find
any description about why this has changed.

I'm on record for having said (many times) that drivers that are
converted to phylink should _not_ mess with the net device carrier
state themselves, but should leave it to phylink to manage.

The above appears to cause a problem when testing on a singleshot
mcbin board - as a direct result of the above, I find that _all_
the network devices apparently have link, including those which
have no SFP inserted into the cage.  This results in debian jessie
hanging at boot for over 1 minute while systemd tries to bring up
all network devices.

The same should be true of the doubleshot board's 1G cage - which
is the same as the singleshot in every respect, and the singleshot
exhibits this problem there as well.  I haven't actually tested
this on the doubleshot though.

Have you identified a case where mac_config() is called with the
link up for which a major reconfiguration is required?  mac_config()
will get called for small reconfigurations such as changing the
pause parameters (which should _not_ require the queues to be
restarted) but the link should always be down for major
reconfigurations such sa changing the PHY interface mode.

mac_config() can also be called when nothing has changed - if we've
decided to re-run the link state resolve, it can be called with the
same parameters as previously, especially now that we have polling
of a GPIO for link state monitoring.  With your code above, this will
cause mvpp2 to down/up the carrier state every second.

Note that state->link here is the _future_ state of the link, which
may change state before the mac_link_up()/down() functions have been
called - turning the carrier on/off like this will prevent these
callbacks being made, and the link state being printed by phylink.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
