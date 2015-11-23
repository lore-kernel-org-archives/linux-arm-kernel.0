From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Nov 2015 22:57:07 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20151123213206.GG19156@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <133921941.Qfq59EaTOs@wuerfel> <20151123213206.GG19156@codeaurora.org>
Message-ID: <6359949.bhCrxaQvmL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 November 2015 13:32:06 Stephen Boyd wrote:
> On 11/23, Arnd Bergmann wrote:
> > On Monday 23 November 2015 12:38:47 Stephen Boyd wrote:
> > > On 11/23, Arnd Bergmann wrote:
> > > > On Monday 23 November 2015 09:14:39 Christopher Covington wrote:
> > > > > On 11/23/2015 03:15 AM, Arnd Bergmann wrote:
> > > > > LPAE is only supported in the Krait 450.
> > > > > 
> > > > > http://www.anandtech.com/show/7537/qualcomms-snapdragon-805-25ghz-128bit-memory-interface-d3d11class-graphics-more
> > > > > 
> > > > > I'm pretty sure idiv support came earlier, but I don't have the
> > > > > specifics on hand.
> > > > 
> > > > I have seen that article, but didn't trust it as a canonical
> > > > source of information here.
> > > > 
> > > > If you can confirm that it's right, that would mean that we
> > > > don't support LPAE on mach-qcom, as the only SoC with Krait 450
> > > > seems to be APQ8084, and mainline Linux doesn't run on that.
> > > 
> > > arch/arm/boot/dts/qcom-apq8084.dtsi exists in the mainline
> > > kernel. We support more than what's in the Kconfig language
> > > under mach-qcom.
> > 
> > Ok, cool. I'm sometimes confused by the model numbers, could you
> > do a separate patch to update the Kconfig help text?
> 
> What did you have in mind? I'm also confused by the model numbers
> so I don't know how helpful I will be.
> 
> It would be nice to drop the ARCH_MSM* configs entirely. If we
> could select the right timers from kconfig without using selects
> then we could drop them. Or we could just select both types of
> timers when building qcom platforms.

Ok, dropping the specific Kconfig entries is actually an awesome
idea, as it completely solves the other problem as well, more on
that below.

In that case, don't worry about listing all the models, once
we stop listing a subset of them, the confusion is already
reduced by the fact that one has to look at the .dts files
so see which models we support, and I assume there will be
additional ones coming in for at least a few more years (before
you stop caring about 32-bit MSM and compatibles).

Regarding the timers:
HAVE_ARM_ARCH_TIMER is already user-selectable, so maybe something
like

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b251013eef0a..bad6343c34d5 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -324,8 +324,9 @@ config EM_TIMER_STI
 	  such as EMEV2 from former NEC Electronics.
 
 config CLKSRC_QCOM
-	bool "Qualcomm MSM timer" if COMPILE_TEST
+	bool "Qualcomm MSM timer" if ARCH_QCOM || COMPILE_TEST
 	depends on ARM
+	default ARCH_QCOM
 	select CLKSRC_OF
 	help
 	  This enables the clocksource and the per CPU clockevent driver for the

would make both of them equally configurable and not clutter up
the Kconfig file when ARCH_QCOM is not selected. I've added
Daniel Lezcano to Cc, he probably has an opinion on this too.

> > > > The ones we do support are MSM8x60 (Scorpion), MSM8960
> > > > (Krait-without-number),and MSM7874 (Krait 400). Do those all
> > > > support IDIV but not LPAE?
> > > > 
> > > 
> > > Krait supports IDIV for all versions. Scorpion doesn't support
> > > IDIV or lpae. Here's the output of /proc/cpuinfo on that device. 
> > > 
> > > # cat /proc/cpuinfo
> > > processor       : 0
> > > model name      : ARMv7 Processor rev 2 (v7l)
> > > BogoMIPS        : 13.50
> > > Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
> > > CPU implementer : 0x51
> > > CPU architecture: 7
> > > CPU variant     : 0x0
> > > CPU part        : 0x02d
> > > CPU revision    : 2
> > 
> > Ok, that leaves just one missing puzzle piece: can you confirm that
> > no supported Krait variant other than Krait 450 / apq8084 has LPAE?
> > 
> 
> Right, apq8084 is the only SoC with a Krait CPU that supports
> LPAE.

Ok, thanks for the confirmation.

Summarizing what we've found, I think we can get away with just
introducing two Kconfig symbols ARCH_MULTI_V7VE and CPU_V7VE.
Most CPUs fall clearly into one category or the other, and then
we can allow LPAE to be selected for V7VE-only build but not
for plain V7, and we can unconditionally build the kernel with

arch-$(CONFIG_CPU_32v7VE)  = -D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7ve,-march=armv7-a -mcpu=cortex-a15)

This works perfectly for Cortex-A5, -A8, -A9, -A12, -A15, -A17, Brahma-B15,
PJ4B-MP, Scorpion and Krait-450, which all clearly fall into one of
the two other categories.

The two exceptions that don't quite fit are still "good enough":

- PJ4/PJ4B (not PJ4B-MP) has a different custom opcode for udiv and sdiv
  in ARM mode. We don't support that with true multiplatform kernels
  because those opcodes work nowhere else, though with your proposed
  series we could easily do that for dynamic patching.

- Krait (pre-450) won't run kernels with LPAE disabled, but if we only
  have one global ARCH_QCOM option that can be enabled for both
  ARCH_MULTI_V7VE and ARCH_MULTI_V7, we still win: a mach-qcom
  kernel with only ARCH_MULTI_V7VE will use IDIV by default, and
  give you the option to enable LPAE. If you pick LPAE, it will
  still work fine on Krait-450 but not the older ones, and that is
  a user error. If you enable ARCH_MULTI_V7 / CPU_V7, you get neither
  LPAE nor IDIV, and the kernel will be able to run on both Scorpion
  and Krait, as long as you have the right drivers too.

	Arnd
