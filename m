From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 29 Oct 2011 17:41:09 +0800
Subject: [PATCH 33/51] ARM: mach-prima2: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-34-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-34-git-send-email-will.deacon@arm.com>
Message-ID: <CAGsJ_4xvOTKwd-A83arN7anNNrdN9NQoaur76izUsa0GCmd=xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/28 Will Deacon <will.deacon@arm.com>:
> This patch updates mach-prima2 to use arm_arch_reset instead of
> arch_reset.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Hi Will, i guess you can move the arch reset of prima2 to
arch/arm/mach-prima2/rstc.c instead of creating a new file. rstc is
the reset controller driver in prima2. so that is the right file to
place your codes. and you will not need to include system.h as well.

> ---
> ?arch/arm/mach-prima2/Makefile ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-prima2/include/mach/system.h | ? ?6 ------
> ?arch/arm/mach-prima2/reset.c ? ? ? ? ? ? ? | ? 22 ++++++++++++++++++++++
> ?3 files changed, 23 insertions(+), 6 deletions(-)
> ?create mode 100644 arch/arm/mach-prima2/reset.c
>
> diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
> index 7af7fc0..75a7127 100644
> --- a/arch/arm/mach-prima2/Makefile
> +++ b/arch/arm/mach-prima2/Makefile
> @@ -2,6 +2,7 @@ obj-y := timer.o
> ?obj-y += irq.o
> ?obj-y += clock.o
> ?obj-y += rstc.o
> +obj-y += reset.o
> ?obj-y += prima2.o
> ?obj-$(CONFIG_DEBUG_LL) += lluart.o
> ?obj-$(CONFIG_CACHE_L2X0) += l2x0.o
> diff --git a/arch/arm/mach-prima2/include/mach/system.h b/arch/arm/mach-prima2/include/mach/system.h
> index 0dbd257..1d14a77 100644
> --- a/arch/arm/mach-prima2/include/mach/system.h
> +++ b/arch/arm/mach-prima2/include/mach/system.h
> @@ -9,11 +9,6 @@
> ?#ifndef __MACH_SYSTEM_H__
> ?#define __MACH_SYSTEM_H__
>
> -#include <linux/bitops.h>
> -#include <mach/hardware.h>
> -
> -#define SIRFSOC_SYS_RST_BIT ?BIT(31)
> -
> ?extern void __iomem *sirfsoc_rstc_base;
>
> ?static inline void arch_idle(void)
> @@ -23,7 +18,6 @@ static inline void arch_idle(void)
>
> ?static inline void arch_reset(char mode, const char *cmd)
> ?{
> - ? ? ? writel(SIRFSOC_SYS_RST_BIT, sirfsoc_rstc_base);
> ?}
>
> ?#endif
> diff --git a/arch/arm/mach-prima2/reset.c b/arch/arm/mach-prima2/reset.c
> new file mode 100644
> index 0000000..5473ae8
> --- /dev/null
> +++ b/arch/arm/mach-prima2/reset.c
> @@ -0,0 +1,22 @@
> +/*
> + * arch/arm/mach-prima2/reset.c
> + */
> +
> +#include <linux/init.h>
> +#include <linux/bitops.h>
> +#include <mach/hardware.h>
> +#include <asm/system.h>
> +
> +#define SIRFSOC_SYS_RST_BIT ?BIT(31)
> +
> +static void prima2_arch_reset(char mode, const char *cmd)
> +{
> + ? ? ? writel(SIRFSOC_SYS_RST_BIT, sirfsoc_rstc_base);
> +}
> +
> +static int __init prima2_arch_reset_init(void)
> +{
> + ? ? ? arm_arch_reset = prima2_arch_reset;
> + ? ? ? return 0;
> +}
> +arch_initcall(prima2_arch_reset_init);
> --
> 1.7.4.1

Thanks
barry
