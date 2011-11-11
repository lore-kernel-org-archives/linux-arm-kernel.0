From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 11 Nov 2011 16:04:22 +0100
Subject: [PATCH 1/1] ASoC: mxs-saif: remove function in platform_data
In-Reply-To: <1321003740-10992-1-git-send-email-b29396@freescale.com>
References: <1321003740-10992-1-git-send-email-b29396@freescale.com>
Message-ID: <20111111150422.GX16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 05:29:00PM +0800, Dong Aisheng wrote:
> Add master_mode and master_id in platfrom_data since it's board
> specific and board knows it.
> Then we can remove the function pointer in platfrom_data to make
> the driver more devicetree friendly.

Looks ok. Marc, is it ok when I take this patch? The SoC specific stuff
for this patch depends on it.

Sascha

> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
> This patch is based on Sascha's suggestions and see using in
> [PATCH v5 0/3] ARM: mxs: add recording support for saif
> ---
>  include/sound/saif.h     |    4 ++--
>  sound/soc/mxs/mxs-saif.c |   19 ++++++++-----------
>  2 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/include/sound/saif.h b/include/sound/saif.h
> index d0e0de7..f22f3e1 100644
> --- a/include/sound/saif.h
> +++ b/include/sound/saif.h
> @@ -10,7 +10,7 @@
>  #define __SOUND_SAIF_H__
>  
>  struct mxs_saif_platform_data {
> -	int (*init) (void);
> -	int (*get_master_id) (unsigned int saif_id);
> +	bool master_mode;	/* if true use master mode */
> +	int master_id;		/* id of the master if in slave mode */
>  };
>  #endif
> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> index 76dc74d..03b64d2 100644
> --- a/sound/soc/mxs/mxs-saif.c
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -625,13 +625,6 @@ static int mxs_saif_probe(struct platform_device *pdev)
>  	if (pdev->id >= ARRAY_SIZE(mxs_saif))
>  		return -EINVAL;
>  
> -	pdata = pdev->dev.platform_data;
> -	if (pdata && pdata->init) {
> -		ret = pdata->init();
> -		if (ret)
> -			return ret;
> -	}
> -
>  	saif = kzalloc(sizeof(*saif), GFP_KERNEL);
>  	if (!saif)
>  		return -ENOMEM;
> @@ -639,12 +632,16 @@ static int mxs_saif_probe(struct platform_device *pdev)
>  	mxs_saif[pdev->id] = saif;
>  	saif->id = pdev->id;
>  
> -	saif->master_id = saif->id;
> -	if (pdata && pdata->get_master_id) {
> -		saif->master_id = pdata->get_master_id(saif->id);
> +	pdata = pdev->dev.platform_data;
> +	if (pdata && !pdata->master_mode) {
> +		saif->master_id = pdata->master_id;
>  		if (saif->master_id < 0 ||
> -			saif->master_id >= ARRAY_SIZE(mxs_saif))
> +			saif->master_id >= ARRAY_SIZE(mxs_saif) ||
> +			saif->master_id == saif->id)
> +			dev_err(&pdev->dev, "get wrong master id\n");
>  			return -EINVAL;
> +	} else {
> +		saif->master_id = saif->id;
>  	}
>  
>  	saif->clk = clk_get(&pdev->dev, NULL);
> -- 
> 1.7.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
