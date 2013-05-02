From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 02 May 2013 14:31:43 +0900
Subject: [PATCH 8/9] s3c2410fb: Remove redundant platform_set_drvdata()
In-Reply-To: <1367006543-5458-9-git-send-email-sylvester.nawrocki@gmail.com>
References: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
 <1367006543-5458-9-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <000001ce46f6$54f27cc0$fed77640$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, April 27, 2013 5:02 AM, Sylwester Nawrocki wrote:
> driver_data field is being cleared by the driver core since
> commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> device-core: Ensure drvdata = NULL when no driver is bound
> hence there is no need to do it in the driver's remove() callback.
> 
> Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> ---
>  drivers/video/s3c2410fb.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
> index 11f98ca..0439ed0 100644
> --- a/drivers/video/s3c2410fb.c
> +++ b/drivers/video/s3c2410fb.c
> @@ -1013,7 +1013,6 @@ static int s3c2410fb_remove(struct platform_device *pdev)
>  	irq = platform_get_irq(pdev, 0);
>  	free_irq(irq, info);
> 
> -	platform_set_drvdata(pdev, NULL);
>  	framebuffer_release(fbinfo);

Hi Sylwester,

How about eliminating platform_set_drvdata(pdev, NULL)
in s3c24xxfb_probe() as well as s3c2410fb_remove()?

@@ -1005,7 +1005,6 @@ release_regs:
 release_mem:
        release_mem_region(res->start, size);
 dealloc_fb:
-       platform_set_drvdata(pdev, NULL);
        framebuffer_release(fbinfo);
        return ret;
 }

Best regards,
Jingoo Han

> 
>  	return 0;
> --
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
