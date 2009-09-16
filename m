From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 01:17:09 +0100
Subject: [PATCH 09/10] S3C64XX I2S: Set parent links for clock audio-bus.
In-Reply-To: <1253008961-10698-1-git-send-email-jassi.brar@samsung.com>
References: <1253008961-10698-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090916001709.GE24720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:41PM +0900, Jassi wrote:
> Explicitly route audio-bus from FOUTepll via MOUTepll.
> 
> Signed-Off-by: Jassi <jassi.brar@samsung.com>
> ---
>  sound/soc/s3c24xx/s3c64xx-i2s.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
> index 66f4ded..71aeb33 100644
> --- a/sound/soc/s3c24xx/s3c64xx-i2s.c
> +++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
> @@ -254,6 +254,7 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
>  {
>  	struct s3c_i2sv2_info *i2s;
>  	struct snd_soc_dai *dai;
> +	struct clk *cm, *cf;
>  	int ret;
>  
>  	if (pdev->id >= ARRAY_SIZE(s3c64xx_i2s)) {
> @@ -275,6 +276,21 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> +	cm = clk_get(NULL, "mout_epll");
> +	if (IS_ERR(cm)) {
> +		dev_err(&pdev->dev, "failed to get mout_epll\n");
> +		ret = PTR_ERR(cm);
> +		goto mout_err;
> +	}
> +	clk_set_parent(i2s->iis_cclk, cm);
> +	cf = clk_get(NULL, "fout_epll");
> +	if (IS_ERR(cf)) {
> +		dev_err(&pdev->dev, "failed to get fout_epll\n");
> +		ret = PTR_ERR(cf);
> +		goto fout_err;
> +	}
> +	clk_set_parent(cm, cf);
> +
>  	ret = s3c_i2sv2_probe(pdev, dai, i2s, 0);
>  	if (ret)
>  		goto err_clk;
> @@ -283,11 +299,17 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
>  	if (ret != 0)
>  		goto err_i2sv2;
>  
> +	clk_put(cf);
> +	clk_put(cm);
>  	return 0;
>  
>  err_i2sv2:
>  	/* Not implemented for I2Sv2 core yet */
>  err_clk:
> +	clk_put(cf);
> +fout_err:
> +	clk_put(cm);
> +mout_err:
>  	clk_put(i2s->iis_cclk);
>  err:
>  	return ret;

This is the wrong place to be changing the clocks, it is making a policy
for _all_ boards that may use this code. It either belongs in the board
setup code, possibly in the board specific ASoC glue driver (maybe with
a common library if enough do it).

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
