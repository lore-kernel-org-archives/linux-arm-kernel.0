From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 7 Nov 2011 16:15:39 +0800
Subject: [PATCH 27/41] ARM: restart: prima2: use new restart hook
In-Reply-To: <E1RN6qC-0001YQ-Dx@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6qC-0001YQ-Dx@rmk-PC.arm.linux.org.uk>
Message-ID: <CAGsJ_4xzo_bQLPeqgE7zO+0n0vGYJw4DiQ7AH-ji_RR9XmQd8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/7 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Barry Song <Baohua.Song@csr.com>

> ---
> ?arch/arm/mach-prima2/common.h ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-prima2/include/mach/system.h | ? ?8 --------
> ?arch/arm/mach-prima2/prima2.c ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-prima2/rstc.c ? ? ? ? ? ? ? ?| ? ?7 +++++++
> ?4 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
> index 83e5d21..b28a930 100644
> --- a/arch/arm/mach-prima2/common.h
> +++ b/arch/arm/mach-prima2/common.h
> @@ -16,6 +16,7 @@ extern struct sys_timer sirfsoc_timer;
>
> ?extern void __init sirfsoc_of_irq_init(void);
> ?extern void __init sirfsoc_of_clk_init(void);
> +extern void sirfsoc_restart(char, const char *);
>
> ?#ifndef CONFIG_DEBUG_LL
> ?static inline void sirfsoc_map_lluart(void) ?{}
> diff --git a/arch/arm/mach-prima2/include/mach/system.h b/arch/arm/mach-prima2/include/mach/system.h
> index 0dbd257..eb16b4b 100644
> --- a/arch/arm/mach-prima2/include/mach/system.h
> +++ b/arch/arm/mach-prima2/include/mach/system.h
> @@ -9,13 +9,6 @@
> ?#ifndef __MACH_SYSTEM_H__
> ?#define __MACH_SYSTEM_H__
>
> -#include <linux/bitops.h>
> -#include <mach/hardware.h>
> -
> -#define SIRFSOC_SYS_RST_BIT ?BIT(31)
> -
> -extern void __iomem *sirfsoc_rstc_base;
> -
> ?static inline void arch_idle(void)
> ?{
> ? ? ? ?cpu_do_idle();
> @@ -23,7 +16,6 @@ static inline void arch_idle(void)
>
> ?static inline void arch_reset(char mode, const char *cmd)
> ?{
> - ? ? ? writel(SIRFSOC_SYS_RST_BIT, sirfsoc_rstc_base);
> ?}
>
> ?#endif
> diff --git a/arch/arm/mach-prima2/prima2.c b/arch/arm/mach-prima2/prima2.c
> index ef555c0..8609aad 100644
> --- a/arch/arm/mach-prima2/prima2.c
> +++ b/arch/arm/mach-prima2/prima2.c
> @@ -39,4 +39,5 @@ MACHINE_START(PRIMA2_EVB, "prima2cb")
> ? ? ? ?.dma_zone_size ?= SZ_256M,
> ? ? ? ?.init_machine ? = sirfsoc_mach_init,
> ? ? ? ?.dt_compat ? ? ?= prima2cb_dt_match,
> + ? ? ? .restart ? ? ? ?= sirfsoc_restart,
> ?MACHINE_END
> diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
> index 492cfa8..762adb7 100644
> --- a/arch/arm/mach-prima2/rstc.c
> +++ b/arch/arm/mach-prima2/rstc.c
> @@ -68,3 +68,10 @@ int sirfsoc_reset_device(struct device *dev)
>
> ? ? ? ?return 0;
> ?}
> +
> +#define SIRFSOC_SYS_RST_BIT ?BIT(31)
> +
> +void sirfsoc_restart(char mode, const char *cmd)
> +{
> + ? ? ? writel(SIRFSOC_SYS_RST_BIT, sirfsoc_rstc_base);
> +}
> --
> 1.7.4.4
