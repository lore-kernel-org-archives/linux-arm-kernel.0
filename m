From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 28 Mar 2011 11:08:15 +0530
Subject: [PATCH] OMAP3: l3: fix for "irq 10: nobody cared" message
In-Reply-To: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
References: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <f12f050c3f7fe0b405fde475fcd62104@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Omar Ramirez Luna [mailto:omar.ramirez at ti.com]
> Sent: Saturday, March 26, 2011 6:00 AM
> To: Tony Lindgren
> Cc: Russell King; l-o; lak; sricharan; Santosh Shilimkar; Felipe
> Balbi; Benoit Cousson; Omar Ramirez Luna
> Subject: [PATCH] OMAP3: l3: fix for "irq 10: nobody cared" message
>
> If an error occurs in the L3 on any other initiator than MPU,
> the interrupt goes unhandled given that the 'base' register
> was calculated with the initialized err_base value (which
> coincidentally points to MPU) and not with the actual source
> of the error.
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Patch looks good. Did you observe this with DSP initiator??

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> ---
>  arch/arm/mach-omap2/omap_l3_smx.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-
> omap2/omap_l3_smx.c
> index 5f2da75..da917c2 100644
> --- a/arch/arm/mach-omap2/omap_l3_smx.c
> +++ b/arch/arm/mach-omap2/omap_l3_smx.c
> @@ -196,11 +196,12 @@ static irqreturn_t omap3_l3_app_irq(int irq,
> void *_l3)
>  		/* No timeout error for debug sources */
>  	}
>
> -	base = ((l3->rt) + (*(omap3_l3_bases[int_type] +
> err_source)));
> -
>  	/* identify the error source */
>  	for (err_source = 0; !(status & (1 << err_source));
> err_source++)
>  									;
> +
> +	base = ((l3->rt) + (*(omap3_l3_bases[int_type] +
> err_source)));
> +
>  	error = omap3_l3_readll(base, L3_ERROR_LOG);
>
>  	if (error) {
> --
> 1.7.1
