From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 28 Apr 2010 20:23:26 +0800
Subject: [02/10] mmp: enable L2 in mmp2
In-Reply-To: <z2m771cded01004280518ge227275h923782cecd738993@mail.gmail.com>
References: <z2m771cded01004280518ge227275h923782cecd738993@mail.gmail.com>
Message-ID: <t2of17812d71004280523sf8cd87aen8baa1762b0d1049a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 28, 2010 at 8:18 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From e45db2c733ff20593a96693e603c57b020692a09 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 28 Apr 2010 10:59:45 -0400
> Subject: [PATCH] [ARM] mmp: enable L2 in mmp2
>
> Enable Tauros2 L2 in mmp2. Tauros2 L2 is shared in Marvell ARM cores.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> ?arch/arm/configs/mmp2_defconfig | ? ?2 ++
> ?arch/arm/mach-mmp/mmp2.c ? ? ? ?| ? ?5 +++++
> ?arch/arm/mm/Kconfig ? ? ? ? ? ? | ? ?4 ++--
> ?3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
> index 03f76cf..db89363 100644
> --- a/arch/arm/configs/mmp2_defconfig
> +++ b/arch/arm/configs/mmp2_defconfig
> @@ -246,6 +246,8 @@ CONFIG_ARM_THUMB=y
> ?# CONFIG_CPU_ICACHE_DISABLE is not set
> ?# CONFIG_CPU_DCACHE_DISABLE is not set
> ?# CONFIG_CPU_BPREDICT_DISABLE is not set
> +CONFIG_OUTER_CACHE=y
> +CONFIG_CACHE_TAUROS2=y
> ?CONFIG_ARM_L1_CACHE_SHIFT=5
> ?# CONFIG_ARM_ERRATA_411920 is not set
> ?CONFIG_COMMON_CLKDEV=y
> diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
> index cca3992..e236ec0 100644
> --- a/arch/arm/mach-mmp/mmp2.c
> +++ b/arch/arm/mach-mmp/mmp2.c
> @@ -15,6 +15,8 @@
> ?#include <linux/init.h>
> ?#include <linux/io.h>
>
> +#include <asm/hardware/cache-tauros2.h>
> +
> ?#include <mach/addr-map.h>
> ?#include <mach/regs-apbc.h>
> ?#include <mach/regs-apmu.h>
> @@ -99,6 +101,9 @@ static struct clk_lookup mmp2_clkregs[] = {
> ?static int __init mmp2_init(void)
> ?{
> ? ? ? ?if (cpu_is_mmp2()) {
> +#ifdef CONFIG_CACHE_TAUROS2
> + ? ? ? ? ? ? ? tauros2_init();
> +#endif
> ? ? ? ? ? ? ? ?mfp_init_base(MFPR_VIRT_BASE);
> ? ? ? ? ? ? ? ?mfp_init_addr(mmp2_addr_map);
> ? ? ? ? ? ? ? ?clkdev_add_table(ARRAY_AND_SIZE(mmp2_clkregs));
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 5bd7c89..39c4761 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -769,8 +769,8 @@ config CACHE_L2X0
>
> ?config CACHE_TAUROS2
> ? ? ? ?bool "Enable the Tauros2 L2 cache controller"
> - ? ? ? depends on ARCH_DOVE
> - ? ? ? default y
> + ? ? ? depends on (ARCH_DOVE || ARCH_MMP)
> + ? ? ? default n

This also affects Dove by making default to 'n'. Is there any specific reason
that MMP2 doesn't turn L2 on by default?

> ? ? ? ?select OUTER_CACHE
> ? ? ? ?help
> ? ? ? ? ?This option enables the Tauros2 L2 cache controller (as
> --
> 1.5.6.5
>
