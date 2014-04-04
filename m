From: elder@ieee.org (Alex Elder)
Date: Fri, 04 Apr 2014 15:38:47 -0500
Subject: [RFC PATCH 0/7] ARM: SMP: common "pen" secondary release method
In-Reply-To: <1396041180-29897-1-git-send-email-elder@linaro.org>
References: <1396041180-29897-1-git-send-email-elder@linaro.org>
Message-ID: <533F1857.1020604@ieee.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2014 04:12 PM, Alex Elder wrote:
> This series proposes creating a single implementation of the "pen
> release" (or spin-table) mechanism for starting secondary CPUs on
> ARM SMP systems.  This mechanism is currently implemented at least 5
> times in the kernel, each essentially identical to the other.  There
> are other machines that use this method, but slight differences make
> it necessary to incorporate further work in order to accomodate them
> with a single set of functions.

Given Russell King's reluctance to include this sort of
thing in common code I'm withdrawing this series from
consideration.

					-Alex

> 
> This work began with integrating SMP support for a Broadcom SoC.
> The code I started was another copy of the "pen release" code.
> Looking at how existing systems handled this, the duplication of
> code was obvious, but the fact that implementations were identical
> was less so.  In addition, the arm64 (though not 32-bit arm) code
> supports the ability to define an "enable-method" property for CPUs
> in a machine's device tree (one of which is "spin-table"), allowing
> the secondary startup mechanism to be specified abstractly.
> 
> My broader goal then was to set up the SMP support for the Broadcom
> SoC such that it could be defined in its device tree using a central
> "spin-table" enable method for secondary CPUs.  The first step was
> to create a central spin-table implementation.  I've tried to do
> this generally so it's usable by as many other platforms as
> possible.  (An alternative would be to define a custom enable method
> for this platform, but I'd prefer to avoid that if I can.)
> 
> I already have some code for the second step--which supports
> specifying the "spin-table" CPU enable method in device tree files.
> But before presenting that I wanted to post this series to get
> feedback on the approach.
> 
> I've provided a little more information for each patch below.
> 
> This code is available in the "review/common-spin-code" branch of
> the git repository here:
>     http://git.linaro.org/landing-teams/working/broadcom/kernel.git
> 
> 
> 					-Alex
> 
> Alex Elder (7):
>   ARM: allow <asm/cputype.h> inclusion from assembly
>     This patch is done specifically so the next one can use the
>     value of MPIDR_HWID_BITMASK in secondary_holding_pen(), which is
>     defined in asssembly.
>   ARM: SMP: generic SMP spin-table method routines
>     Define the common code (based on any of the others, but
>     reportedly they all derive from ARM Realview.)  Names are
>     changed to be more like arch/arm64/kernel/smp_spin_table.c.
> 
>   ARM: realview: use central SMP spin-table routines
>   ARM: vexpress: use central SMP spin-table routines
>   ARM: versatile: kill off SMP support code
>   	The SMP code for realview and vexpress both use SMP code
> 	defined under mach-versatile, so these three go together.
> 
>   ARM: ux500: use generic SMP spin-table routines
>     This one is a pretty straightforward switch to using
>     the common code.
>   	
>   ARM: spear: use central SMP spin-table routines
>     This is straightforward as well, but it depends on the
>     two prerequisite patches mentioned above (which together
>     make this code roughly identical to the rest).
> 
>  arch/arm/include/asm/cputype.h                 |    4 ++
>  arch/arm/include/asm/smp.h                     |    5 ++
>  arch/arm/kernel/head.S                         |   33 +++++++++
>  arch/arm/kernel/smp.c                          |   77 ++++++++++++++++++++
>  arch/arm/mach-realview/platsmp.c               |    8 +--
>  arch/arm/mach-spear/Makefile                   |    2 +-
>  arch/arm/mach-spear/generic.h                  |    1 -
>  arch/arm/mach-spear/headsmp.S                  |   47 ------------
>  arch/arm/mach-spear/platsmp.c                  |   75 +------------------
>  arch/arm/mach-ux500/Makefile                   |    2 +-
>  arch/arm/mach-ux500/headsmp.S                  |   37 ----------
>  arch/arm/mach-ux500/platsmp.c                  |   72 +------------------
>  arch/arm/mach-vexpress/platsmp.c               |    8 +--
>  arch/arm/mach-vexpress/v2m.c                   |    1 -
>  arch/arm/plat-versatile/Makefile               |    1 -
>  arch/arm/plat-versatile/headsmp.S              |   41 -----------
>  arch/arm/plat-versatile/include/plat/platsmp.h |   14 ----
>  arch/arm/plat-versatile/platsmp.c              |   91 ------------------------
>  18 files changed, 133 insertions(+), 386 deletions(-)
>  delete mode 100644 arch/arm/mach-spear/headsmp.S
>  delete mode 100644 arch/arm/mach-ux500/headsmp.S
>  delete mode 100644 arch/arm/plat-versatile/headsmp.S
>  delete mode 100644 arch/arm/plat-versatile/include/plat/platsmp.h
>  delete mode 100644 arch/arm/plat-versatile/platsmp.c
> 
