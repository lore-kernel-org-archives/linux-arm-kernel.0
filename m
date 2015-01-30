From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 30 Jan 2015 07:35:19 +0000
Subject: [PATCH v5 00/13] AT91 pm cleanup for 3.20
In-Reply-To: <54CA30E3.2050301@atmel.com>
References: <1422513316-21509-1-git-send-email-wenyou.yang@atmel.com>
 <54CA30E3.2050301@atmel.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFD3A116@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

> -----Original Message-----
> From: Ferre, Nicolas
> Sent: Thursday, January 29, 2015 9:09 PM
> To: Yang, Wenyou; linux at arm.linux.org.uk
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> alexandre.belloni at free-electrons.com; sylvain.rochet at finsecur.com;
> peda at axentia.se; sergei.shtylyov at cogentembedded.com; linux at maxim.org.za
> Subject: Re: [PATCH v5 00/13] AT91 pm cleanup for 3.20
> 
> Le 29/01/2015 07:35, Wenyou Yang a ?crit :
> > Hi Nicolas,
> >
> > This version is rebased on the branch: at91-3.20-cleanup of the repository
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
> >
> > It is purpose to clean up the PM code, includes the patches from Peter Rosin
> and Sylvain Rochet.
> >
> > Since verifying the USB clock and USB PLL disabling before suspending
> > to memory, it aslo depends on the following patch serials from Sylvain:
> > 	[PATCHv6 0/5] USB: gadget: atmel_usba_udc: Driver improvements
> > 	[PATCHv7 0/6] USB: host: Atmel OHCI and EHCI drivers improvements
> >
> > Removes CONFIG_AT91_SLOW_CLOCK config item to simply the PM config,
> > The suspend to standby mode uses the same sram function as the suspend to
> memory mode.
> > Remove some unused code.
> >
> > Alexandr & Sylvain, Thank you very much for so many feedbacks.
> 
> Wenyou,
> 
> I'm sorry but the PM "cleanup" and "improvement" series won't be merged for 3.20
> (so you can remove this from the series subject). The series are pretty big,
> address a sensitive aspect of the chips and are not completely ready. So I
> propose to slow down the pace of versions and focus on these two objectives:
> 
> 1/ try to extract a handful of patches that could be sent as "fixes" for
> 3.20 (no more than 5-6 patches). If they are enough urgent, I can try to add them to
> an early "fixes" branch during the 3.20 stabilization process.
OK, I will send some stable patches.

> 
> 2/ try to figure out if from this big amount of assembly code can't be extracted
> some parts that can be converted to C or parts that can use ARM common code
> (for cache management for instance).
Yes, I need dig deeply the cache code.

> 
> During 3.21 development phase, we will come back to the "cleanup" series and
> prepare something that can host the sama5 PM support. Finally we will add
> sama5d3/sama5d4 PM enhancements.
> 
> 
> > Changes in v5:
> >  - Rebase the branch: at91-3.20-cleanup HEAD:fa9df37
> >
> > Changes in v4:
> >  - Clear unused state argument in at91_pm_verify_clocks()
> >  - Remove pr_info("AT91:... slow_clock ? ..") in patch 07/13.
> >
> > Changes in v3
> >  - Sylvain splits the patch in two
> >  - Add handling if no sram allocated for PM
> >  - Retain the STANDBY and SUSPEND_MEM select in at91_pm_enter.
> >
> > Changes in v2:
> >  - Rebase on the at91-3.20-cleanup branch
> >  - Recover the verify clock condition, only for suspend to memory.
> >  - Collect ACK from Alexandre
> >  - Add the macro for PM mode
> >
> > Peter Rosin (1):
> >   pm: at91: Workaround DDRSDRC self-refresh bug with LPDDR1 memories.
> >
> > Sylvain Rochet (2):
> >   pm: at91: pm_slowclock: fix suspend/resume hang up in timeouts
> >   pm: at91: pm_slowclock: remove clocks which are already stopped when
> >     entering slow clock mode
> >
> > Wenyou Yang (10):
> >   pm: at91: pm_slowclock: remove the unused code related with
> >     SLOWDOWN_MASTER_CLOCK
> >   pm: at91: move the copying the sram function to the sram
> >     initializationi phase
> >   ARM: at91: move select SRAM to ARCH_AT91
> >   pm: at91: remove the config item CONFIG_AT91_SLOW_CLOCK
> >   pm: at91: the standby mode uses the same sram function as the suspend
> >     to memory mode
> >   pm: at91: rename file name: pm_slowclock.S -->pm_suspend.S
> >   pm: at91: rename function name:
> >     at91_slow_clock()-->at91_pm_suspend_sram_fn
> >   pm: at91: remove the at91_xxx_standby() function definitions in the
> >     pm.h
> >   pm: at91: remove the data member at91_xxx_standby() of struct
> >     ramc_ids
> >   pm: at91: amend the pm_suspend entry for at91_cpuidle_device
> >
> >  arch/arm/mach-at91/Kconfig         |   17 +-
> >  arch/arm/mach-at91/Makefile        |    2 +-
> >  arch/arm/mach-at91/pm.c            |  166 +++++++++---------
> >  arch/arm/mach-at91/pm.h            |  100 +----------
> >  arch/arm/mach-at91/pm_slowclock.S  |  323 ------------------------------------
> >  arch/arm/mach-at91/pm_suspend.S    |  277
> +++++++++++++++++++++++++++++++
> >  include/soc/at91/at91sam9_ddrsdr.h |    2 +-
> >  7 files changed, 366 insertions(+), 521 deletions(-)  delete mode
> > 100644 arch/arm/mach-at91/pm_slowclock.S  create mode 100644
> > arch/arm/mach-at91/pm_suspend.S
> >
> 
> 
> --
> Nicolas Ferre

Best Regards,
Wenyou Yang
