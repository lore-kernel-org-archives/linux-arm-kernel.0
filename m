From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 3 Apr 2017 18:51:38 +0800
Subject: [PATCH v3 04/11] drm/sun4i: abstract the layer type
In-Reply-To: <20170403081423.p6x4ytfoga2krygv@lukather>
References: <20170329194613.55548-1-icenowy@aosc.io>
 <20170329194613.55548-5-icenowy@aosc.io>
 <20170403081423.p6x4ytfoga2krygv@lukather>
Message-ID: <CAGb2v66gej-udjXVwrRLwTmVf+G1NL2eLeyTzTq8W1z=wD8NMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 3, 2017 at 4:14 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Mar 30, 2017 at 03:46:06AM +0800, Icenowy Zheng wrote:
>> As we are going to add support for the Allwinner DE2 Mixer in sun4i-drm
>> driver, we will finally have two types of layer.
>>
>> Abstract the layer type to void * and a ops struct, which contains the
>> only function used by crtc -- get the drm_plane struct of the layer.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Refactored patch in v3.
>>
>>  drivers/gpu/drm/sun4i/sun4i_crtc.c  | 19 +++++++++++--------
>>  drivers/gpu/drm/sun4i/sun4i_crtc.h  |  3 ++-
>>  drivers/gpu/drm/sun4i/sun4i_layer.c | 19 ++++++++++++++++++-
>>  drivers/gpu/drm/sun4i/sun4i_layer.h |  2 +-
>>  drivers/gpu/drm/sun4i/sunxi_layer.h | 17 +++++++++++++++++
>>  5 files changed, 49 insertions(+), 11 deletions(-)
>>  create mode 100644 drivers/gpu/drm/sun4i/sunxi_layer.h
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
>> index 3c876c3a356a..33854ee7f636 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
>> @@ -29,6 +29,7 @@
>>  #include "sun4i_crtc.h"
>>  #include "sun4i_drv.h"
>>  #include "sun4i_layer.h"
>> +#include "sunxi_layer.h"
>>  #include "sun4i_tcon.h"
>>
>>  static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
>> @@ -149,7 +150,7 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
>>       scrtc->tcon = tcon;
>>
>>       /* Create our layers */
>> -     scrtc->layers = sun4i_layers_init(drm, scrtc->backend);
>> +     scrtc->layers = (void **)sun4i_layers_init(drm, scrtc);
>>       if (IS_ERR(scrtc->layers)) {
>>               dev_err(drm->dev, "Couldn't create the planes\n");
>>               return NULL;
>> @@ -157,14 +158,15 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
>>
>>       /* find primary and cursor planes for drm_crtc_init_with_planes */
>>       for (i = 0; scrtc->layers[i]; i++) {
>> -             struct sun4i_layer *layer = scrtc->layers[i];
>> +             void *layer = scrtc->layers[i];
>> +             struct drm_plane *plane = scrtc->layer_ops->get_plane(layer);
>>
>> -             switch (layer->plane.type) {
>> +             switch (plane->type) {
>>               case DRM_PLANE_TYPE_PRIMARY:
>> -                     primary = &layer->plane;
>> +                     primary = plane;
>>                       break;
>>               case DRM_PLANE_TYPE_CURSOR:
>> -                     cursor = &layer->plane;
>> +                     cursor = plane;
>>                       break;
>>               default:
>>                       break;
>> @@ -190,10 +192,11 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
>>       /* Set possible_crtcs to this crtc for overlay planes */
>>       for (i = 0; scrtc->layers[i]; i++) {
>>               uint32_t possible_crtcs = BIT(drm_crtc_index(&scrtc->crtc));
>> -             struct sun4i_layer *layer = scrtc->layers[i];
>> +             void *layer = scrtc->layers[i];
>> +             struct drm_plane *plane = scrtc->layer_ops->get_plane(layer);
>>
>> -             if (layer->plane.type == DRM_PLANE_TYPE_OVERLAY)
>> -                     layer->plane.possible_crtcs = possible_crtcs;
>> +             if (plane->type == DRM_PLANE_TYPE_OVERLAY)
>> +                     plane->possible_crtcs = possible_crtcs;
>
> I think the logic should be reversed here, the CRTC shouldn't care
> (much) about the layers at all.

Correct. It shouldn't. However since the layers are tied to a specific
crtc, they get created as part of the crtc init sequence.

> We should modify sun4i_crtc_init to get the argument it needs (primary
> and cursor planes for example) through its parameters, and have the
> caller (which iirc is sun4i_drv) call it with the right parameters

The caller is (now) sun4i_crtc_init.

> depending on whether you're using DE or DE2.

Ack.

>
> If we're doing that, I don't think we even need the pointer to the
> array of layers in struct sun4i_crtc, which will make it easier to
> deal with.

Ack.

ChenYu
