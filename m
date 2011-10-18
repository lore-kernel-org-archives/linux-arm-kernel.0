From: msalter@redhat.com (Mark Salter)
Date: Tue, 18 Oct 2011 09:16:43 -0400
Subject: [PATCH] arm: fix handling of nr_cpus
In-Reply-To: <20111013151004.GF21648@n2100.arm.linux.org.uk>
References: <1318339864-32396-1-git-send-email-msalter@redhat.com>
	<20111012172628.GC21648@n2100.arm.linux.org.uk>
	<1318508268.2300.67.camel@deneb.redhat.com>
	<20111013151004.GF21648@n2100.arm.linux.org.uk>
Message-ID: <1318943804.2346.15.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-10-13 at 16:10 +0100, Russell King - ARM Linux wrote:
> I still wonder if doing this wouldn't be easier though - it results in
> a consistent message across all platforms, which is important if we're
> going to be checking against a user-passed value.
> 
>  arch/arm/mach-exynos4/platsmp.c  |   10 ++++------
>  arch/arm/mach-omap2/omap-smp.c   |   10 ++++------
>  arch/arm/mach-realview/platsmp.c |   10 ++++------
>  arch/arm/mach-tegra/platsmp.c    |    8 ++++----
>  arch/arm/mach-ux500/platsmp.c    |   10 ++++------
>  5 files changed, 20 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/platsmp.c
> b/arch/arm/mach-exynos4/platsmp.c
> index df6ef1b..7381f56 100644
> --- a/arch/arm/mach-exynos4/platsmp.c
> +++ b/arch/arm/mach-exynos4/platsmp.c
> @@ -193,12 +193,10 @@ void __init smp_init_cpus(void)
>         ncores = scu_base ? scu_get_core_count(scu_base) : 1;
>  
>         /* sanity check */
> -       if (ncores > NR_CPUS) {
> -               printk(KERN_WARNING
> -                      "EXYNOS4: no. of cores (%d) greater than configured "
> -                      "maximum of %d - clipping\n",
> -                      ncores, NR_CPUS);
> -               ncores = NR_CPUS;
> +       if (ncores > nr_cpu_ids) {
> +               pr_warn("EXYNOS4: %u cores greater than maximum (%u), clipping\n",
> +                       ncores, nr_cpu_ids);
> +               ncores = nr_cpu_ids;
>         }
>  
>         for (i = 0; i < ncores; i++)

...

That's fine by me. mach-msm, mach-shmobile, and mach-vexpress also need
patching. They currently don't clip against NR_CPUS.

--Mark
