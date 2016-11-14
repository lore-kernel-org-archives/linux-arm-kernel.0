From: zourongrong@huawei.com (Rongrong Zou)
Date: Mon, 14 Nov 2016 22:07:30 +0800
Subject: [PATCH v6 7/9] drm/hisilicon/hibmc: Add connector for VDAC
In-Reply-To: <CAOw6vbJA3Oe3GmRZBZjF24wtu_5hyTdVL2HK-1p3BLbiY1G7Tw@mail.gmail.com>
References: <1477639682-22520-1-git-send-email-zourongrong@gmail.com>
 <1477639682-22520-8-git-send-email-zourongrong@gmail.com>
 <CAOw6vbJA3Oe3GmRZBZjF24wtu_5hyTdVL2HK-1p3BLbiY1G7Tw@mail.gmail.com>
Message-ID: <5829C522.1040908@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016/11/11 9:45, Sean Paul ??:
> On Fri, Oct 28, 2016 at 3:28 AM, Rongrong Zou <zourongrong@gmail.com> wrote:
>> Add connector funcs and helper funcs for VDAC.
>>
>> Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  |  8 +++
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  2 +
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 76 ++++++++++++++++++++++++
>>   3 files changed, 86 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index ba191e1..4253603 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> @@ -131,6 +131,14 @@ static int hibmc_kms_init(struct hibmc_drm_device *hidev)
>>                  return ret;
>>          }
>>
>> +       ret = hibmc_connector_init(hidev);
>> +       if (ret) {
>> +               DRM_ERROR("failed to init connector\n");
>> +               return ret;
>> +       }
>> +
>> +       drm_mode_connector_attach_encoder(&hidev->connector,
>> +                                         &hidev->encoder);
>
> The connector should be initialized in the vdac driver with the
> encoder, not in the drv file (same as plane/crtc)

applied, thanks.

>
>>          return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> index 401cea4..450247d 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> @@ -48,6 +48,7 @@ struct hibmc_drm_device {
>>          struct drm_plane plane;
>>          struct drm_crtc crtc;
>>          struct drm_encoder encoder;
>> +       struct drm_connector connector;
>
> No need to keep track here

will allocate with devm_kzalloc(), thanks.

>
>>          bool mode_config_initialized;
>>
>>          /* ttm */
>> @@ -89,6 +90,7 @@ static inline struct hibmc_bo *gem_to_hibmc_bo(struct drm_gem_object *gem)
>>   int hibmc_plane_init(struct hibmc_drm_device *hidev);
>>   int hibmc_crtc_init(struct hibmc_drm_device *hidev);
>>   int hibmc_encoder_init(struct hibmc_drm_device *hidev);
>> +int hibmc_connector_init(struct hibmc_drm_device *hidev);
>>   int hibmc_fbdev_init(struct hibmc_drm_device *hidev);
>>   void hibmc_fbdev_fini(struct hibmc_drm_device *hidev);
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> index 953f659..ebefcd1 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> @@ -87,3 +87,79 @@ int hibmc_encoder_init(struct hibmc_drm_device *hidev)
>>          drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
>>          return 0;
>>   }
>> +
>> +static int hibmc_connector_get_modes(struct drm_connector *connector)
>> +{
>> +       int count;
>> +
>> +       count = drm_add_modes_noedid(connector, 800, 600);
>> +       drm_set_preferred_mode(connector, defx, defy);
>
> So you have defx/defy as module parameters, but then hardcode the
> 800x600 mode. If defx/defy is anything other than 800/600, this won't
> work. I think you should just remove the defx/defy module params and
> rely on userspace adding modes as appropriate.

will remove them, thanks.

>
>> +       return count;
>> +}
>> +
>> +static int hibmc_connector_mode_valid(struct drm_connector *connector,
>> +                                     struct drm_display_mode *mode)
>> +{
>> +       struct hibmc_drm_device *hiprivate =
>> +        container_of(connector, struct hibmc_drm_device, connector);
>> +       unsigned long size = mode->hdisplay * mode->vdisplay * 4;
>
> Why * 4 here and why * 2 below? You support formats less than 32 bpp,
> so the * 4 isn't necessarily correct for all formats. Is the * 2 to
> account for front & back buffer?
>

it is from bochs, the original comments below:
	/*
	 * Make sure we can fit two framebuffers into video memory.
	 * This allows up to 1600x1200 with 16 MB (default size).
	 * If you want more try this:
	 *     'qemu -vga std -global VGA.vgamem_mb=32 $otherargs'
	 */
i think it is not necessary for hibmc, so will remove it and return
MODE_OK, thanks.

>
>> +
>> +       if (size * 2 > hiprivate->fb_size)
>> +               return MODE_BAD;
>> +
>> +       return MODE_OK;
>> +}
>> +
>> +static struct drm_encoder *
>> +hibmc_connector_best_encoder(struct drm_connector *connector)
>> +{
>> +       int enc_id = connector->encoder_ids[0];
>> +
>> +       /* pick the encoder ids */
>> +       if (enc_id)
>> +               return drm_encoder_find(connector->dev, enc_id);
>
> Can't you just do return drm_encoder_find(connector->dev,
> connector->encoder_ids[0]); ?
>
> ie: won't drm_encoder_find do the right thing if you pass in id == 0?

hibmc_connector_best_encoder(struct drm_connector *connector)
{
	return drm_encoder_find(connector->dev, connector->encoder_ids[0]);
}
looks more simple, i like it, thanks:)

>
>> +
>> +       return NULL;
>> +}
>> +
>> +static enum drm_connector_status hibmc_connector_detect(struct drm_connector
>> +                                                *connector, bool force)
>> +{
>> +       return connector_status_connected;
>
> Perhaps this should be connector_status_unknown, since you don't
> necessarily know it's connected.

it is always connected in hibmc's scenario, usually it is used as a
management chip on server, we use KVM(keyboard, mouse, video) rather than
a directly connected monitor. I will modify if a phisical monitor
is connected later.

>
>> +}
>> +
>> +static const struct drm_connector_helper_funcs
>> +       hibmc_connector_connector_helper_funcs = {
>> +       .get_modes = hibmc_connector_get_modes,
>> +       .mode_valid = hibmc_connector_mode_valid,
>> +       .best_encoder = hibmc_connector_best_encoder,
>> +};
>> +
>> +static const struct drm_connector_funcs hibmc_connector_connector_funcs = {
>> +       .dpms = drm_atomic_helper_connector_dpms,
>> +       .detect = hibmc_connector_detect,
>> +       .fill_modes = drm_helper_probe_single_connector_modes,
>> +       .destroy = drm_connector_cleanup,
>> +       .reset = drm_atomic_helper_connector_reset,
>> +       .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>> +       .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>> +};
>> +
>> +int hibmc_connector_init(struct hibmc_drm_device *hidev)
>> +{
>> +       struct drm_device *dev = hidev->dev;
>> +       struct drm_connector *connector = &hidev->connector;
>> +       int ret;
>> +
>> +       ret = drm_connector_init(dev, connector,
>> +                                &hibmc_connector_connector_funcs,
>> +                                DRM_MODE_CONNECTOR_VGA);
>> +       if (ret) {
>> +               DRM_ERROR("failed to init connector\n");
>> +               return ret;
>> +       }
>> +       drm_connector_helper_add(connector,
>> +                                &hibmc_connector_connector_helper_funcs);
>> +
>> +       return 0;
>> +}
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> _______________________________________________
> linuxarm mailing list
> linuxarm at huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
>
> .
>


-- 
Regards, Rongrong
