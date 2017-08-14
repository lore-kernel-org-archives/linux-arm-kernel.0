From: eric@anholt.net (Eric Anholt)
Date: Mon, 14 Aug 2017 11:56:11 -0700
Subject: [PATCH 2/4] drm/tve200: Add new driver for TVE200
In-Reply-To: <20170813151132.24736-3-linus.walleij@linaro.org>
References: <20170813151132.24736-1-linus.walleij@linaro.org>
 <20170813151132.24736-3-linus.walleij@linaro.org>
Message-ID: <87zib2dlmc.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> This adds a new DRM driver for the Faraday Technology TVE200
> block. This "TV Encoder" encodes a ITU-T BT.656 stream and can
> be found in the StorLink SL3516 (later Cortina Systems CS3516)
> as well as the Grain Media GM8180.
>
> I do not have definitive word from anyone at Faraday that this
> IP block is theirs, but it bears the hallmark of their 3-digit
> version code (200) and is used in two SoCs from completely
> different companies. (Grain Media was fully owned by Faraday
> until it was transferred to NovoTek this january, and
> Faraday did lots of work on the StorLink SoCs.)
>
> The D-Link DIR-685 uses this in connection with the Ilitek
> ILI9322 panel driver that supports BT.656 input, while the
> GM8180 apparently has been used with the Cirrus Logic CS4954
> digital video encoder. The oldest user seems to be
> something called Techwall 2835.
>
> This driver is heavily inspired by Eric Anholt's PL111
> driver and therefore I have mentioned all the ancestor authors
> in the header file.

This looks great!  I've got just a couple of little things I noticed,
but with the init error path bugs fixed it's:

Reviewed-by: Eric Anholt <eric@anholt.net>

I also recommend checking out panel-bridge for deleting a bunch of the
code, and joining us in the drm-misc committer group :)

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/gpu/index.rst               |   1 +
>  Documentation/gpu/tve200.rst              |   6 +
>  MAINTAINERS                               |   6 +
>  drivers/gpu/drm/Kconfig                   |   2 +
>  drivers/gpu/drm/Makefile                  |   1 +
>  drivers/gpu/drm/tve200/Kconfig            |  15 ++
>  drivers/gpu/drm/tve200/Makefile           |   5 +
>  drivers/gpu/drm/tve200/tve200_connector.c | 126 +++++++++++
>  drivers/gpu/drm/tve200/tve200_display.c   | 346 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tve200/tve200_drm.h       | 129 +++++++++++
>  drivers/gpu/drm/tve200/tve200_drv.c       | 277 ++++++++++++++++++++++++
>  11 files changed, 914 insertions(+)
>  create mode 100644 Documentation/gpu/tve200.rst
>  create mode 100644 drivers/gpu/drm/tve200/Kconfig
>  create mode 100644 drivers/gpu/drm/tve200/Makefile
>  create mode 100644 drivers/gpu/drm/tve200/tve200_connector.c
>  create mode 100644 drivers/gpu/drm/tve200/tve200_display.c
>  create mode 100644 drivers/gpu/drm/tve200/tve200_drm.h
>  create mode 100644 drivers/gpu/drm/tve200/tve200_drv.c
>
> diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
> index 35d673bf9b56..c36586dad29d 100644
> --- a/Documentation/gpu/index.rst
> +++ b/Documentation/gpu/index.rst
> @@ -15,6 +15,7 @@ Linux GPU Driver Developer's Guide
>     pl111
>     tegra
>     tinydrm
> +   tve200
>     vc4
>     vga-switcheroo
>     vgaarbiter
> diff --git a/Documentation/gpu/tve200.rst b/Documentation/gpu/tve200.rst
> new file mode 100644
> index 000000000000..69b17b324e12
> --- /dev/null
> +++ b/Documentation/gpu/tve200.rst
> @@ -0,0 +1,6 @@
> +==================================
> + drm/tve200 Faraday TV Encoder 200
> +==================================
> +
> +.. kernel-doc:: drivers/gpu/drm/tve200/tve200_drv.c
> +   :doc: Faraday TV Encoder 200
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e87cba115ea4..c3d42d68253a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4305,6 +4305,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  S:	Maintained
>  F:	drivers/gpu/drm/bochs/
>  
> +DRM DRIVER FOR FARADAY TVE200 TV ENCODER
> +M:	Linus Walleij <linus.walleij@linaro.org>
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +S:	Maintained
> +F:	drivers/gpu/drm/tve200/
> +
>  DRM DRIVER FOR INTEL I810 VIDEO CARDS
>  S:	Orphan / Obsolete
>  F:	drivers/gpu/drm/i810/
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 83cb2a88c204..c5e1a8409285 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -278,6 +278,8 @@ source "drivers/gpu/drm/tinydrm/Kconfig"
>  
>  source "drivers/gpu/drm/pl111/Kconfig"
>  
> +source "drivers/gpu/drm/tve200/Kconfig"
> +
>  # Keep legacy drivers last
>  
>  menuconfig DRM_LEGACY
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 24a066e1841c..cc81813e2238 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -100,3 +100,4 @@ obj-$(CONFIG_DRM_ZTE)	+= zte/
>  obj-$(CONFIG_DRM_MXSFB)	+= mxsfb/
>  obj-$(CONFIG_DRM_TINYDRM) += tinydrm/
>  obj-$(CONFIG_DRM_PL111) += pl111/
> +obj-$(CONFIG_DRM_TVE200) += tve200/
> diff --git a/drivers/gpu/drm/tve200/Kconfig b/drivers/gpu/drm/tve200/Kconfig
> new file mode 100644
> index 000000000000..21d9841ddb88
> --- /dev/null
> +++ b/drivers/gpu/drm/tve200/Kconfig
> @@ -0,0 +1,15 @@
> +config DRM_TVE200
> +	tristate "DRM Support for Faraday TV Encoder TVE200"
> +	depends on DRM
> +	depends on CMA
> +	depends on ARM || COMPILE_TEST
> +	depends on OF
> +	select DRM_PANEL
> +	select DRM_KMS_HELPER
> +	select DRM_KMS_CMA_HELPER
> +	select DRM_GEM_CMA_HELPER
> +	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
> +	help
> +	  Choose this option for DRM support for the Faraday TV Encoder
> +	  TVE200 Controller.
> +	  If M is selected the module will be called tve200_drm.
> diff --git a/drivers/gpu/drm/tve200/Makefile b/drivers/gpu/drm/tve200/Makefile
> new file mode 100644
> index 000000000000..a9dba54f7ee5
> --- /dev/null
> +++ b/drivers/gpu/drm/tve200/Makefile
> @@ -0,0 +1,5 @@
> +tve200_drm-y +=	tve200_connector.o \
> +		tve200_display.o \
> +		tve200_drv.o
> +
> +obj-$(CONFIG_DRM_TVE200) += tve200_drm.o
> diff --git a/drivers/gpu/drm/tve200/tve200_connector.c b/drivers/gpu/drm/tve200/tve200_connector.c
> new file mode 100644
> index 000000000000..93e99156d375
> --- /dev/null
> +++ b/drivers/gpu/drm/tve200/tve200_connector.c
> @@ -0,0 +1,126 @@
> +/*
> + * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
> + * Parts of this file were based on sources as follows:
> + *
> + * Copyright (C) 2006-2008 Intel Corporation
> + * Copyright (C) 2007 Amos Lee <amos_lee@storlinksemi.com>
> + * Copyright (C) 2007 Dave Airlie <airlied@linux.ie>
> + * Copyright (C) 2011 Texas Instruments
> + * Copyright (C) 2017 Eric Anholt
> + *
> + * This program is free software and is provided to you under the terms of the
> + * GNU General Public License version 2 as published by the Free Software
> + * Foundation, and any use by you of this program is subject to the terms of
> + * such GNU licence.
> + */
> +
> +/**
> + * tve200_drm_connector.c
> + * Implementation of the connector functions for the Faraday TV Encoder
> + */
> +#include <linux/version.h>
> +#include <linux/shmem_fs.h>
> +#include <linux/dma-buf.h>
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +
> +#include "tve200_drm.h"
> +
> +static void tve200_connector_destroy(struct drm_connector *connector)
> +{
> +	struct tve200_drm_connector *tve200con =
> +		to_tve200_connector(connector);
> +
> +	if (tve200con->panel)
> +		drm_panel_detach(tve200con->panel);
> +
> +	drm_connector_unregister(connector);
> +	drm_connector_cleanup(connector);
> +}
> +
> +static enum drm_connector_status tve200_connector_detect(struct drm_connector
> +							*connector, bool force)
> +{
> +	struct tve200_drm_connector *tve200con =
> +		to_tve200_connector(connector);
> +
> +	return (tve200con->panel ?
> +		connector_status_connected :
> +		connector_status_disconnected);
> +}
> +
> +static int tve200_connector_helper_get_modes(struct drm_connector *connector)
> +{
> +	struct tve200_drm_connector *tve200con =
> +		to_tve200_connector(connector);
> +
> +	if (!tve200con->panel)
> +		return 0;
> +
> +	return drm_panel_get_modes(tve200con->panel);
> +}
> +
> +static const struct drm_connector_funcs connector_funcs = {
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.destroy = tve200_connector_destroy,
> +	.detect = tve200_connector_detect,
> +	.dpms = drm_atomic_helper_connector_dpms,
> +	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static const struct drm_connector_helper_funcs connector_helper_funcs = {
> +	.get_modes = tve200_connector_helper_get_modes,
> +};
> +
> +/*
> + * Walks the OF graph to find the panel node and then asks DRM to look
> + * up the panel.
> + */
> +static struct drm_panel *tve200_get_panel(struct device *dev)
> +{
> +	struct device_node *endpoint, *panel_node;
> +	struct device_node *np = dev->of_node;
> +	struct drm_panel *panel;
> +
> +	endpoint = of_graph_get_next_endpoint(np, NULL);
> +	if (!endpoint) {
> +		dev_err(dev, "no endpoint to fetch panel\n");
> +		return NULL;
> +	}
> +
> +	/* Don't proceed if we have an endpoint but no panel_node tied to it */
> +	panel_node = of_graph_get_remote_port_parent(endpoint);
> +	of_node_put(endpoint);
> +	if (!panel_node) {
> +		dev_err(dev, "no valid panel node\n");
> +		return NULL;
> +	}
> +
> +	panel = of_drm_find_panel(panel_node);
> +	of_node_put(panel_node);
> +
> +	return panel;
> +}
> +
> +int tve200_connector_init(struct drm_device *dev)
> +{
> +	struct tve200_drm_dev_private *priv = dev->dev_private;
> +	struct tve200_drm_connector *tve200con = &priv->connector;
> +	struct drm_connector *connector = &tve200con->connector;
> +
> +	drm_connector_init(dev, connector, &connector_funcs,
> +			   DRM_MODE_CONNECTOR_DPI);
> +	drm_connector_helper_add(connector, &connector_helper_funcs);
> +
> +	tve200con->panel = tve200_get_panel(dev->dev);
> +	if (tve200con->panel)
> +		drm_panel_attach(tve200con->panel, connector);
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/tve200/tve200_display.c b/drivers/gpu/drm/tve200/tve200_display.c
> new file mode 100644
> index 000000000000..027553aacb33
> --- /dev/null
> +++ b/drivers/gpu/drm/tve200/tve200_display.c
> @@ -0,0 +1,346 @@
> +/*
> + * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
> + * Parts of this file were based on sources as follows:
> + *
> + * Copyright (C) 2006-2008 Intel Corporation
> + * Copyright (C) 2007 Amos Lee <amos_lee@storlinksemi.com>
> + * Copyright (C) 2007 Dave Airlie <airlied@linux.ie>
> + * Copyright (C) 2011 Texas Instruments
> + * Copyright (C) 2017 Eric Anholt
> + *
> + * This program is free software and is provided to you under the terms of the
> + * GNU General Public License version 2 as published by the Free Software
> + * Foundation, and any use by you of this program is subject to the terms of
> + * such GNU licence.
> + */
> +#include <linux/clk.h>
> +#include <linux/version.h>
> +#include <linux/dma-buf.h>
> +#include <linux/of_graph.h>
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +
> +#include "tve200_drm.h"
> +
> +irqreturn_t tve200_irq(int irq, void *data)
> +{
> +	struct tve200_drm_dev_private *priv = data;
> +	u32 stat;
> +	u32 val;
> +
> +	stat = readl(priv->regs + TVE200_INT_STAT);
> +
> +	if (!stat)
> +		return IRQ_NONE;
> +
> +	/*
> +	 * Vblank IRQ
> +	 *
> +	 * The hardware is a bit tilted: the line stays high after clearing
> +	 * the vblank IRQ, fireing many more interrupts. We counter this
> +	 * by toggling the IRQ back and forth from fireing at vblank and
> +	 * fireing at start of active image, which works around the problem
> +	 * since those occur strictly in sequence, and we get two IRQs for each
> +	 * frame, one at start of Vblank (that we make call into the CRTC) and
> +	 * another one at the start of the image (that we discard).
> +	 */

spelling nit: firing

Seems like a pretty good solution, though it makes me wonder how they
intended the HW to be used.

> +	if (stat & TVE200_INT_V_STATUS) {
> +		val = readl(priv->regs + TVE200_CTRL);
> +		/* We have an actual start of vsync */
> +		if (!(val & TVE200_VSTSTYPE_BITS)) {
> +			drm_crtc_handle_vblank(&priv->pipe.crtc);
> +			/* Toggle trigger to start of active image */
> +			val |= TVE200_VSTSTYPE_VAI;
> +		} else {
> +			/* Toggle trigger back to start of vsync */
> +			val &= ~TVE200_VSTSTYPE_BITS;
> +		}
> +		writel(val, priv->regs + TVE200_CTRL);
> +	} else
> +		dev_err(priv->drm->dev, "stray IRQ %08x\n", stat);
> +
> +	/* Clear the interrupt once done */
> +	writel(stat, priv->regs + TVE200_INT_CLR);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int tve200_display_check(struct drm_simple_display_pipe *pipe,
> +			       struct drm_plane_state *pstate,
> +			       struct drm_crtc_state *cstate)
> +{
> +	const struct drm_display_mode *mode = &cstate->mode;
> +	struct drm_framebuffer *old_fb = pipe->plane.state->fb;
> +	struct drm_framebuffer *fb = pstate->fb;
> +	struct drm_connector *connector = pipe->connector;
> +	struct drm_device *drm = connector->dev;
> +
> +	/*
> +	 * We support these specific resolutions and nothing else.
> +	 */
> +	if (!(mode->hdisplay == 352 && mode->vdisplay == 240) && /* SIF(525) */
> +	    !(mode->hdisplay == 352 && mode->vdisplay == 288) && /* CIF(625) */
> +	    !(mode->hdisplay == 640 && mode->vdisplay == 480) && /* VGA */
> +	    !(mode->hdisplay == 720 && mode->vdisplay == 480) && /* D1 */
> +	    !(mode->hdisplay == 720 && mode->vdisplay == 576)) { /* D1 */
> +		dev_err(drm->dev, "unsupported display mode (%u x %u)\n",
> +			mode->hdisplay, mode->vdisplay);
> +		return -EINVAL;
> +	}
> +
> +	if (fb) {
> +		u32 offset = drm_fb_cma_get_gem_addr(fb, pstate, 0);
> +
> +		/* FB base address must be dword aligned. */
> +		if (offset & 3) {
> +			dev_err(drm->dev, "FB not 32-bit aligned\n");
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * There's no pitch register, the mode's hdisplay
> +		 * controls this.
> +		 */
> +		if (fb->pitches[0] != mode->hdisplay * fb->format->cpp[0]) {
> +			dev_err(drm->dev, "can't handle pitches\n");
> +			return -EINVAL;
> +		}

I learned recently that one of the general guidelines we have is "don't
let userspace trigger dmesg errors."  I think these dev_err()s would be
better as DRM_DEBUG_KMS() (which you can enable at boot or runtime using
the drm.debug module parameter)

> +static struct drm_driver tve200_drm_driver = {
> +	.driver_features =
> +		DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME | DRIVER_ATOMIC,
> +	.lastclose = tve200_lastclose,
> +	.ioctls = NULL,
> +	.fops = &drm_fops,
> +	.name = "tve200",
> +	.desc = DRIVER_DESC,
> +	.date = "20170703",
> +	.major = 1,
> +	.minor = 0,
> +	.patchlevel = 0,
> +	.dumb_create = drm_gem_cma_dumb_create,
> +	.dumb_destroy = drm_gem_dumb_destroy,
> +	.dumb_map_offset = drm_gem_cma_dumb_map_offset,
> +	.gem_free_object = drm_gem_cma_free_object,
> +	.gem_vm_ops = &drm_gem_cma_vm_ops,
> +
> +	.enable_vblank = tve200_enable_vblank,
> +	.disable_vblank = tve200_disable_vblank,
> +
> +	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> +	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> +	.gem_prime_import = drm_gem_prime_import,
> +	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> +	.gem_prime_export = drm_gem_prime_export,
> +	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,

I think you also want CMA's helpers for .gem_prime_vmap, vunmap, mmap.
I think there are igt tests for this, but it's something you won't
notice in normal usage.

> +};
> +
> +static int tve200_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct tve200_drm_dev_private *priv;
> +	struct drm_device *drm;
> +	struct resource *res;
> +	int irq;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	drm = drm_dev_alloc(&tve200_drm_driver, dev);
> +	if (IS_ERR(drm))
> +		return PTR_ERR(drm);
> +	platform_set_drvdata(pdev, drm);
> +	priv->drm = drm;
> +	drm->dev_private = priv;
> +
> +	/* Clock the silicon so we can access the registers */
> +	priv->pclk = devm_clk_get(dev, "PCLK");
> +	if (IS_ERR(priv->pclk)) {
> +		dev_err(dev, "unable to get PCLK\n");
> +		ret = PTR_ERR(priv->pclk);
> +		goto dev_unref;
> +	}
> +	ret = clk_prepare_enable(priv->pclk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable PCLK\n");
> +		goto dev_unref;
> +	}
> +
> +	/* This clock is for the pixels (27MHz) */
> +	priv->clk = devm_clk_get(dev, "TVE");
> +	if (IS_ERR(priv->clk)) {
> +		dev_err(dev, "unable to get TVE clock\n");
> +		ret = PTR_ERR(priv->clk);
> +		goto clk_disable;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->regs = devm_ioremap_resource(dev, res);
> +	if (!priv->regs) {
> +		dev_err(dev, "%s failed mmio\n", __func__);
> +		ret = -EINVAL;
> +		goto dev_unref;

Don't this and the following gotos want to be goto clk_disable, instead?

> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (!irq) {
> +		ret = -EINVAL;
> +		goto dev_unref;
> +	}
> +
> +	/* turn off interrupts before requesting the irq */
> +	writel(0, priv->regs + TVE200_INT_EN);
> +
> +	ret = devm_request_irq(dev, irq, tve200_irq, 0, "tve200", priv);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq %d\n", ret);
> +		return ret;

goto instead of return here, as well?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170814/3f831343/attachment-0001.sig>
