From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sun, 18 May 2014 01:08:36 +0300
Subject: [PATCH v3] ARM: imx: fix error handling in ipu device registration
In-Reply-To: <20140517191821.GD16662@pengutronix.de>
References: <1400352033-18262-1-git-send-email-emilgoode@gmail.com>
 <20140517191821.GD16662@pengutronix.de>
Message-ID: <20140517220836.GI15585@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 17, 2014 at 09:18:21PM +0200, Uwe Kleine-K?nig wrote:
> diff --git a/arch/arm/mach-imx/devices/platform-ipu-core.c b/arch/arm/mach-imx/devices/platform-ipu-core.c
> index fc4dd7cedc11..6bd7c3f37ac0 100644
> --- a/arch/arm/mach-imx/devices/platform-ipu-core.c
> +++ b/arch/arm/mach-imx/devices/platform-ipu-core.c
> @@ -77,7 +77,7 @@ struct platform_device *__init imx_alloc_mx3_camera(
>  
>  	pdev = platform_device_alloc("mx3-camera", 0);
>  	if (!pdev)
> -		goto err;
> +		return ERR_PTR(-ENOMEM);
>  
>  	pdev->dev.dma_mask = kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
>  	if (!pdev->dev.dma_mask)

Emil, do this one, please and not the second suggestion.

Direct returns are more readable.  Otherwise, you wonder what the goto
is for and where it will take you and be annoyed to discover it is a
waste of time, no-op goto.  Also you will wonder if platform_device_put()
accepts NULL pointers.  Thirdly there is a small ugliness that the error
code is not preserved.  What is the point of setting the error code to
-ENOMEM only to discard it?

Let's look at that error handling again.

err:  <-- the name is not descriptive.  the location is bad.
		kfree(pdev->dev.dma_mask);  <- null dereference.
		platform_device_put(pdev);  <- ok
		return ERR_PTR(-ENODEV);    <- should be "return ERR_PTR(ret);"

3 out of 4 of the lines are bad.

regards,
dan carpenter
