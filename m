From: nicolas.thery@st.com (Nicolas THERY)
Date: Wed, 29 Aug 2012 16:55:32 +0200
Subject: [PATCH] [media] atmel_isi: allocate memory to store the isi
 platform data.
In-Reply-To: <1346235093-28613-1-git-send-email-josh.wu@atmel.com>
References: <1346235093-28613-1-git-send-email-josh.wu@atmel.com>
Message-ID: <503E2D64.1020303@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2012-08-29 12:11, Josh Wu wrote:
> This patch fix the bug: ISI driver's platform data became invalid when isi platform data's attribution is __initdata.
> 
> If the isi platform data is passed as __initdata. Then we need store it in driver allocated memory. otherwise when we use it out of the probe() function, then the isi platform data is invalid.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
>  drivers/media/platform/soc_camera/atmel-isi.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
> index ec3f6a0..dc0fdec 100644
> --- a/drivers/media/platform/soc_camera/atmel-isi.c
> +++ b/drivers/media/platform/soc_camera/atmel-isi.c
> @@ -926,6 +926,7 @@ static int __devexit atmel_isi_remove(struct platform_device *pdev)
>  	clk_put(isi->mck);
>  	clk_unprepare(isi->pclk);
>  	clk_put(isi->pclk);
> +	kfree(isi->pdata);

Not needed if you use devm_kzalloc().  See below.

>  	kfree(isi);
>  
>  	return 0;
> @@ -968,8 +969,15 @@ static int __devinit atmel_isi_probe(struct platform_device *pdev)
>  		goto err_alloc_isi;
>  	}
>  
> +	isi->pdata = kzalloc(sizeof(struct isi_platform_data), GFP_KERNEL);
> +	if (!isi->pdata) {
> +		ret = -ENOMEM;
> +		dev_err(&pdev->dev, "Can't allocate isi platform data!\n");
> +		goto err_alloc_isi_pdata;
> +	}
> +	memcpy(isi->pdata, pdata, sizeof(struct isi_platform_data));
> +

It is more idiomatic to use sizeof(*isi->pdata) in kzalloc() and memcpy() calls
to be resilient to future type changes.

You may also want to use dev_kzalloc() which frees memory automagically on
driver detach.

>  	isi->pclk = pclk;
> -	isi->pdata = pdata;
>  	isi->active = NULL;
>  	spin_lock_init(&isi->lock);
>  	init_waitqueue_head(&isi->vsync_wq);
> @@ -1073,6 +1081,8 @@ err_set_mck_rate:
>  err_clk_prepare_mck:
>  	clk_put(isi->mck);
>  err_clk_get:
> +	kfree(isi->pdata);
> +err_alloc_isi_pdata:
>  	kfree(isi);
>  err_alloc_isi:
>  	clk_unprepare(pclk);
> 

Best regards,
Nicolas
