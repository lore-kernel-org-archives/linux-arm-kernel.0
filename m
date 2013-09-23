From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 23 Sep 2013 14:44:09 +0200
Subject: [PATCH v5 4/4] media: s5p-tv: Fix mixer driver to work with CCF
In-Reply-To: <1379775649-6331-5-git-send-email-m.krawczuk@partner.samsung.com>
References: <1379775649-6331-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1379775649-6331-5-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <52403799.7020103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/13 17:00, Mateusz Krawczuk wrote:
> Replace clk_enable by clock_enable_prepare and clk_disable with clk_disable_unprepare.
> Clock prepare is required by Clock Common Framework, and old clock driver didn`t support it.
> Without it Common Clock Framework prints a warning.

nit: Please wrap this text to not exceed 80 columns.

> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/media/platform/s5p-tv/mixer_drv.c | 34 +++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/s5p-tv/mixer_drv.c b/drivers/media/platform/s5p-tv/mixer_drv.c
> index 8ce7c3e..7eea286 100644
> --- a/drivers/media/platform/s5p-tv/mixer_drv.c
> +++ b/drivers/media/platform/s5p-tv/mixer_drv.c
> @@ -347,19 +347,41 @@ static int mxr_runtime_resume(struct device *dev)
>  {
>  	struct mxr_device *mdev = to_mdev(dev);
>  	struct mxr_resources *res = &mdev->res;
> +	int ret;
>  
>  	dev_dbg(mdev->dev, "resume - start\n");
>  	mutex_lock(&mdev->mutex);
>  	/* turn clocks on */
> -	clk_enable(res->mixer);
> -	clk_enable(res->vp);
> -	clk_enable(res->sclk_mixer);
> +	ret = clk_prepare_enable(res->mixer);
> +	if (ret < 0) {
> +		dev_err(mdev->dev, "clk_prepare_enable(mixer) failed\n");
> +		goto fail;
> +	}
> +	ret = clk_prepare_enable(res->vp);
> +	if (ret < 0) {
> +		dev_err(mdev->dev, "clk_prepare_enable(vp) failed\n");
> +		goto fail_mixer;
> +	}
> +	ret = clk_prepare_enable(res->sclk_mixer);
> +	if (ret < 0) {
> +		dev_err(mdev->dev, "clk_prepare_enable(sclk_mixer) failed\n");
> +		goto fail_vp;
> +	}
>  	/* apply default configuration */
>  	mxr_reg_reset(mdev);
>  	dev_dbg(mdev->dev, "resume - finished\n");
>  
>  	mutex_unlock(&mdev->mutex);
>  	return 0;
> +
> +fail_vp:
> +	clk_disable_unprepare(res->vp);
> +fail_mixer:
> +	clk_disable_unprepare(res->mixer);
> +fail:

How about only one error log here if any of the clk_prepare_enable() calls
fails ? I'm not sure if we need a separate log for each single clock.

> +	mutex_unlock(&mdev->mutex);
> +	dev_err(mdev->dev, "resume failed\n");
> +	return ret;
>  }

Regards,
Sylwester
