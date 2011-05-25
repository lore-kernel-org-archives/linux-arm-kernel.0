From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 25 May 2011 12:06:02 -0700
Subject: [PATCH] ARM: exynos4: fix secondary CPU boot
In-Reply-To: <1306346645.27474.182.camel@e102391-lin.cambridge.arm.com>
References: <1305899190-16732-1-git-send-email-marc.zyngier@arm.com>	
	<4DDD3C57.6020705@samsung.com>
	<1306346645.27474.182.camel@e102391-lin.cambridge.arm.com>
Message-ID: <4DDD531A.50604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/11 11:04, Marc Zyngier wrote:
> On Wed, 2011-05-25 at 10:28 -0700, Kukjin Kim wrote:
>> On 05/20/11 06:46, Marc Zyngier wrote:

(snip)

> So that address has changed between two SoC revisions? That's
> unfortunate, to say the least. I'm most probably using an early revision
> of the hardware (EVT0?), as it doesn't even support MCT.
>
I'm afraid :( and I agree secondary CPU should work on all of 
Exynos4210. But I'm still think about the method...

> What about the following patch?
>
Uhm...this is really hack but I'd like to use another normal way...?

> 	M.
>
>> From c27e75b86e1ee181987a9364286a888421e76205 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier<marc.zyngier@arm.com>
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
> Try to solve the problem by poking both locations. This should be
> safe as this is done early enough in the kernel boot process, and nobody
> should be using the SRAM yet.
>
> Tested on a vintage SMDK-v310.

vintage ;)

>
> Cc: Kukjin Kim<kgene.kim@samsung.com>
> Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
> ---
>   arch/arm/mach-exynos4/include/mach/map.h |    1 +
>   arch/arm/mach-exynos4/platsmp.c          |   14 ++++++++++++++
>   2 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
> index 0009e77..781e149 100644
> --- a/arch/arm/mach-exynos4/include/mach/map.h
> +++ b/arch/arm/mach-exynos4/include/mach/map.h
> @@ -24,6 +24,7 @@
>   #include<plat/map-s5p.h>
>
>   #define EXYNOS4_PA_SYSRAM		0x02020000
> +#define EXYNOS4_PA_SYSRAM_EVT0		0x02025000
>
>   #define EXYNOS4_PA_FIMC0		0x11800000
>   #define EXYNOS4_PA_FIMC1		0x11810000
> diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
> index c5e65a0..f261c34 100644
> --- a/arch/arm/mach-exynos4/platsmp.c
> +++ b/arch/arm/mach-exynos4/platsmp.c
> @@ -155,6 +155,7 @@ void __init smp_init_cpus(void)
>   void __init platform_smp_prepare_cpus(unsigned int max_cpus)
>   {
>   	int i;
> +	void __iomem *sysram_evt0;
>
>   	/*
>   	 * Initialise the present map, which describes the set of CPUs
> @@ -172,4 +173,17 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
>   	 * secondary CPU branches to this address.
>   	 */
>   	__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)), S5P_VA_SYSRAM);
> +
> +	/*
> +	 * EVT0 has the system-wide flags register at a different address.
> +	 * Poke it as well, in case we're running on an old SoC revision.
> +	 */
> +	sysram_evt0 = ioremap(EXYNOS4_PA_SYSRAM_EVT0, SZ_4K);

Hmm...first of all, need to check whether can ioremap the area on newer 
one but I'm out off office now so will check it after backing.

> +	if (!sysram_evt0) {
> +		pr_err("Unable to remap EXYNOS4_PA_SYSRAM_EVT0\n");

Do we really need 'pr_err' here?...

> +		return;
> +	}
> +
> +	__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)), sysram_evt0);
> +	iounmap(sysram_evt0);
>   }

-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
