From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Feb 2017 14:54:41 -0800
Subject: [PATCH 4/8] drm/sun4i: add support for sun8i DE2 mixers and
 display engines
In-Reply-To: <3557471487795322@web2j.yandex.ru>
References: <20170222152310.3719-5-icenowy@aosc.xyz>
 <20170222200947.3ikrhvv76ymfu5tv@lukather>
 <3557471487795322@web2j.yandex.ru>
Message-ID: <20170222225441.s7xnv6hvavwbsqma@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

(Please fix your mailer, its quotation is broken and mangles all the
indentation)

On Thu, Feb 23, 2017 at 04:28:42AM +0800, Icenowy Zheng wrote:
> >> ?@@ -187,3 +220,30 @@ struct sun4i_layer **sun4i_layers_init(struct drm_device *drm)
> >>
> >> ??????????return layers;
> >> ??}
> >> ?+
> >> ?+struct sun4i_layer **sun8i_layers_init(struct drm_device *drm)
> >
> > And store this (and sun4i_layers_init) in an structure holding the
> > function pointers for those.
> 
> How should I do it?
> If I create a ops struct, where should I reference it?

I'm not sure I get your question. You can create that structure, fill
a field in the sun4i_drv structure at bind time, and call those
function pointers directly where you need to.

> >> ?+{
> >> ?+ struct sun4i_layer **layers;
> >> ?+ int i;
> >> ?+
> >> ?+ layers = devm_kcalloc(drm->dev, ARRAY_SIZE(sun8i_mixer_planes),
> >> ?+ sizeof(**layers), GFP_KERNEL);
> >> ?+ if (!layers)
> >> ?+ return ERR_PTR(-ENOMEM);
> >> ?+
> >> ?+ for (i = 0; i < ARRAY_SIZE(sun8i_mixer_planes); i++) {
> >> ?+ const struct sun4i_plane_desc *plane = &sun8i_mixer_planes[i];
> >> ?+ struct sun4i_layer *layer = layers[i];
> >> ?+
> >> ?+ layer = sun4i_layer_init_one(drm, plane);
> >> ?+ if (IS_ERR(layer)) {
> >> ?+ dev_err(drm->dev, "Couldn't initialize %s plane\n",
> >> ?+ i ? "overlay" : "primary");
> >> ?+ return ERR_CAST(layer);
> >> ?+ };
> >> ?+
> >> ?+ layer->id = i;
> >> ?+ };
> >> ?+
> >> ?+ return layers;
> >> ?+}
> >> ?diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.h b/drivers/gpu/drm/sun4i/sun4i_layer.h
> >> ?index a2f65d7a3f4e..f7b9e5daea50 100644
> >> ?--- a/drivers/gpu/drm/sun4i/sun4i_layer.h
> >> ?+++ b/drivers/gpu/drm/sun4i/sun4i_layer.h
> >> ?@@ -26,5 +26,6 @@ plane_to_sun4i_layer(struct drm_plane *plane)
> >> ??}
> >>
> >> ??struct sun4i_layer **sun4i_layers_init(struct drm_device *drm);
> >> ?+struct sun4i_layer **sun8i_layers_init(struct drm_device *drm);
> >>
> >> ??#endif /* _SUN4I_LAYER_H_ */
> >> ?diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> >> ?new file mode 100644
> >> ?index 000000000000..9427b57240d3
> >> ?--- /dev/null
> >> ?+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> >> ?@@ -0,0 +1,417 @@
> >> ?+/*
> >> ?+ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
> >> ?+ *
> >> ?+ * Based on sun4i_backend.c, which is:
> >> ?+ * Copyright (C) 2015 Free Electrons
> >> ?+ * Copyright (C) 2015 NextThing Co
> >> ?+ *
> >> ?+ * This program is free software; you can redistribute it and/or
> >> ?+ * modify it under the terms of the GNU General Public License as
> >> ?+ * published by the Free Software Foundation; either version 2 of
> >> ?+ * the License, or (at your option) any later version.
> >> ?+ */
> >> ?+
> >> ?+#include <drm/drmP.h>
> >> ?+#include <drm/drm_atomic_helper.h>
> >> ?+#include <drm/drm_crtc.h>
> >> ?+#include <drm/drm_crtc_helper.h>
> >> ?+#include <drm/drm_fb_cma_helper.h>
> >> ?+#include <drm/drm_gem_cma_helper.h>
> >> ?+#include <drm/drm_plane_helper.h>
> >> ?+
> >> ?+#include <linux/component.h>
> >> ?+#include <linux/reset.h>
> >> ?+#include <linux/of_device.h>
> >> ?+
> >> ?+#include "sun8i_mixer.h"
> >> ?+#include "sun4i_drv.h"
> >> ?+
> >> ?+#define SUN8I_DRAM_OFFSET 0x40000000
> >
> > PHYS_OFFSET?
> 
> Any name is OK.

What I meant is that there is already a variable holding that value
that is PHYS_OFFSET.

> (P.S. this seems also needed for some DE1s)

Did you encounter any issue on it?

> >> ?+#if defined CONFIG_DRM_SUN4I_DE2
> >
> > That ifdef should be in the header
> 
> So the file only compile if this option is enabled?

Yes.

> And if this option is disabled, inlined null stubs should be
> made in header?

Yes.

> >> ?+void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
> >> ?+ int layer, bool enable)
> >> ?+{
> >> ?+ u32 val;
> >> ?+ /* Currently the first UI channel is used */
> >> ?+ int chan = mixer->cfg->vi_num;
> >> ?+
> >> ?+ DRM_DEBUG_DRIVER("Enabling layer %d in channel %d\n", layer, chan);
> >> ?+
> >> ?+ if (enable)
> >> ?+ val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
> >> ?+ else
> >> ?+ val = 0;
> >
> > So you only support the UI channel?
> >
> > Why do you expose several planes then?
> 
> Currently I didn't find any way to enable more than one channel
> at the same time, so only the first UI channel is used.
> 
> After more knowledges are gained for DE2 mixers we can implement
> more functions (for example, Jernejsk have already discovered how
> to do color space correlation in DE2 for TVE).

Then please expose only the primary plane. You also expose an overlay
here that is not functional from what you tell me.

> >> ?+ regmap_update_bits(mixer->regs,
> >> ?+ SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
> >> ?+ SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
> >> ?+
> >> ?+ /* Set the alpha configuration */
> >> ?+ regmap_update_bits(mixer->regs,
> >> ?+ SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
> >> ?+ SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK,
> >> ?+ SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF);
> >> ?+ regmap_update_bits(mixer->regs,
> >> ?+ SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
> >> ?+ SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK,
> >> ?+ SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF);
> >
> > This should be in a property
> 
> What property?

Alpha?

> >> ?+}
> >> ?+EXPORT_SYMBOL(sun8i_mixer_layer_enable);
> >> ?+
> >> ?+static int sun8i_mixer_drm_format_to_layer(struct drm_plane *plane,
> >> ?+ u32 format, u32 *mode)
> >> ?+{
> >> ?+ if ((plane->type == DRM_PLANE_TYPE_PRIMARY) &&
> >> ?+ (format == DRM_FORMAT_ARGB8888))
> >> ?+ format = DRM_FORMAT_XRGB8888;
> >
> > Do you actually have that issue.
> 
> Yes, it really do, at least screen go black when I set this to ARGB8888 in
> U-Boot. (U-Boot is a good experiement area ;-) )

Ok. And you have some color when you set the background to some colour ?

> >> ?+ switch (format) {
> >> ?+ case DRM_FORMAT_ARGB8888:
> >> ?+ *mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_ARGB8888;
> >> ?+ break;
> >> ?+
> >> ?+ case DRM_FORMAT_XRGB8888:
> >> ?+ *mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_XRGB8888;
> >> ?+ break;
> >> ?+
> >> ?+ case DRM_FORMAT_RGB888:
> >> ?+ *mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_RGB888;
> >> ?+ break;
> >> ?+
> >> ?+ default:
> >> ?+ return -EINVAL;
> >> ?+ }
> >> ?+
> >> ?+ return 0;
> >> ?+}
> >> ?+
> >> ?+int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
> >> ?+ int layer, struct drm_plane *plane)
> >> ?+{
> >> ?+ struct drm_plane_state *state = plane->state;
> >> ?+ struct drm_framebuffer *fb = state->fb;
> >> ?+ /* Currently the first UI channel is used */
> >> ?+ int chan = mixer->cfg->vi_num;
> >> ?+ int i;
> >> ?+
> >> ?+ DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
> >> ?+
> >> ?+ if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
> >> ?+ DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
> >> ?+ state->crtc_w, state->crtc_h);
> >> ?+ regmap_write(mixer->regs, SUN8I_MIXER_GLOBAL_SIZE,
> >> ?+ SUN8I_MIXER_SIZE(state->crtc_w,
> >> ?+ state->crtc_h));
> >> ?+ DRM_DEBUG_DRIVER("Updating blender size\n");
> >> ?+ for (i = 0; i < SUN8I_MIXER_MAX_CHAN_COUNT; i++)
> >> ?+ regmap_write(mixer->regs,
> >> ?+ SUN8I_MIXER_BLEND_ATTR_INSIZE(i),
> >> ?+ SUN8I_MIXER_SIZE(state->crtc_w,
> >> ?+ state->crtc_h));
> >> ?+ regmap_write(mixer->regs, SUN8I_MIXER_BLEND_OUTSIZE,
> >> ?+ SUN8I_MIXER_SIZE(state->crtc_w,
> >> ?+ state->crtc_h));
> >> ?+ DRM_DEBUG_DRIVER("Updating channel size\n");
> >> ?+ regmap_write(mixer->regs, SUN8I_MIXER_CHAN_UI_OVL_SIZE(chan),
> >> ?+ SUN8I_MIXER_SIZE(state->crtc_w,
> >> ?+ state->crtc_h));
> >> ?+ }
> >> ?+
> >> ?+ /* Set the line width */
> >> ?+ DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
> >> ?+ regmap_write(mixer->regs, SUN8I_MIXER_CHAN_UI_LAYER_PITCH(chan, layer),
> >> ?+ fb->pitches[0]);
> >> ?+
> >> ?+ /* Set height and width */
> >> ?+ DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n",
> >> ?+ state->crtc_w, state->crtc_h);
> >> ?+ regmap_write(mixer->regs, SUN8I_MIXER_CHAN_UI_LAYER_SIZE(chan, layer),
> >> ?+ SUN8I_MIXER_SIZE(state->crtc_w, state->crtc_h));
> >> ?+
> >> ?+ /* Set base coordinates */
> >> ?+ DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
> >> ?+ state->crtc_x, state->crtc_y);
> >> ?+ regmap_write(mixer->regs, SUN8I_MIXER_CHAN_UI_LAYER_COORD(chan, layer),
> >> ?+ SUN8I_MIXER_COORD(state->crtc_x, state->crtc_y));
> >> ?+
> >> ?+ return 0;
> >> ?+}
> >> ?+EXPORT_SYMBOL(sun8i_mixer_update_layer_coord);
> >> ?+
> >> ?+int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
> >> ?+ int layer, struct drm_plane *plane)
> >> ?+{
> >> ?+ struct drm_plane_state *state = plane->state;
> >> ?+ struct drm_framebuffer *fb = state->fb;
> >> ?+ bool interlaced = false;
> >> ?+ u32 val;
> >> ?+ /* Currently the first UI channel is used */
> >> ?+ int chan = mixer->cfg->vi_num;
> >> ?+ int ret;
> >> ?+
> >> ?+ if (plane->state->crtc)
> >> ?+ interlaced = plane->state->crtc->state->adjusted_mode.flags
> >> ?+ & DRM_MODE_FLAG_INTERLACE;
> >> ?+
> >> ?+ regmap_update_bits(mixer->regs, SUN8I_MIXER_BLEND_OUTCTL,
> >> ?+ SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> >> ?+ interlaced ?
> >> ?+ SUN8I_MIXER_BLEND_OUTCTL_INTERLACED : 0);
> >> ?+
> >> ?+ DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
> >> ?+ interlaced ? "on" : "off");
> >> ?+
> >> ?+ ret = sun8i_mixer_drm_format_to_layer(plane, fb->format->format,
> >> ?+ &val);
> >> ?+ if (ret) {
> >> ?+ DRM_DEBUG_DRIVER("Invalid format\n");
> >> ?+ return ret;
> >> ?+ }
> >> ?+
> >> ?+ regmap_update_bits(mixer->regs,
> >> ?+ SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
> >> ?+ SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
> >> ?+
> >> ?+ return 0;
> >> ?+}
> >> ?+EXPORT_SYMBOL(sun8i_mixer_update_layer_formats);
> >> ?+
> >> ?+int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
> >> ?+ int layer, struct drm_plane *plane)
> >> ?+{
> >> ?+ struct drm_plane_state *state = plane->state;
> >> ?+ struct drm_framebuffer *fb = state->fb;
> >> ?+ struct drm_gem_cma_object *gem;
> >> ?+ dma_addr_t paddr;
> >> ?+ uint32_t paddr_u32;
> >> ?+ /* Currently the first UI channel is used */
> >> ?+ int chan = mixer->cfg->vi_num;
> >> ?+ int bpp;
> >> ?+
> >> ?+ /* Get the physical address of the buffer in memory */
> >> ?+ gem = drm_fb_cma_get_gem_obj(fb, 0);
> >> ?+
> >> ?+ DRM_DEBUG_DRIVER("Using GEM @ %pad\n", &gem->paddr);
> >> ?+
> >> ?+ /* Compute the start of the displayed memory */
> >> ?+ bpp = fb->format->cpp[0];
> >> ?+ paddr = gem->paddr + fb->offsets[0];
> >> ?+ paddr += (state->src_x >> 16) * bpp;
> >> ?+ paddr += (state->src_y >> 16) * fb->pitches[0];
> >> ?+ paddr -= SUN8I_DRAM_OFFSET;
> >> ?+
> >> ?+ DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
> >> ?+
> >> ?+ paddr_u32 = (uint32_t) paddr;
> >> ?+
> >> ?+ regmap_write(mixer->regs,
> >> ?+ SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(chan, layer),
> >> ?+ paddr_u32);
> >> ?+
> >> ?+ return 0;
> >> ?+}
> >> ?+EXPORT_SYMBOL(sun8i_mixer_update_layer_buffer);
> >> ?+
> >> ?+static struct regmap_config sun8i_mixer_regmap_config = {
> >> ?+ .reg_bits = 32,
> >> ?+ .val_bits = 32,
> >> ?+ .reg_stride = 4,
> >> ?+ .max_register = 0xbffc, /* guessed */
> >> ?+};
> >> ?+
> >> ?+static int sun8i_mixer_bind(struct device *dev, struct device *master,
> >> ?+ void *data)
> >> ?+{
> >> ?+ struct platform_device *pdev = to_platform_device(dev);
> >> ?+ struct drm_device *drm = data;
> >> ?+ struct sun4i_drv *drv = drm->dev_private;
> >> ?+ struct sun8i_mixer *mixer;
> >> ?+ struct resource *res;
> >> ?+ void __iomem *regs;
> >> ?+ int i, ret;
> >> ?+
> >> ?+ mixer = devm_kzalloc(dev, sizeof(*mixer), GFP_KERNEL);
> >> ?+ if (!mixer)
> >> ?+ return -ENOMEM;
> >> ?+ dev_set_drvdata(dev, mixer);
> >> ?+ drv->mixer = mixer;
> >> ?+
> >> ?+ mixer->cfg = of_device_get_match_data(dev);
> >> ?+ if (!mixer->cfg)
> >> ?+ return -EINVAL;
> >> ?+
> >> ?+ res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> ?+ regs = devm_ioremap_resource(dev, res);
> >> ?+ if (IS_ERR(regs))
> >> ?+ return PTR_ERR(regs);
> >> ?+
> >> ?+ mixer->regs = devm_regmap_init_mmio(dev, regs,
> >> ?+ &sun8i_mixer_regmap_config);
> >> ?+ if (IS_ERR(mixer->regs)) {
> >> ?+ dev_err(dev, "Couldn't create the mixer regmap\n");
> >> ?+ return PTR_ERR(mixer->regs);
> >> ?+ }
> >> ?+
> >> ?+ mixer->reset = devm_reset_control_get(dev, NULL);
> >> ?+ if (IS_ERR(mixer->reset)) {
> >> ?+ dev_err(dev, "Couldn't get our reset line\n");
> >> ?+ return PTR_ERR(mixer->reset);
> >> ?+ }
> >> ?+
> >> ?+ ret = reset_control_deassert(mixer->reset);
> >> ?+ if (ret) {
> >> ?+ dev_err(dev, "Couldn't deassert our reset line\n");
> >> ?+ return ret;
> >> ?+ }
> >> ?+
> >> ?+ mixer->bus_clk = devm_clk_get(dev, "bus");
> >> ?+ if (IS_ERR(mixer->bus_clk)) {
> >> ?+ dev_err(dev, "Couldn't get the mixer bus clock\n");
> >> ?+ ret = PTR_ERR(mixer->bus_clk);
> >> ?+ goto err_assert_reset;
> >> ?+ }
> >> ?+ clk_prepare_enable(mixer->bus_clk);
> >> ?+
> >> ?+ mixer->mod_clk = devm_clk_get(dev, "mod");
> >> ?+ if (IS_ERR(mixer->mod_clk)) {
> >> ?+ dev_err(dev, "Couldn't get the mixer module clock\n");
> >> ?+ ret = PTR_ERR(mixer->mod_clk);
> >> ?+ goto err_disable_bus_clk;
> >> ?+ }
> >> ?+ clk_prepare_enable(mixer->mod_clk);
> >
> > Supporting runtime_pm would be better.
> 
> But I think it's at least not support yet for DE1 backend...

This is true, but unrelated.

> >> ?+ /* Reset the registers */
> >> ?+ for (i = 0x0; i < 0x20000; i += 4)
> >> ?+ regmap_write(mixer->regs, i, 0);
> >
> > Do you still need to reset it? Isn't the reset line enough?
> 
> Nope, some strange data lies in the DE2 space.
> 
> Here's a reg dump of a running DE2 's channel 2 on V3s:
> => md 01104000
> 01104000: ff000403 010f01df 00000000 00000780    ................
> 01104010: 03f80000 00000000 00000000 00000000    ................
> 01104020: 00000000 00000000 00000000 00000000    ................
> 01104030: 00000000 00000000 00000000 00000000    ................
> 01104040: 00000000 00000000 00000000 00000000    ................
> 01104050: 00000000 00000000 00000000 00000000    ................
> 01104060: 00000000 00000000 00000000 00000000    ................
> 01104070: 00000000 00000000 00000000 00000000    ................
> 01104080: 00000000 00000000 010f01df bbe4d3b0    ................
> 01104090: 54daaf98 13835927 a1479b58 8396b8ad    ...T'Y..X.G.....
> 011040a0: 07d02ede a39a18da 87d88aba a2d23cf6    .............<..
> 011040b0: e8bfa8f7 2c8d2b7c f8bbeb3e 98013b75    ....|+.,>...u;..
> 011040c0: 7c186f48 4ddcdbde b658caf8 76b770d6    Ho.|...M..X..p.v
> 011040d0: b9a620ef fe215cc1 edd6c4b3 c5f7a66c    . ...\!.....l...
> 011040e0: 0d1ff6d3 956ca9e8 7f51f80a ad9a184a    ......l...Q.J...
> 011040f0: ff23e428 772d8d14 f4c03077 8bf495ca    (.#...-ww0......
> 
> (P.S. only first 0x88 bytes are used in a UI channel, so the following is
> not reseted by U-Boot DE2 driver and is kept the original after reset line
> deasserting)

is it causing any issues? This is not unusual to have !0 default
values out of reset, and this shouldn't cause any troubles.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170222/fdc5a10b/attachment-0001.sig>
