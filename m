From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 15 Mar 2013 12:07:12 +0100
Subject: [PATCH 4/4 v2] mv643xx_eth: convert to use the Marvell Orion
 MDIO driver
In-Reply-To: <1363284515-9865-5-git-send-email-florian@openwrt.org>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-5-git-send-email-florian@openwrt.org>
Message-ID: <514300E0.2030108@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/14/13 19:08, Florian Fainelli a ?crit :
> This patch converts the Marvell MV643XX ethernet driver to use the
> Marvell Orion MDIO driver. As a result, PowerPC and ARM platforms
> registering the Marvell MV643XX ethernet driver are also updated to
> register a Marvell Orion MDIO driver. This driver voluntarily overlaps
> with the Marvell Ethernet shared registers because it will use a subset
> of this shared register (shared_base + 0x4 - shared_base + 0x84). The
> Ethernet driver is also updated to look up for a PHY device using the
> Orion MDIO bus driver.

Thanks to the help of Andrew Lunn, there is at least two known issues 
with this patch version:

- we need to move up the mvmdio line in 
drivers/net/ethernet/marvell/Makefile to make sure that configs having 
both mvmdio and mv643xx_eth built-in get the probing order right
- the bus name used by mv643xx_eth is not the right now (orion-mdio.0 vs 
expected orion-mdio) so the PHY device will not be found during 
phy_connect()

I will fix these two issues in the next version of the patchset.
--
Florian
