From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 29 Jan 2013 21:41:03 +0100
Subject: [PATCH 5/5] mv643xx_eth: convert to use the Marvell Orion MDIO
 driver
In-Reply-To: <20130129181306.GF25646@obsidianresearch.com>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1359473048-26551-6-git-send-email-florian@openwrt.org>
 <20130129181306.GF25646@obsidianresearch.com>
Message-ID: <201301292141.03931.florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi 29 janvier 2013 19:13:06, Jason Gunthorpe a ?crit :
> On Tue, Jan 29, 2013 at 04:24:08PM +0100, Florian Fainelli wrote:
> > This patch converts the Marvell MV643XX ethernet driver to use the
> > Marvell Orion MDIO driver. As a result, PowerPC and ARM platforms
> > registering the Marvell MV643XX ethernet driver are also updated to
> > register a Marvell Orion MDIO driver. This driver voluntarily overlaps
> > with the Marvell Ethernet shared registers because it will use a subset
> > of this shared register (shared_base + 0x4 - shared_base + 0x84). The
> > Ethernet driver is also updated to look up for a PHY device using the
> > Orion MDIO bus driver.
> 
> Can you finish off this job by making the mv643xx_eth driver accept
> the standard phy-handle OF property instead of using a phy address?

I can certainly do that, at the same time we need to continue supporting the 
"old" platform device style registration without breaking them (PowerPC in 
particular, and the hopefully yet to be converted orion5x). So the phy_scan() 
as I modified it will probably still be there.

> 
> Ie the end result should be something like:
> 
>                 smi0: mdio at 72000 {
>                         device_type = "mdio";
>                         compatible = "marvell,orion-mdio";
>                         reg = <0x72004 0x4>;
> 
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         PHY1: ethernet-phy at 1 {
>                                 reg = <1>;
>                                 device_type = "ethernet-phy";
>                                 phy-id = <0x01410e90>;
>                         };
>                 };
> 
>                 egiga0 {
>                         device_type = "network";
>                         compatible = "marvell,mv643xx-eth";
>                         reg = <0x72000 0x4000>;
>                         port_number = <0>;
>                         phy-handle = <&PHY1>;
>                         interrupts = <11>;
>                         local-mac-address = [000000000002];  /* Filled by
> boot loader */ };
> 
> Regards,
> Jason

-- 
Florian
