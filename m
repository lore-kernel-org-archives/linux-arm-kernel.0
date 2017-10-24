From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Oct 2017 11:01:02 -0500
Subject: [PATCH 02/10] drm/sun4i: tcon: Add support for A10 TCON
In-Reply-To: <20171017121807.2994-3-wens@csie.org>
References: <20171017121807.2994-1-wens@csie.org>
 <20171017121807.2994-3-wens@csie.org>
Message-ID: <20171024160102.fjonpvkykyijxmow@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 08:17:59PM +0800, Chen-Yu Tsai wrote:
> From: Jonathan Liu <net147@gmail.com>
> 
> The A10 has two TCONs that are similar to the ones found on other SoCs.
> Like the A31, TCON0 has a register used to mux the TCON outputs to the
> downstream encoders. The bit fields are slightly different.
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> [wens at csie.org: Reworked for A10 and fixed up commit message]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt           |  1 +
>  drivers/gpu/drm/sun4i/sun4i_drv.c                  |  3 ++-
>  drivers/gpu/drm/sun4i/sun4i_tcon.c                 | 30 ++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 46df3b78ae9e..b2c08af73a95 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -86,6 +86,7 @@ The TCON acts as a timing controller for RGB, LVDS and TV interfaces.
>  
>  Required properties:
>   - compatible: value must be either:
> +   * allwinner,sun4i-a10-tcon
>     * allwinner,sun5i-a13-tcon
>     * allwinner,sun6i-a31-tcon
>     * allwinner,sun6i-a31s-tcon
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index b5879d4620d8..b8089ac6feef 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -184,7 +184,8 @@ static bool sun4i_drv_node_is_frontend(struct device_node *node)
>  
>  static bool sun4i_drv_node_is_tcon(struct device_node *node)
>  {
> -	return of_device_is_compatible(node, "allwinner,sun5i-a13-tcon") ||
> +	return of_device_is_compatible(node, "allwinner,sun4i-a10-tcon") ||
> +		of_device_is_compatible(node, "allwinner,sun5i-a13-tcon") ||

This would be better written with of_match_node. Since there's already a 
match table in sun4i_tcon.c, it would be better to use it.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
