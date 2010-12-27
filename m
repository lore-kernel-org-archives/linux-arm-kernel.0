From: mayur@ti.com (Janorkar, Mayuresh)
Date: Mon, 27 Dec 2010 19:14:00 +0530
Subject: [PATCH v3] video: imxfb: Fix the maximum value for yres
In-Reply-To: <1293193704-2855-1-git-send-email-fabio.estevam@freescale.com>
References: <1293193704-2855-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB03229E3308@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio,
________________________________________
> From: linux-fbdev-owner at vger.kernel.org [linux-fbdev-owner at vger.kernel.org] On Behalf Of Fabio Estevam [fabio.estevam at freescale.com]
> Sent: Friday, December 24, 2010 5:58 PM
> To: linux-fbdev at vger.kernel.org
> Cc: kernel at pengutronix.de; linux-arm-kernel at lists.infradead.org; lethal at linux-sh.org; Fabio Estevam
> Subject: [PATCH v3] video: imxfb: Fix the maximum value for yres
>
>MX27 and MX25 have 10 bits in the YMAX field of LCDC Size Register.
>
>Fix the maximum value for yres.
>
>Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>---
>Changes since v2:
>- Perform run-time detection of CPU time
>
>Changes since v1:
>- factor out SIZE_YMAX definition
> drivers/video/imxfb.c |    9 +++------
> 1 files changed, 3 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
>index 5c363d0..1ab2c25 100644
>--- a/drivers/video/imxfb.c
>+++ b/drivers/video/imxfb.c
>@@ -53,11 +53,8 @@
 >#define LCDC_SIZE      0x04
 >#define SIZE_XMAX(x)   ((((x) >> 4) & 0x3f) << 20)
>
>-#ifdef CONFIG_ARCH_MX1
>-#define SIZE_YMAX(y)   ((y) & 0x1ff)
>-#else
>-#define SIZE_YMAX(y)   ((y) & 0x3ff)
>-#endif
>+#define YMAX_MASK       (cpu_is_mx1() ? 0x1ff : 0x3ff)
>+#define SIZE_YMAX(y)   ((y) & YMAX_MASK)
>
>#define LCDC_VPW       0x08
> #define VPW_VPW(x)     ((x) & 0x3ff)
> @@ -623,7 +620,7 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
>       if (var->right_margin > 255)
>                printk(KERN_ERR "%s: invalid right_margin %d\n",
>                      info->fix.id, var->right_margin);
>-       if (var->yres < 1 || var->yres > 511)
>+       if (var->yres < 1 || var->yres > YMAX_MASK)

[Mayuresh]: If minimum value of yres_mask is 1 then you please define YMIN_MASK to be 1
This would make your code more readable.

>               printk(KERN_ERR "%s: invalid yres %d\n",
>                      info->fix.id, var->yres);
>       if (var->vsync_len > 100)
>--
> 1.6.0.4
