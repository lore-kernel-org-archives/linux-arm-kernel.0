From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 2 Mar 2015 21:51:12 +0800
Subject: [PATCH v3 1/1] i.MX6: WEIM: improve error handling upon child
 probe-failure
In-Reply-To: <1424330650-8499-1-git-send-email-alison_chaiken@mentor.com>
References: <21911320.10lVZQzK19@jclayton-pc>
 <1424330650-8499-1-git-send-email-alison_chaiken@mentor.com>
Message-ID: <20150302135109.GH3040@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 11:24:10PM -0800, alison at she-devel.com wrote:
> From: Alison Chaiken <alison_chaiken@mentor.com>
> 
> Probe all children of the WEIM node, reporting any failures.  Report
> failure from parsing of WEIM node itself if probes of all children fail.
> 
> Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>

Applied after fixing the patch prefix to be 'bus: imx-weim: '.

Shawn

> ---
>  drivers/bus/imx-weim.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 0958b69..e98d15e 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -142,7 +142,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
>  							   &pdev->dev);
>  	const struct imx_weim_devtype *devtype = of_id->data;
>  	struct device_node *child;
> -	int ret;
> +	int ret, have_child = 0;
>  
>  	if (devtype == &imx50_weim_devtype) {
>  		ret = imx_weim_gpr_setup(pdev);
> @@ -155,14 +155,15 @@ static int __init weim_parse_dt(struct platform_device *pdev,
>  			continue;
>  
>  		ret = weim_timing_setup(child, base, devtype);
> -		if (ret) {
> -			dev_err(&pdev->dev, "%s set timing failed.\n",
> +		if (ret)
> +			dev_warn(&pdev->dev, "%s set timing failed.\n",
>  				child->full_name);
> -			return ret;
> -		}
> +		else
> +			have_child = 1;
>  	}
>  
> -	ret = of_platform_populate(pdev->dev.of_node,
> +	if (have_child)
> +		ret = of_platform_populate(pdev->dev.of_node,
>  				   of_default_bus_match_table,
>  				   NULL, &pdev->dev);
>  	if (ret)
> -- 
> 2.1.4
> 
