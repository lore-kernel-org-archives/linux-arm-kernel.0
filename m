From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 21 Nov 2018 01:01:37 +0530
Subject: [PATCH 04/16] arm: dts: Add devicetree for RDA8810PL SoC
In-Reply-To: <CAL_JsqLf_9ryCUtUkkE6P4GS8tC7nQ0pLHwLCQzy_HLJNTNMrw@mail.gmail.com>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-5-manivannan.sadhasivam@linaro.org>
 <CAL_JsqLf_9ryCUtUkkE6P4GS8tC7nQ0pLHwLCQzy_HLJNTNMrw@mail.gmail.com>
Message-ID: <20181120193137.GB16122@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Mon, Nov 19, 2018 at 12:25:58PM -0600, Rob Herring wrote:
> On Mon, Nov 19, 2018 at 11:11 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Add initial device tree for RDA8810PL SoC from RDA Microelectronics.
> >
> > Signed-off-by: Andreas F?rber <afaerber@suse.de>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm/boot/dts/rda8810pl.dtsi | 95 ++++++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi
> >
> > diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
> > new file mode 100644
> > index 000000000000..7f1ff2021eff
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/rda8810pl.dtsi
> > @@ -0,0 +1,95 @@
> > +/*
> > + * RDA8810PL SoC
> > + *
> > + * Copyright (c) 2017 Andreas F?rber
> > + * Copyright (c) 2018 Manivannan Sadhasivam
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> 
> Goes on 1st line. checkpatch.pl will tell you this.
> 

Ack.

> > + */
> > +
> > +/ {
> > +       compatible = "rda,8810pl";
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +
> > +       aliases {
> > +               serial0 = &uart0;
> > +               serial1 = &uart1;
> > +               serial2 = &uart2;
> > +       };
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               cpu at 0 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a5";
> > +                       reg = <0x0>;
> > +               };
> > +       };
> > +
> > +       soc {
> 
> soc at 0
> 

Ack.

> > +               compatible = "simple-bus";
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               ranges = <0x0 0x0 0x80000000>;
> > +
> > +               sram at 100000 {
> > +                       compatible = "mmio-sram";
> > +                       reg = <0x100000 0x10000>;
> 
> Based on the address of this and everything else, perhaps you should
> move this to the top-level (or another bus node) and then either get
> rid of the soc node level or make it start at 0x20000000. Kind of
> depends on what the rest of the memory map looks like.
>

Okay. Will move sram node to top level and make soc reg address start
from 0x20000000.

> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges;
> > +               };
> > +
> > +               apb at 20800000 {
> > +                       compatible = "simple-bus";
> > +                       reg = <0x20800000 0x100000>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges = <0x0 0x20800000 0x100000>;
> > +               };
> > +
> > +               apb at 20900000 {
> > +                       compatible = "simple-bus";
> > +                       reg = <0x20900000 0x100000>;
> 
> By definition of a simple-bus, it should not have any registers. Or
> you should also have a specific compatible.
> 

Okay, will remove the reg property.

Thanks,
Mani

> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges = <0x0 0x20900000 0x100000>;
> > +               };
> > +
> > +               apb at 20a00000 {
> > +                       compatible = "simple-bus";
> > +                       reg = <0x20a00000 0x100000>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges = <0x0 0x20a00000 0x100000>;
> > +
> > +                       uart0: serial at 0 {
> > +                               compatible = "rda,8810pl-uart";
> > +                               reg = <0x0 0x1000>;
> > +                               status = "disabled";
> > +                       };
> > +
> > +                       uart1: serial at 10000 {
> > +                               compatible = "rda,8810pl-uart";
> > +                               reg = <0x10000 0x1000>;
> > +                               status = "disabled";
> > +                       };
> > +
> > +                       uart2: serial at 90000 {
> > +                               compatible = "rda,8810pl-uart";
> > +                               reg = <0x90000 0x1000>;
> > +                               status = "disabled";
> > +                       };
> > +               };
> > +
> > +               l2: cache-controller at 21100000 {
> > +                       compatible = "arm,pl310-cache";
> > +                       reg = <0x21100000 0x1000>;
> > +                       cache-unified;
> > +                       cache-level = <2>;
> > +               };
> > +       };
> > +};
> > --
> > 2.17.1
> >
