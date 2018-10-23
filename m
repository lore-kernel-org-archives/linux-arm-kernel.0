From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 23 Oct 2018 16:09:40 +0000
Subject: [PATCH V3 6/8] arm64: dts: imx: add imx8qxp support
In-Reply-To: <CAPDyKFpYXo21fsHynZWTV9OOoCWGUJe2SZBR-A-dc8T8g3cLrg@mail.gmail.com>
References: <1539886483-15775-1-git-send-email-aisheng.dong@nxp.com>
 <1539886483-15775-7-git-send-email-aisheng.dong@nxp.com>
 <20181018202457.GA25174@bogus>
 <DB7PR04MB42188ABE426A055E6097C03080F90@DB7PR04MB4218.eurprd04.prod.outlook.com>
 <CAPDyKFpYXo21fsHynZWTV9OOoCWGUJe2SZBR-A-dc8T8g3cLrg@mail.gmail.com>
Message-ID: <AM0PR04MB4211E163C5AF713142C56A5A80F50@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson at linaro.org]
> Sent: Tuesday, October 23, 2018 10:55 PM
[...]
> On 19 October 2018 at 10:02, A.s. Dong <aisheng.dong@nxp.com> wrote:
> >> -----Original Message-----
> >> From: Rob Herring [mailto:robh at kernel.org]
> >> Sent: Friday, October 19, 2018 4:25 AM
> >> To: A.s. Dong <aisheng.dong@nxp.com>
> > [...]
> >> On Thu, Oct 18, 2018 at 06:19:39PM +0000, A.s. Dong wrote:
> >> > i.MX 8QuadXPlus is a quad (4x) Cortex-A35 proccessor with powerful
> >> > graphic and multimedia features. This patch adds the core SoC dtsi
> >> > file support.
> >> >
> >> > Cc: Rob Herring <robh+dt@kernel.org>
> >> > Cc: Mark Rutland <mark.rutland@arm.com>
> >> > Cc: devicetree at vger.kernel.org
> >> > Cc: Shawn Guo <shawnguo@kernel.org>
> >> > Cc: Sascha Hauer <kernel@pengutronix.de>
> >> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> >> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >> > ---
> >> > v2->v3:
> >> >  * add more SoC specific compatible string to IP nodes
> >> >  * move memory node into board dts
> >> >  * change pd reg value into hex
> >> >  * add more explanation about SoC in commit message
> >> >  * add external clocks
> >> >  * remove pmu compatible string which is not supported
> >> > v1->v2:
> >> >  * mu binding usage update
> >> >  * no define for node address
> >> >  * do not use '_' for node name
> >> >  * drop 'fsl-' prefix for imx dtsi
> >> >  * no defines for unit address
> >> >  * generic node names
> >> >  * range map for 32bit register
> >> >  * separate board dts
> >> > ---
> >> >  Documentation/devicetree/bindings/arm/fsl.txt |   4 +
> >> >  arch/arm64/boot/dts/freescale/imx8-ca35.dtsi  |  61 ++
> >> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 870
> >> ++++++++++++++++++++++++++
> >> >  3 files changed, 935 insertions(+)  create mode 100644
> >> > arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> >> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/arm/fsl.txt
> >> > b/Documentation/devicetree/bindings/arm/fsl.txt
> >> > index 968f238..baeb1fc 100644
> >> > --- a/Documentation/devicetree/bindings/arm/fsl.txt
> >> > +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> >> > @@ -119,6 +119,10 @@ i.MX6q generic board  Required root node
> >> > properties:
> >> >      - compatible = "fsl,imx6q";
> >> >
> >> > +i.MX8QXP generic board
> >> > +Required root node properties:
> >> > +    - compatible = "fsl,imx8qxp";
> >> > +
> >> >  Freescale Vybrid Platform Device Tree Bindings
> >> >  ----------------------------------------------
> >> >
> >> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> >> > b/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> >> > new file mode 100644
> >> > index 0000000..c79e97a
> >> > --- /dev/null
> >> > +++ b/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> >> > @@ -0,0 +1,61 @@
> >> > +// SPDX-License-Identifier: GPL-2.0+
> >> > +/*
> >> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> >> > + * Copyright 2017~2018 NXP
> >> > + */
> >> > +
> >> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >> > +
> >> > +/{
> >> > +   cpus {
> >> > +           #address-cells = <2>;
> >> > +           #size-cells = <0>;
> >> > +
> >> > +           /* We have 1 clusters with 4 Cortex-A35 cores */
> >> > +           A35_0: cpu at 0 {
> >> > +                   device_type = "cpu";
> >> > +                   compatible = "arm,cortex-a35";
> >> > +                   reg = <0x0 0x0>;
> >> > +                   enable-method = "psci";
> >> > +                   next-level-cache = <&A35_L2>;
> >> > +           };
> >> > +
> >> > +           A35_1: cpu at 1 {
> >> > +                   device_type = "cpu";
> >> > +                   compatible = "arm,cortex-a35";
> >> > +                   reg = <0x0 0x1>;
> >> > +                   enable-method = "psci";
> >> > +                   next-level-cache = <&A35_L2>;
> >> > +           };
> >> > +
> >> > +           A35_2: cpu at 2 {
> >> > +                   device_type = "cpu";
> >> > +                   compatible = "arm,cortex-a35";
> >> > +                   reg = <0x0 0x2>;
> >> > +                   enable-method = "psci";
> >> > +                   next-level-cache = <&A35_L2>;
> >> > +           };
> >> > +
> >> > +           A35_3: cpu at 3 {
> >> > +                   device_type = "cpu";
> >> > +                   compatible = "arm,cortex-a35";
> >> > +                   reg = <0x0 0x3>;
> >> > +                   enable-method = "psci";
> >> > +                   next-level-cache = <&A35_L2>;
> >> > +           };
> >> > +
> >> > +           A35_L2: l2-cache0 {
> >> > +                   compatible = "cache";
> >> > +           };
> >> > +   };
> >> > +
> >> > +   pmu {
> >> > +           compatible = "arm,armv8-pmuv3";
> >> > +           interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> >> > +   };
> >> > +
> >> > +   psci {
> >> > +           compatible = "arm,psci-1.0";
> >> > +           method = "smc";
> >> > +   };
> >> > +};
> >> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> >> > b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> >> > new file mode 100644
> >> > index 0000000..acb4770
> >> > --- /dev/null
> >> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> >> > @@ -0,0 +1,870 @@
> >> > +// SPDX-License-Identifier: GPL-2.0+
> >> > +/*
> >> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> >> > + * Copyright 2017-2018 NXP
> >> > + * Dong Aisheng <aisheng.dong@nxp.com>  */
> >> > +
> >> > +#include <dt-bindings/clock/imx8qxp-clock.h>
> >> > +#include <dt-bindings/gpio/gpio.h> #include
> >> > +<dt-bindings/pinctrl/pads-imx8qxp.h>
> >> > +
> >> > +#include "imx8-ca35.dtsi"
> >> > +
> >> > +/ {
> >> > +   interrupt-parent = <&gic>;
> >> > +   #address-cells = <2>;
> >> > +   #size-cells = <2>;
> >> > +
> >> > +   aliases {
> >> > +           serial0 = &dma_lpuart0;
> >> > +           mmc0 = &usdhc1;
> >> > +           mmc1 = &usdhc2;
> >> > +           mmc2 = &usdhc3;
> >> > +   };
> >> > +
> >> > +   gic: interrupt-controller at 51a00000 {
> >> > +           compatible = "arm,gic-v3";
> >> > +           reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
> >> > +                 <0x0 0x51b00000 0 0xc0000>; /* GICR (RD_base +
> >> > + SGI_base)
> >> */
> >> > +           #interrupt-cells = <3>;
> >> > +           interrupt-controller;
> >> > +           interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> >> > +   };
> >> > +
> >> > +   timer {
> >> > +           compatible = "arm,armv8-timer";
> >> > +           interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /*
> >> > + Physical Secure
> >> */
> >> > +                        <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /*
> >> > + Physical
> >> Non-Secure */
> >> > +                        <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /*
> Virtual */
> >> > +                        <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /*
> Hypervisor */
> >> > +   };
> >> > +
> >> > +   xtal32k: clock-xtal32k {
> >> > +           compatible = "fixed-clock";
> >> > +           #clock-cells = <0>;
> >> > +           clock-frequency = <32768>;
> >> > +           clock-output-names = "xtal_32KHz";
> >> > +   };
> >> > +
> >> > +   xtal24m: clock-xtal24m {
> >> > +           compatible = "fixed-clock";
> >> > +           #clock-cells = <0>;
> >> > +           clock-frequency = <24000000>;
> >> > +           clock-output-names = "xtal_24MHz";
> >> > +   };
> >> > +
> >> > +   scu {
> >> > +           compatible = "fsl,imx-scu";
> >> > +           mbox-names = "tx0", "tx1", "tx2", "tx3",
> >> > +                        "rx0", "rx1", "rx2", "rx3";
> >> > +           mboxes = <&lsio_mu1 0 0
> >> > +                     &lsio_mu1 0 1
> >> > +                     &lsio_mu1 0 2
> >> > +                     &lsio_mu1 0 3
> >> > +                     &lsio_mu1 1 0
> >> > +                     &lsio_mu1 1 1
> >> > +                     &lsio_mu1 1 2
> >> > +                     &lsio_mu1 1 3>;
> >> > +
> >> > +           clk: clock-controller {
> >> > +                   compatible = "fsl,imx8qxp-clk";
> >> > +                   #clock-cells = <1>;
> >> > +                   clocks = <&xtal32k &xtal24m>;
> >> > +                   clock-names = "xtal_32KHz", "xtal_24Mhz";
> >> > +           };
> >> > +
> >> > +           iomuxc: pinctrl {
> >> > +                   compatible = "fsl,imx8qxp-iomuxc";
> >> > +           };
> >> > +
> >> > +           imx8qx-pm {
> >> > +                   compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
> >> > +                   #address-cells = <1>;
> >> > +                   #size-cells = <0>;
> >> > +
> >> > +                   pd_lsio: lsio-power-domain {
> >> > +                           #power-domain-cells = <0>;
> >> > +                           #address-cells = <1>;
> >> > +                           #size-cells = <0>;
> >> > +
> >> > +                           pd_lsio_pwm0: lsio-pwm0 at bf {
> >> > +                                   reg = <0xbf>;
> >> > +                                   #power-domain-cells = <0>;
> >> > +                                   power-domains = <&pd_lsio>;
> >>
> >> Power domains are supposed to be a block that can be power gated. No
> >> chip design is going to put tiny PWM, GPIO, etc. blocks each in their own
> domain.
> >>
> >> If you really want to maintain these sub domains, just use 2
> >> #power-domain-cells. The first cell can be the power domain and the
> >> 2nd cell the device ID.
> >>
> >
> > Unfortunately the SCU firmware is designed like that each device has a
> > power domain ID which is specified in reg property in device tree.
> > Each driver should enable that power domain before being able to
> > access the HW, otherwise, xRDC (security and access control HW) may report
> bus errors.
> 
> This is what Rob is suggesting:
> 

Thanks for the example

> pd_lsio: lsio-power-domain {
>        compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
>        #power-domain-cells = <2>;
> }
> 
> pd_lsio_pwm0: lsio-pwm0 at bf {
>        power-domains = <&pd_lsio 0 0xbf>; }
> 

What does 0 (cell 1) represent?

> Perhaps it's even sufficient for you to use one cell, if your power-domain
> provider models only one PM domain. In such case, the below works as well:
> 
> pd_lsio: lsio-power-domain {
>        compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
>        #power-domain-cells = <1>;
> }
> 
> pd_lsio_pwm0: lsio-pwm0 at bf {
>        power-domains = <&pd_lsio 0xbf>;
> }
> 
> In other words, you don't need "reg".

Will compiler complain a warning if missing "reg" property as we already have
the unit-address?

> 
> To make this work, you also need to implement your own genpd xlate provider
> function. Do notice that, of_genpd_add_provider_onecell() already supports
> provider specific xlate functions. Just set it, before calling
> of_genpd_add_provider_onecell().
> 
> If you would like to look at an example, see
> drivers/soc/tegra/powergate-bpmp.c.
>

Will study. Thanks for the sharing.
 
> > And there could be different multi-level domains, how to do 2cells
> presentation for this case?
> > E.g.
> > Domain_A: {
> >         Domain_B {
> >                 Domain_C {
> >                         ...
> >                 }
> >         }
> > }
> 
> To specify a master domain, we use the power-domains specifier from within a
> power domain provider node. Of course it needs to use the correct number of
> cells as specified by the master provider, which may be something different
> that what it self uses.
> 
> Something like this:
> 
> pd_lsio_master: lsio-power-domain-master {
>        compatible = "fsl,imx8qxp-scu-pd-master", "fsl,scu-pd0-master";

Introduced two new compatible string?

>        #power-domain-cells = <0>;
> }
> 
> pd_lsio: lsio-power-domain {
>        compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
>        #power-domain-cells = <1>;
>        power-domains = <&pd_lsio_master>; }
> 
> pd_lsio_pwm0: lsio-pwm0 at bf {
>        power-domains = <&pd_lsio 0xbf>;
> }
> 

Overally I'm still not quite understand this new approach, may need some more
time to digest.

A simple question is: Do we lose the power domain tree hierarchy?
The original tree view seems like more straightforward. Not sure why need
to do like that.

And overally this new approach seems much more complicated than the old one
due to we have to handle the special multilevel power domains.

I'm a bit confusing whether it's worthy to switch to this new complicated
one and what's real advantage we can get comparing to the old simple way?
I will spend more time to research.
Hopefully Rob and You can help clarify a bit more to help the understanding.

Regards
Dong Aisheng

> [...]
> 
> Hope this helps!
> 
> Kind regards
> Uffe
