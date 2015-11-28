From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Sat, 28 Nov 2015 20:38:24 +0100
Subject: [PATCH 1/2] ARM: dts: imx6: Add support for Toradex Apalis SoM
In-Reply-To: <5b507c5d85e51d56074a8f8c32b8dcf9@agner.ch>
References: <1447935900-13635-1-git-send-email-ynezz@true.cz>
 <1447935900-13635-2-git-send-email-ynezz@true.cz>
 <1447942325.3144.86.camel@pengutronix.de>
 <20151126101742.GM19674@ibawizard.net>
 <5b507c5d85e51d56074a8f8c32b8dcf9@agner.ch>
Message-ID: <20151128193824.GN19674@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Agner <stefan@agner.ch> [2015-11-27 12:02:46]:

> Hi Petr,

Hi,

> > &fec {
> > 	pinctrl-names = "default";
> > 	pinctrl-0 = <&pinctrl_enet &pinctrl_enet_ctrl>;
> > 	phy-mode = "rgmii";
> > 
> > 	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
> > 	interrupts-extended = <&gpio1 30 IRQ_TYPE_LEVEL_LOW>,
> > 			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
> > 	status = "okay";
> > };
> 
> According to the schema, &gpio1 30 is low active as well as the reset
> GPIO &gpio1 25. Both pulled high externally...
> 
> So phy reset GPIO should be ACTIVE_LOW, otherwise things look correct to
> me.
> 
> I guess in that case U-Boot took care of it. However, this is not a
> clean solution...

Yes, I think, that it's being setup by U-Boot and there is something not
properly(*) defined in the DTS or in kernel. I'll probably start over with a
vanilla U-Boot to get relatively clean table.

* If I boot Toradex's 3.10.17+gitr602505a35 first and then reboot into
  4.4.0-rc2, the kernel hangs somewhere in the platform init. It's probably
  the PAD_CTRL_NO problem. I'll get into this once I fix the fec.

> Not sure what happens exactly, maybe the phy-reset does not honor the
> GPIO_ACTIVE_LOW flag?

Reset works probably fine, I haven't verified that with a scope, but if I boot
over NFS, it takes longer then without reset-gpio defined.

The issue is with IRQ GPIO, which I can't get to work. Here are two cases I've
observed so far:

1. PHY init failure due to MDIO read timeout

  interrupts-extended = <&gpio1 30 IRQ_TYPE_LEVEL_LOW>, <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;

  [    2.685556] of_irq_parse_raw:  /soc/aips-bus at 02000000/gpio at 0209c000:0000001e,00000008
  [    2.701521] of_irq_parse_raw:  /interrupt-controller at 00a01000:00000000,00000077,00000004
  [    2.732258] fec 2188000.ethernet (unnamed net_device) (uninitialized): MDIO read timeout
  [    2.740859] fec: probe of 2188000.ethernet failed with error -5

2. PHY init is OK, but MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 is not being used as IRQ:

  interrupts-extended = <&gpio1 30 IRQ_TYPE_LEVEL_LOW>, <&intc 0 118 IRQ_TYPE_LEVEL_HIGH>;

  [    2.685479] of_irq_parse_raw:  /soc/aips-bus at 02000000/gpio at 0209c000:0000001e,00000008
  [    2.701440] of_irq_parse_raw:  /interrupt-controller at 00a01000:00000000,00000076,00000004
  [    2.714595] libphy: fec_enet_mii_bus: probed
  [    2.719674] fec 2188000.ethernet eth0: registered PHC device 0

  root at OpenWrt:/# cat /proc/interrupts | grep ethernet
   65:          0          0          0          0  gpio-mxc  30 Level     2188000.ethernet
  288:       7513          0          0          0       GIC 150 Level     2188000.ethernet

I've to look into it deeper next week. Thanks!

-- ynezz
