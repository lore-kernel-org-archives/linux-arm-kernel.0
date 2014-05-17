From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 17 May 2014 21:18:21 +0200
Subject: [PATCH v3] ARM: imx: fix error handling in ipu device registration
In-Reply-To: <1400352033-18262-1-git-send-email-emilgoode@gmail.com>
References: <1400352033-18262-1-git-send-email-emilgoode@gmail.com>
Message-ID: <20140517191821.GD16662@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Emil,

On Sat, May 17, 2014 at 08:40:33PM +0200, Emil Goode wrote:
> If we fail to allocate struct platform_device pdev we
> dereference it after the goto label err.
> 
> I have rearranged the error handling a bit to fix the issue
> and also make it more clear.
> 
> Signed-off-by: Emil Goode <emilgoode@gmail.com>
> ---
> v3: Made subject line more specific.
> v2: Changed to return -ENOMEM instead of ret where possible and
>     updated the subject line.
> 
>  arch/arm/mach-imx/devices/platform-ipu-core.c |   22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
Considering that you can fix the issue also by just doing:

diff --git a/arch/arm/mach-imx/devices/platform-ipu-core.c b/arch/arm/mach-imx/devices/platform-ipu-core.c
index fc4dd7cedc11..6bd7c3f37ac0 100644
--- a/arch/arm/mach-imx/devices/platform-ipu-core.c
+++ b/arch/arm/mach-imx/devices/platform-ipu-core.c
@@ -77,7 +77,7 @@ struct platform_device *__init imx_alloc_mx3_camera(
 
 	pdev = platform_device_alloc("mx3-camera", 0);
 	if (!pdev)
-		goto err;
+		return ERR_PTR(-ENOMEM);
 
 	pdev->dev.dma_mask = kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
 	if (!pdev->dev.dma_mask)

or

diff --git a/arch/arm/mach-imx/devices/platform-ipu-core.c b/arch/arm/mach-imx/devices/platform-ipu-core.c
index fc4dd7cedc11..c609f3667200 100644
--- a/arch/arm/mach-imx/devices/platform-ipu-core.c
+++ b/arch/arm/mach-imx/devices/platform-ipu-core.c
@@ -96,7 +96,8 @@ struct platform_device *__init imx_alloc_mx3_camera(
 		ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
 		if (ret) {
 err:
-			kfree(pdev->dev.dma_mask);
+			if (pdev)
+				kfree(pdev->dev.dma_mask);
 			platform_device_put(pdev);
 			return ERR_PTR(-ENODEV);
 		}

I would prefer one of them as it is easier to justify and for the next
cycle convert the function to platform_device_register_full.

Also you should point out in the commit log that the issue was found by
coccinelle.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
