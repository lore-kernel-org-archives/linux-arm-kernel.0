From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 8 Sep 2011 11:01:48 -0700
Subject: [RFC PATCH 01/10] OMAP2+: l3-noc: Add support for device-tree
In-Reply-To: <1314191356-10963-2-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-2-git-send-email-b-cousson@ti.com>
Message-ID: <20110908180148.GA2967@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 03:09:07PM +0200, Benoit Cousson wrote:
> Add device-tree support for the l3-noc driver.
> 
> Use platform_driver_register to defer the probing at device init
> time.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap_l3_noc.c |   16 ++++++++++++++--
>  1 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
> index 7b9f190..4630703 100644
> --- a/arch/arm/mach-omap2/omap_l3_noc.c
> +++ b/arch/arm/mach-omap2/omap_l3_noc.c
> @@ -228,16 +228,28 @@ static int __exit omap4_l3_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id l3_noc_match[] = {
> +	{.compatible = "arteris,noc", },

Missing documentation for this compatible property.  Also, it appears
to be rather on the generic side.

> +	{},
> +}
> +MODULE_DEVICE_TABLE(of, l3_noc_match);
> +#else
> +#define l3_noc_match NULL
> +#endif
> +
>  static struct platform_driver omap4_l3_driver = {
> +	.probe		= omap4_l3_probe,

.probe needs to be put into the __devinit section.

>  	.remove		= __exit_p(omap4_l3_remove),

Similarly, at the same time the remove hook should be changed to
__devexit and __devexit_p() at the same time.

>  	.driver		= {
> -	.name		= "omap_l3_noc",
> +		.name		= "omap_l3_noc",
> +		.of_match_table = l3_noc_match,

Looks like ".owner = THIS_MODULE," is missing too.

>  	},
>  };
>  
>  static int __init omap4_l3_init(void)
>  {
> -	return platform_driver_probe(&omap4_l3_driver, omap4_l3_probe);
> +	return platform_driver_register(&omap4_l3_driver);
>  }
>  postcore_initcall_sync(omap4_l3_init);
>  
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
