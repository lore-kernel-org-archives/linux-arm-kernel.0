From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 5 Sep 2012 14:47:16 -0500
Subject: [PATCH v8 1/3] ARM: OMAP2/3: hwmod data: add gpmc
In-Reply-To: <17b686d1aaf6fa6bfdbe30993804dd5a269ae6db.1346846464.git.afzal@ti.com>
References: <cover.1346846464.git.afzal@ti.com>
 <17b686d1aaf6fa6bfdbe30993804dd5a269ae6db.1346846464.git.afzal@ti.com>
Message-ID: <5047AC44.2060208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Afzal,

On 09/05/2012 07:37 AM, Afzal Mohammed wrote:
> Add gpmc hwmod and associated interconnect data
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   18 +++++++
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   18 +++++++
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   44 ++++++++++++++++-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   54 ++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_common_data.h       |    1 +
>  arch/arm/mach-omap2/prcm-common.h                  |    2 +
>  6 files changed, 136 insertions(+), 1 deletions(-)

[snip]

> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 3e7d6c1..ce02b56 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -2059,6 +2059,42 @@ static struct omap_hwmod omap3xxx_counter_32k_hwmod = {
>  };
>  
>  /*
> + * 'gpmc' class
> + * general purpose memory controller
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap3xxx_gpmc_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
> +			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap3xxx_gpmc_hwmod_class = {
> +	.name	= "gpmc",
> +	.sysc	= &omap3xxx_gpmc_sysc,
> +};
> +
> +static struct omap_hwmod_irq_info omap3xxx_gpmc_irqs[] = {
> +	{ .irq = 20 },
> +	{ .irq = -1 }
> +};
> +
> +static struct omap_hwmod omap3xxx_gpmc_hwmod = {
> +	.name		= "gpmc",
> +	.class		= &omap3xxx_gpmc_hwmod_class,
> +	.clkdm_name	= "l3_init_clkdm",

This all looks good, but I believe that the gpmc clock-domain should be
the core_l3_clkdm.

Cheers
Jon
