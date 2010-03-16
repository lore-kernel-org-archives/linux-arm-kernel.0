From: jayakumar.lkml@gmail.com (Jaya Kumar)
Date: Tue, 16 Mar 2010 15:57:51 +0800
Subject: [RFC/PATCH 08/10] [ARM] tegra: Add framebuffer driver
In-Reply-To: <1268721688-27550-9-git-send-email-konkers@google.com>
References: <4344f3c71003151538r7dc30e01uc9885ca5d3f327cd@mail.gmail.com>
	<1268721688-27550-1-git-send-email-konkers@google.com>
	<1268721688-27550-2-git-send-email-konkers@google.com>
	<1268721688-27550-3-git-send-email-konkers@google.com>
	<1268721688-27550-4-git-send-email-konkers@google.com>
	<1268721688-27550-5-git-send-email-konkers@google.com>
	<1268721688-27550-6-git-send-email-konkers@google.com>
	<1268721688-27550-7-git-send-email-konkers@google.com>
	<1268721688-27550-8-git-send-email-konkers@google.com>
	<1268721688-27550-9-git-send-email-konkers@google.com>
Message-ID: <45a44e481003160057oaf4a75ax2ec6c9eee9f4a3e9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin, Erik,

Interesting work.

I'd recommend CCing linux-fbdev as well in future so that fbdev folks
can also get a chance to review your new fbdev driver.

On Tue, Mar 16, 2010 at 2:41 PM,  <konkers@google.com> wrote:
> From: Colin Cross <ccross@android.com>
>
> Signed-off-by: Colin Cross <ccross@android.com>
> Signed-off-by: Erik Gilling <konkers@android.com>
> ---
> ?arch/arm/mach-tegra/include/mach/tegra_fb.h | ? 24 +
> ?drivers/video/Kconfig ? ? ? ? ? ? ? ? ? ? ? | ? 11 +
> ?drivers/video/Makefile ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
> ?drivers/video/tegrafb.c ? ? ? ? ? ? ? ? ? ? | ?620 +++++++++++++++++++++++++++
> ?4 files changed, 656 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-tegra/include/mach/tegra_fb.h
> ?create mode 100644 drivers/video/tegrafb.c
>
> diff --git a/arch/arm/mach-tegra/include/mach/tegra_fb.h b/arch/arm/mach-tegra/include/mach/tegra_fb.h
> new file mode 100644
> index 0000000..f173544
> --- /dev/null
> +++ b/arch/arm/mach-tegra/include/mach/tegra_fb.h
> @@ -0,0 +1,24 @@
> +/*
> + * arch/arm/mach-tegra/include/mach/tegra_fb.h
> + *
> + * Copyright (C) 2010 Google, Inc.
> + * Author: Colin Cross <ccross@android.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +struct tegra_fb_lcd_data {
> + ? ? ? int ? ? fb_xres;
> + ? ? ? int ? ? fb_yres;
> + ? ? ? int ? ? lcd_xres;
> + ? ? ? int ? ? lcd_yres;
> + ? ? ? int ? ? bits_per_pixel;
> +};

I'm trying to understand what's the difference between fb and lcd *res.

> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 5a5c303..b2e68e2 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1074,6 +1074,17 @@ config FB_RIVA_BACKLIGHT
> ? ? ? ?help
> ? ? ? ? ?Say Y here if you want to control the backlight of your display.
>
> +config FB_TEGRA
> + ? ? ? tristate "NVIDIA Tegra SoC display support"
> + ? ? ? depends on ARCH_TEGRA && FB = y
> + ? ? ? select FB_CFB_FILLRECT
> + ? ? ? select FB_CFB_COPYAREA
> + ? ? ? select FB_CFB_IMAGEBLIT
> + ? ? ? default FB
> + ? ? ? help
> + ? ? ? ? This driver supports the NVIDIA Tegra systems-on-a-chip. ?This
> + ? ? ? ? driver can not be compiled as a module.

Out of curiosity, why not?

> +
> ?config FB_I810
> ? ? ? ?tristate "Intel 810/815 support (EXPERIMENTAL)"
> ? ? ? ?depends on EXPERIMENTAL && FB && PCI && X86_32 && AGP_INTEL
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 4ecb30c..d4a14f2 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -129,6 +129,7 @@ obj-$(CONFIG_XEN_FBDEV_FRONTEND) ?+= xen-fbfront.o
> ?obj-$(CONFIG_FB_CARMINE) ? ? ? ? ?+= carminefb.o
> ?obj-$(CONFIG_FB_MB862XX) ? ? ? ? += mb862xx/
> ?obj-$(CONFIG_FB_MSM) ? ? ? ? ? ? ?+= msm/
> +obj-$(CONFIG_FB_TEGRA) ? ? ? ? ? ?+= tegrafb.o
>
> ?# Platform or fallback drivers go here
> ?obj-$(CONFIG_FB_UVESA) ? ? ? ? ? ?+= uvesafb.o
> diff --git a/drivers/video/tegrafb.c b/drivers/video/tegrafb.c
> new file mode 100644
> index 0000000..634022b
> --- /dev/null
> +++ b/drivers/video/tegrafb.c
> @@ -0,0 +1,620 @@
> +/*
> + * drivers/video/tegrafb.c
> + *
> + * Copyright (C) 2010 Google, Inc.
> + * Author: Colin Cross <ccross@android.com>
> + * ? ? ? ? Travis Geiselbrecht <travis@palm.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/fb.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/clk.h>
> +#include <linux/wait.h>
> +#include <asm/cacheflush.h>
> +#include <mach/tegra_fb.h>
> +
> +#define DEBUG 1

You want to enable Debug by default for everyone?

> +
> +struct tegra_fb_info {
> + ? ? ? struct clk *clk;
> + ? ? ? struct resource *reg_mem;
> + ? ? ? struct resource *fb_mem;
> + ? ? ? void __iomem *reg_base;
> + ? ? ? wait_queue_head_t event_wq;
> + ? ? ? unsigned int wait_condition;
> + ? ? ? int lcd_xres;
> + ? ? ? int lcd_yres;
> + ? ? ? int irq;
> +};

I think a comment about lcd_.res would help us understand what its
used for and how it differs from fb_.res. How come it is being
duplicated in multiple structures?

> +static int tegra_fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
> +{
> + ? ? ? return 0;
> +}
> +
> +static int tegra_fb_sync(struct fb_info *info)
> +{
> + ? ? ? return 0;
> +}

Out of curiosity, why populate these functions if they don't do anything?

> +
> +#ifdef DEBUG
> +#define DUMP_REG(a) pr_info("%-32s\t%03x\t%08x\n", #a, a, tegra_fb_readl(tegra_fb, a));

Could pr_debug be useful above?

> +static struct fb_ops tegra_fb_ops = {
> + ? ? ? .fb_cursor = tegra_fb_cursor,
> + ? ? ? .fb_sync = tegra_fb_sync,

These 2 were the empty functions from above. I'm guessing this isn't needed.

> +
> +static int tegra_plat_remove(struct platform_device *pdev)
> +{
> + ? ? ? struct fb_info *fb = platform_get_drvdata(pdev);
> + ? ? ? struct tegra_fb_info *tegra_fb = fb->par;
> + ? ? ? clk_disable(tegra_fb->clk);
> + ? ? ? iounmap(fb->screen_base);
> + ? ? ? release_resource(tegra_fb->fb_mem);
> + ? ? ? iounmap(tegra_fb->reg_base);
> + ? ? ? release_resource(tegra_fb->reg_mem);
> + ? ? ? framebuffer_release(fb);
> + ? ? ? return 0;
> +}
> +

I didn't read through carefully but shouldn't there be an
unregister_framebuffer in above? Wouldn't the above cause a free while
the structures could still in use by fb*?

Thanks,
jaya
