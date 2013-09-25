From: t.stanislaws@samsung.com (Tomasz Stanislawski)
Date: Wed, 25 Sep 2013 17:59:45 +0200
Subject: [PATCH v5 3/4] media: s5p-tv: Fix sdo driver to work with CCF
In-Reply-To: <1379775649-6331-4-git-send-email-m.krawczuk@partner.samsung.com>
References: <1379775649-6331-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1379775649-6331-4-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <52430871.6040003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename to 'media: s5p-tv: sdo: integrate with CCF'

On 09/21/2013 05:00 PM, Mateusz Krawczuk wrote:
> Replace clk_enable by clock_enable_prepare and clk_disable with clk_disable_unprepare.
> Clock prepare is required by Clock Common Framework, and old clock driver didn`t support it.
> Without it Common Clock Framework prints a warning.
> 
> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/media/platform/s5p-tv/sdo_drv.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/s5p-tv/sdo_drv.c b/drivers/media/platform/s5p-tv/sdo_drv.c
> index e49ac6c..17272e1 100644
> --- a/drivers/media/platform/s5p-tv/sdo_drv.c
> +++ b/drivers/media/platform/s5p-tv/sdo_drv.c
> @@ -208,9 +208,9 @@ static int sdo_streamon(struct sdo_device *sdev)
>  	clk_get_rate(sdev->fout_vpll));
>  	/* enable clock in SDO */
>  	sdo_write_mask(sdev, SDO_CLKCON, ~0, SDO_TVOUT_CLOCK_ON);
> -	ret = clk_enable(sdev->dacphy);
> +	ret = clk_prepare_enable(sdev->dacphy);
>  	if (ret < 0) {
> -		dev_err(sdev->dev, "clk_enable(dacphy) failed\n");
> +		dev_err(sdev->dev, "clk_prepare_enable(dacphy) failed\n");
>  		goto fail;
>  	}
>  	/* enable DAC */
> @@ -229,7 +229,7 @@ static int sdo_streamoff(struct sdo_device *sdev)
>  	int tries;
>  
>  	sdo_write_mask(sdev, SDO_DAC, 0, SDO_POWER_ON_DAC);
> -	clk_disable(sdev->dacphy);
> +	clk_disable_unprepare(sdev->dacphy);
>  	sdo_write_mask(sdev, SDO_CLKCON, 0, SDO_TVOUT_CLOCK_ON);
>  	for (tries = 100; tries; --tries) {
>  		if (sdo_read(sdev, SDO_CLKCON) & SDO_TVOUT_CLOCK_READY)
> @@ -273,7 +273,7 @@ static int sdo_runtime_suspend(struct device *dev)
>  	dev_info(dev, "suspend\n");
>  	regulator_disable(sdev->vdet);
>  	regulator_disable(sdev->vdac);
> -	clk_disable(sdev->sclk_dac);
> +	clk_disable_unprepare(sdev->sclk_dac);
>  	return 0;
>  }
>  
> @@ -285,7 +285,7 @@ static int sdo_runtime_resume(struct device *dev)
>  
>  	dev_info(dev, "resume\n");
>  
> -	ret = clk_enable(sdev->sclk_dac);
> +	ret = clk_prepare_enable(sdev->sclk_dac);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -318,7 +318,7 @@ static int sdo_runtime_resume(struct device *dev)
>  vdac_r_dis:
>  	regulator_disable(sdev->vdac);
>  dac_clk_dis:
> -	clk_disable(sdev->sclk_dac);
> +	clk_disable_unprepare(sdev->sclk_dac);
>  	return ret;
>  }
>  
> @@ -424,7 +424,11 @@ static int sdo_probe(struct platform_device *pdev)
>  	}
>  
>  	/* enable gate for dac clock, because mixer uses it */
> -	clk_enable(sdev->dac);
> +	ret = clk_prepare_enable(sdev->dac);
> +	if (ret < 0) {
> +		dev_err(dev, "clk_prepare_enable(dac) failed\n");
> +		goto fail_fout_vpll;
> +	}
>  
>  	/* configure power management */
>  	pm_runtime_enable(dev);
> @@ -463,7 +467,7 @@ static int sdo_remove(struct platform_device *pdev)
>  	struct sdo_device *sdev = sd_to_sdev(sd);
>  
>  	pm_runtime_disable(&pdev->dev);
> -	clk_disable(sdev->dac);
> +	clk_disable_unprepare(sdev->dac);
>  	clk_put(sdev->fout_vpll);
>  	clk_put(sdev->dacphy);
>  	clk_put(sdev->dac);
> 
