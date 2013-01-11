From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 19:18:32 +0530
Subject: [PATCHv2 09/11] arm: arch_timer: move core to drivers/clocksource
In-Reply-To: <1357747640-18594-10-git-send-email-mark.rutland@arm.com>
References: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
 <1357747640-18594-10-git-send-email-mark.rutland@arm.com>
Message-ID: <50F01830.5040205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013 09:37 PM, Mark Rutland wrote:
> The core functionality of the arch_timer driver is not directly tied to
> anything under arch/arm, and can be split out.
>
> This patch factors out the core of the arch_timer driver, so it can be
> shared with other architectures. A couple of functions are added so
> that architecture-specific code can interact with the driver without
> needing to touch its internals.
>
> The ARM_ARCH_TIMER config variable is moved out to
> drivers/clocksource/Kconfig, existing uses in arch/arm are replaced with
> USE_ARM_ARCH_TIMER, which selects it.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/Kconfig                     |    3 +-
>   arch/arm/include/asm/arch_timer.h    |   19 +--
>   arch/arm/kernel/arch_timer.c         |  375 ++--------------------------------
>   arch/arm/mach-omap2/Kconfig          |    2 +-
>   drivers/clocksource/Kconfig          |    3 +
>   drivers/clocksource/Makefile         |    1 +
>   drivers/clocksource/arm_arch_timer.c |  374 +++++++++++++++++++++++++++++++++
>   include/clocksource/arm_arch_timer.h |   63 ++++++
>   8 files changed, 465 insertions(+), 375 deletions(-)
>   create mode 100644 drivers/clocksource/arm_arch_timer.c
>   create mode 100644 include/clocksource/arm_arch_timer.h
>
It would have been easy if you have formated the patch with -C option.
That will just leave the delta changes only and hiding the file
movement related diff.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f95ba14..487696a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1567,9 +1567,10 @@ config HAVE_ARM_SCU
>   	help
>   	  This option enables support for the ARM system coherency unit
>
> -config ARM_ARCH_TIMER
> +config USE_ARM_ARCH_TIMER
>   	bool "Architected timer support"
>   	depends on CPU_V7
> +	select ARM_ARCH_TIMER
>   	help
>   	  This option enables support for the ARM architected timer
>
How about HAVE_ARM_ARCH_TIMER in-line with HAVE_ARM_TWD. No strong
opinion though.

Regards
Santosh
