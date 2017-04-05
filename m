From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Apr 2017 10:09:58 +0200
Subject: [linux-sunxi] Re: [PATCH v3 04/11] drm/sun4i: abstract the layer
 type
In-Reply-To: <20170405052325.98B958A2E94@relay.mailchannels.net>
References: <20170405052325.98B958A2E94@relay.mailchannels.net>
Message-ID: <20170405080958.lrqoled7df5ugtur@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 01:23:15PM +0800, Icenowy Zheng wrote:
> 
> 2017?4?5? 10:27? Chen-Yu Tsai <wens@csie.org>???
> >
> > On Wed, Apr 5, 2017 at 3:53 AM, Icenowy Zheng <icenowy@aosc.io> wrote: 
> > > 
> > > 
> > > ? 2017?04?05? 03:28, Sean Paul ??: 
> > >> 
> > >> On Thu, Mar 30, 2017 at 03:46:06AM +0800, Icenowy Zheng wrote: 
> > >>> 
> > >>> As we are going to add support for the Allwinner DE2 Mixer in sun4i-drm 
> > >>> driver, we will finally have two types of layer. 
> > >>> 
> > >>> Abstract the layer type to void * and a ops struct, which contains the 
> > >>> only function used by crtc -- get the drm_plane struct of the layer. 
> > >>> 
> > >>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io> 
> > >>> --- 
> > >>> Refactored patch in v3. 
> > >>> 
> > >>>? drivers/gpu/drm/sun4i/sun4i_crtc.c? | 19 +++++++++++-------- 
> > >>>? drivers/gpu/drm/sun4i/sun4i_crtc.h? |? 3 ++- 
> > >>>? drivers/gpu/drm/sun4i/sun4i_layer.c | 19 ++++++++++++++++++- 
> > >>>? drivers/gpu/drm/sun4i/sun4i_layer.h |? 2 +- 
> > >>>? drivers/gpu/drm/sun4i/sunxi_layer.h | 17 +++++++++++++++++ 
> > >>>? 5 files changed, 49 insertions(+), 11 deletions(-) 
> > >>>? create mode 100644 drivers/gpu/drm/sun4i/sunxi_layer.h 
> > >>> 
> > >>> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c 
> > >>> b/drivers/gpu/drm/sun4i/sun4i_crtc.c 
> > >>> index 3c876c3a356a..33854ee7f636 100644 
> > >>> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.c 
> > >>> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c 
> > >>> @@ -29,6 +29,7 @@ 
> > >>>? #include "sun4i_crtc.h" 
> > >>>? #include "sun4i_drv.h" 
> > >>>? #include "sun4i_layer.h" 
> > >>> +#include "sunxi_layer.h" 
> > >>>? #include "sun4i_tcon.h" 
> > >>> 
> > >>>? static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc, 
> > >>> @@ -149,7 +150,7 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device 
> > >>> *drm, 
> > >>>???????? scrtc->tcon = tcon; 
> > >>> 
> > >>>???????? /* Create our layers */ 
> > >>> -?????? scrtc->layers = sun4i_layers_init(drm, scrtc->backend); 
> > >>> +?????? scrtc->layers = (void **)sun4i_layers_init(drm, scrtc); 
> > >>>???????? if (IS_ERR(scrtc->layers)) { 
> > >>>???????????????? dev_err(drm->dev, "Couldn't create the planes\n"); 
> > >>>???????????????? return NULL; 
> > >>> @@ -157,14 +158,15 @@ struct sun4i_crtc *sun4i_crtc_init(struct 
> > >>> drm_device *drm, 
> > >>> 
> > >>>???????? /* find primary and cursor planes for drm_crtc_init_with_planes 
> > >>> */ 
> > >>>???????? for (i = 0; scrtc->layers[i]; i++) { 
> > >>> -?????????????? struct sun4i_layer *layer = scrtc->layers[i]; 
> > >>> +?????????????? void *layer = scrtc->layers[i]; 
> > >>> +?????????????? struct drm_plane *plane = 
> > >>> scrtc->layer_ops->get_plane(layer); 
> > >>> 
> > >>> -?????????????? switch (layer->plane.type) { 
> > >>> +?????????????? switch (plane->type) { 
> > >>>???????????????? case DRM_PLANE_TYPE_PRIMARY: 
> > >>> -?????????????????????? primary = &layer->plane; 
> > >>> +?????????????????????? primary = plane; 
> > >>>???????????????????????? break; 
> > >>>???????????????? case DRM_PLANE_TYPE_CURSOR: 
> > >>> -?????????????????????? cursor = &layer->plane; 
> > >>> +?????????????????????? cursor = plane; 
> > >>>???????????????????????? break; 
> > >>>???????????????? default: 
> > >>>???????????????????????? break; 
> > >>> @@ -190,10 +192,11 @@ struct sun4i_crtc *sun4i_crtc_init(struct 
> > >>> drm_device *drm, 
> > >>>???????? /* Set possible_crtcs to this crtc for overlay planes */ 
> > >>>???????? for (i = 0; scrtc->layers[i]; i++) { 
> > >>>???????????????? uint32_t possible_crtcs = 
> > >>> BIT(drm_crtc_index(&scrtc->crtc)); 
> > >>> -?????????????? struct sun4i_layer *layer = scrtc->layers[i]; 
> > >>> +?????????????? void *layer = scrtc->layers[i]; 
> > >>> +?????????????? struct drm_plane *plane = 
> > >>> scrtc->layer_ops->get_plane(layer); 
> > >>> 
> > >>> -?????????????? if (layer->plane.type == DRM_PLANE_TYPE_OVERLAY) 
> > >>> -?????????????????????? layer->plane.possible_crtcs = possible_crtcs; 
> > >>> +?????????????? if (plane->type == DRM_PLANE_TYPE_OVERLAY) 
> > >>> +?????????????????????? plane->possible_crtcs = possible_crtcs; 
> > >>>???????? } 
> > >>> 
> > >>>???????? return scrtc; 
> > >>> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.h 
> > >>> b/drivers/gpu/drm/sun4i/sun4i_crtc.h 
> > >>> index 230cb8f0d601..a4036ee44cf8 100644 
> > >>> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.h 
> > >>> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.h 
> > >>> @@ -19,7 +19,8 @@ struct sun4i_crtc { 
> > >>> 
> > >>>???????? struct sun4i_backend??????????? *backend; 
> > >>>???????? struct sun4i_tcon?????????????? *tcon; 
> > >>> -?????? struct sun4i_layer????????????? **layers; 
> > >>> +?????? void??????????????????????????? **layers; 
> > >>> +?????? const struct sunxi_layer_ops??? *layer_ops; 
> > >> 
> > >> 
> > >> I think you should probably take a different approach to abstract the 
> > >> layer 
> > >> type. How about creating 
> > >> 
> > >> struct sunxi_layer { 
> > >>???????? struct drm_plane plane; 
> > >> } 
> > >> 
> > >> base and then subclassing that for sun4i and sun8i? By doing this you can 
> > >> avoid 
> > >> the nasty casting and you can also get rid of the get_plane() hook and 
> > >> layer_ops. 
> > > 
> > > 
> > > For the situation that using ** things are easily to get weird. 
> >
> > That code could be reworked, by initializing the layers directly within 
> > the crtc init code. If you look at rockchip's drm driver, you'll see 
> > they do this. There is a good reason to do it this way, as you need 
> > to first create the primary and cursor layers, pass them in when you 
> > create the crtc, then initialize any additional layers with the 
> > possible_crtcs bitmap. 
> 
> But furthurly maybe more layers will be created for DE2 mixer, and
> may even depends on mixer type (On A83T/H3/A64/H5 mixer1 has fewer
> channel than mixer0).

You'll always have one primary and one cursor plane, no matter how
much planes you support.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170405/bd177b26/attachment.sig>
