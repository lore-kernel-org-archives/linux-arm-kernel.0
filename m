From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 8 Jun 2017 09:20:18 +0300
Subject: [PATCH 05/11] ARM: OMAP2+: Remove unused legacy code for McBSP
In-Reply-To: <20170531225139.30723-6-tony@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-6-tony@atomide.com>
Message-ID: <453777a3-ba95-61ef-494c-af0442b42284@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-06-01 01:51, Tony Lindgren wrote:
> We are now booting all mach-omap2 in device tree only mode.
> Any code that is only called in legacy boot mode where
> of_have_populated_dt() is not set is safe to remove now.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  arch/arm/mach-omap2/mcbsp.c | 70 ---------------------------------------------
>  1 file changed, 70 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -53,73 +53,3 @@ void __init omap3_mcbsp_init_pdata_callback(
>  
>  	pdata->force_ick_on = omap3_mcbsp_force_ick_on;
>  }
> -
> -static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
> -{
> -	int id, count = 1;
> -	char *name = "omap-mcbsp";
> -	struct omap_hwmod *oh_device[2];
> -	struct omap_mcbsp_platform_data *pdata = NULL;
> -	struct platform_device *pdev;
> -
> -	sscanf(oh->name, "mcbsp%d", &id);
> -
> -	pdata = kzalloc(sizeof(struct omap_mcbsp_platform_data), GFP_KERNEL);
> -	if (!pdata) {
> -		pr_err("%s: No memory for mcbsp\n", __func__);
> -		return -ENOMEM;
> -	}
> -
> -	pdata->reg_step = 4;
> -	if (oh->class->rev < MCBSP_CONFIG_TYPE2) {
> -		pdata->reg_size = 2;
> -	} else {
> -		pdata->reg_size = 4;
> -		pdata->has_ccr = true;
> -	}
> -
> -	if (oh->class->rev == MCBSP_CONFIG_TYPE2) {
> -		/* The FIFO has 128 locations */
> -		pdata->buffer_size = 0x80;
> -	} else if (oh->class->rev == MCBSP_CONFIG_TYPE3) {
> -		if (id == 2)
> -			/* The FIFO has 1024 + 256 locations */
> -			pdata->buffer_size = 0x500;
> -		else
> -			/* The FIFO has 128 locations */
> -			pdata->buffer_size = 0x80;
> -	} else if (oh->class->rev == MCBSP_CONFIG_TYPE4) {
> -		/* The FIFO has 128 locations for all instances */
> -		pdata->buffer_size = 0x80;
> -	}
> -
> -	if (oh->class->rev >= MCBSP_CONFIG_TYPE3)
> -		pdata->has_wakeup = true;
> -
> -	oh_device[0] = oh;
> -
> -	if (oh->dev_attr) {
> -		oh_device[1] = omap_hwmod_lookup((
> -		(struct omap_mcbsp_dev_attr *)(oh->dev_attr))->sidetone);
> -		pdata->force_ick_on = omap3_mcbsp_force_ick_on;
> -		count++;
> -	}
> -	pdev = omap_device_build_ss(name, id, oh_device, count, pdata,
> -				    sizeof(*pdata));
> -	kfree(pdata);
> -	if (IS_ERR(pdev))  {
> -		pr_err("%s: Can't build omap_device for %s:%s.\n", __func__,
> -					name, oh->name);
> -		return PTR_ERR(pdev);
> -	}
> -	return 0;
> -}
> -
> -static int __init omap2_mcbsp_init(void)
> -{
> -	if (!of_have_populated_dt())
> -		omap_hwmod_for_each_by_class("mcbsp", omap_init_mcbsp, NULL);
> -
> -	return 0;
> -}
> -omap_arch_initcall(omap2_mcbsp_init);
> 

- P?ter
