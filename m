From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 7 May 2018 16:35:11 -0700
Subject: [PATCH v2 1/2] arm64: dts: Add msm8998 SoC and MTP board support
In-Reply-To: <152573399648.138124.10341359049104453178@swboyd.mtv.corp.google.com>
References: <20180428054248.22387-1-bjorn.andersson@linaro.org>
 <152573399648.138124.10341359049104453178@swboyd.mtv.corp.google.com>
Message-ID: <20180507233511.GC14924@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 07 May 15:59 PDT 2018, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2018-04-27 22:42:47)
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > new file mode 100644
> > index 000000000000..d6665e4f801f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > @@ -0,0 +1,340 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2016, The Linux Foundation. All rights reserved. */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/clock/qcom,gcc-msm8998.h>
> > +
> > +/ {
> > +       model = "Qualcomm Technologies, Inc. MSM 8998";
> > +
> > +       interrupt-parent = <&intc>;
> > +
> > +       qcom,msm-id = <292 0x0>;
> 
> No update to dtbtool?
> 

This allows me to concatenate the dtb to the Image.gz and boot the
device. From my scripts I see that I tried to use dtbTool before
reverting to this...

[..]
> > +               cpu-map {
> > +                       cluster0 {
> > +                               core0 {
> > +                                       cpu = <&CPU0>;
> > +                               };
> > +
> > +                               core1 {
> > +                                       cpu = <&CPU1>;
> > +                               };
> > +
> > +                               core2 {
> > +                                       cpu = <&CPU2>;
> > +                               };
> > +
> > +                               core3 {
> > +                                       cpu = <&CPU3>;
> > +                               };
> > +                       };
> > +
> > +                       cluster1 {
> > +                               core0 {
> > +                                       cpu = <&CPU4>;
> > +                               };
> > +
> > +                               core1 {
> > +                                       cpu = <&CPU5>;
> > +                               };
> > +
> > +                               core2 {
> > +                                       cpu = <&CPU6>;
> > +                               };
> > +
> > +                               core3 {
> > +                                       cpu = <&CPU7>;
> > +                               };
> > +                       };
> > +               };
> 
> I still wonder if this is accurate, but OK.
> 

Afaict it matches downstream, not sure if I'm missing something?

[..]
> > +       intc: interrupt-controller at 17a00000 {
> > +               compatible = "arm,gic-v3";
> > +               reg = <0x17a00000 0x10000>,       /* GICD */
> > +                     <0x17b00000 0x100000>;      /* GICR * 8 */
> > +               #interrupt-cells = <3>;
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               ranges;
> > +               interrupt-controller;
> > +               #redistributor-regions = <1>;
> > +               redistributor-stride = <0x0 0x20000>;
> 
> Is this needed? The redistributor stuff can be left out if there's only
> one right?
> 

#redistributor-regions is listed as optional if there's more than 1, the
stride is still needed.

Afaict the stride still needs to be specified, as it's different from
the default 64kb.

> > +               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +       };
> > +
> > +       blsp2_uart1: serial at c1b0000 {
> 
> Clk name says uart2 though?
> 

That's because it's the wrong clock. Thanks!

> > +               compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> > +               reg = <0xc1b0000 0x1000>;
> > +               interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> > +               clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
> > +                        <&gcc GCC_BLSP2_AHB_CLK>;
> > +               clock-names = "core", "iface";
> > +               status = "disabled";
> > +       };

Regards,
Bjorn
