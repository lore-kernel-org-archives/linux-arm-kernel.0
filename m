From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 29 Jun 2011 14:52:37 +0900
Subject: [PATCH] ARM: exynos4: fix secondary CPU boot
In-Reply-To: <4DF8811B.9090506@arm.com>
References: <1305899190-16732-1-git-send-email-marc.zyngier@arm.com>
	<4DDD3C57.6020705@samsung.com>
	<1306346645.27474.182.camel@e102391-lin.cambridge.arm.com>
	<4DDD531A.50604@samsung.com>
	<1306422710.27474.237.camel@e102391-lin.cambridge.arm.com>
	<BANLkTi=fjq5ki8BGDhQxHVD3u-s7W-C1rw@mail.gmail.com>
	<1307003689.31098.6.camel@e102391-lin.cambridge.arm.com>
	<BANLkTi=mvCgi_6Y57aVjpwrMhL58zPcUHw@mail.gmail.com>
	<1307004853.31098.12.camel@e102391-lin.cambridge.arm.com>
	<BANLkTi=hEBKTpEq6daMyEdLo63aet52Gbg@mail.gmail.com>
	<BANLkTinov=XKF5dH9EOpMj=oQC7oyKGKfA@mail.gmail.com>
	<4DF8811B.9090506@arm.com>
Message-ID: <BANLkTimeBUaBujqybqZiuzV5GWsjiO1mvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's first step to handle the EVT.

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>


> Jazz is not dead. It just smells funny...
> From a24392183d396fab790557b0efb35e840c9e8a81 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <marc.zyngier@arm.com>
> Date: Fri, 20 May 2011 14:38:25 +0100
> Subject: [PATCH] ARM: exynos4: fix secondary CPU boot on early SoC revisions
>
> It appears that the system-wide flags register that used to be at
> 0x02025000 on the first revision of Exynos4 has moved to 0x02020000.
>
> The kernel has been updated accordingly, but this unfortunately leaves
> early boards without SMP support (the secondary CPU spins endlessly
> in BL0 waiting for an address to be written at that memory location).
>
> Solve the problem by providing an s3c_get_chip_id() function, common
> to all s3c/s5p implementations, and test the result on the secondary boot
> path.
>
> Revision table, as provided by Kyungmin Park <kmpark@infradead.org>:
> 0x4320 0200 EVT0
> 0x4321 0210 EVT1
> 0x4321 0211 EVT2
>
> The last 8 bits can be overrided by efuses, so only bits [16:19] are
> used to identify the revision.
>
> Tested on a vintage SMDK-v310.
>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Kyungmin Park <kmpark@infradead.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> ?arch/arm/mach-exynos4/include/mach/map.h | ? ?1 +
> ?arch/arm/mach-exynos4/platsmp.c ? ? ? ? ?| ? 22 +++++++++++++++++++++-
> ?arch/arm/plat-samsung/include/plat/cpu.h | ? ?2 ++
> ?arch/arm/plat-samsung/init.c ? ? ? ? ? ? | ? ?8 ++++++++
> ?4 files changed, 32 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
> index 57d8074..da08f5c 100644
> --- a/arch/arm/mach-exynos4/include/mach/map.h
> +++ b/arch/arm/mach-exynos4/include/mach/map.h
> @@ -24,6 +24,7 @@
> ?#include <plat/map-s5p.h>
>
> ?#define EXYNOS4_PA_SYSRAM ? ? ? ? ? ? ?0x02020000
> +#define EXYNOS4_PA_SYSRAM_EVT0 ? ? ? ? 0x02025000
>
> ?#define EXYNOS4_PA_FIMC0 ? ? ? ? ? ? ? 0x11800000
> ?#define EXYNOS4_PA_FIMC1 ? ? ? ? ? ? ? 0x11810000
> diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
> index c5e65a0..086d1e3 100644
> --- a/arch/arm/mach-exynos4/platsmp.c
> +++ b/arch/arm/mach-exynos4/platsmp.c
> @@ -26,6 +26,8 @@
> ?#include <asm/smp_scu.h>
> ?#include <asm/unified.h>
>
> +#include <plat/cpu.h>
> +
> ?#include <mach/hardware.h>
> ?#include <mach/regs-clock.h>
>
> @@ -170,6 +172,24 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
> ? ? ? ? * system-wide flags register. The boot monitor waits
> ? ? ? ? * until it receives a soft interrupt, and then the
> ? ? ? ? * secondary CPU branches to this address.
> + ? ? ? ?*
> + ? ? ? ?* EVT0 has the system-wide flags register at a different
> + ? ? ? ?* address, hence the following hackery...
> ? ? ? ? */
> - ? ? ? __raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)), S5P_VA_SYSRAM);
> + ? ? ? if (s3c_get_chip_id() & 0xF0000UL)
> + ? ? ? ? ? ? ? __raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?S5P_VA_SYSRAM);
> + ? ? ? else {
> + ? ? ? ? ? ? ? void __iomem *sysram_evt0;
> +
> + ? ? ? ? ? ? ? sysram_evt0 = ioremap(EXYNOS4_PA_SYSRAM_EVT0, SZ_4K);
> + ? ? ? ? ? ? ? if (!sysram_evt0) {
> + ? ? ? ? ? ? ? ? ? ? ? pr_err("Unable to remap EXYNOS4_PA_SYSRAM_EVT0\n");
> + ? ? ? ? ? ? ? ? ? ? ? return;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? __raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?sysram_evt0);
> + ? ? ? ? ? ? ? iounmap(sysram_evt0);
> + ? ? ? }
> +
> ?}
> diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
> index c0a5741..41573cc 100644
> --- a/arch/arm/plat-samsung/include/plat/cpu.h
> +++ b/arch/arm/plat-samsung/include/plat/cpu.h
> @@ -44,6 +44,8 @@ struct cpu_table {
> ?extern void s3c_init_cpu(unsigned long idcode,
> ? ? ? ? ? ? ? ? ? ? ? ? struct cpu_table *cpus, unsigned int cputab_size);
>
> +extern unsigned long s3c_get_chip_id(void);
> +
> ?/* core initialisation functions */
>
> ?extern void s3c24xx_init_irq(void);
> diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
> index 79d10fc..320b88f 100644
> --- a/arch/arm/plat-samsung/init.c
> +++ b/arch/arm/plat-samsung/init.c
> @@ -30,6 +30,7 @@
> ?#include <plat/regs-serial.h>
>
> ?static struct cpu_table *cpu;
> +static unsigned long s3c_chip_id;
>
> ?static struct cpu_table * __init s3c_lookup_cpu(unsigned long idcode,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct cpu_table *tab,
> @@ -60,6 +61,8 @@ void __init s3c_init_cpu(unsigned long idcode,
> ? ? ? ? ? ? ? ?panic("Unsupported Samsung CPU");
> ? ? ? ?}
>
> + ? ? ? s3c_chip_id = idcode;
> +
> ? ? ? ?cpu->map_io();
> ?}
>
> @@ -140,6 +143,11 @@ void __init s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
> ? ? ? ? ? ? ? ?(cpu->init_uarts)(cfg, no);
> ?}
>
> +unsigned long s3c_get_chip_id(void)
> +{
> + ? ? ? return s3c_chip_id;
> +}
> +
> ?static int __init s3c_arch_init(void)
> ?{
> ? ? ? ?int ret;
> --
> 1.7.0.4
>
>
