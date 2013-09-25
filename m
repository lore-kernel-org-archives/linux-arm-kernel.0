From: t.stanislaws@samsung.com (Tomasz Stanislawski)
Date: Wed, 25 Sep 2013 17:46:36 +0200
Subject: [PATCH v5 2/4] media: s5p-tv: Restore vpll clock rate
In-Reply-To: <1379775649-6331-3-git-send-email-m.krawczuk@partner.samsung.com>
References: <1379775649-6331-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1379775649-6331-3-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <5243055C.7070205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As you can see sdo, hdmi and mixer are saparate drivers that are
parts of s5p-tv drivers set. Could you rename commit name to
'media: s5p-tv: sdo: Restore vpll clock rate after streamoff'


On 09/21/2013 05:00 PM, Mateusz Krawczuk wrote:
> Restore vpll clock rate if start stream fail or stream is off.
> 
> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/media/platform/s5p-tv/sdo_drv.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/s5p-tv/sdo_drv.c b/drivers/media/platform/s5p-tv/sdo_drv.c
> index 0afa90f..e49ac6c 100644
> --- a/drivers/media/platform/s5p-tv/sdo_drv.c
> +++ b/drivers/media/platform/s5p-tv/sdo_drv.c
> @@ -55,6 +55,8 @@ struct sdo_device {
>  	struct clk *dacphy;
>  	/** clock for control of VPLL */
>  	struct clk *fout_vpll;
> +	/** vpll rate before sdo stream was on */
> +	unsigned long vpll_rate;
>  	/** regulator for SDO IP power */
>  	struct regulator *vdac;
>  	/** regulator for SDO plug detection */
> @@ -193,17 +195,33 @@ static int sdo_s_power(struct v4l2_subdev *sd, int on)
>  
>  static int sdo_streamon(struct sdo_device *sdev)
>  {
> +	int ret;
> +
>  	/* set proper clock for Timing Generator */
> -	clk_set_rate(sdev->fout_vpll, 54000000);
> +	sdev->vpll_rate = clk_get_rate(sdev->fout_vpll);
> +	ret = clk_set_rate(sdev->fout_vpll, 54000000);
> +	if (ret < 0) {
> +		dev_err(sdev->dev, "Failed to set vpll rate\n");
> +		return ret;
> +	}
>  	dev_info(sdev->dev, "fout_vpll.rate = %lu\n",

Could you also remove the line below in a new 'sdo: cleanup' patch?
Change dev_info to dev_dbg in the line above.

>  	clk_get_rate(sdev->fout_vpll));
>  	/* enable clock in SDO */
>  	sdo_write_mask(sdev, SDO_CLKCON, ~0, SDO_TVOUT_CLOCK_ON);
> -	clk_enable(sdev->dacphy);
> +	ret = clk_enable(sdev->dacphy);
> +	if (ret < 0) {
> +		dev_err(sdev->dev, "clk_enable(dacphy) failed\n");
> +		goto fail;
> +	}
>  	/* enable DAC */
>  	sdo_write_mask(sdev, SDO_DAC, ~0, SDO_POWER_ON_DAC);
>  	sdo_reg_debug(sdev);
>  	return 0;
> +	
> +fail:
> +	sdo_write_mask(sdev, SDO_CLKCON, 0, SDO_TVOUT_CLOCK_ON);
> +	clk_set_rate(sdev->fout_vpll, sdev->vpll_rate);
> +	return ret;
>  }
>  
>  static int sdo_streamoff(struct sdo_device *sdev)
> @@ -220,6 +238,7 @@ static int sdo_streamoff(struct sdo_device *sdev)
>  	}
>  	if (tries == 0)
>  		dev_err(sdev->dev, "failed to stop streaming\n");

Produce some warning if the line below fails.

> +	clk_set_rate(sdev->fout_vpll, sdev->vpll_rate);
>  	return tries ? 0 : -EIO;
>  }
>  
> 
