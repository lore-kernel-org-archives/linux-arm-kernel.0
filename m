From: ajaynumb@gmail.com (Ajay kumar)
Date: Mon, 2 Feb 2015 14:44:43 +0530
Subject: [PATCH 03/14] drm/bridge: make bridge registration independent of
 drm flow
In-Reply-To: <CAF6AEGs8GbgYMLmaPjGnXAv=Gsf6gMhNj+Zt0-2GKHOnHv4d4Q@mail.gmail.com>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
 <1421771935-31618-4-git-send-email-ajaykumar.rs@samsung.com>
 <CAF6AEGs8GbgYMLmaPjGnXAv=Gsf6gMhNj+Zt0-2GKHOnHv4d4Q@mail.gmail.com>
Message-ID: <CAEC9eQPmv__SMw+UK6TOrFqYrhwrqOiMOBan8LJwDfqjjip1QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Jan 30, 2015 at 9:07 PM, Rob Clark <robdclark@gmail.com> wrote:
> On Tue, Jan 20, 2015 at 11:38 AM, Ajay Kumar <ajaykumar.rs@samsung.com> wrote:
>> Currently, third party bridge drivers(ptn3460) are dependent
>> on the corresponding encoder driver init, since bridge driver
>> needs a drm_device pointer to finish drm initializations.
>> The encoder driver passes the drm_device pointer to the
>> bridge driver. Because of this dependency, third party drivers
>> like ptn3460 doesn't adhere to the driver model.
>>
>> In this patch, we reframe the bridge registration framework
>> so that bridge initialization is split into 2 steps, and
>> bridge registration happens independent of drm flow:
>> --Step 1: gather all the bridge settings independent of drm and
>>           add the bridge onto a global list of bridges.
>> --Step 2: when the encoder driver is probed, call drm_bridge_attach
>>           for the corresponding bridge so that the bridge receives
>>           drm_device pointer and continues with connector and other
>>           drm initializations.
>>
>> The old set of bridge helpers are removed, and a set of new helpers
>> are added to accomplish the 2 step initialization.
>>
>> The bridge devices register themselves onto global list of bridges
>> when they get probed by calling "drm_bridge_add".
>>
>> The parent encoder driver waits till the bridge is available
>> in the lookup table(by calling "of_drm_find_bridge") and then
>> continues with its initialization.
>>
>> The encoder driver should also call "drm_bridge_attach" to pass
>> on the drm_device to the bridge object.
>>
>> drm_bridge_attach inturn calls "bridge->funcs->attach" so that
>> bridge can continue with drm related initializations.
>
> ok, so I probably should have had a closer look at this before it
> landed in drm-next, so if it is too late to revert (and deal w/
> untangling subsequent patches that depend on this) some of these
> issues we'll just have to fix with follow-on patches.
>
> 1) needs headerdoc for new fxns in drm_bridge.c, and needs to be added
> in drm.tmpl
Ohh, I totally forgot. I will do this. Just point me to some recent
patch which updates docbook.
> 2) as far as I can tell, the new approach to cleaning up bridge
> objects is to just let them leak !?!
I just checked. Only MSM hdmi_bridge is leaking, and this is because
it doesn't use devm_kzalloc. All other bridges use devm_kzalloc,
and hence that memory is automatically freed.
For MSM HDMI, we need to find a place to call hdmi_bridge_destroy.

> I'll also need to update the new bridge in the msm edp code..
> although that isn't such a big deal if I knew how this was *supposed*
> to work..
You just need to convert drm_bridge_init to drm_bridge_attach, and
remove destroy callback. Refer this:
http://cgit.freedesktop.org/~airlied/linux/commit/?h=drm-next&id=b5217bf4692218d202d3d2cd772864fa1e10be4d

Regards,
Ajay Kumar
> since what is there now at least doesn't look right..
>
> BR,
> -R
>
>
>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>> Acked-by: Inki Dae <inki.dae@samsung.com>
>> Tested-by: Rahul Sharma <rahul.sharma@samsung.com>
>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Tested-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>> Tested-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>> ---
>>  drivers/gpu/drm/Makefile               |    2 +-
>>  drivers/gpu/drm/bridge/ptn3460.c       |   27 +++++-----
>>  drivers/gpu/drm/drm_bridge.c           |   91 ++++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/drm_crtc.c             |   67 -----------------------
>>  drivers/gpu/drm/msm/hdmi/hdmi.c        |    4 +-
>>  drivers/gpu/drm/msm/hdmi/hdmi.h        |    1 +
>>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c |    6 +--
>>  drivers/gpu/drm/sti/sti_hda.c          |   10 +---
>>  drivers/gpu/drm/sti/sti_hdmi.c         |   10 +---
>>  include/drm/bridge/ptn3460.h           |    8 +++
>>  include/drm/drm_crtc.h                 |   26 ++++-----
>>  11 files changed, 133 insertions(+), 119 deletions(-)
>>  create mode 100644 drivers/gpu/drm/drm_bridge.c
>>
>> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
>> index e620807..c83ef2d 100644
>> --- a/drivers/gpu/drm/Makefile
>> +++ b/drivers/gpu/drm/Makefile
>> @@ -14,7 +14,7 @@ drm-y       :=        drm_auth.o drm_bufs.o drm_cache.o \
>>                 drm_info.o drm_debugfs.o drm_encoder_slave.o \
>>                 drm_trace_points.o drm_global.o drm_prime.o \
>>                 drm_rect.o drm_vma_manager.o drm_flip_work.o \
>> -               drm_modeset_lock.o drm_atomic.o
>> +               drm_modeset_lock.o drm_atomic.o drm_bridge.o
>>
>>  drm-$(CONFIG_COMPAT) += drm_ioc32.o
>>  drm-$(CONFIG_DRM_GEM_CMA_HELPER) += drm_gem_cma_helper.o
>> diff --git a/drivers/gpu/drm/bridge/ptn3460.c b/drivers/gpu/drm/bridge/ptn3460.c
>> index a2ddc8d..4a818c1 100644
>> --- a/drivers/gpu/drm/bridge/ptn3460.c
>> +++ b/drivers/gpu/drm/bridge/ptn3460.c
>> @@ -176,24 +176,11 @@ static void ptn3460_post_disable(struct drm_bridge *bridge)
>>  {
>>  }
>>
>> -static void ptn3460_bridge_destroy(struct drm_bridge *bridge)
>> -{
>> -       struct ptn3460_bridge *ptn_bridge = bridge_to_ptn3460(bridge);
>> -
>> -       drm_bridge_cleanup(bridge);
>> -       if (gpio_is_valid(ptn_bridge->gpio_pd_n))
>> -               gpio_free(ptn_bridge->gpio_pd_n);
>> -       if (gpio_is_valid(ptn_bridge->gpio_rst_n))
>> -               gpio_free(ptn_bridge->gpio_rst_n);
>> -       /* Nothing else to free, we've got devm allocated memory */
>> -}
>> -
>>  static struct drm_bridge_funcs ptn3460_bridge_funcs = {
>>         .pre_enable = ptn3460_pre_enable,
>>         .enable = ptn3460_enable,
>>         .disable = ptn3460_disable,
>>         .post_disable = ptn3460_post_disable,
>> -       .destroy = ptn3460_bridge_destroy,
>>  };
>>
>>  static int ptn3460_get_modes(struct drm_connector *connector)
>> @@ -314,7 +301,7 @@ int ptn3460_init(struct drm_device *dev, struct drm_encoder *encoder,
>>         }
>>
>>         ptn_bridge->bridge.funcs = &ptn3460_bridge_funcs;
>> -       ret = drm_bridge_init(dev, &ptn_bridge->bridge);
>> +       ret = drm_bridge_attach(dev, &ptn_bridge->bridge);
>>         if (ret) {
>>                 DRM_ERROR("Failed to initialize bridge with drm\n");
>>                 goto err;
>> @@ -343,3 +330,15 @@ err:
>>         return ret;
>>  }
>>  EXPORT_SYMBOL(ptn3460_init);
>> +
>> +void ptn3460_destroy(struct drm_bridge *bridge)
>> +{
>> +       struct ptn3460_bridge *ptn_bridge = bridge->driver_private;
>> +
>> +       if (gpio_is_valid(ptn_bridge->gpio_pd_n))
>> +               gpio_free(ptn_bridge->gpio_pd_n);
>> +       if (gpio_is_valid(ptn_bridge->gpio_rst_n))
>> +               gpio_free(ptn_bridge->gpio_rst_n);
>> +       /* Nothing else to free, we've got devm allocated memory */
>> +}
>> +EXPORT_SYMBOL(ptn3460_destroy);
>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>> new file mode 100644
>> index 0000000..d1187e5
>> --- /dev/null
>> +++ b/drivers/gpu/drm/drm_bridge.c
>> @@ -0,0 +1,91 @@
>> +/*
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sub license,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice (including the
>> + * next paragraph) shall be included in all copies or substantial portions
>> + * of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> + * DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +
>> +#include <drm/drm_crtc.h>
>> +
>> +#include "drm/drmP.h"
>> +
>> +static DEFINE_MUTEX(bridge_lock);
>> +static LIST_HEAD(bridge_list);
>> +
>> +int drm_bridge_add(struct drm_bridge *bridge)
>> +{
>> +       mutex_lock(&bridge_lock);
>> +       list_add_tail(&bridge->list, &bridge_list);
>> +       mutex_unlock(&bridge_lock);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(drm_bridge_add);
>> +
>> +void drm_bridge_remove(struct drm_bridge *bridge)
>> +{
>> +       mutex_lock(&bridge_lock);
>> +       list_del_init(&bridge->list);
>> +       mutex_unlock(&bridge_lock);
>> +}
>> +EXPORT_SYMBOL(drm_bridge_remove);
>> +
>> +extern int drm_bridge_attach(struct drm_device *dev, struct drm_bridge *bridge)
>> +{
>> +       if (!dev || !bridge)
>> +               return -EINVAL;
>> +
>> +       if (bridge->dev)
>> +               return -EBUSY;
>> +
>> +       bridge->dev = dev;
>> +
>> +       if (bridge->funcs->attach)
>> +               return bridge->funcs->attach(bridge);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(drm_bridge_attach);
>> +
>> +#ifdef CONFIG_OF
>> +struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>> +{
>> +       struct drm_bridge *bridge;
>> +
>> +       mutex_lock(&bridge_lock);
>> +
>> +       list_for_each_entry(bridge, &bridge_list, list) {
>> +               if (bridge->of_node == np) {
>> +                       mutex_unlock(&bridge_lock);
>> +                       return bridge;
>> +               }
>> +       }
>> +
>> +       mutex_unlock(&bridge_lock);
>> +       return NULL;
>> +}
>> +EXPORT_SYMBOL(of_drm_find_bridge);
>> +#endif
>> +
>> +MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
>> +MODULE_DESCRIPTION("DRM bridge infrastructure");
>> +MODULE_LICENSE("GPL and additional rights");
>> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
>> index af57103..bb8e31e 100644
>> --- a/drivers/gpu/drm/drm_crtc.c
>> +++ b/drivers/gpu/drm/drm_crtc.c
>> @@ -1028,58 +1028,6 @@ void drm_connector_unplug_all(struct drm_device *dev)
>>  EXPORT_SYMBOL(drm_connector_unplug_all);
>>
>>  /**
>> - * drm_bridge_init - initialize a drm transcoder/bridge
>> - * @dev: drm device
>> - * @bridge: transcoder/bridge to set up
>> - *
>> - * Initialises a preallocated bridge. Bridges should be
>> - * subclassed as part of driver connector objects.
>> - *
>> - * Returns:
>> - * Zero on success, error code on failure.
>> - */
>> -int drm_bridge_init(struct drm_device *dev, struct drm_bridge *bridge)
>> -{
>> -       int ret;
>> -
>> -       drm_modeset_lock_all(dev);
>> -
>> -       ret = drm_mode_object_get(dev, &bridge->base, DRM_MODE_OBJECT_BRIDGE);
>> -       if (ret)
>> -               goto out;
>> -
>> -       bridge->dev = dev;
>> -
>> -       list_add_tail(&bridge->head, &dev->mode_config.bridge_list);
>> -       dev->mode_config.num_bridge++;
>> -
>> - out:
>> -       drm_modeset_unlock_all(dev);
>> -       return ret;
>> -}
>> -EXPORT_SYMBOL(drm_bridge_init);
>> -
>> -/**
>> - * drm_bridge_cleanup - cleans up an initialised bridge
>> - * @bridge: bridge to cleanup
>> - *
>> - * Cleans up the bridge but doesn't free the object.
>> - */
>> -void drm_bridge_cleanup(struct drm_bridge *bridge)
>> -{
>> -       struct drm_device *dev = bridge->dev;
>> -
>> -       drm_modeset_lock_all(dev);
>> -       drm_mode_object_put(dev, &bridge->base);
>> -       list_del(&bridge->head);
>> -       dev->mode_config.num_bridge--;
>> -       drm_modeset_unlock_all(dev);
>> -
>> -       memset(bridge, 0, sizeof(*bridge));
>> -}
>> -EXPORT_SYMBOL(drm_bridge_cleanup);
>> -
>> -/**
>>   * drm_encoder_init - Init a preallocated encoder
>>   * @dev: drm device
>>   * @encoder: the encoder to init
>> @@ -1594,7 +1542,6 @@ static int drm_mode_group_init(struct drm_device *dev, struct drm_mode_group *gr
>>         total_objects += dev->mode_config.num_crtc;
>>         total_objects += dev->mode_config.num_connector;
>>         total_objects += dev->mode_config.num_encoder;
>> -       total_objects += dev->mode_config.num_bridge;
>>
>>         group->id_list = kzalloc(total_objects * sizeof(uint32_t), GFP_KERNEL);
>>         if (!group->id_list)
>> @@ -1603,7 +1550,6 @@ static int drm_mode_group_init(struct drm_device *dev, struct drm_mode_group *gr
>>         group->num_crtcs = 0;
>>         group->num_connectors = 0;
>>         group->num_encoders = 0;
>> -       group->num_bridges = 0;
>>         return 0;
>>  }
>>
>> @@ -1623,7 +1569,6 @@ int drm_mode_group_init_legacy_group(struct drm_device *dev,
>>         struct drm_crtc *crtc;
>>         struct drm_encoder *encoder;
>>         struct drm_connector *connector;
>> -       struct drm_bridge *bridge;
>>         int ret;
>>
>>         if ((ret = drm_mode_group_init(dev, group)))
>> @@ -1640,11 +1585,6 @@ int drm_mode_group_init_legacy_group(struct drm_device *dev,
>>                 group->id_list[group->num_crtcs + group->num_encoders +
>>                                group->num_connectors++] = connector->base.id;
>>
>> -       list_for_each_entry(bridge, &dev->mode_config.bridge_list, head)
>> -               group->id_list[group->num_crtcs + group->num_encoders +
>> -                              group->num_connectors + group->num_bridges++] =
>> -                                       bridge->base.id;
>> -
>>         return 0;
>>  }
>>  EXPORT_SYMBOL(drm_mode_group_init_legacy_group);
>> @@ -5208,7 +5148,6 @@ void drm_mode_config_init(struct drm_device *dev)
>>         INIT_LIST_HEAD(&dev->mode_config.fb_list);
>>         INIT_LIST_HEAD(&dev->mode_config.crtc_list);
>>         INIT_LIST_HEAD(&dev->mode_config.connector_list);
>> -       INIT_LIST_HEAD(&dev->mode_config.bridge_list);
>>         INIT_LIST_HEAD(&dev->mode_config.encoder_list);
>>         INIT_LIST_HEAD(&dev->mode_config.property_list);
>>         INIT_LIST_HEAD(&dev->mode_config.property_blob_list);
>> @@ -5249,7 +5188,6 @@ void drm_mode_config_cleanup(struct drm_device *dev)
>>         struct drm_connector *connector, *ot;
>>         struct drm_crtc *crtc, *ct;
>>         struct drm_encoder *encoder, *enct;
>> -       struct drm_bridge *bridge, *brt;
>>         struct drm_framebuffer *fb, *fbt;
>>         struct drm_property *property, *pt;
>>         struct drm_property_blob *blob, *bt;
>> @@ -5260,11 +5198,6 @@ void drm_mode_config_cleanup(struct drm_device *dev)
>>                 encoder->funcs->destroy(encoder);
>>         }
>>
>> -       list_for_each_entry_safe(bridge, brt,
>> -                                &dev->mode_config.bridge_list, head) {
>> -               bridge->funcs->destroy(bridge);
>> -       }
>> -
>>         list_for_each_entry_safe(connector, ot,
>>                                  &dev->mode_config.connector_list, head) {
>>                 connector->funcs->destroy(connector);
>> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
>> index 062c687..95f7b8d 100644
>> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
>> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
>> @@ -247,9 +247,9 @@ int hdmi_modeset_init(struct hdmi *hdmi,
>>         return 0;
>>
>>  fail:
>> -       /* bridge/connector are normally destroyed by drm: */
>> +       /* bridge is normally destroyed by drm: */
>>         if (hdmi->bridge) {
>> -               hdmi->bridge->funcs->destroy(hdmi->bridge);
>> +               hdmi_bridge_destroy(hdmi->bridge);
>>                 hdmi->bridge = NULL;
>>         }
>>         if (hdmi->connector) {
>> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
>> index 43e654f..4d4cad4 100644
>> --- a/drivers/gpu/drm/msm/hdmi/hdmi.h
>> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
>> @@ -146,6 +146,7 @@ void hdmi_audio_set_sample_rate(struct hdmi *hdmi, int rate);
>>   */
>>
>>  struct drm_bridge *hdmi_bridge_init(struct hdmi *hdmi);
>> +void hdmi_bridge_destroy(struct drm_bridge *bridge);
>>
>>  /*
>>   * hdmi connector:
>> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
>> index 52ed2b5..d6f8d58 100644
>> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
>> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
>> @@ -23,10 +23,9 @@ struct hdmi_bridge {
>>  };
>>  #define to_hdmi_bridge(x) container_of(x, struct hdmi_bridge, base)
>>
>> -static void hdmi_bridge_destroy(struct drm_bridge *bridge)
>> +void hdmi_bridge_destroy(struct drm_bridge *bridge)
>>  {
>>         struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
>> -       drm_bridge_cleanup(bridge);
>>         kfree(hdmi_bridge);
>>  }
>>
>> @@ -200,7 +199,6 @@ static const struct drm_bridge_funcs hdmi_bridge_funcs = {
>>                 .disable = hdmi_bridge_disable,
>>                 .post_disable = hdmi_bridge_post_disable,
>>                 .mode_set = hdmi_bridge_mode_set,
>> -               .destroy = hdmi_bridge_destroy,
>>  };
>>
>>
>> @@ -222,7 +220,7 @@ struct drm_bridge *hdmi_bridge_init(struct hdmi *hdmi)
>>         bridge = &hdmi_bridge->base;
>>         bridge->funcs = &hdmi_bridge_funcs;
>>
>> -       drm_bridge_init(hdmi->dev, bridge);
>> +       drm_bridge_attach(hdmi->dev, bridge);
>>
>>         return bridge;
>>
>> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
>> index 6cf145d..a9bbb08 100644
>> --- a/drivers/gpu/drm/sti/sti_hda.c
>> +++ b/drivers/gpu/drm/sti/sti_hda.c
>> @@ -508,19 +508,12 @@ static void sti_hda_bridge_nope(struct drm_bridge *bridge)
>>         /* do nothing */
>>  }
>>
>> -static void sti_hda_brigde_destroy(struct drm_bridge *bridge)
>> -{
>> -       drm_bridge_cleanup(bridge);
>> -       kfree(bridge);
>> -}
>> -
>>  static const struct drm_bridge_funcs sti_hda_bridge_funcs = {
>>         .pre_enable = sti_hda_pre_enable,
>>         .enable = sti_hda_bridge_nope,
>>         .disable = sti_hda_disable,
>>         .post_disable = sti_hda_bridge_nope,
>>         .mode_set = sti_hda_set_mode,
>> -       .destroy = sti_hda_brigde_destroy,
>>  };
>>
>>  static int sti_hda_connector_get_modes(struct drm_connector *connector)
>> @@ -665,7 +658,7 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
>>
>>         bridge->driver_private = hda;
>>         bridge->funcs = &sti_hda_bridge_funcs;
>> -       drm_bridge_init(drm_dev, bridge);
>> +       drm_bridge_attach(drm_dev, bridge);
>>
>>         encoder->bridge = bridge;
>>         connector->encoder = encoder;
>> @@ -694,7 +687,6 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
>>  err_sysfs:
>>         drm_connector_unregister(drm_connector);
>>  err_connector:
>> -       drm_bridge_cleanup(bridge);
>>         drm_connector_cleanup(drm_connector);
>>         return -EINVAL;
>>  }
>> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
>> index 74e943e..e840ca5d 100644
>> --- a/drivers/gpu/drm/sti/sti_hdmi.c
>> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
>> @@ -463,19 +463,12 @@ static void sti_hdmi_bridge_nope(struct drm_bridge *bridge)
>>         /* do nothing */
>>  }
>>
>> -static void sti_hdmi_brigde_destroy(struct drm_bridge *bridge)
>> -{
>> -       drm_bridge_cleanup(bridge);
>> -       kfree(bridge);
>> -}
>> -
>>  static const struct drm_bridge_funcs sti_hdmi_bridge_funcs = {
>>         .pre_enable = sti_hdmi_pre_enable,
>>         .enable = sti_hdmi_bridge_nope,
>>         .disable = sti_hdmi_disable,
>>         .post_disable = sti_hdmi_bridge_nope,
>>         .mode_set = sti_hdmi_set_mode,
>> -       .destroy = sti_hdmi_brigde_destroy,
>>  };
>>
>>  static int sti_hdmi_connector_get_modes(struct drm_connector *connector)
>> @@ -636,7 +629,7 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
>>
>>         bridge->driver_private = hdmi;
>>         bridge->funcs = &sti_hdmi_bridge_funcs;
>> -       drm_bridge_init(drm_dev, bridge);
>> +       drm_bridge_attach(drm_dev, bridge);
>>
>>         encoder->bridge = bridge;
>>         connector->encoder = encoder;
>> @@ -668,7 +661,6 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
>>  err_sysfs:
>>         drm_connector_unregister(drm_connector);
>>  err_connector:
>> -       drm_bridge_cleanup(bridge);
>>         drm_connector_cleanup(drm_connector);
>>  err_adapt:
>>         put_device(&hdmi->ddc_adapt->dev);
>> diff --git a/include/drm/bridge/ptn3460.h b/include/drm/bridge/ptn3460.h
>> index ff62344..b11f8e1 100644
>> --- a/include/drm/bridge/ptn3460.h
>> +++ b/include/drm/bridge/ptn3460.h
>> @@ -15,6 +15,7 @@
>>  #define _DRM_BRIDGE_PTN3460_H_
>>
>>  struct drm_device;
>> +struct drm_bridge;
>>  struct drm_encoder;
>>  struct i2c_client;
>>  struct device_node;
>> @@ -23,6 +24,9 @@ struct device_node;
>>
>>  int ptn3460_init(struct drm_device *dev, struct drm_encoder *encoder,
>>                 struct i2c_client *client, struct device_node *node);
>> +
>> +void ptn3460_destroy(struct drm_bridge *bridge);
>> +
>>  #else
>>
>>  static inline int ptn3460_init(struct drm_device *dev,
>> @@ -32,6 +36,10 @@ static inline int ptn3460_init(struct drm_device *dev,
>>         return 0;
>>  }
>>
>> +static inline void ptn3460_destroy(struct drm_bridge *bridge)
>> +{
>> +}
>> +
>>  #endif
>>
>>  #endif
>> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
>> index 5b8f254..cc369f3 100644
>> --- a/include/drm/drm_crtc.h
>> +++ b/include/drm/drm_crtc.h
>> @@ -813,15 +813,16 @@ struct drm_plane {
>>
>>  /**
>>   * struct drm_bridge_funcs - drm_bridge control functions
>> + * @attach: Called during drm_bridge_attach
>>   * @mode_fixup: Try to fixup (or reject entirely) proposed mode for this bridge
>>   * @disable: Called right before encoder prepare, disables the bridge
>>   * @post_disable: Called right after encoder prepare, for lockstepped disable
>>   * @mode_set: Set this mode to the bridge
>>   * @pre_enable: Called right before encoder commit, for lockstepped commit
>>   * @enable: Called right after encoder commit, enables the bridge
>> - * @destroy: make object go away
>>   */
>>  struct drm_bridge_funcs {
>> +       int (*attach)(struct drm_bridge *bridge);
>>         bool (*mode_fixup)(struct drm_bridge *bridge,
>>                            const struct drm_display_mode *mode,
>>                            struct drm_display_mode *adjusted_mode);
>> @@ -832,22 +833,24 @@ struct drm_bridge_funcs {
>>                          struct drm_display_mode *adjusted_mode);
>>         void (*pre_enable)(struct drm_bridge *bridge);
>>         void (*enable)(struct drm_bridge *bridge);
>> -       void (*destroy)(struct drm_bridge *bridge);
>>  };
>>
>>  /**
>>   * struct drm_bridge - central DRM bridge control structure
>>   * @dev: DRM device this bridge belongs to
>> - * @head: list management
>> + * @of_node: device node pointer to the bridge
>> + * @list: to keep track of all added bridges
>>   * @base: base mode object
>>   * @funcs: control functions
>>   * @driver_private: pointer to the bridge driver's internal context
>>   */
>>  struct drm_bridge {
>>         struct drm_device *dev;
>> -       struct list_head head;
>> -
>> -       struct drm_mode_object base;
>> +       struct drm_encoder *encoder;
>> +#ifdef CONFIG_OF
>> +       struct device_node *of_node;
>> +#endif
>> +       struct list_head list;
>>
>>         const struct drm_bridge_funcs *funcs;
>>         void *driver_private;
>> @@ -950,7 +953,6 @@ struct drm_mode_group {
>>         uint32_t num_crtcs;
>>         uint32_t num_encoders;
>>         uint32_t num_connectors;
>> -       uint32_t num_bridges;
>>
>>         /* list of object IDs for this group */
>>         uint32_t *id_list;
>> @@ -969,8 +971,6 @@ struct drm_mode_group {
>>   * @fb_list: list of framebuffers available
>>   * @num_connector: number of connectors on this device
>>   * @connector_list: list of connector objects
>> - * @num_bridge: number of bridges on this device
>> - * @bridge_list: list of bridge objects
>>   * @num_encoder: number of encoders on this device
>>   * @encoder_list: list of encoder objects
>>   * @num_overlay_plane: number of overlay planes on this device
>> @@ -1015,8 +1015,6 @@ struct drm_mode_config {
>>
>>         int num_connector;
>>         struct list_head connector_list;
>> -       int num_bridge;
>> -       struct list_head bridge_list;
>>         int num_encoder;
>>         struct list_head encoder_list;
>>
>> @@ -1153,8 +1151,10 @@ extern unsigned int drm_connector_index(struct drm_connector *connector);
>>  /* helper to unplug all connectors from sysfs for device */
>>  extern void drm_connector_unplug_all(struct drm_device *dev);
>>
>> -extern int drm_bridge_init(struct drm_device *dev, struct drm_bridge *bridge);
>> -extern void drm_bridge_cleanup(struct drm_bridge *bridge);
>> +extern int drm_bridge_add(struct drm_bridge *bridge);
>> +extern void drm_bridge_remove(struct drm_bridge *bridge);
>> +extern struct drm_bridge *of_drm_find_bridge(struct device_node *np);
>> +extern int drm_bridge_attach(struct drm_device *dev, struct drm_bridge *bridge);
>>
>>  extern int drm_encoder_init(struct drm_device *dev,
>>                             struct drm_encoder *encoder,
>> --
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
