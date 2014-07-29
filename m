From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 29 Jul 2014 13:32:21 +0100
Subject: [PATCH v15 07/12] ARM: dts: append hip04 dts
In-Reply-To: <CAD6h2NQLgB1=8+WznE19rjsFwm3XWPUYEbDuPCbKbWjseRCBDg@mail.gmail.com>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-8-git-send-email-haojian.zhuang@linaro.org>
 <20140728180609.GE2576@leverpostej>
 <CAD6h2NQLgB1=8+WznE19rjsFwm3XWPUYEbDuPCbKbWjseRCBDg@mail.gmail.com>
Message-ID: <20140729123221.GN2576@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 03:44:40AM +0100, Haojian Zhuang wrote:
> On 29 July 2014 02:06, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Jul 28, 2014 at 02:57:51PM +0100, Haojian Zhuang wrote:
> >> Add hip04-d01.dts & hip04.dtsi for hip04 SoC platform.
> >>
> >> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> >> ---
> >>  arch/arm/boot/dts/Makefile      |   1 +
> >>  arch/arm/boot/dts/hip04-d01.dts |  39 ++++++
> >>  arch/arm/boot/dts/hip04.dtsi    | 267 ++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 307 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/hip04-d01.dts
> >>  create mode 100644 arch/arm/boot/dts/hip04.dtsi
> >>
> >> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >> index 721525e..6587bbf 100644
> >> --- a/arch/arm/boot/dts/Makefile
> >> +++ b/arch/arm/boot/dts/Makefile
> >> @@ -86,6 +86,7 @@ dtb-$(CONFIG_ARCH_HI3xxx) += hi3620-hi4511.dtb
> >>  dtb-$(CONFIG_ARCH_HIX5HD2) += hix5hd2-dkb.dtb
> >>  dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
> >>         ecx-2000.dtb
> >> +dtb-$(CONFIG_ARCH_HIP04) += hip04-d01.dtb
> >>  dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
> >>         integratorcp.dtb
> >>  dtb-$(CONFIG_ARCH_KEYSTONE) += k2hk-evm.dtb \
> >> diff --git a/arch/arm/boot/dts/hip04-d01.dts b/arch/arm/boot/dts/hip04-d01.dts
> >> new file mode 100644
> >> index 0000000..661c8e5
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/hip04-d01.dts
> >> @@ -0,0 +1,39 @@
> >> +/*
> >> + *  Copyright (C) 2013-2014 Linaro Ltd.
> >> + *  Author: Haojian Zhuang <haojian.zhuang@linaro.org>
> >> + *
> >> + *  This program is free software; you can redistribute it and/or modify
> >> + *  it under the terms of the GNU General Public License version 2 as
> >> + *  publishhed by the Free Software Foundation.
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +/* For bootwrapper */
> >> +/memreserve/ 0x10c00000 0x00010000;
> >
> > How exactly is this bootwrapper used? Is the kernel compiled into it?
> >
> > It might make more sense for the wrapper build system to inject
> > bootwrapper-related properties. Then the DTB is less likely to
> > amalgamate hacks to workaround differences between versions, and can be
> > used on systems without a wrapper without throwing away some memory.
> >
> 
> In this platform, we relied on the bootwrapper. If I discard this,
> I'll fail to bring up all secondary cores.

What loads the boot wrapper into memory, and from where?

In another reply you mentioned you're using UEFI. Is this wrapper
considered part of your UEFI implementation? If so it should be reserved
in the UEFI memory map, and there should be no need of memory nodes or
memreserves -- all that should come from UEFI.

What exactly is the boot wrapper in charge of?

What is the split in responsiblity between the wrapper and the kernel?

[...]

> >> +               };
> >> +
> >> +               fabric: fabric {
> >> +                       compatible = "hisilicon,hip04-fabric";
> >> +                       reg = <0x302a000 0x1000>;
> >
> > How is this going to be used?
> >
> 
> Fabric could configure snoop filter of multiple cluster. I don't have
> the manual. I only know this.

Is this accessible to the non-secure side?

If the firmware is currently programming things correctly then we
shouldn't need this for now.

> >> +               };
> >> +
> >> +               dual_timer0: dual_timer at 3000000 {
> >> +                       compatible = "arm,sp804", "arm,primecell";
> >> +                       reg = <0x3000000 0x1000>;
> >> +                       interrupts = <0 224 4>;
> >> +                       clocks = <&clock HIP04_CLK_50M>;
> >> +                       clock-names = "apb_pclk";
> >> +               };
> >
> > I thought sp804 had two clocks (one for AMBA and one for the actual
> > timer). What's going on here?
> >
> 
> If only one clock is configured at here, sp804 driver believes that
> clk2 is same as clk1.

I'm not keen on relying on that. It's arguably a bug in the driver.

Thanks,
Mark.
