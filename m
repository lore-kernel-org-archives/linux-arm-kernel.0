From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Oct 2014 12:57:11 +0200
Subject: [RFC 3/7] ARM: vf610m4: add new machine and SoC for Vybrid on
 Cortex-M4
In-Reply-To: <776a06abd938d507d7798670e6ad27d1@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
 <2790232.XFn8jX0Lfm@wuerfel> <776a06abd938d507d7798670e6ad27d1@agner.ch>
Message-ID: <2289511.sEGFxtoWl5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 October 2014 12:03:12 Stefan Agner wrote:
> Am 2014-10-12 20:51, schrieb Arnd Bergmann:
> > On Sunday 12 October 2014 20:13:57 Stefan Agner wrote:
> >> This patch adds a new machine ARCH_MXCM4 which requires !MMU and
> >> !MULTIARCH and is meant as machine for the hetregenous multi-core
> >> Vybrid/i.MX SoC's to run Linux on the Cortex-M4.
> >>
> >> The first SoC supported is Vybrid on Cortex-M4 (SOC_VF610M4).
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >> Not sure whether we really need a new MACH, but since MACH_MXC needs
> >> MULTIARCH, which in turn conflicts with !MMU, I guess there is no
> >> easier way to do it... And then, this also needs a new SOC.
> > 
> > I've carried an experimental patch to enable !MMU in combination with
> > MULTIPLATFORM for a while, it's probably time to do this for real now,
> > especially since we now have two !MMU platforms that can be built
> > together. Independent of the question of whether such a combined kernel
> > could run on real hardware or anybody would want to run such a kernel
> > if it were possible, I think it's very useful to be able to build
> > allmodconfig with MMU disabled and get all drivers for the available
> > platforms for build testing.
> 
> Are these patches online somewhere?
> 
> That sounds interesting. I guess I can get rid of ARCH_MXCM4 then.
> Still, SOC_VF610M4 will be needed. We just need to make ARCH_MXC also
> available on !MMU and use if to distinguish !MMU/MMU SoC's.

I have a long series of patches at
http://git.kernel.org/cgit/linux/kernel/git/arnd/playground.git
and I should upload a newer version of that.

The part with !MMU support has to be changed anyway, but you can
get a lot of useful patches from my tree if you look carefully.

We should probably have a Kconfig symbol

config ARCH_MULTIPLATFORM_STRICT
	bool "Allow only configurations that do not break multiplatform support"
	depends on ARCH_MULTIPLATFORM && EXPERT

and then make this mutually exclusive with all options that are known
to break multiplatform: !MMU, CPU_BIG_ENDIAN, DEBUG_LL, XIP_KERNEL,
!AUTO_ZRELADDR, !ARM_PATCH_PHYS_VIRT and a lot of the errata workarounds
that are currently 'depends on !MULTIPLATFORM'.

Also, we currently have a rather complex setup to pick the allowed
CPU architecture levels in arbitrary combinations. Adding in V7M
would make this even more complicated, so I'd rather simplify it first,
and change it into a "minimum architecture level" choice statement,
which in effect isn't all that different to what we have today.

Something like

choice "CPU Core family selection"

config ARCH_MULTI_V4_MIN
	bool "ARMv4 based platforms (FA526)"
	select ARCH_MULTI_V4
	select ARCH_MULTI_V4T
	select ARCH_MULTI_V5

config ARCH_MULTI_V4T_MIN
	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
	select ARCH_MULTI_V4T
	select ARCH_MULTI_V5

config ARCH_MULTI_V5_MIN
	bool "ARMv5 based platforms (ARM926T, PJ1, ...)"
	select ARCH_MULTI_V5

config ARCH_MULTI_V6_MIN
	bool "ARMv6 based platforms (ARM1136r0)"
	select ARCH_MULTI_V6
	select ARCH_MULTI_V6K
	select ARCH_MULTI_V7
	select ARCH_MULTI_V7_VE

config ARCH_MULTI_V6K_MIN
	bool "ARMv6K based platforms (ARM1136r1, ARM1176, ARM11MPCORE)"
	select ARCH_MULTI_V6K
	select ARCH_MULTI_V7
	select ARCH_MULTI_V7VE

config ARCH_MULTI_V7_MIN
	bool "ARMv7 based platforms (Cortex-A5/A8/A9, PJ4, Scorpion)"
	select ARCH_MULTI_V7
	select ARCH_MULTI_V7VE

config ARCH_MULTI_V7_VEMIN
	bool "ARMv7VE based platforms (Cortex-A7/A12/A15/A17, Brahma-B15, Krait)"
	select ARCH_MULTI_V7VE

config ARCH_MULTI_V7M
	bool "ARMv7-M based platforms (Cortex-M3/M4/M7)"

endchoice

I'm not sure about the exact symbol names, we should try to minimize the
impact on existing configuration file when doing this.

	Arnd
