From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Nov 2015 15:13:52 -0800
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <6359949.bhCrxaQvmL@wuerfel>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <133921941.Qfq59EaTOs@wuerfel>
 <20151123213206.GG19156@codeaurora.org>
 <6359949.bhCrxaQvmL@wuerfel>
Message-ID: <20151123231352.GH19156@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23, Arnd Bergmann wrote:
> On Monday 23 November 2015 13:32:06 Stephen Boyd wrote:
> > On 11/23, Arnd Bergmann wrote:
> > > On Monday 23 November 2015 12:38:47 Stephen Boyd wrote:
> > 
> > It would be nice to drop the ARCH_MSM* configs entirely. If we
> > could select the right timers from kconfig without using selects
> > then we could drop them. Or we could just select both types of
> > timers when building qcom platforms.
> 
> Ok, dropping the specific Kconfig entries is actually an awesome
> idea, as it completely solves the other problem as well, more on
> that below.
> 
> In that case, don't worry about listing all the models, once
> we stop listing a subset of them, the confusion is already
> reduced by the fact that one has to look at the .dts files
> so see which models we support, and I assume there will be
> additional ones coming in for at least a few more years (before
> you stop caring about 32-bit MSM and compatibles).
> 
> Regarding the timers:
> HAVE_ARM_ARCH_TIMER is already user-selectable, so maybe something
> like

> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index b251013eef0a..bad6343c34d5 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -324,8 +324,9 @@ config EM_TIMER_STI
>  	  such as EMEV2 from former NEC Electronics.
>  
>  config CLKSRC_QCOM
> -	bool "Qualcomm MSM timer" if COMPILE_TEST
> +	bool "Qualcomm MSM timer" if ARCH_QCOM || COMPILE_TEST
>  	depends on ARM
> +	default ARCH_QCOM
>  	select CLKSRC_OF
>  	help
>  	  This enables the clocksource and the per CPU clockevent driver for the
> 
> would make both of them equally configurable and not clutter up
> the Kconfig file when ARCH_QCOM is not selected. I've added
> Daniel Lezcano to Cc, he probably has an opinion on this too.

Yeah I think that architected timers are an outlier. I recall
some words from John Stultz that platforms should select the
clocksources they use, but maybe things have changed. For this
kind of thing I wouldn't mind putting it in the defconfig though.
I'll put the patches on the list to get the discussion started.

> 
> > > > > The ones we do support are MSM8x60 (Scorpion), MSM8960
> > > > > (Krait-without-number),and MSM7874 (Krait 400). Do those all
> > > > > support IDIV but not LPAE?
> > > > > 
> > > > 
> > > > Krait supports IDIV for all versions. Scorpion doesn't support
> > > > IDIV or lpae. Here's the output of /proc/cpuinfo on that device. 
> > > > 
> > > > # cat /proc/cpuinfo
> > > > processor       : 0
> > > > model name      : ARMv7 Processor rev 2 (v7l)
> > > > BogoMIPS        : 13.50
> > > > Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
> > > > CPU implementer : 0x51
> > > > CPU architecture: 7
> > > > CPU variant     : 0x0
> > > > CPU part        : 0x02d
> > > > CPU revision    : 2
> > > 
> > > Ok, that leaves just one missing puzzle piece: can you confirm that
> > > no supported Krait variant other than Krait 450 / apq8084 has LPAE?
> > > 
> > 
> > Right, apq8084 is the only SoC with a Krait CPU that supports
> > LPAE.
> 
> Ok, thanks for the confirmation.
> 
> Summarizing what we've found, I think we can get away with just
> introducing two Kconfig symbols ARCH_MULTI_V7VE and CPU_V7VE.
> Most CPUs fall clearly into one category or the other, and then
> we can allow LPAE to be selected for V7VE-only build but not
> for plain V7, and we can unconditionally build the kernel with
> 
> arch-$(CONFIG_CPU_32v7VE)  = -D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7ve,-march=armv7-a -mcpu=cortex-a15)
> 
> This works perfectly for Cortex-A5, -A8, -A9, -A12, -A15, -A17, Brahma-B15,
> PJ4B-MP, Scorpion and Krait-450, which all clearly fall into one of
> the two other categories.
> 
> The two exceptions that don't quite fit are still "good enough":
> 
> - PJ4/PJ4B (not PJ4B-MP) has a different custom opcode for udiv and sdiv
>   in ARM mode. We don't support that with true multiplatform kernels
>   because those opcodes work nowhere else, though with your proposed
>   series we could easily do that for dynamic patching.

Do you have the information on these custom opcodes? I can work
that into the patches assuming the MIDR is different.

> 
> - Krait (pre-450) won't run kernels with LPAE disabled, but if we only
>   have one global ARCH_QCOM option that can be enabled for both
>   ARCH_MULTI_V7VE and ARCH_MULTI_V7, we still win: a mach-qcom
>   kernel with only ARCH_MULTI_V7VE will use IDIV by default, and
>   give you the option to enable LPAE. If you pick LPAE, it will
>   still work fine on Krait-450 but not the older ones, and that is
>   a user error. If you enable ARCH_MULTI_V7 / CPU_V7, you get neither
>   LPAE nor IDIV, and the kernel will be able to run on both Scorpion
>   and Krait, as long as you have the right drivers too.
> 

So if I have built mach-qcom with ARCH_MULTI_V7VE won't I get a
kernel that uses idiv instructions that could be run on Scorpion,
where the instruction doesn't exist? Or is that a user error
again like picking LPAE?

It seems fine to me to go ahead with this approach. Should I take
care of cooking up the patches? I can package this all up into a
series that adds the new CPU type, updates the affected
platforms, and layers the runtime patching on top when plain V7
is a selected CPU type.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
