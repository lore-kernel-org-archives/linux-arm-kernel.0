From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Fri, 24 Feb 2017 15:57:26 +0800
Subject: [PATCH V2 1/3] arm64: dts: Add basic DT to support Spreadtrum's
 SP9860G
In-Reply-To: <CAL_JsqJ-VXB8pJw3r_fi9Lbmat2dqH-1jmGy8ibK8=PnoZ-c=Q@mail.gmail.com>
References: <1487660104-15693-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1487660104-15693-2-git-send-email-chunyan.zhang@spreadtrum.com>
 <CAL_JsqJ-VXB8pJw3r_fi9Lbmat2dqH-1jmGy8ibK8=PnoZ-c=Q@mail.gmail.com>
Message-ID: <20170224075725.GA32714@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?,  2? 23, 2017 at 06:00:20?? -0600, Rob Herring wrote:
> On Tue, Feb 21, 2017 at 12:55 AM, Chunyan Zhang
> <chunyan.zhang@spreadtrum.com> wrote:
> > From: Orson Zhai <orson.zhai@spreadtrum.com>
> >
> > SC9860G is a 8 cores of A53 SoC with 4G LTE support SoC from Spreadtrum.
> >
> > According to regular hierarchy of sprd dts, whale2.dtsi contains SoC
> > peripherals IP nodes, sc9860.dtsi contains stuff related to ARM core stuff
> > and sp9860g dts is for the board level.
> >
> > Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> > ---
> >  arch/arm64/boot/dts/sprd/Makefile         |   3 +-
> >  arch/arm64/boot/dts/sprd/sc9860.dtsi      | 531 ++++++++++++++++++++++++++++++
> >  arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |  56 ++++
> >  arch/arm64/boot/dts/sprd/whale2.dtsi      |  70 ++++
> >  4 files changed, 659 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/boot/dts/sprd/sc9860.dtsi
> >  create mode 100644 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> >  create mode 100644 arch/arm64/boot/dts/sprd/whale2.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/sprd/Makefile b/arch/arm64/boot/dts/sprd/Makefile
> > index b658c5e..f0535e6 100644
> > --- a/arch/arm64/boot/dts/sprd/Makefile
> > +++ b/arch/arm64/boot/dts/sprd/Makefile
> > @@ -1,4 +1,5 @@
> > -dtb-$(CONFIG_ARCH_SPRD) += sc9836-openphone.dtb
> > +dtb-$(CONFIG_ARCH_SPRD) += sc9836-openphone.dtb \
> > +                       sp9860g-1h10.dtb
> >
> >  always         := $(dtb-y)
> >  subdir-y       := $(dts-dirs)
> > diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
> > new file mode 100644
> > index 0000000..73deb4e
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
> > @@ -0,0 +1,531 @@
> > +/*
> > + * Spreadtrum SP9860 SoC DTS file
> > + *
> > + * Copyright (C) 2016, Spreadtrum Communications Inc.
> > + *
> > + * This file is licensed under a dual GPLv2 or X11 license.
> 
> Please use SPDX-License-Identifier tag instead.
>

Just to double check, if I use it like:

SPDX-License-Identifier: (GPL-2.0 or X11)

Is this what you mean?
Will this file still be licensed under the same terms it was, right?
 
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include "whale2.dtsi"
> > +
> > +/ {
> > +       cpus {
> > +               #address-cells = <2>;
> > +               #size-cells = <0>;
> > +
> > +               cpu-map {
> > +                       cluster0 {
> > +                               core0 {
> > +                                       cpu = <&CPU0>;
> > +                               };
> > +                               core1 {
> > +                                       cpu = <&CPU1>;
> > +                               };
> > +                               core2 {
> > +                                       cpu = <&CPU2>;
> > +                               };
> > +                               core3 {
> > +                                       cpu = <&CPU3>;
> > +                               };
> > +                       };
> > +
> > +                       cluster1 {
> > +                               core0 {
> > +                                       cpu = <&CPU4>;
> > +                               };
> > +                               core1 {
> > +                                       cpu = <&CPU5>;
> > +                               };
> > +                               core2 {
> > +                                       cpu = <&CPU6>;
> > +                               };
> > +                               core3 {
> > +                                       cpu = <&CPU7>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               CPU0: cpu at 530000 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53", "arm,armv8";
> > +                       reg = <0x0 0x530000>;
> > +                       enable-method = "psci";
> > +                       cpu-idle-states = <&CORE_PD &CLUSTER_PD>;
> > +               };
> > +
> > +               CPU1: cpu at 530001 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53", "arm,armv8";
> > +                       reg = <0x0 0x530001>;
> > +                       enable-method = "psci";
> > +                       cpu-idle-states = <&CORE_PD &CLUSTER_PD>;
> > +               };
> > +
> > +               CPU2: cpu at 530002 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53", "arm,armv8";
> > +                       reg = <0x0 0x530002>;
> > +                       enable-method = "psci";
> > +                       cpu-idle-states = <&CORE_PD &CLUSTER_PD>;
> > +               };
> > +
> > +               CPU3: cpu at 530003 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53", "arm,armv8";
> > +                       reg = <0x0 0x530003>;
> > +                       enable-method = "psci";
> > +                       cpu-idle-states = <&CORE_PD &CLUSTER_PD>;
> > +               };
> > +
> > +               CPU4: cpu at 530100 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53", "arm,armv8";
> > +                       reg = <0x0 0x530100>;
> > +                       enable-method = "psci";
> > +                       cpu-idle-states = <&CORE_PD &CLUSTER_PD>;
> > +               };
> > +
> > +               CPU5: cpu at 530101 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53", "arm,armv8";
> > +                       reg = <0x0 0x530101>;
> > +                       enable-method = "psci";
> > +                       cpu-idle-states = <&CORE_PD &CLUSTER_PD>;
> > +               };
> > +
> > +               CPU6: cpu at 530102 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53", "arm,armv8";
> > +                       reg = <0x0 0x530102>;
> > +                       enable-method = "psci";
> > +                       cpu-idle-states = <&CORE_PD &CLUSTER_PD>;
> > +               };
> > +
> > +               CPU7: cpu at 530103 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53", "arm,armv8";
> > +                       reg = <0x0 0x530103>;
> > +                       enable-method = "psci";
> > +                       cpu-idle-states = <&CORE_PD &CLUSTER_PD>;
> > +               };
> > +       };
> > +
> > +       idle-states{
> > +               entry-method = "arm,psci";
> > +
> > +               CORE_PD: core_pd {
> > +                       compatible = "arm,idle-state";
> > +                       entry-latency-us = <1000>;
> > +                       exit-latency-us = <700>;
> > +                       min-residency-us = <2500>;
> > +                       local-timer-stop;
> > +                       arm,psci-suspend-param = <0x00010002>;
> > +               };
> > +
> > +               CLUSTER_PD: cluster_pd {
> > +                       compatible = "arm,idle-state";
> > +                       entry-latency-us = <1000>;
> > +                       exit-latency-us = <1000>;
> > +                       min-residency-us = <3000>;
> > +                       local-timer-stop;
> > +                       arm,psci-suspend-param = <0x01010003>;
> > +               };
> > +       };
> > +
> > +       gic: interrupt-controller at 12001000 {
> > +               compatible = "arm,gic-400";
> > +               reg = <0 0x12001000 0 0x1000>,
> > +                     <0 0x12002000 0 0x2000>,
> > +                     <0 0x12004000 0 0x2000>,
> > +                     <0 0x12006000 0 0x2000>;
> > +               #interrupt-cells = <3>;
> > +               interrupt-controller;
> > +               interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8)
> > +                                       | IRQ_TYPE_LEVEL_HIGH)>;
> > +       };
> > +
> > +       psci {
> > +               compatible = "arm,psci-0.2";
> > +               method = "smc";
> > +       };
> > +
> > +       timer {
> > +               compatible = "arm,armv8-timer";
> > +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8)
> > +                                        | IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8)
> > +                                        | IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8)
> > +                                        | IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8)
> > +                                        | IRQ_TYPE_LEVEL_LOW)>;
> > +       };
> > +
> > +       pmu {
> > +               compatible = "arm,cortex-a53-pmu", "arm,armv8-pmuv3";
> > +               interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
> > +               interrupt-affinity = <&CPU0>,
> > +                                    <&CPU1>,
> > +                                    <&CPU2>,
> > +                                    <&CPU3>,
> > +                                    <&CPU4>,
> > +                                    <&CPU5>,
> > +                                    <&CPU6>,
> > +                                    <&CPU7>;
> > +       };
> > +
> > +       soc {
> > +               soc_funnel: funnel at 10001000 {
> > +                       compatible = "arm,coresight-funnel", "arm,primecell";
> > +                       reg = <0 0x10001000 0 0x1000>;
> 
> If all the devices are within 0x1xxxxxxx, then use ranges property to
> limit the address range. It doesn't look like address or size cells
> needs to be 2.

There're some devices not included in this DT for now whose addresses
is 64-bit.  I will add more devices into this device tree later on.

> 
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +                       ports {
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +
> > +                               port at 0 {
> > +                                       reg = <0>;
> > +                                       soc_funnel_out_port: endpoint {
> > +                                               remote-endpoint = <&etb_in>;
> > +                                       };
> > +                               };
> > +
> > +                               port at 1 {
> > +                                       reg = <0>;
> > +                                       soc_funnel_in_port: endpoint {
> > +                                               slave-mode;
> > +                                               remote-endpoint =
> > +                                               <&main_funnel_out_port>;
> > +                                       };
> > +                               };
> > +                       };
> > +               };
> > +
> > +               etb at 10003000 {
> > +                       compatible = "arm,coresight-tmc", "arm,primecell";
> > +                       reg = <0 0x10003000 0 0x1000>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +                       port {
> > +                               etb_in: endpoint {
> > +                                       slave-mode;
> > +                                       remote-endpoint =
> > +                                               <&soc_funnel_out_port>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               cluster0_funnel: funnel at 11001000 {
> > +                       compatible = "arm,coresight-funnel", "arm,primecell";
> > +                       reg = <0 0x11001000 0 0x1000>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +                       ports {
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +
> > +                               port at 0 {
> > +                                       reg = <0>;
> > +                                       cluster0_funnel_out_port: endpoint {
> > +                                               remote-endpoint =
> > +                                                       <&cluster0_etf_in>;
> > +                                       };
> > +                               };
> > +
> > +                               port at 1 {
> > +                                       reg = <0>;
> > +                                       cluster0_funnel_in_port0: endpoint {
> > +                                               slave-mode;
> > +                                               remote-endpoint = <&etm0_out>;
> > +                                       };
> > +                               };
> > +
> > +                               port at 2 {
> > +                                       reg = <1>;
> > +                                       cluster0_funnel_in_port1: endpoint {
> > +                                               slave-mode;
> > +                                               remote-endpoint = <&etm1_out>;
> > +                                       };
> > +                               };
> > +
> > +                               port at 3 {
> > +                                       reg = <2>;
> > +                                       cluster0_funnel_in_port2: endpoint {
> > +                                               slave-mode;
> > +                                               remote-endpoint = <&etm2_out>;
> > +                                       };
> > +                               };
> > +
> > +                               port at 4 {
> > +                                       reg = <4>;
> > +                                       cluster0_funnel_in_port3: endpoint {
> > +                                               slave-mode;
> > +                                               remote-endpoint = <&etm3_out>;
> > +                                       };
> > +                               };
> > +                       };
> > +               };
> > +
> > +               cluster1_funnel: funnel at 11002000 {
> > +                       compatible = "arm,coresight-funnel", "arm,primecell";
> > +                       reg = <0 0x11002000 0 0x1000>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +                       ports {
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +
> > +                               port at 0 {
> > +                                       reg = <0>;
> > +                                       cluster1_funnel_out_port: endpoint {
> > +                                               remote-endpoint =
> > +                                                       <&cluster1_etf_in>;
> > +                                       };
> > +                               };
> > +
> > +                               port at 1 {
> > +                                       reg = <0>;
> > +                                       cluster1_funnel_in_port0: endpoint {
> > +                                               slave-mode;
> > +                                               remote-endpoint = <&etm4_out>;
> > +                                       };
> > +                               };
> > +
> > +                               port at 2 {
> > +                                       reg = <1>;
> > +                                       cluster1_funnel_in_port1: endpoint {
> > +                                               slave-mode;
> > +                                               remote-endpoint = <&etm5_out>;
> > +                                       };
> > +                               };
> > +
> > +                               port at 3 {
> > +                                       reg = <2>;
> > +                                       cluster1_funnel_in_port2: endpoint {
> > +                                               slave-mode;
> > +                                               remote-endpoint = <&etm6_out>;
> > +                                       };
> > +                               };
> > +
> > +                               port at 4 {
> > +                                       reg = <3>;
> > +                                       cluster1_funnel_in_port3: endpoint {
> > +                                               slave-mode;
> > +                                               remote-endpoint = <&etm7_out>;
> > +                                       };
> > +                               };
> > +                       };
> > +               };
> > +
> > +               cluster0_etf: etf at 11003000 {
> > +                       compatible = "arm,coresight-tmc", "arm,primecell";
> > +                       reg = <0 0x11003000 0 0x1000>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +
> > +                       port at 0 {
> > +                               cluster0_etf_out: endpoint {
> > +                                       remote-endpoint =
> > +                                               <&main_funnel_in_port0>;
> > +                               };
> > +                       };
> > +
> > +                       port at 1 {
> > +                               cluster0_etf_in: endpoint {
> > +                                       slave-mode;
> > +                                       remote-endpoint =
> > +                                               <&cluster0_funnel_out_port>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               cluster1_etf: etf at 11004000 {
> > +                       compatible = "arm,coresight-tmc", "arm,primecell";
> > +                       reg = <0 0x11004000 0 0x1000>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +
> > +                       port at 0 {
> > +                               cluster1_etf_out: endpoint {
> > +                                       remote-endpoint =
> > +                                               <&main_funnel_in_port1>;
> > +                               };
> > +                       };
> > +
> > +                       port at 1 {
> > +                               cluster1_etf_in: endpoint {
> > +                                       slave-mode;
> > +                                       remote-endpoint =
> > +                                               <&cluster1_funnel_out_port>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               main_funnel: funnel at 11005000 {
> > +                       compatible = "arm,coresight-funnel", "arm,primecell";
> > +                       reg = <0 0x11005000 0 0x1000>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +
> > +                       ports {
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +
> > +                               port at 0 {
> > +                                       reg = <0>;
> > +                                       main_funnel_out_port: endpoint {
> > +                                               remote-endpoint =
> > +                                                       <&soc_funnel_in_port>;
> > +                                       };
> > +                               };
> > +
> > +                               port at 1 {
> > +                                       reg = <0>;
> > +                                       main_funnel_in_port0: endpoint {
> > +                                               slave-mode;
> > +                                               remote-endpoint =
> > +                                                       <&cluster0_etf_out>;
> > +                                       };
> > +                               };
> > +
> > +                               port at 2 {
> > +                                       reg = <1>;
> > +                                       main_funnel_in_port1: endpoint {
> > +                                               slave-mode;
> > +                                               remote-endpoint =
> > +                                                       <&cluster1_etf_out>;
> > +                                       };
> > +                               };
> > +                       };
> > +               };
> > +
> > +               etm at 11440000 {
> > +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                       reg = <0 0x11440000 0 0x1000>;
> > +                       cpu = <&CPU0>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +
> > +                       port {
> > +                               etm0_out: endpoint {
> > +                                       remote-endpoint =
> > +                                               <&cluster0_funnel_in_port0>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               etm at 11540000 {
> > +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                       reg = <0 0x11540000 0 0x1000>;
> > +                       cpu = <&CPU1>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +
> > +                       port {
> > +                               etm1_out: endpoint {
> > +                                       remote-endpoint =
> > +                                               <&cluster0_funnel_in_port1>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               etm at 11640000 {
> > +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                       reg = <0 0x11640000 0 0x1000>;
> > +                       cpu = <&CPU2>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +
> > +                       port {
> > +                               etm2_out: endpoint {
> > +                                       remote-endpoint =
> > +                                               <&cluster0_funnel_in_port2>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               etm at 11740000 {
> > +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                       reg = <0 0x11740000 0 0x1000>;
> > +                       cpu = <&CPU3>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +
> > +                       port {
> > +                               etm3_out: endpoint {
> > +                                       remote-endpoint =
> > +                                               <&cluster0_funnel_in_port3>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               etm at 11840000 {
> > +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                       reg = <0 0x11840000 0 0x1000>;
> > +                       cpu = <&CPU4>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +
> > +                       port {
> > +                               etm4_out: endpoint {
> > +                                       remote-endpoint =
> > +                                               <&cluster1_funnel_in_port0>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               etm at 11940000 {
> > +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                       reg = <0 0x11940000 0 0x1000>;
> > +                       cpu = <&CPU5>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +
> > +                       port {
> > +                               etm5_out: endpoint {
> > +                                       remote-endpoint =
> > +                                               <&cluster1_funnel_in_port1>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               etm at 11a40000 {
> > +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                       reg = <0 0x11a40000 0 0x1000>;
> > +                       cpu = <&CPU6>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +
> > +                       port {
> > +                               etm6_out: endpoint {
> > +                                       remote-endpoint =
> > +                                               <&cluster1_funnel_in_port2>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               etm at 11b40000 {
> > +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                       reg = <0 0x11b40000 0 0x1000>;
> > +                       cpu = <&CPU7>;
> > +                       clocks = <&ext_26m>;
> > +                       clock-names = "apb_pclk";
> > +
> > +                       port {
> > +                               etm7_out: endpoint {
> > +                                       remote-endpoint =
> > +                                               <&cluster1_funnel_in_port3>;
> > +                               };
> > +                       };
> > +               };
> > +       };
> > +};
> > diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> > new file mode 100644
> > index 0000000..5faa452
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> > @@ -0,0 +1,56 @@
> > +/*
> > + * Spreadtrum SP9860g board DTS file
> > + *
> > + * Copyright (C) 2017, Spreadtrum Communications Inc.
> > + *
> > + * This file is licensed under a dual GPLv2 or X11 license.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sc9860.dtsi"
> > +
> > +/ {
> > +       model = "Spreadtrum SP9860G 3GFHD Board";
> > +
> > +       compatible = "sprd,sp9860g-1h10", "sprd,sc9860";
> > +
> > +       aliases {
> > +               serial0 = &uart0; /* for Bluetooth */
> > +               serial1 = &uart1; /* UART console */
> > +               serial2 = &uart2; /* Reserved */
> > +               serial3 = &uart3; /* for GPS */
> > +       };
> > +
> > +       memory{
> > +               device_type = "memory";
> > +               reg = <0x0 0x80000000 0 0x60000000>,
> > +                     <0x1 0x80000000 0 0x60000000>;
> > +       };
> > +
> > +       chosen {
> > +               stdout-path = "serial1:115200n8";
> > +       };
> > +
> > +       reserved-memory {
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges;
> > +       };
> > +};
> > +
> > +&uart0 {
> > +       status = "okay";
> > +};
> > +
> > +&uart1 {
> > +       status = "okay";
> > +};
> > +
> > +&uart2 {
> > +       status = "okay";
> > +};
> > +
> > +&uart3 {
> > +       status = "okay";
> > +};
> > diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
> > new file mode 100644
> > index 0000000..64f06d9
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
> > @@ -0,0 +1,70 @@
> > +/*
> > + * Spreadtrum Whale2 SoC platform peripherals DTS file
> > + *
> > + * Copyright (C) 2016, Spreadtrum Communications Inc.
> > + *
> > + * This file is licensed under a dual GPLv2 or X11 license.
> > + */
> > +
> > +/ {
> > +       interrupt-parent = <&gic>;
> > +       #address-cells = <2>;
> > +       #size-cells = <2>;
> > +
> > +       soc: soc {
> > +               compatible = "simple-bus";
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges;
> > +
> > +               ap-apb {
> > +                       compatible = "simple-bus";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges = <0 0x0 0x70000000 0x10000000>;
> 
> Probably you should have 2 buses for each range of addresses.

I may not understand your point, I just looked at the SoC specification, the
address range of this AP APB bus is from 0x70000000 ~ 0x7fffffff.

> 
> > +
> > +                       uart0: serial at 70000000 {
> > +                               compatible = "sprd,sc9838-uart",
> > +                                            "sprd,sc9836-uart";
> > +                               reg = <0x000000 0x100>;
> > +                               interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> > +                               clocks = <&ext_26m>;
> > +                               status = "disabled";
> > +                       };
> > +
> > +                       uart1: serial at 70100000 {
> > +                               compatible = "sprd,sc9838-uart",
> > +                                            "sprd,sc9836-uart";
> > +                               reg = <0x100000 0x100>;
> > +                               interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> > +                               clocks = <&ext_26m>;
> > +                               status = "disabled";
> > +                       };
> > +
> > +                       uart2: serial at 70200000 {
> > +                               compatible = "sprd,sc9838-uart",
> > +                                            "sprd,sc9836-uart";
> > +                               reg = <0x200000 0x100>;
> > +                               interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> > +                               clocks = <&ext_26m>;
> > +                               status = "disabled";
> > +                       };
> > +
> > +                       uart3: serial at 70300000 {
> > +                               compatible = "sprd,sc9838-uart",
> > +                                            "sprd,sc9836-uart";
> > +                               reg = <0x300000 0x100>;
> > +                               interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> > +                               clocks = <&ext_26m>;
> > +                               status = "disabled";
> > +                       };
> > +               };
> > +
> > +               ext_26m: ext-26m {
> 
> This should be at the top-level. It is not part of the bus.

This clock node is in 'soc' node, not under 'ap-apb'.  Since there're other
clocks on SC9860 which would have 'reg' property, we thought this fixed
clock would be better under 'soc' with other clocks.

Thanks your comments,
Chunyan

> 
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <26000000>;
> > +                       clock-output-names = "ext_26m";
> > +               };
> > +       };
> > +};
> > --
> > 2.7.4
> >
