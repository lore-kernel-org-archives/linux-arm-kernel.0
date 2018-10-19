From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 19 Oct 2018 08:05:51 +0000
Subject: [PATCH V3 7/8] arm64: dts: imx: add imx8qxp mek support
In-Reply-To: <20181018202740.GA7262@bogus>
References: <1539886483-15775-1-git-send-email-aisheng.dong@nxp.com>
 <1539886483-15775-8-git-send-email-aisheng.dong@nxp.com>
 <20181018202740.GA7262@bogus>
Message-ID: <DB7PR04MB4218778D66FBD51554D64D6980F90@DB7PR04MB4218.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Friday, October 19, 2018 4:28 AM
> To: A.s. Dong <aisheng.dong@nxp.com>
[...]
> On Thu, Oct 18, 2018 at 06:19:43PM +0000, A.s. Dong wrote:
> > i.MX 8QuadXPlus is a quad (4x) Cortex-A35 proccessor with powerful
> > graphic and multimedia features. This patch adds imx8qxp mek board
> > support.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree at vger.kernel.org
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > v2->v3:
> >  * Pad names update
> >  * move memory node to here
> >  * add no-sd and no-sdio under emmc node
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.txt |   4 +
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 141
> > ++++++++++++++++++++++++++
> >  3 files changed, 146 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.txt
> > b/Documentation/devicetree/bindings/arm/fsl.txt
> > index baeb1fc..704472b 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.txt
> > +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> > @@ -97,6 +97,10 @@ i.MX7 SabreSD Board  Required root node
> properties:
> >      - compatible = "fsl,imx7d-sdb", "fsl,imx7d";
> >
> > +i.MX8QXP MEK Board
> > +Required root node properties:
> > +    - compatible = "fsl,imx8qxp-mek", "fsl,imx8qxp";
> > +
> >  Generic i.MX boards
> >  -------------------
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > b/arch/arm64/boot/dts/freescale/Makefile
> > index 86e18ad..cff87f3 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=
> fsl-ls2080a-rdb.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> > +dtb-$(CONFIG_SOC_IMX8QXP) += imx8qxp-mek.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> > b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> > new file mode 100644
> > index 0000000..6087ead
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> > @@ -0,0 +1,141 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2017~2018 NXP
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx8qxp.dtsi"
> > +
> > +/ {
> > +	model = "Freescale i.MX8QXP MEK";
> > +	compatible = "fsl,imx8qxp-mek", "fsl,imx8qxp";
> > +
> > +	chosen {
> > +		stdout-path = &dma_lpuart0;
> > +	};
> > +
> > +	memory at 80000000 {
> > +		device_type = "memory";
> > +		reg = <0x00000000 0x80000000 0 0x40000000>;
> > +	};
> > +
> > +	reg_usdhc2_vmmc: usdhc2-vmmc {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "SD1_SPWR";
> > +		regulator-min-microvolt = <3000000>;
> > +		regulator-max-microvolt = <3000000>;
> > +		gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> > +};
> > +
> > +&dma_lpuart0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_lpuart0>;
> > +	status = "okay";
> > +};
> > +
> > +&fec1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_fec1>;
> > +	phy-mode = "rgmii-id";
> > +	phy-handle = <&ethphy0>;
> > +	fsl,magic-packet;
> > +	status = "okay";
> > +
> > +	mdio {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		ethphy0: ethernet-phy at 0 {
> > +			compatible = "ethernet-phy-ieee802.3-c22";
> 
> > +			at803x,eee-disabled;
> > +			at803x,vddio-1p8v;
> 
> These 2 are Not documented.

Sorry for missing these.
They're seemed to be introduce with original local code, as it does not
Affect the normal function, I will remove them in next patch set.

Thanks for the carefully review.

Regards
Dong Aisheng
