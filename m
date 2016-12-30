From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 30 Dec 2016 14:46:52 +0800
Subject: [PATCH v2] bus: imx-weim: Fix the "fsl, weim-cs-gpr" lookup method
In-Reply-To: <1480089861-28025-1-git-send-email-festevam@gmail.com>
References: <1480089861-28025-1-git-send-email-festevam@gmail.com>
Message-ID: <20161230064650.GN6177@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 02:04:21PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Commit 1be81ea5860744520 ("ARM: dts: imx6: Add imx-weim parameters to
> dtsi's") causes the following probe error when the weim node is not
> present on the board dts (such as imx6q-sabresd):
> 
> imx-weim 21b8000.weim: Invalid 'ranges' configuration
> imx-weim: probe of 21b8000.weim failed with error -22
> 
> As the "fsl,weim-cs-gpr" property changed the location from the individual
> board dts "&weim" node to the common dtsi node we can no longer reach it
> via syscon_regmap_lookup_by_phandle(), so use
> syscon_regmap_lookup_by_compatible() instead, which will successfully
> find the "fsl,weim-cs-gpr" property.
> 
> Fixes: 1be81ea5860744520 ("ARM: dts: imx6: Add imx-weim parameters to dtsi's")
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

NACK.

> ---
> Changes since v1:
> - Fix copy and paste error of the error message
> - Add Fixes tag
> 
>  drivers/bus/imx-weim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 4bd361d..9824c58 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -76,7 +76,7 @@ static int __init imx_weim_gpr_setup(struct platform_device *pdev)
>  	int cs = 0;
>  	int i = 0;
>  
> -	gpr = syscon_regmap_lookup_by_phandle(np, "fsl,weim-cs-gpr");
> +	gpr = syscon_regmap_lookup_by_compatible("fsl,weim-cs-gpr");

"fsl,weim-cs-gpr" is *not* a compatible string, while
what syscon_regmap_lookup_by_compatible() does is to find a syscon node
by its compatible string.

Your understanding about how the error message comes and the fix to it
are completely wrong.

Shawn

>  	if (IS_ERR(gpr)) {
>  		dev_dbg(&pdev->dev, "failed to find weim-cs-gpr\n");
>  		return 0;
> -- 
> 2.7.4
> 
