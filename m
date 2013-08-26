From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 26 Aug 2013 18:03:59 +0200
Subject: [PATCH RFC 2/5] media: s5p-tv: Fix mixer driver to work with CCF
In-Reply-To: <1377517114-20222-3-git-send-email-m.krawczuk@partner.samsung.com>
References: <1377517114-20222-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1377517114-20222-3-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <6152934.i30tL7314f@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, August 26, 2013 01:38:31 PM Mateusz Krawczuk wrote:
> Replace clk_enable by clock_enable_prepare and clk_disable with clk_disable_unprepare.
> Clock prepare is required by Clock Common Framework, and old clock driver didn`t support it.
> Without it Common Clock Framework prints a warning.
> 
> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> ---
>  drivers/media/platform/s5p-tv/mixer_drv.c | 33 +++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/s5p-tv/mixer_drv.c b/drivers/media/platform/s5p-tv/mixer_drv.c
> index 51805a5..f889591 100644
> --- a/drivers/media/platform/s5p-tv/mixer_drv.c
> +++ b/drivers/media/platform/s5p-tv/mixer_drv.c
> @@ -345,21 +345,42 @@ fail:
>  
>  static int mxr_runtime_resume(struct device *dev)
>  {
> +	int ret = 0;

There is no need to initialize it to 0 here.

>  	struct mxr_device *mdev = to_mdev(dev);
>  	struct mxr_resources *res = &mdev->res;
>  
>  	mxr_dbg(mdev, "resume - start\n");
>  	mutex_lock(&mdev->mutex);
>  	/* turn clocks on */
> -	clk_enable(res->mixer);
> -	clk_enable(res->vp);
> -	clk_enable(res->sclk_mixer);
> +	ret = clk_prepare_enable(res->mixer);
> +	if (ret < 0) {
> +		dev_err(dev, "clk_prepare_enable(mixer) failed\n");

There is no consistency in the error messages between patch #1 and #2.

How's about changing error messages in the patch #2 to use

"%s: Failed to prepare and enable mixer clock!", __func__

form?

> +		goto fail;
> +	}
> +	ret = clk_prepare_enable(res->vp);
> +	if (ret < 0) {
> +		dev_err(dev, "clk_prepare_enable(vp) failed\n");
> +		goto fail_mixer;
> +	}
> +	ret = clk_prepare_enable(res->sclk_mixer);
> +	if (ret < 0) {
> +		dev_err(dev, "clk_prepare_enable(sclk_mixer) failed\n");
> +		goto fail_vp;
> +	}
>  	/* apply default configuration */
>  	mxr_reg_reset(mdev);
>  	mxr_dbg(mdev, "resume - finished\n");

While at it the above mxr_dbg() can be moved outside the mutex lock.

>  	mutex_unlock(&mdev->mutex);
>  	return 0;
> +fail_vp:
> +	clk_disable_unprepare(res->vp);
> +fail_mixer:
> +	clk_disable_unprepare(res->mixer);
> +fail:
> +	mutex_unlock(&mdev->mutex);
> +	dev_info(dev, "resume failed\n");

Shouldn't it be dev_err()?

Please also add mxr_dbg(mdev, "resume - finished\n") call here
to match the earlier mxr_dbg(mdev, "resume - start\n") one.

> +	return ret;
>  }
>  
>  static int mxr_runtime_suspend(struct device *dev)
> @@ -369,9 +390,9 @@ static int mxr_runtime_suspend(struct device *dev)
>  	mxr_dbg(mdev, "suspend - start\n");
>  	mutex_lock(&mdev->mutex);
>  	/* turn clocks off */
> -	clk_disable(res->sclk_mixer);
> -	clk_disable(res->vp);
> -	clk_disable(res->mixer);
> +	clk_disable_unprepare(res->sclk_mixer);
> +	clk_disable_unprepare(res->vp);
> +	clk_disable_unprepare(res->mixer);
>  	mutex_unlock(&mdev->mutex);
>  	mxr_dbg(mdev, "suspend - finished\n");
>  	return 0;

While at this driver please note that currently it defines its own macros to
use instead of dev_err(), dev_warn() and dev_info().

drivers/media/platform/s5p-tv/mixer.h:
...
#define mxr_err(mdev, fmt, ...)  dev_err(mdev->dev, fmt, ##__VA_ARGS__)
#define mxr_warn(mdev, fmt, ...) dev_warn(mdev->dev, fmt, ##__VA_ARGS__)
#define mxr_info(mdev, fmt, ...) dev_info(mdev->dev, fmt, ##__VA_ARGS__)
...

Since your patch adds dev_err() and dev_info() instances it would be a good
thing to remove mxr_*() macros in the preparatory patch.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
