From: nm@ti.com (Nishanth Menon)
Date: Fri, 1 Mar 2013 07:50:01 -0600
Subject: [PATCH 01/15] ARM: OMAP4+: PM: Consolidate MPU subsystem PM code
 for re-use
In-Reply-To: <1362139864-9233-2-git-send-email-santosh.shilimkar@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130301135001.GB20420@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:40-20130301, Santosh Shilimkar wrote:
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   56 +++++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index abdd0f6..ee8a1e4 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -71,10 +71,37 @@ struct omap4_cpu_pm_info {
>  	void (*secondary_startup)(void);
>  };
>  
> +struct cpu_pm_ops {
> +	int (*finish_suspend)(unsigned long cpu_state);
> +	void (*resume)(void);
> +	void (*scu_prepare)(unsigned int cpu_id, unsigned int cpu_state);
> +};
> +
> +extern int omap4_finish_suspend(unsigned long cpu_state);
> +extern void omap4_cpu_resume(void);
> +
>  static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
>  static struct powerdomain *mpuss_pd;
>  static void __iomem *sar_base;
>  
> +static int default_finish_suspend(unsigned long cpu_state)
> +{
> +	omap_do_wfi();
> +	return 0;
> +}
> +
> +static void dummy_cpu_resume(void)
> +{}
> +
> +void dummy_scu_prepare(unsigned int cpu_id, unsigned int cpu_state)
static?
> +{}
> +
> +struct cpu_pm_ops omap_pm_ops = {
> +	.finish_suspend		= default_finish_suspend,
> +	.resume			= dummy_cpu_resume,
> +	.scu_prepare		= dummy_scu_prepare,
> +};
> +
Otherwise,
Acked-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
