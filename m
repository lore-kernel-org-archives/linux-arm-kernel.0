From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 9 Jan 2017 14:25:42 +0100
Subject: [PATCH v3 5/5] drm/rockchip: Implement CRC debugfs API
In-Reply-To: <CAOw6vbLAwzrwfHdny=-RYrUE7wBksqwkOxatJ1=_HMojQLPm4w@mail.gmail.com>
References: <20170106143029.11553-1-tomeu.vizoso@collabora.com>
 <20170106143029.11553-6-tomeu.vizoso@collabora.com>
 <CAOw6vbLAwzrwfHdny=-RYrUE7wBksqwkOxatJ1=_HMojQLPm4w@mail.gmail.com>
Message-ID: <CAAObsKCCFic7ReS=Jxsiko2G_o2gTXVV6cyfG_B+ra9oOQaq-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 January 2017 at 16:56, Sean Paul <seanpaul@chromium.org> wrote:
> On Fri, Jan 6, 2017 at 9:30 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>> Implement the .set_crc_source() callback and call the DP helpers
>> accordingly to start and stop CRC capture.
>>
>> This is only done if this CRTC is currently using the eDP connector.
>>
>> v3: Remove superfluous check on rockchip_crtc_state->output_type
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>
>>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 48 +++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> index fb5f001f51c3..5e19bef6d5b4 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> @@ -19,6 +19,7 @@
>>  #include <drm/drm_crtc_helper.h>
>>  #include <drm/drm_flip_work.h>
>>  #include <drm/drm_plane_helper.h>
>> +#include <drm/bridge/analogix_dp.h>
>>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>> @@ -1105,6 +1106,52 @@ static void vop_crtc_destroy_state(struct drm_crtc *crtc,
>>         kfree(s);
>>  }
>>
>> +static struct drm_connector *vop_get_edp_connector(struct vop *vop)
>> +{
>> +       struct drm_crtc *crtc = &vop->crtc;
>> +       struct drm_connector *connector;
>> +
>> +       mutex_lock(&crtc->dev->mode_config.mutex);
>> +       drm_for_each_connector(connector, crtc->dev)
>> +               if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
>> +                       mutex_unlock(&crtc->dev->mode_config.mutex);
>> +                       return connector;
>> +               }
>> +       mutex_unlock(&crtc->dev->mode_config.mutex);
>> +
>> +       return NULL;
>> +}
>> +
>> +static int vop_crtc_set_crc_source(struct drm_crtc *crtc,
>> +                                  const char *source_name, size_t *values_cnt)
>> +{
>> +       struct vop *vop = to_vop(crtc);
>> +       struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc->state);
>> +       struct drm_connector *connector;
>> +       int ret;
>> +
>> +       connector = vop_get_edp_connector(vop);
>> +       if (!connector)
>> +               return -EINVAL;
>> +
>> +       *values_cnt = 3;
>> +
>> +       if (source_name &&
>> +           strcmp(source_name, "auto") == 0) {
>> +
>> +               if (s->output_type != DRM_MODE_CONNECTOR_eDP)
>> +                       return -EINVAL;
>> +
>> +               ret = analogix_dp_start_crc(connector);
>
> To pick up my thoughts from 1/5, you could do the following instead:
>
> analogix_dp_start_crc(drm_crtc_index(crtc));

Well, I still need the dpaux to access the dpcd, so that would have to be:

analogix_dp_start_crc(connector, drm_crtc_index(crtc));

Regards,

Tomeu

>> +       } else if (!source_name)
>> +
>> +               ret = analogix_dp_stop_crc(connector);
>> +       else
>> +               ret = -EINVAL;
>> +
>> +       return ret;
>> +}
>> +
>>  static const struct drm_crtc_funcs vop_crtc_funcs = {
>>         .set_config = drm_atomic_helper_set_config,
>>         .page_flip = drm_atomic_helper_page_flip,
>> @@ -1112,6 +1159,7 @@ static const struct drm_crtc_funcs vop_crtc_funcs = {
>>         .reset = vop_crtc_reset,
>>         .atomic_duplicate_state = vop_crtc_duplicate_state,
>>         .atomic_destroy_state = vop_crtc_destroy_state,
>> +       .set_crc_source = vop_crtc_set_crc_source,
>>  };
>>
>>  static void vop_fb_unref_worker(struct drm_flip_work *work, void *val)
>> --
>> 2.9.3
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
> --
> Sean Paul, Software Engineer, Google / Chromium OS
