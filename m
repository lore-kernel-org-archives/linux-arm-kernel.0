From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 2 Jun 2011 09:43:28 +0900
Subject: [PATCH] [CPUFREQ] Move ARM Samsung cpufreq drivers to
	drivers/cpufreq/
In-Reply-To: <1306963102-12830-1-git-send-email-kgene.kim@samsung.com>
References: <1306963102-12830-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <BANLkTikWhqOO2dcXpp+f=1i1JWOoaYEY5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I think you already saw the same patchs[1] at mailing list and even
worse you commented it[2]
One different is kconfig handling. and these can be handled easily as you did.

Please respect others works.

Thank you,
Kyungmin Park

1. http://www.gossamer-threads.com/lists/linux/kernel/1385739?page=last
2. http://www.spinics.net/lists/cpufreq/msg02262.html

On Thu, Jun 2, 2011 at 6:18 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> According to discussion of the ARM arch subsystem migration,
> ARM cpufreq drivers move to drivers/cpufreq. So this patch
> adds Kconfig.arm for ARM like x86 and adds Samsung S5PV210
> and EXYNOS4210 cpufreq driver compile in there.
> As a note, otherw will be moved.
>
> Cc: Dave Jones <davej@redhat.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?arch/arm/mach-exynos4/Makefile ? ? ? ? ? ? ? ? ? ? | ? ?1 -
> ?arch/arm/mach-s5pv210/Makefile ? ? ? ? ? ? ? ? ? ? | ? ?1 -
> ?drivers/cpufreq/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?5 ++++
> ?drivers/cpufreq/Kconfig.arm ? ? ? ? ? ? ? ? ? ? ? ?| ? 23 ++++++++++++++++++++
> ?drivers/cpufreq/Makefile ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +
> ?.../cpufreq/exynos4210-cpufreq.c ? ? ? ? ? ? ? ? ? | ? ?3 +-
> ?.../cpufreq.c => drivers/cpufreq/s5pv210-cpufreq.c | ? ?3 +-
> ?7 files changed, 32 insertions(+), 6 deletions(-)
> ?create mode 100644 drivers/cpufreq/Kconfig.arm
> ?rename arch/arm/mach-exynos4/cpufreq.c => drivers/cpufreq/exynos4210-cpufreq.c (99%)
> ?rename arch/arm/mach-s5pv210/cpufreq.c => drivers/cpufreq/s5pv210-cpufreq.c (99%)
>
> diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
> index a9bb94f..0cebfa7 100644
> --- a/arch/arm/mach-exynos4/Makefile
> +++ b/arch/arm/mach-exynos4/Makefile
> @@ -15,7 +15,6 @@ obj- ? ? ? ? ? ? ? ? ? ? ? ? ?:=
> ?obj-$(CONFIG_CPU_EXYNOS4210) ? += cpu.o init.o clock.o irq-combiner.o
> ?obj-$(CONFIG_CPU_EXYNOS4210) ? += setup-i2c0.o irq-eint.o dma.o
> ?obj-$(CONFIG_PM) ? ? ? ? ? ? ? += pm.o sleep.o
> -obj-$(CONFIG_CPU_FREQ) ? ? ? ? += cpufreq.o
> ?obj-$(CONFIG_CPU_IDLE) ? ? ? ? += cpuidle.o
>
> ?obj-$(CONFIG_SMP) ? ? ? ? ? ? ?+= platsmp.o headsmp.o
> diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
> index 50907ac..599a3c0 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -15,7 +15,6 @@ obj- ? ? ? ? ? ? ? ? ? ? ? ? ?:=
> ?obj-$(CONFIG_CPU_S5PV210) ? ? ?+= cpu.o init.o clock.o dma.o
> ?obj-$(CONFIG_CPU_S5PV210) ? ? ?+= setup-i2c0.o
> ?obj-$(CONFIG_S5PV210_PM) ? ? ? += pm.o sleep.o
> -obj-$(CONFIG_CPU_FREQ) ? ? ? ? += cpufreq.o
>
> ?# machine support
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 9fb8485..e898215 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -184,5 +184,10 @@ depends on X86
> ?source "drivers/cpufreq/Kconfig.x86"
> ?endmenu
>
> +menu "ARM CPU frequency scaling drivers"
> +depends on ARM
> +source "drivers/cpufreq/Kconfig.arm"
> +endmenu
> +
> ?endif
> ?endmenu
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> new file mode 100644
> index 0000000..fafdbb8
> --- /dev/null
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -0,0 +1,23 @@
> +#
> +# ARM CPU Frequency scaling drivers
> +#
> +
> +config ARM_S5PV210_CPUFREQ
> + ? ? ? bool "Samsung S5PV210 and S5PC110"
> + ? ? ? depends on CPU_S5PV210
> + ? ? ? default y
> + ? ? ? help
> + ? ? ? ? This adds the CPUFreq driver for Samsung S5PV210 and
> + ? ? ? ? S5PC110 SoCs.
> +
> + ? ? ? ? If in doubt, say N.
> +
> +config ARM_EXYNOS4210_CPUFREQ
> + ? ? ? bool "Samsung EXYNOS4210"
> + ? ? ? depends on CPU_EXYNOS4210
> + ? ? ? default y
> + ? ? ? help
> + ? ? ? ? This adds the CPUFreq driver for Samsung EXYNOS4210
> + ? ? ? ? SoC (S5PV310 or S5PC210).
> +
> + ? ? ? ? If in doubt, say N.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index e2fc2d2..864a27c 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -41,3 +41,5 @@ obj-$(CONFIG_X86_CPUFREQ_NFORCE2) ? ? += cpufreq-nforce2.o
>
> ?# ARM SoC drivers
> ?obj-$(CONFIG_UX500_SOC_DB8500) ? ? ? ? += db8500-cpufreq.o
> +obj-$(CONFIG_ARM_S5PV210_CPUFREQ) ? ? ?+= s5pv210-cpufreq.o
> +obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ) ? += exynos4210-cpufreq.o
> diff --git a/arch/arm/mach-exynos4/cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
> similarity index 99%
> rename from arch/arm/mach-exynos4/cpufreq.c
> rename to drivers/cpufreq/exynos4210-cpufreq.c
> index a1bd258..54025fc 100644
> --- a/arch/arm/mach-exynos4/cpufreq.c
> +++ b/drivers/cpufreq/exynos4210-cpufreq.c
> @@ -1,5 +1,4 @@
> -/* linux/arch/arm/mach-exynos4/cpufreq.c
> - *
> +/*
> ?* Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
> ?* ? ? ? ? ? ? http://www.samsung.com
> ?*
> diff --git a/arch/arm/mach-s5pv210/cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> similarity index 99%
> rename from arch/arm/mach-s5pv210/cpufreq.c
> rename to drivers/cpufreq/s5pv210-cpufreq.c
> index 22046e2..c482fc8 100644
> --- a/arch/arm/mach-s5pv210/cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -1,5 +1,4 @@
> -/* linux/arch/arm/mach-s5pv210/cpufreq.c
> - *
> +/*
> ?* Copyright (c) 2010 Samsung Electronics Co., Ltd.
> ?* ? ? ? ? ? ? http://www.samsung.com
> ?*
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
