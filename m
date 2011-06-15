From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Wed, 15 Jun 2011 22:15:05 +0300
Subject: [PATCH] ep93xx-eth: convert to phylib
In-Reply-To: <20110609203059.GZ16318@ibawizard.net>
References: <201106051957.36492.florian@openwrt.org>
	<201106052029.24742.f.fainelli@gmail.com>
	<20110609203059.GZ16318@ibawizard.net>
Message-ID: <20110615191505.GA2595@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2011 at 10:30:59PM +0200, Petr ?tetiar wrote:
> 
> just FYI, I wanted to test recent Mika's DMA/ep93xx_eth fixes, so I've added
> this patch also and it oopsed. If I revert this patch, it seems to work so
> far. You can find the whole patchset I've been testing on the GitHub[1]. I've
> tested it on ts-7250 and ts-7300, the oops is same. Here's the oops:
> 
> 	ep93xx-eth version 0.1 loading
> 	ep93xx_eth_mii: probed
> 	ep93xx_eth:ep93xx_mii_probe: no PHY found
> 	ep93xx-eth ep93xx-eth: failed to probe MII bus

I ran into same problem when I tried this patch on my TS-7260. It turned out
that call to mdiobus_register() tries to access PHY registers and the hardware
is not fully initialized yet. On Sim.One there is no such problem and I guess
that the bootloader leaves the hardware in more consistent state or something.

I was able to boot both TS-7260 and Sim.One with following hack on top of
this patch:

diff --git a/drivers/net/arm/ep93xx_eth.c b/drivers/net/arm/ep93xx_eth.c
index 21cc0ee..06eeb10 100644
--- a/drivers/net/arm/ep93xx_eth.c
+++ b/drivers/net/arm/ep93xx_eth.c
@@ -241,6 +241,13 @@ static int ep93xx_mdiobus_write(struct mii_bus *bus, int phy_id, int reg, u16 da
 
 static int ep93xx_mdiobus_reset(struct mii_bus *bus)
 {
+	struct ep93xx_priv *ep = netdev_priv(bus->priv);
+
+	/*
+	 * Make sure that the PHY clock divisor is valid before trying to
+	 * access any of it's registers.
+	 */
+	wrl(ep, REG_SELFCTL, ((ep->mdc_divisor - 1) << 9));
 	return 0;
 }
 
@@ -631,10 +638,8 @@ err:
 	return 1;
 }
 
-static int ep93xx_start_hw(struct net_device *dev)
+static void ep93xx_reset_hw(struct ep93xx_priv *ep)
 {
-	struct ep93xx_priv *ep = netdev_priv(dev);
-	unsigned long addr;
 	int i;
 
 	wrl(ep, REG_SELFCTL, REG_SELFCTL_RESET);
@@ -644,12 +649,15 @@ static int ep93xx_start_hw(struct net_device *dev)
 		msleep(1);
 	}
 
-	if (i == 10) {
+	if (i == 10)
 		pr_crit("hw failed to reset\n");
-		return 1;
-	}
+}
 
-	wrl(ep, REG_SELFCTL, ((ep->mdc_divisor - 1) << 9));
+static int ep93xx_start_hw(struct net_device *dev)
+{
+	struct ep93xx_priv *ep = netdev_priv(dev);
+	unsigned long addr;
+	int i;
 
 	/* Does the PHY support preamble suppress?  */
 	if ((ep93xx_mdiobus_read(ep->mii_bus, ep->phy_addr, MII_BMSR) & 0x0040) != 0)
@@ -715,18 +723,7 @@ static int ep93xx_start_hw(struct net_device *dev)
 
 static void ep93xx_stop_hw(struct net_device *dev)
 {
-	struct ep93xx_priv *ep = netdev_priv(dev);
-	int i;
-
-	wrl(ep, REG_SELFCTL, REG_SELFCTL_RESET);
-	for (i = 0; i < 10; i++) {
-		if ((rdl(ep, REG_SELFCTL) & REG_SELFCTL_RESET) == 0)
-			break;
-		msleep(1);
-	}
-
-	if (i == 10)
-		pr_crit("hw failed to reset\n");
+	ep93xx_reset_hw(netdev_priv(dev));
 }
 
 static int ep93xx_open(struct net_device *dev)
@@ -934,6 +931,8 @@ static int ep93xx_eth_probe(struct platform_device *pdev)
 	}
 	ep->irq = irq;
 
+	ep93xx_reset_hw(ep);
+
 	ep->mii_bus = mdiobus_alloc();
 	if (!ep->mii_bus) {
 		dev_err(&pdev->dev, "Failed to allocate mdiobus\n");
