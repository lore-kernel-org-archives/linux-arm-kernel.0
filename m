From: amit.kachhap@linaro.org (Amit Kachhap)
Date: Tue, 26 Jul 2011 17:44:26 +0530
Subject: [RFC PATCH 17/17] ARM: kernel: save/restore build infrastructure
In-Reply-To: <1310053830-23779-18-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-18-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <CAK44p23WC9F59JoN1TjhDDcMqTEB7+v25cNAfBprFECo9=6FLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 July 2011 21:20, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> This patch adds the required Kconfig and Makefile entries to
> enable and compile common idle code for ARM kernel.
>
> Common idle code depends on CPU_PM platform notifiers to trigger
> save/restore of kernel subsystems like PMU, VFP, GIC.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
> ?arch/arm/Kconfig ? ? ? ? | ? 11 +++++++++++
> ?arch/arm/kernel/Makefile | ? ?4 ++++
> ?2 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 356f266..5b670bd 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1992,6 +1992,17 @@ config VFP
>
> ? ? ? ? ?Say N if your target does not have VFP hardware.
>
> +config CONTEXT_SR
> + ? ? ? bool "Save/Restore code support for CPU/Cluster Power Management"
> + ? ? ? depends on CPU_V7 && CPU_PM
> + ? ? ? help
> + ? ? ? ? Say Y to include Save/Restore code in the kernel. This provides
> + ? ? ? ? generic infrastructure to put the code in dormant/shutdown mode
> + ? ? ? ? and save/restore the required system state inclusive of L2 cache
> + ? ? ? ? logic.
> +
> + ? ? ? ? Say N if your target does not have Power Management hardware.
> +

Currently this is placed inside the "Floating point emulation" menu.
"cpu power management" menu may be a better option.
Also I did not find where configs CPU_PM,  ARCH_USES_CPU_PM are enabled.

> ?config VFPv3
> ? ? ? ?bool
> ? ? ? ?depends on VFP
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 8b42d58..ac931f1 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -49,6 +49,10 @@ obj-$(CONFIG_CRASH_DUMP) ? ? += crash_dump.o
> ?obj-$(CONFIG_SWP_EMULATE) ? ? ?+= swp_emulate.o
> ?CFLAGS_swp_emulate.o ? ? ? ? ? := -Wa,-march=armv7-a
> ?obj-$(CONFIG_HAVE_HW_BREAKPOINT) ? ? ? += hw_breakpoint.o
> +obj-$(CONFIG_CONTEXT_SR) ? ? ? += ? ? ?lb_lock.o sr_api.o sr_mapping.o \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sr_entry.o ?sr_arch.o ?sr_context.o \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sr_platform.o sr_power.o reset_v7.o \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sr_v7_helpers.o
>
> ?obj-$(CONFIG_CRUNCH) ? ? ? ? ? += crunch.o crunch-bits.o
> ?AFLAGS_crunch-bits.o ? ? ? ? ? := -Wa,-mcpu=ep9312
> --
> 1.7.4.4
>
>
>
