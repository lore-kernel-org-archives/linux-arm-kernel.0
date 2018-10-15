From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 16 Oct 2018 01:22:21 +0300
Subject: [PATCH 3/5] drm: rcar-du: Add r8a77470 support
In-Reply-To: <1537553311-8831-4-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1537553311-8831-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1537553311-8831-4-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1733512.u0bX59egiB@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrizio,

Thank you for the patch.

On Friday, 21 September 2018 21:08:29 EEST Fabrizio Castro wrote:
> Add RZ/G1C (a.k.a. r8a77470) support to the R-Car DU driver.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index 02aee6c..c07d3f1 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -77,6 +77,31 @@ static const struct rcar_du_device_info
> rzg1_du_r8a7745_info = { },
>  };
> 
> +static const struct rcar_du_device_info rzg1_du_r8a77470_info = {
> +	.gen = 2,
> +	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
> +		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,

The DU driver has recently gained two new feature flags, 
RCAR_DU_FEATURE_INTERLACED and RCAR_DU_FEATURE_TVM_SYNC. I believe that both 
should be set here. Could you please confirm (and test) ?

> +	.channels_mask = BIT(1) | BIT(0),
> +	.routes = {
> +		/*
> +		 * R8A77470 has two RGB outputs, one LVDS output, and
> +		 * one analog video output (unsupported)

I'd write this "and one (currently unsupported) analog video output" to match 
the other device entries. With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +		 */
> +		[RCAR_DU_OUTPUT_DPAD0] = {
> +			.possible_crtcs = BIT(0),
> +			.port = 0,
> +		},
> +		[RCAR_DU_OUTPUT_DPAD1] = {
> +			.possible_crtcs = BIT(1),
> +			.port = 1,
> +		},
> +		[RCAR_DU_OUTPUT_LVDS0] = {
> +			.possible_crtcs = BIT(0) | BIT(1),
> +			.port = 2,
> +		},
> +	},
> +};
> +
>  static const struct rcar_du_device_info rcar_du_r8a7779_info = {
>  	.gen = 2,
>  	.features = 0,
> @@ -297,6 +322,7 @@ static const struct rcar_du_device_info
> rcar_du_r8a77970_info = { static const struct of_device_id
> rcar_du_of_table[] = {
>  	{ .compatible = "renesas,du-r8a7743", .data = &rzg1_du_r8a7743_info },
>  	{ .compatible = "renesas,du-r8a7745", .data = &rzg1_du_r8a7745_info },
> +	{ .compatible = "renesas,du-r8a77470", .data = &rzg1_du_r8a77470_info },
>  	{ .compatible = "renesas,du-r8a7779", .data = &rcar_du_r8a7779_info },
>  	{ .compatible = "renesas,du-r8a7790", .data = &rcar_du_r8a7790_info },
>  	{ .compatible = "renesas,du-r8a7791", .data = &rcar_du_r8a7791_info },

-- 
Regards,

Laurent Pinchart
