From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 12 Jan 2011 09:24:47 +0800
Subject: [PATCH 06/16] nuc900fb: don't treat NULL clk as an error
In-Reply-To: <1294749833-32019-7-git-send-email-jamie@jamieiles.com>
References: <1294749833-32019-1-git-send-email-jamie@jamieiles.com>
	<1294749833-32019-7-git-send-email-jamie@jamieiles.com>
Message-ID: <AANLkTingg+wm8jy4kRL=ubLFrCDXq17jZQkD3v3M4h+Y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/11 Jamie Iles <jamie@jamieiles.com>:
> clk_get() returns a struct clk cookie to the driver and some platforms
> may return NULL if they only support a single clock. ?clk_get() has only
> failed if it returns a ERR_PTR() encoded pointer.
>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: linux-fbdev at vger.kernel.org
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
> ?drivers/video/nuc900fb.c | ? ?5 +++--
> ?1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
> index 81687ed..62498bd 100644
> --- a/drivers/video/nuc900fb.c
> +++ b/drivers/video/nuc900fb.c
> @@ -15,6 +15,7 @@
> ?*/
> ?#include <linux/module.h>
> ?#include <linux/kernel.h>
> +#include <linux/err.h>
> ?#include <linux/errno.h>
> ?#include <linux/string.h>
> ?#include <linux/mm.h>
> @@ -597,9 +598,9 @@ static int __devinit nuc900fb_probe(struct platform_device *pdev)
> ? ? ? ?}
>
> ? ? ? ?fbi->clk = clk_get(&pdev->dev, NULL);
> - ? ? ? if (!fbi->clk || IS_ERR(fbi->clk)) {
> + ? ? ? if (IS_ERR(fbi->clk)) {
> ? ? ? ? ? ? ? ?printk(KERN_ERR "nuc900-lcd:failed to get lcd clock source\n");
> - ? ? ? ? ? ? ? ret = -ENOENT;
> + ? ? ? ? ? ? ? ret = PTR_ERR(fbi->clk);
> ? ? ? ? ? ? ? ?goto release_irq;
> ? ? ? ?}
>
Hi,

Thanks for your patch.

Acked-by: Wan ZongShun <mcuos.com@gmail.com>

> --
> 1.7.3.4
>
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
