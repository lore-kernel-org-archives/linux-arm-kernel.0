From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 20 Mar 2017 10:26:14 +0100
Subject: [PATCH 4/8] soc: imx: gpc: fix imx6sl gpc power domain regression
In-Reply-To: <1489990547-1510-5-git-send-email-aisheng.dong@nxp.com>
References: <1489990547-1510-1-git-send-email-aisheng.dong@nxp.com>
 <1489990547-1510-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1490001974.2895.11.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 20.03.2017, 14:15 +0800 schrieb Dong Aisheng:
> Commit 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> broke the MX6SL GPC power domain support.
> It always got the following error:
> [    1.248364] imx-gpc 20dc000.gpc: could not find pgc DT node
> This patch adds back the legecy support.

This patch removes a safeguard against abusing the old binding for new
SoCs. Please leave this check in place and instead loosen the check to
also allow the old i.MX6SL binding.

> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/soc/imx/gpc.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index ba6e7ab..c1d0e67 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -385,12 +385,6 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!pgc_node) {
> -		/* old DT layout is only supported for mx6q aka 2 domains */
> -		if (of_id_data->num_domains != 2) {
> -			dev_err(&pdev->dev, "could not find pgc DT node\n");
> -			return -ENODEV;
> -		}
> -
>  		ret = imx_gpc_old_dt_init(&pdev->dev, regmap);
>  		if (ret)
>  			return ret;
