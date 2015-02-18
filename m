From: joshua.clayton@uniwest.com (Joshua Clayton)
Date: Wed, 18 Feb 2015 08:30:33 -0800
Subject: [PATCH] i.MX6: WEIM: improve error handling upon child
 probe-failure
In-Reply-To: <1424248641-30331-1-git-send-email-alison_chaiken@mentor.com>
References: <21911320.10lVZQzK19@jclayton-pc>
 <1424248641-30331-1-git-send-email-alison_chaiken@mentor.com>
Message-ID: <5344077.NzmbySR7Uz@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alison.
I'm assuming this is a v2 of your previously posted patch.
Bear in mind I am not super familiar with refcount issues in devicetree.
There is no explicit of_node_get(), at least at this level, so the need 
for the original patch is not entirely clear to me.

On Wednesday, February 18, 2015 12:37:21 AM alison at she-devel.com wrote:
> From: Alison Chaiken <alison_chaiken@mentor.com>
> 
> Probe all children of the WEIM node, reporting any failures.  Report
> failure from parsing of WEIM node itself if probes of all children fail.
> 
> Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>
> ---
>  drivers/bus/imx-weim.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 0958b69..98e04bf 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -142,7 +142,7 @@ static int __init weim_parse_dt(struct platform_device
> *pdev, &pdev->dev);
>  	const struct imx_weim_devtype *devtype = of_id->data;
>  	struct device_node *child;
> -	int ret;
> +	int ret, have_child;
You need to initialize have_child to 0.

> 
>  	if (devtype == &imx50_weim_devtype) {
>  		ret = imx_weim_gpr_setup(pdev);
> @@ -155,20 +155,24 @@ static int __init weim_parse_dt(struct platform_device
> *pdev, continue;
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
Where did the need for of_node_put() in the original patch come from?
Is it absolved by calling platform_populate? If so, should of_node_put()
be called for each child in the !have_child case?

> -	if (ret)
> +	if (ret) {
>  		dev_err(&pdev->dev, "%s fail to create devices.\n",
>  			pdev->dev.of_node->full_name);
> -	return ret;
> +		return ret;
> +	}
> +
> +	return 0;
>  }

This last change doesn't... err ... change. drop it.
> 
>  static int __init weim_probe(struct platform_device *pdev)
> --
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Joshua Clayton
Software Engineer
UniWest
122 S. 4th Avenue
Pasco, WA 99301
Ph: (509) 544-0720
Fx: (509) 544-0868 
