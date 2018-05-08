From: swboyd@chromium.org (Stephen Boyd)
Date: Tue, 08 May 2018 09:32:58 -0700
Subject: [PATCH v2 1/2] arm64: dts: Add msm8998 SoC and MTP board support
In-Reply-To: <20180507233511.GC14924@minitux>
References: <20180428054248.22387-1-bjorn.andersson@linaro.org>
 <152573399648.138124.10341359049104453178@swboyd.mtv.corp.google.com>
 <20180507233511.GC14924@minitux>
Message-ID: <152579717814.138124.2254267448028084692@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Bjorn Andersson (2018-05-07 16:35:11)
> On Mon 07 May 15:59 PDT 2018, Stephen Boyd wrote:
> 
> > Quoting Bjorn Andersson (2018-04-27 22:42:47)
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > > new file mode 100644
> > > index 000000000000..d6665e4f801f
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > > @@ -0,0 +1,340 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2016, The Linux Foundation. All rights reserved. */
> > > +
> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +#include <dt-bindings/clock/qcom,gcc-msm8998.h>
> > > +
> > > +/ {
> > > +       model = "Qualcomm Technologies, Inc. MSM 8998";

Drop the space between MSM and 8998?

> > > +
> > > +       interrupt-parent = <&intc>;
> > > +
> > > +       qcom,msm-id = <292 0x0>;
> > 
> > No update to dtbtool?
> > 
> 
> This allows me to concatenate the dtb to the Image.gz and boot the
> device. From my scripts I see that I tried to use dtbTool before
> reverting to this...

Oh, must be that the bootloader mandates the magic numbers exist in the
blob and you can't concatenate a single dtb and have it ignore the magic
numbers? Sounds perfect.

> 
> [..]
> > > +               cpu-map {
> > > +                       cluster0 {
> > > +                               core0 {
> > > +                                       cpu = <&CPU0>;
> > > +                               };
> > > +
> > > +                               core1 {
> > > +                                       cpu = <&CPU1>;
> > > +                               };
> > > +
> > > +                               core2 {
> > > +                                       cpu = <&CPU2>;
> > > +                               };
> > > +
> > > +                               core3 {
> > > +                                       cpu = <&CPU3>;
> > > +                               };
> > > +                       };
> > > +
> > > +                       cluster1 {
> > > +                               core0 {
> > > +                                       cpu = <&CPU4>;
> > > +                               };
> > > +
> > > +                               core1 {
> > > +                                       cpu = <&CPU5>;
> > > +                               };
> > > +
> > > +                               core2 {
> > > +                                       cpu = <&CPU6>;
> > > +                               };
> > > +
> > > +                               core3 {
> > > +                                       cpu = <&CPU7>;
> > > +                               };
> > > +                       };
> > > +               };
> > 
> > I still wonder if this is accurate, but OK.
> > 
> 
> Afaict it matches downstream, not sure if I'm missing something?

Right, it matches downstream, but I seem to recall that downstream was
describing the power "clusters" for big and little, when this mapping
usually follows the cache layout of the CPUs (i.e. if all CPUs share a
cache then they're in the same cluster).

> 
> [..]
> > > +       intc: interrupt-controller at 17a00000 {
> > > +               compatible = "arm,gic-v3";
> > > +               reg = <0x17a00000 0x10000>,       /* GICD */
> > > +                     <0x17b00000 0x100000>;      /* GICR * 8 */
> > > +               #interrupt-cells = <3>;
> > > +               #address-cells = <1>;
> > > +               #size-cells = <1>;
> > > +               ranges;
> > > +               interrupt-controller;
> > > +               #redistributor-regions = <1>;
> > > +               redistributor-stride = <0x0 0x20000>;
> > 
> > Is this needed? The redistributor stuff can be left out if there's only
> > one right?
> > 
> 
> #redistributor-regions is listed as optional if there's more than 1, the
> stride is still needed.
> 
> Afaict the stride still needs to be specified, as it's different from
> the default 64kb.

There's one region though. Marc rejected those properties in the sdm845
dts file[1] and it looks exactly the same here. It would be nice if the
ITS region was described (we know it's there and it's probably the same
offset as on SDM845 no doubt).

> 
> > > +               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > > +       };
> > > +
> > > +       blsp2_uart1: serial at c1b0000 {
> > 
> > Clk name says uart2 though?
> > 
> 
> That's because it's the wrong clock. Thanks!

Hah!

[1] https://lkml.kernel.org/r/96fac632-8fb8-0933-cc1f-627acb38a595 at arm.com
