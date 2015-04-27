From: andrej@inversepath.com (Andrej Rosano)
Date: Mon, 27 Apr 2015 15:26:58 +0200
Subject: [PATCH] ARM: dts: imx53: add support for USB armory board
In-Reply-To: <CAOMZO5BR=ODT6aBsbPJy5Dt9ZF4t9_R7Comqw4G8m2DUz6kumw@mail.gmail.com>
References: <1429882425-24514-1-git-send-email-andrej@inversepath.com>
 <CAOMZO5BR=ODT6aBsbPJy5Dt9ZF4t9_R7Comqw4G8m2DUz6kumw@mail.gmail.com>
Message-ID: <20150427132658.GB11598@core.inversepath.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, Apr 24, 2015 at 05:26:40PM -0300, Fabio Estevam wrote:
> On Fri, Apr 24, 2015 at 10:33 AM,  <andrej@inversepath.com> wrote:
> > From: Andrej Rosano <andrej@inversepath.com>
> >
> > Add support for Inverse Path USB armory board, an open source
> > flash-drive sized computer based on Freescale i.MX53 SoC.
> >
> > http://inversepath.com/usbarmory
> 
> Nice board!

Thanks!

> 
> > As the device can work in either USB device mode or USB host mode,
> > two different device tree file are needed along with one common
> > include file.
> >
> > Signed-off-by: Andrej Rosano <andrej@inversepath.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: Chris Kuethe <chris.kuethe@gmail.com>
> > Cc: Vagrant Cascadian <vagrant@debian.org>
> > ---
> >  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
> >  arch/arm/boot/dts/imx53-usbarmory-common.dtsi      |  205 ++++++++++++++++++++
> >  arch/arm/boot/dts/imx53-usbarmory-host.dts         |   18 ++
> >  arch/arm/boot/dts/imx53-usbarmory.dts              |   18 ++
> >  4 files changed, 242 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx53-usbarmory-common.dtsi
> >  create mode 100644 arch/arm/boot/dts/imx53-usbarmory-host.dts
> >  create mode 100644 arch/arm/boot/dts/imx53-usbarmory.dts
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 83737a3..e7a10ce 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -102,6 +102,7 @@ img Imagination Technologies Ltd.
> >  innolux        Innolux Corporation
> >  intel  Intel Corporation
> >  intercontrol   Inter Control Group
> > +inversepath    Inverse Path, S.r.l.
> 
> This should be in a separate patch.

Ok.

> 
> > diff --git a/arch/arm/boot/dts/imx53-usbarmory-common.dtsi b/arch/arm/boot/dts/imx53-usbarmory-common.dtsi
> > new file mode 100644
> > index 0000000..4b4feae
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx53-usbarmory-common.dtsi
> > @@ -0,0 +1,205 @@
> > +/*
> > + * USB armory MkI device tree include file
> > + * http://inversepath.com/usbarmory
> > + *
> > + * Copyright (C) 2015, Inverse Path
> > + * Andrej Rosano <andrej@inversepath.com>
> > + *
> > + * Licensed under GPLv2
> > + */
> 
> Could you use a dual-license type? Take a look at imx6sl-warp.dts as a
> reference.

Sure.

> 
> > +       soc {
> > +               aips at 60000000 {
> > +                       sahara: crypto at 63ff8000 {
> > +                               compatible = "fsl,imx53-sahara";
> > +                               reg = <0x63ff8000 0x4000>;
> > +                               interrupts = <19 20>;
> > +                               clocks = <&clks IMX5_CLK_SAHARA_IPG_GATE>,
> > +                                        <&clks IMX5_CLK_SAHARA_IPG_GATE>;
> > +                               clock-names = "ipg", "ahb";
> > +                       };
> > +               };
> > +       };
> 
> There is a sahara node in imx53.dtsi, so no need to put it here.

Ok.

> 
> > +};
> > +
> > +&cpu0 {
> > +       device_type = "cpu";
> > +       compatible = "arm,cortex-a8";
> > +       reg = <0x0>;
> > +       clocks = <&clks IMX5_CLK_ARM>;
> > +       clock-latency = <61036>;
> > +       voltage-tolerance = <5>;
> > +       operating-points = <
> > +               /* kHz */
> > +                166666  850000
> > +                400000  900000
> > +                800000 1050000
> > +       >;
> > +};
> 
> Same here. This is also part of imx53.dtsi.

This is necessary because the USB armory mounts a i.MX534 and
it does not support the 1 and 1.2 GHz operating point.
Or maybe there is a better way to restrict the operating frequency
range?

> 
> > +
> > +&esdhc1 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_esdhc1>;
> > +       status = "okay";
> > +};
> > +
> > +&iomuxc {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_hog>;
> > +
> > +       imx53-usbarmory {
> > +               pinctrl_hog: hoggrp {
> > +                       fsl,pins = <
> > +                               MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK 0x80000000
> > +                               MX53_PAD_GPIO_8__GPIO1_8          0x80000000
> > +                               MX53_PAD_PATA_DATA14__GPIO2_14    0x80000000
> > +                               MX53_PAD_PATA_DATA15__GPIO2_15    0x80000000
> > +                               MX53_PAD_EIM_DA11__GPIO3_11       0x80000000
> > +                               MX53_PAD_EIM_DA12__GPIO3_12       0x80000000
> > +                               MX53_PAD_PATA_DA_0__GPIO7_6       0x80000000
> > +                               MX53_PAD_PATA_DA_2__GPIO7_8       0x80000000
> > +                               MX53_PAD_GPIO_16__GPIO7_11        0x80000000
> > +                       >;
> 
> Please don't use 0x80000000 settings. Better to pass the real IOMUX
> values, so that we don't need to rely on the bootloader pin settings.
> 
> > +&vpu {
> > +       status = "okay";
> > +};
> 
> VPU is already enabled in imx53.dtsi.

There is no "status" defined for vpu in imx53.dtsi, also imx53-qsb-common.dtsi
explicitly enable it.

> 
> Regards,
> 
> Fabio Estevam

--
Andrej Rosano                                           Inverse Path Srl
<andrej@inversepath.com>                      http://www.inversepath.com

0x01939B21            5BB8 574E 68E8 D841 E18F  D5E9 CEAD E0CF 0193 9B21
