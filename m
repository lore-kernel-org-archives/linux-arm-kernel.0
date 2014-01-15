From: phdm@macq.eu (Philippe De Muyter)
Date: Wed, 15 Jan 2014 10:45:51 +0100
Subject: imx6dl/imx6q fec rmii mode with external ref_clk
In-Reply-To: <20140115073536.GD1914@S2101-09.ap.freescale.net>
References: <20140114153012.GA22550@frolo.macqel>
 <20140115073536.GD1914@S2101-09.ap.freescale.net>
Message-ID: <20140115094551.GA26117@frolo.macqel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 03:35:40PM +0800, Shawn Guo wrote:
> On Tue, Jan 14, 2014 at 04:30:12PM +0100, Philippe De Muyter wrote:
> > Hi,
> > 
> > On the custom board we are developping (imx6q and imx6dl), we have connected
> > the fec to a switch chip using rmii mode, and we let the switch provide the
> > reference clock to gpio_16.
> > 
> > I work currently with 3.13-rc8 and
> > 
> > - I do not have ethernet access working (tx timeout)
> > - I do not find in the dtb files a description of the pad settings for the
> > RMII mode
> > - when searching about the setting for bit 21 ing GPR1, which seems to
> > be important for my setting to work, I found the following mail:
> > 	http://www.spinics.net/lists/devicetree/msg06450.html
> 
> Just for testing your hardware, does the following change make the
> Ethernet work for you?
> 
> Shawn
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c
> b/arch/arm/mach-imx/mach-imx6q.c
> index e51e3da..be8d074 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -188,7 +188,7 @@ static void __init imx6q_1588_init(void)
>         if (!IS_ERR(gpr))
>                 regmap_update_bits(gpr, IOMUXC_GPR1,
>                                 IMX6Q_GPR1_ENET_CLK_SEL_MASK,
> -                               IMX6Q_GPR1_ENET_CLK_SEL_ANATOP);
> +                               0);
>         else
>                 pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
> 

I tried your patch (above mine, see below), and here is what I get :

[  180.015659] fec 2188000.ethernet eth0: Freescale FEC PHY driver [Generic PHY] (mii_bus:phy_addr=2188000.ethernet:01, irq=-1)
[  180.015861] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[  182.013790] libphy: 2188000.ethernet:01 - Link is Up - 100/Full
[  182.014134] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  226.001667] ------------[ cut here ]------------
[  226.001740] WARNING: CPU: 1 PID: 0 at net/sched/sch_generic.c:264 dev_watchdog+0x27c/0x2a0()
[  226.001758] NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out


Here are my patches (I have called my board imx6dl-p6-2094):
Do I need to replace the hex value after MX6QDL_PAD_GPIO_16__ENET_REF_CLK
by something else ?

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d57c1a6..bc115f7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -136,6 +136,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx53-mba53.dtb \
 	imx53-qsb.dtb \
 	imx53-smd.dtb \
+	imx6dl-p6-2094.dtb \
 	imx6dl-sabreauto.dtb \
 	imx6dl-sabresd.dtb \
 	imx6dl-wandboard.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-p6-2094.dts b/arch/arm/boot/dts/imx6dl-p6-2094.dts
new file mode 100644
index 0000000..526e83a
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-p6-2094.dts
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "imx6qdl-sabresd.dtsi"
+
+&usdhc4 {
+	non-removable;
+#if 0
+	vmmc-supply = <&reg_3p3v>;
+#endif
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4_1>;
+	bus-width = <8>;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet_4>;
+	phy-mode = "rmii";
+	status = "okay";
+};
+
+/ {
+	model = "Macq i.MX6 DualLite P6-2094 Board";
+	compatible = "fsl,imx6dl-sabresd", "fsl,imx6dl";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index e75e11b..d850ff1 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -181,7 +181,9 @@
 				MX6QDL_PAD_NANDF_CLE__GPIO6_IO07 0x80000000
 				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
 				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
+#if 0 /* conflicts with pinctrl_enet_4:MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN */
 				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x80000000
+#endif
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fb28b2e..7a0b341 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -729,6 +729,22 @@
 							MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN     0x1b0b0
 						>;
 					};
+
+					pinctrl_enet_4: enetgrp-4 {
+						fsl,pins = <
+							MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+							MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+							MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x1b0b0	/* RMII */
+							MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x1b0b0	/* MII/RMII */
+							MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x1b0b0	/* MII/RMII */
+							MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0	/* MII/RMII */
+							MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER	0x1b0b0	/* MII/RMII */
+							MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x1b0b0	/* MII/RMII */
+							MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x1b0b0	/* MII/RMII */
+							MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0	/* MII/RMII */
+							MX6QDL_PAD_GPIO_19__ENET_TX_ER		0x1b0b0	/* MII/RMII */
+						>;
+					};
 				};
 
 				esai {
-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
