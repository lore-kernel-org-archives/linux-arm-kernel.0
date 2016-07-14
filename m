From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 14 Jul 2016 07:02:22 -0700
Subject: [v5 PATCH 5/5] drm/rockchip: cdn-dp: add cdn DP support for rk3399
In-Reply-To: <57870210.4020307@rock-chips.com>
References: <1468336188-565-1-git-send-email-zyw@rock-chips.com>
 <1468336188-565-6-git-send-email-zyw@rock-chips.com>
 <CAOw6vb+=F=X1MeWhUbs42MzP_CFfMkYrFUqKmWjVwwohufFOhw@mail.gmail.com>
 <57870210.4020307@rock-chips.com>
Message-ID: <CAOw6vbKCCoQHO-4TB3qCOuAA09aheXx0H6jRjQQnrkb4KqmtCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 8:08 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> Hi Sean
>
> Thanks for your detailed review. I'm working to modify most of code
> according to comment.
> And there is reply for some comment
>
> On 07/13/2016 09:59 PM, Sean Paul wrote:
>>
>> On Tue, Jul 12, 2016 at 8:09 AM, Chris Zhong <zyw@rock-chips.com> wrote:
>>>
>>> Add support for cdn DP controller which is embedded in the rk3399
>>> SoCs. The DP is compliant with DisplayPort Specification,
>>> Version 1.3, This IP is compatible with the rockchip type-c PHY IP.
>>> There is a uCPU in DP controller, it need a firmware to work,
>>> please put the firmware file to /lib/firmware/cdn/dptx.bin. The
>>> uCPU in charge of aux communication and link training, the host use
>>> mailbox to communicate with the ucpu.
>>> The dclk pin_pol of vop must not be invert for DP.
>>>
>>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>>>
>>> ---
>>>
>>> Changes in v5:
>>> - alphabetical order
>>> - do not use long, use u32 or u64
>>> - return MODE_CLOCK_HIGH when requested > actual
>>> - Optimized Coding Style
>>> - add a formula to get better tu size and symbol value.
>>>
>>> Changes in v4:
>>> - use phy framework to control DP phy
>>> - support 2 phys
>>>
>>> Changes in v3:
>>> - use EXTCON_DISP_DP and EXTCON_DISP_DP_ALT cable to get dp port state.
>>> - reset spdif before config it
>>> - modify the firmware clk to 100Mhz
>>> - retry load firmware if fw file is requested too early
>>>
>>> Changes in v2:
>>> - Alphabetic order
>>> - remove excess error message
>>> - use define clk_rate
>>> - check all return value
>>> - remove dev_set_name(dp->dev, "cdn-dp");
>>> - use schedule_delayed_work
>>> - remove never-called functions
>>> - remove some unnecessary ()
>>>
>>> Changes in v1:
>>> - use extcon API
>>> - use hdmi-codec for the DP Asoc
>>> - do not initialize the "ret"
>>> - printk a err log when drm_of_encoder_active_endpoint_id
>>> - modify the dclk pin_pol to a single line
>>>
>>>   drivers/gpu/drm/rockchip/Kconfig            |   9 +
>>>   drivers/gpu/drm/rockchip/Makefile           |   1 +
>>>   drivers/gpu/drm/rockchip/cdn-dp-core.c      | 761
>>> ++++++++++++++++++++++++++++
>>>   drivers/gpu/drm/rockchip/cdn-dp-core.h      | 113 +++++
>>>   drivers/gpu/drm/rockchip/cdn-dp-reg.c       | 740
>>> +++++++++++++++++++++++++++
>>>   drivers/gpu/drm/rockchip/cdn-dp-reg.h       | 409 +++++++++++++++
>>
>> Could you explain the file naming convention in the rk driver? We've
>> got analogix_dp-rockchip.c, dw_hdmi-rockchip.c, dw-mipi-dsi.c, and now
>> cdn-dp-(core|reg).[ch]. I'm honestly not sure whether these filenames
>> are consistent with the rest, but bleh.
>>
> cdn is the IP vendor's name
> dp is the controller's name.
>
>>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   6 +-
>>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   2 +
>>>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c |   2 +
>>>   9 files changed, 2042 insertions(+), 1 deletion(-)
>>>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.c
>>>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.h
>>>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c
>>>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.h
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/Kconfig
>>> b/drivers/gpu/drm/rockchip/Kconfig
>>> index d30bdc3..20da9a8 100644
>>> --- a/drivers/gpu/drm/rockchip/Kconfig
>>> +++ b/drivers/gpu/drm/rockchip/Kconfig
>>> @@ -25,6 +25,15 @@ config ROCKCHIP_ANALOGIX_DP
>>>            for the Analogix Core DP driver. If you want to enable DP
>>>            on RK3288 based SoC, you should selet this option.
>>>
>>> +config ROCKCHIP_CDN_DP
>>> +        tristate "Rockchip cdn DP"
>>> +        depends on DRM_ROCKCHIP
>>> +        help
>>> +         This selects support for Rockchip SoC specific extensions
>>> +         for the cdn Dp driver. If you want to enable Dp on
>>
>> s/Dp/DP/
>>
>>> +         RK3399 based SoC, you should selet this
>>
>> s/selet/select/
>>
>>> +         option.
>>> +
>>>   config ROCKCHIP_DW_HDMI
>>>           tristate "Rockchip specific extensions for Synopsys DW HDMI"
>>>           depends on DRM_ROCKCHIP
>>> diff --git a/drivers/gpu/drm/rockchip/Makefile
>>> b/drivers/gpu/drm/rockchip/Makefile
>>> index 05d0713..abdecd5 100644
>>> --- a/drivers/gpu/drm/rockchip/Makefile
>>> +++ b/drivers/gpu/drm/rockchip/Makefile
>>> @@ -7,6 +7,7 @@ rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o \
>>>   rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
>>>
>>>   obj-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
>>> +obj-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o
>>>   obj-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
>>>   obj-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
>>>   obj-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
>>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c
>>> b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>>> new file mode 100644
>>> index 0000000..5b8a15e
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>>> @@ -0,0 +1,761 @@
>>> +/*
>>> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
>>> + * Author: Chris Zhong <zyw@rock-chips.com>
>>> + *
>>> + * This software is licensed under the terms of the GNU General Public
>>> + * License version 2, as published by the Free Software Foundation, and
>>> + * may be copied, distributed, and modified under those terms.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#include <drm/drmP.h>
>>> +#include <drm/drm_atomic_helper.h>
>>> +#include <drm/drm_crtc_helper.h>
>>> +#include <drm/drm_dp_helper.h>
>>> +#include <drm/drm_edid.h>
>>> +#include <drm/drm_of.h>
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/component.h>
>>> +#include <linux/extcon.h>
>>> +#include <linux/firmware.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/reset.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/phy/phy.h>
>>> +
>>> +#include <sound/hdmi-codec.h>
>>> +
>>> +#include <video/of_videomode.h>
>>> +#include <video/videomode.h>
>>
>> Doesn't seem like you use these.
>>
>>
>>> +
>>> +#include "cdn-dp-core.h"
>>> +#include "cdn-dp-reg.h"
>>> +#include "rockchip_drm_vop.h"
>>> +
>>> +#define connector_to_dp(c) \
>>> +               container_of(c, struct cdn_dp_device, connector)
>>> +
>>> +#define encoder_to_dp(c) \
>>> +               container_of(c, struct cdn_dp_device, encoder)
>>> +
>>> +/* dp grf register offset */
>>> +#define DP_VOP_SEL             0x6224
>>> +#define DP_SEL_VOP_LIT         BIT(12)
>>> +#define DP_CLK_RATE            100000000
>>
>> If this clock rate never changes, it should probably live somewhere in
>> the clock driver.
>
>
>
>>
>>> +#define WAIT_HPD_STABLE                300
>>
>> Encode the units in these two define names, ie: DP_CLK_RATE_HZ,
>> WAIT_HPD_STABLE_MS
>>
>>> +
>>> +static int cdn_dp_clk_enable(struct cdn_dp_device *dp)
>>> +{
>>> +       int ret;
>>> +
>>> +       ret = clk_prepare_enable(dp->pclk);
>>> +       if (ret < 0) {
>>> +               dev_err(dp->dev, "cannot enable dp pclk %d\n", ret);
>>> +               goto err_pclk;
>>> +       }
>>> +
>>> +       ret = clk_prepare_enable(dp->core_clk);
>>> +       if (ret < 0) {
>>> +               dev_err(dp->dev, "cannot enable core_clk %d\n", ret);
>>> +               goto err_core_clk;
>>> +       }
>>> +
>>> +       ret = clk_set_rate(dp->core_clk, DP_CLK_RATE);
>>> +       if (ret < 0) {
>>> +               dev_err(dp->dev, "cannot set dp core clk to %d %d\n",
>>> +                       DP_CLK_RATE, ret);
>>> +               goto err_set_rate;
>>> +       }
>>> +
>>> +       /* notice fw the clk freq value */
>>
>> This might be clearer if it was rephrased to "update fw with the
>> current core clk frequency". I still think the rate should be set in
>> the clock driver, and perhaps you can query the rate to get the
>> current value.
>
> This function is setting the controller register, it let the uCPU know what
> freq it is, then the uCPU use this value to do something.
>

I think that's consistent with my suggestion. Either way, this comment
doesn't make sense, so please either remove it or improve it.

>>
>>> +       cdn_dp_set_fw_clk(dp, DP_CLK_RATE);
>>> +
>>> +       return 0;
>>> +
>>> +err_set_rate:
>>> +       clk_disable_unprepare(dp->core_clk);
>>> +err_core_clk:
>>> +       clk_disable_unprepare(dp->pclk);
>>> +err_pclk:
>>> +       return ret;
>>> +}
>>> +
>>> +static enum drm_connector_status
>>> +cdn_dp_connector_detect(struct drm_connector *connector, bool force)
>>> +{
>>> +       struct cdn_dp_device *dp = connector_to_dp(connector);
>>> +
>>> +       return dp->hpd_status ? connector_status_connected :
>>> +                               connector_status_disconnected;
>>
>> If you just stored hpd_status as drm_connector_status, you could avoid
>> having to translate the bool.
>>
>>> +}
>>> +
>>> +static void cdn_dp_connector_destroy(struct drm_connector *connector)
>>> +{
>>> +       drm_connector_unregister(connector);
>>> +       drm_connector_cleanup(connector);
>>> +}
>>> +
>>> +static struct drm_connector_funcs cdn_dp_atomic_connector_funcs = {
>>> +       .dpms = drm_atomic_helper_connector_dpms,
>>> +       .detect = cdn_dp_connector_detect,
>>> +       .destroy = cdn_dp_connector_destroy,
>>> +       .fill_modes = drm_helper_probe_single_connector_modes,
>>> +       .reset = drm_atomic_helper_connector_reset,
>>> +       .atomic_duplicate_state =
>>> drm_atomic_helper_connector_duplicate_state,
>>> +       .atomic_destroy_state =
>>> drm_atomic_helper_connector_destroy_state,
>>> +};
>>> +
>>> +static int cdn_dp_connector_get_modes(struct drm_connector *connector)
>>> +{
>>> +       struct cdn_dp_device *dp = connector_to_dp(connector);
>>> +       struct edid *edid;
>>> +
>>> +       if (!dp->fw_loaded)
>>
>> Can this actually happen? Seems like we shouldn't be returning
>> connected from detect if the fw isn't loaded, so this should never be
>> true. If that is the case, I think BUG_ON or WARN_ON would be more
>> appropriate here.
>>
>>
>>> +               return 0;
>>> +
>>> +       edid = drm_do_get_edid(connector, cdn_dp_get_edid_block, dp);
>>> +       if (edid) {
>>> +               dev_dbg(dp->dev, "got edid: width[%d] x height[%d]\n",
>>> +                       edid->width_cm, edid->height_cm);
>>> +
>>> +               dp->sink_has_audio = drm_detect_monitor_audio(edid);
>>> +               drm_mode_connector_update_edid_property(connector, edid);
>>> +               drm_add_edid_modes(connector, edid);
>>> +               /* Store the ELD */
>>
>> This comment isn't useful
>>
>>> +               drm_edid_to_eld(connector, edid);
>>> +               kfree(edid);
>>> +       } else {
>>> +               dev_dbg(dp->dev, "failed to get edid\n");
>>
>> This seems to warrant a stronger level than dbg, perhaps warn. Also,
>> should this really return success?
>>
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static struct drm_encoder *
>>> +       cdn_dp_connector_best_encoder(struct drm_connector *connector)
>>> +{
>>> +       struct cdn_dp_device *dp = connector_to_dp(connector);
>>> +
>>> +       return &dp->encoder;
>>> +}
>>> +
>>> +static int cdn_dp_connector_mode_valid(struct drm_connector *connector,
>>> +                                      struct drm_display_mode *mode)
>>> +{
>>> +       struct cdn_dp_device *dp = connector_to_dp(connector);
>>> +       struct drm_display_info *display_info =
>>> &dp->connector.display_info;
>>> +       u32 requested = mode->clock * display_info->bpc * 3 / 1000;
>>> +       u32 actual, rate;
>>> +
>>> +       rate = drm_dp_bw_code_to_link_rate(dp->link.rate);
>>> +       actual = rate * dp->link.num_lanes / 100;
>>> +
>>> +       /* efficiency is about 0.8 */
>>> +       actual = actual * 8 / 10;
>>> +
>>> +       if (requested > actual) {
>>> +               dev_dbg(dp->dev, "requested=%d, actual=%d, clock=%d\n",
>>> +                       requested, actual, mode->clock);
>>> +               return MODE_CLOCK_HIGH;
>>> +       }
>>
>> This doesn't seem like something that is likely to happen given the
>> trained rate should be a function of the display that's attached. Is
>> that correct?
>
> Yes, the link training should be a function of the display. But sometimes
> the edid give
> us a excess size for default resolution, it need somewhere to do this mode
> valid checking.
> Maybe we can do it at mode_set.
>

That's kind of interesting. You've seen displays which give you a lane
count that is insufficient for the modes it provides in the edid?
You're always training at 5.4 GHz, so I wouldn't expect this.

> ...
>>
>>
>>> +       hdr = (struct cdn_firmware_header *)fw->data;
>>> +       if (fw->size != le32_to_cpu(hdr->size_bytes))
>>> +               return -EINVAL;
>>> +
>>> +       iram_data = (const u32 *)(fw->data + hdr->header_size);
>>> +       dram_data = (const u32 *)(fw->data + hdr->header_size +
>>> hdr->iram_size);
>>> +
>>> +       ret = cdn_dp_load_firmware(dp, iram_data, hdr->iram_size,
>>> +                                  dram_data, hdr->dram_size);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       release_firmware(fw);
>>
>> Move this out of here and into the same scope as request_firmware so
>> there are no leaks.
>>
>>> +
>>> +       ret = cdn_dp_active(dp, true);
>>> +       if (ret) {
>>> +               dev_err(dp->dev, "active ucpu failed: %d\n", ret);
>>> +               return ret;
>>> +       }
>>> +
>>> +       return cdn_dp_event_config(dp);
>>> +}
>>> +
>>> +static int cdn_dp_init(struct cdn_dp_device *dp)
>>> +{
>>> +       struct device *dev = dp->dev;
>>> +       struct device_node *np = dev->of_node;
>>> +       struct platform_device *pdev = to_platform_device(dev);
>>> +       struct resource *res;
>>> +       int ret;
>>> +
>>> +       dp->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
>>> +       if (IS_ERR(dp->grf)) {
>>> +               dev_err(dev, "cdn-dp needs rockchip,grf property\n");
>>> +               return PTR_ERR(dp->grf);
>>> +       }
>>> +
>>> +       dp->irq = platform_get_irq(pdev, 0);
>>> +       if (dp->irq < 0) {
>>> +               dev_err(dev, "cdn-dp can not get irq\n");
>>> +               return dp->irq;
>>> +       }
>>> +
>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +       dp->regs = devm_ioremap_resource(dev, res);
>>> +       if (IS_ERR(dp->regs)) {
>>> +               dev_err(dev, "ioremap reg failed\n");
>>> +               return PTR_ERR(dp->regs);
>>> +       }
>>> +
>>> +       dp->core_clk = devm_clk_get(dev, "core-clk");
>>> +       if (IS_ERR(dp->core_clk)) {
>>> +               dev_err(dev, "cannot get core_clk_dp\n");
>>> +               return PTR_ERR(dp->core_clk);
>>> +       }
>>> +
>>> +       dp->pclk = devm_clk_get(dev, "pclk");
>>> +       if (IS_ERR(dp->pclk)) {
>>> +               dev_err(dev, "cannot get pclk\n");
>>> +               return PTR_ERR(dp->pclk);
>>> +       }
>>> +
>>> +       dp->spdif_clk = devm_clk_get(dev, "spdif");
>>> +       if (IS_ERR(dp->spdif_clk)) {
>>> +               dev_err(dev, "cannot get spdif_clk\n");
>>> +               return PTR_ERR(dp->spdif_clk);
>>> +       }
>>> +
>>> +       dp->spdif_rst = devm_reset_control_get(dev, "spdif");
>>> +       if (IS_ERR(dp->spdif_rst)) {
>>> +               dev_err(dev, "no spdif reset control found\n");
>>> +               return PTR_ERR(dp->spdif_rst);
>>> +       }
>>> +
>>> +       dp->dpms_mode = DRM_MODE_DPMS_OFF;
>>> +
>>> +       ret = cdn_dp_clk_enable(dp);
>>> +       if (ret < 0)
>>> +               return ret;
>>> +
>>> +       dp_clock_reset_seq(dp);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int cdn_dp_audio_hw_params(struct device *dev,
>>> +                                 struct hdmi_codec_daifmt *daifmt,
>>> +                                 struct hdmi_codec_params *params)
>>> +{
>>> +       struct cdn_dp_device *dp = dev_get_drvdata(dev);
>>> +       struct audio_info audio = {
>>> +               .sample_width = params->sample_width,
>>> +               .sample_rate = params->sample_rate,
>>> +               .channels = params->channels,
>>> +       };
>>> +       int ret;
>>> +
>>> +       if (!dp->encoder.crtc)
>>> +               return -ENODEV;
>>> +
>>> +       switch (daifmt->fmt) {
>>> +       case HDMI_I2S:
>>> +               audio.format = AFMT_I2S;
>>> +               break;
>>> +       case HDMI_SPDIF:
>>> +               audio.format = AFMT_SPDIF;
>>> +               break;
>>> +       default:
>>> +               dev_err(dev, "%s: Invalid format %d\n", __func__,
>>> daifmt->fmt);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       ret = cdn_dp_audio_config_set(dp, &audio);
>>> +       if (!ret)
>>> +               dp->audio_info = audio;
>>> +
>>> +       return ret;
>>> +}
>>> +
>>> +static void cdn_dp_audio_shutdown(struct device *dev)
>>> +{
>>> +       struct cdn_dp_device *dp = dev_get_drvdata(dev);
>>> +       int ret = cdn_dp_audio_stop(dp, &dp->audio_info);
>>> +
>>> +       if (!ret)
>>> +               dp->audio_info.format = AFMT_UNUSED;
>>> +}
>>> +
>>> +static int cdn_dp_audio_digital_mute(struct device *dev, bool enable)
>>> +{
>>> +       struct cdn_dp_device *dp = dev_get_drvdata(dev);
>>> +
>>> +       return cdn_dp_audio_mute(dp, enable);
>>> +}
>>> +
>>> +static int cdn_dp_audio_get_eld(struct device *dev, uint8_t *buf, size_t
>>> len)
>>> +{
>>> +       struct cdn_dp_device *dp = dev_get_drvdata(dev);
>>> +       struct drm_mode_config *config = &dp->encoder.dev->mode_config;
>>> +       struct drm_connector *connector;
>>> +       int ret = -ENODEV;
>>> +
>>> +       mutex_lock(&config->mutex);
>>> +       list_for_each_entry(connector, &config->connector_list, head) {
>>> +               if (&dp->encoder == connector->encoder) {
>>> +                       memcpy(buf, connector->eld,
>>> +                              min(sizeof(connector->eld), len));
>>> +                       ret = 0;
>>> +               }
>>> +       }
>>> +       mutex_unlock(&config->mutex);
>>> +
>>> +       return ret;
>>> +}
>>> +
>>> +static const struct hdmi_codec_ops audio_codec_ops = {
>>> +       .hw_params = cdn_dp_audio_hw_params,
>>> +       .audio_shutdown = cdn_dp_audio_shutdown,
>>> +       .digital_mute = cdn_dp_audio_digital_mute,
>>> +       .get_eld = cdn_dp_audio_get_eld,
>>> +};
>>> +
>>> +static int cdn_dp_audio_codec_init(struct cdn_dp_device *dp,
>>> +                                  struct device *dev)
>>> +{
>>> +       struct hdmi_codec_pdata codec_data = {
>>> +               .i2s = 1,
>>> +               .spdif = 1,
>>> +               .ops = &audio_codec_ops,
>>> +               .max_i2s_channels = 8,
>>> +       };
>>> +
>>> +       dp->audio_pdev = platform_device_register_data(
>>> +                        dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
>>> +                        &codec_data, sizeof(codec_data));
>>> +
>>> +       return PTR_ERR_OR_ZERO(dp->audio_pdev);
>>> +}
>>> +
>>> +static void cdn_dp_get_state(struct cdn_dp_device *dp, struct extcon_dev
>>> *edev)
>>> +{
>>> +       bool dfp, dptx;
>>> +       u8 cap_lanes;
>>> +
>>> +       dfp = extcon_get_cable_state_(edev, EXTCON_USB_HOST);
>>> +       dptx = extcon_get_cable_state_(edev, EXTCON_DISP_DP);
>>> +
>>> +       if (dfp && dptx)
>>> +               cap_lanes = 2;
>>> +       else if (dptx)
>>> +               cap_lanes = 4;
>>> +       else
>>> +               cap_lanes = 0;
>>> +
>>> +       if (cap_lanes != dp->cap_lanes) {
>>> +               dp->cap_lanes = cap_lanes;
>>> +               schedule_delayed_work(&dp->event_wq, 0);
>>> +       }
>>
>> A get function shouldn't be scheduling work. Keep the assignment here
>> and move the schedule into the pd_event function.
>>
>>> +}
>>> +
>>> +static int cdn_dp_pd_event(struct notifier_block *nb,
>>> +                          unsigned long event, void *priv)
>>> +{
>>> +       struct cdn_dp_device *dp;
>>> +       struct extcon_dev *edev = priv;
>>> +       u8 i;
>>> +
>>> +       dp = container_of(nb, struct cdn_dp_device, event_nb);
>>> +
>>> +       for (i = 0; i < MAX_PHY; i++) {
>>> +               if (edev == dp->extcon[i]) {
>>> +                       dp->port_id = i;
>>> +                       break;
>>> +               }
>>> +       }
>>> +
>>> +       cdn_dp_get_state(dp, edev);
>>
>> There's a race here. If the cap_lanes change in between scheduling the
>> work and the work function running (ie, plug/unplug), the work
>> function will have out-of-date information. You should call this from
>> the work function instead.
>>
>>
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static void cdn_dp_pd_event_wq(struct work_struct *work)
>>> +{
>>> +       struct cdn_dp_device *dp;
>>> +       int ret;
>>> +
>>> +       dp = container_of(work, struct cdn_dp_device, event_wq.work);
>>> +
>>> +       ret = request_firmware(&dp->fw, "cdn/dptx.bin", dp->dev);
>>
>> This filename needs to be abstracted into a #define.
>>
>> You're also failing to call release_firmware in a bunch of cases
>> below. It needs to be sorted out.
>>
>>
>>> +       if (ret == -ENOENT && !dp->fw_loaded) {
>>
>> So the case where ret == -ENOENT and dp->fw_loaded is valid? Or is that a
>> bug?
>>
>> I'm not convinced you need fw_loaded stored in cdn_dp_device. It seems
>> like something you could either get rid of (hopefully), or convert to
>> a local.
>
> it is not bug, "ret == -ENOENT" is for file missing, maybe user space is not
> ready.
>
> if dp->fw_loaded it means the firmware has been loaded, do not load again.
>

So how can the fw be already loaded and yet the fw file is missing?

>
>>
>>> +               /*
>>> +                * If can not find the file, retry to load the firmware
>>> in 1
>>> +                * second, if still failed after 1 minute, give up.
>>> +                */
>>> +               if (dp->fw_retry++ < 60) {
>>> +                       schedule_delayed_work(&dp->event_wq,
>>> +                                             msecs_to_jiffies(HZ));
>>
>> I'd rather do this as an exponential back-off so if it doesn't find
>> the file, it waits progressively longer.
>>
>> Perhaps something like:
>>
>> #define MAX_FW_WAIT_SECS 64
>>
>> [...]
>>
>> if (dp->fw_wait <= MAX_FW_WAIT_SECS) {
>>    schedule_delayed_work(&dp_>event_wq, msecs_to_jiffies(dp->fw_wait *
>> HZ));
>>    dp->fw_wait *= 2;
>> }
>
> If so, sometimes boot with DP will later than boot and then plug DP cable.
>

Yeah, I realize that. It's a trade-off between waking up every second
vs potentially delaying the external display coming up. I think I'm Ok
with the external display taking a bit longer.


>
>>> +               }
>>> +
>>> +               dev_err(dp->dev, "failed to request firmware %d\n", ret);
>>
>> Print the wait/retries.
>>
>>> +               return;
>>> +       }
>>> +
>>> +       if (!dp->cap_lanes) {
>>> +               if (dp->phy_status[dp->port_id])
>>> +                       phy_power_off(dp->phy[dp->port_id]);
>>> +               dp->phy_status[dp->port_id] = 0;
>>> +               dp->hpd_status = false;
>>> +               drm_helper_hpd_irq_event(dp->drm_dev);
>>> +               return;
>>> +       }
>>> +
>>> +       if (!dp->phy_status[dp->port_id]) {
>>> +               ret = phy_power_on(dp->phy[dp->port_id]);
>>> +               if (ret)
>>
>> Log something in this case
>>
>>> +                       return;
>>> +
>>> +               msleep(WAIT_HPD_STABLE);
>>
>> 300ms is a long time, do we really need to wait that long?
>
> The 300ms is a safe value, maybe this time can be reduced
>

Yeah, the DisplayPort spec states the HPD pulse should be considered a
plug event after 2ms, so I strongly suspect this can be pulled in.

>>
>>> +       }
>>> +
>>> +       dp->phy_status[dp->port_id] = 1;
>>
>> Do you really need phy_status? It seems like if things are
>> well-behaved you shouldn't need it. Of course, if you're turning
>> on/off multiple times, perhaps there's a bug elsewhere.
>
> This status is needed, since the phy_power_on would increase the
> power_count, this status can avoid power on multiple times
>

Yeah, I realize the phy_power is refcounted. Why do you have unmatched
on/off calls?

>>
>>> +
>>> +       ret = cdn_dp_firmware_init(dp);
>>> +       if (ret)
>>> +               return;
>>> +
>>> +       /* read hpd status failed, or the hpd does not exist. */
>>> +       ret = cdn_dp_get_hpd_status(dp);
>>> +       if (ret <= 0)
>>
>> Log something?
>>
>>> +               return;
>>> +
>>> +       /*
>>> +        * Set the capability and start the training process once
>>> +        * the hpd is detected.
>>> +        */
>>> +       ret = cdn_dp_set_host_cap(dp);
>>> +       if (ret) {
>>> +               dev_err(dp->dev, "set host capabilities failed\n");
>>
>> print ret
>>
>>> +               return;
>>> +       }
>>> +
>>> +       ret = cdn_dp_training_start(dp);
>>> +       if (ret) {
>>> +               dev_err(dp->dev, "hw lt err:%d\n", ret);
>>
>> s/lt/link training/
>>
>>> +               return;
>>> +       }
>>> +
>>> +       ret = cdn_dp_get_lt_status(dp);
>>
>> Change to cdn_dp_get_training_status
>>
>>> +       if (ret) {
>>> +               dev_err(dp->dev, "hw lt get status failed\n");
>>
>> print ret
>>
>>> +               return;
>>> +       }
>>> +
>>> +       dev_info(dp->dev, "rate:%d, lanes:%d\n",
>>> +                dp->link.rate, dp->link.num_lanes);
>>> +
>>
>> I think everything from cdn_dp_firmare_init to here should be moved
>> out of the wq and deferred until modeset time. That way you're
>> training the link at the same time as you're setting the mode, which
>> should obviate the need to check the clocks in mode_valid.
>
>
> cdn_dp_training_start and cdn_dp_get_lt_status can be move the mode_set,
> but the others are need by get_modes, so stay here is better.
>

Ok, that sounds like an improvement.

>>
>>> +       dp->hpd_status = true;
>>> +       drm_helper_hpd_irq_event(dp->drm_dev);
>>> +}
>>> +
>>> +static int cdn_dp_bind(struct device *dev, struct device *master,
>>> +                      void *data)
>>> +{
>>> +       struct cdn_dp_device *dp = dev_get_drvdata(dev);
>>> +       struct drm_encoder *encoder;
>>> +       struct drm_connector *connector;
>>> +       struct drm_device *drm_dev = data;
>>> +       int ret, i;
>>> +
>>> +       ret = cdn_dp_init(dp);
>>> +       if (ret < 0)
>>> +               return ret;
>>> +
>>> +       dp->drm_dev = drm_dev;
>>> +
>>> +       encoder = &dp->encoder;
>>> +
>>> +       encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
>>> +
>>> dev->of_node);
>>> +       DRM_DEBUG_KMS("possible_crtcs = 0x%x\n",
>>> encoder->possible_crtcs);
>>> +
>>> +       ret = drm_encoder_init(drm_dev, encoder, &cdn_dp_encoder_funcs,
>>> +                              DRM_MODE_ENCODER_TMDS, NULL);
>>> +       if (ret) {
>>> +               DRM_ERROR("failed to initialize encoder with drm\n");
>>> +               return ret;
>>> +       }
>>> +
>>> +       drm_encoder_helper_add(encoder, &cdn_dp_encoder_helper_funcs);
>>> +
>>> +       connector = &dp->connector;
>>> +       connector->polled = DRM_CONNECTOR_POLL_HPD;
>>> +       connector->dpms = DRM_MODE_DPMS_OFF;
>>> +
>>> +       ret = drm_connector_init(drm_dev, connector,
>>> +                                &cdn_dp_atomic_connector_funcs,
>>> +                                DRM_MODE_CONNECTOR_DisplayPort);
>>> +       if (ret) {
>>> +               DRM_ERROR("failed to initialize connector with drm\n");
>>> +               goto err_free_encoder;
>>> +       }
>>> +
>>> +       drm_connector_helper_add(connector,
>>> &cdn_dp_connector_helper_funcs);
>>> +
>>> +       ret = drm_mode_connector_attach_encoder(connector, encoder);
>>> +       if (ret) {
>>> +               DRM_ERROR("failed to attach connector and encoder\n");
>>> +               goto err_free_connector;
>>> +       }
>>> +
>>> +       cdn_dp_audio_codec_init(dp, dev);
>>> +
>>> +       dp->event_nb.notifier_call = cdn_dp_pd_event;
>>> +       INIT_DELAYED_WORK(&dp->event_wq, cdn_dp_pd_event_wq);
>>> +
>>> +       for (i = 0; i < MAX_PHY; i++) {
>>> +               if (IS_ERR(dp->extcon[i]))
>>> +                       continue;
>>> +
>>> +               ret = extcon_register_notifier(dp->extcon[i],
>>> EXTCON_DISP_DP,
>>> +                                              &dp->event_nb);
>>> +               if (ret) {
>>> +                       dev_err(dev, "regitster EXTCON_DISP_DP notifier
>>> err\n");
>>> +                       return ret;
>>> +               }
>>> +
>>> +               cdn_dp_get_state(dp, dp->extcon[i]);
>>> +       }
>>> +
>>> +       return 0;
>>> +
>>> +err_free_connector:
>>> +       drm_connector_cleanup(connector);
>>> +err_free_encoder:
>>> +       drm_encoder_cleanup(encoder);
>>> +       return ret;
>>> +}
>>> +
>>> +static void cdn_dp_unbind(struct device *dev, struct device *master,
>>> void *data)
>>> +{
>>> +       struct cdn_dp_device *dp = dev_get_drvdata(dev);
>>> +       struct drm_encoder *encoder = &dp->encoder;
>>> +       int i;
>>> +
>>> +       platform_device_unregister(dp->audio_pdev);
>>> +       cdn_dp_encoder_disable(encoder);
>>> +       encoder->funcs->destroy(encoder);
>>> +       drm_connector_unregister(&dp->connector);
>>> +       drm_connector_cleanup(&dp->connector);
>>
>> just call connector->destroy() here
>>
>>> +       drm_encoder_cleanup(encoder);
>>
>> this is already called by encoder->destroy()
>>
>>> +
>>> +       for (i = 0; i < MAX_PHY; i++) {
>>> +               if (!IS_ERR(dp->extcon[i]))
>>> +                       extcon_unregister_notifier(dp->extcon[i],
>>> EXTCON_USB,
>>> +                                                  &dp->event_nb);
>>> +       }
>>> +}
>>> +
>>> +static const struct component_ops cdn_dp_component_ops = {
>>> +       .bind = cdn_dp_bind,
>>> +       .unbind = cdn_dp_unbind,
>>> +};
>>> +
>>> +static int cdn_dp_probe(struct platform_device *pdev)
>>> +{
>>> +       struct device *dev = &pdev->dev;
>>> +       struct cdn_dp_device *dp;
>>> +       u8 count = 0;
>>> +       int i;
>>> +
>>> +       dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
>>> +       if (!dp)
>>> +               return -ENOMEM;
>>> +       dp->dev = dev;
>>> +
>>> +       for (i = 0; i < MAX_PHY; i++) {
>>> +               dp->extcon[i] = extcon_get_edev_by_phandle(dev, i);
>>> +               dp->phy[i] = devm_of_phy_get_by_index(dev, dev->of_node,
>>> i);
>>> +
>>> +               if (!IS_ERR(dp->extcon[i]) && !IS_ERR(dp->phy[i]))
>>> +                       count++;
>>> +
>>> +               if (PTR_ERR(dp->extcon[i]) == -EPROBE_DEFER ||
>>> +                   PTR_ERR(dp->phy[i]) == -EPROBE_DEFER)
>>> +                       return -EPROBE_DEFER;
>>> +       }
>>> +
>>> +       if (!count) {
>>> +               dev_err(dev, "missing extcon or phy\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       dev_set_drvdata(dev, dp);
>>> +
>>> +       return component_add(dev, &cdn_dp_component_ops);
>>> +}
>>> +
>>> +static int cdn_dp_remove(struct platform_device *pdev)
>>> +{
>>> +       component_del(&pdev->dev, &cdn_dp_component_ops);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static const struct of_device_id cdn_dp_dt_ids[] = {
>>> +       { .compatible = "rockchip,rk3399-cdn-dp" },
>>> +       {}
>>> +};
>>> +
>>> +MODULE_DEVICE_TABLE(of, cdn_dp_dt_ids);
>>> +
>>> +static struct platform_driver cdn_dp_driver = {
>>> +       .probe = cdn_dp_probe,
>>> +       .remove = cdn_dp_remove,
>>> +       .driver = {
>>> +                  .name = "cdn-dp",
>>> +                  .owner = THIS_MODULE,
>>> +                  .of_match_table = of_match_ptr(cdn_dp_dt_ids),
>>> +       },
>>> +};
>>> +
>>> +module_platform_driver(cdn_dp_driver);
>>> +
>>> +MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
>>> +MODULE_DESCRIPTION("cdn DP Driver");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h
>>> b/drivers/gpu/drm/rockchip/cdn-dp-core.h
>>> new file mode 100644
>>> index 0000000..31ba22d
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
>>> @@ -0,0 +1,113 @@
>>> +/*
>>> + * Copyright (C) 2016 Chris Zhong <zyw@rock-chips.com>
>>> + * Copyright (C) 2016 ROCKCHIP, Inc.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#ifndef _ROCKCHIP_EDP_CORE_H
>>> +#define _ROCKCHIP_EDP_CORE_H
>>
>> I think the include guard should match the filename
>>
>>> +
>>> +#include <drm/drmP.h>
>>> +#include <drm/drm_crtc_helper.h>
>>> +#include <drm/drm_dp_helper.h>
>>> +#include <drm/drm_panel.h>
>>> +#include "rockchip_drm_drv.h"
>>> +#include "cdn-dp-reg.h"
>>> +
>>> +#define MAX_PHY                2
>>
>> This should probably be stored in the .data member of of_device_id.
>>
>>> +
>>> +enum AUDIO_FORMAT {
>>
>> enum audio_format
>>
>>> +       AFMT_I2S = 0,
>>> +       AFMT_SPDIF = 1,
>>> +       AFMT_UNUSED,
>>> +};
>>> +
>>> +struct audio_info {
>>> +       enum AUDIO_FORMAT format;
>>> +       int sample_rate;
>>> +       int channels;
>>> +       int sample_width;
>>> +};
>>> +
>>> +struct video_info {
>>> +       bool h_sync_polarity;
>>> +       bool v_sync_polarity;
>>> +       bool interlaced;
>>> +       int color_depth;
>>> +       enum VIC_PXL_ENCODING_FORMAT color_fmt;
>>> +};
>>> +
>>> +struct cdn_firmware_header {
>>> +       u32 size_bytes; /* size of the entire header+image(s) in bytes */
>>> +       u32 header_size; /* size of just the header in bytes */
>>> +       u32 iram_size; /* size of iram */
>>> +       u32 dram_size; /* size of dram */
>>> +};
>>> +
>>> +struct cdn_dp_device {
>>> +       struct device *dev;
>>> +       struct drm_device *drm_dev;
>>> +       struct drm_connector connector;
>>> +       struct drm_encoder encoder;
>>> +       struct drm_display_mode mode;
>>> +       struct platform_device *audio_pdev;
>>> +
>>> +       const struct firmware *fw;      /* cdn dp firmware */
>>> +       unsigned int fw_version;        /* cdn fw version */
>>> +       u32 fw_retry;
>>> +       bool fw_loaded;
>>> +       void __iomem *regs;
>>> +       struct regmap *grf;
>>> +       unsigned int irq;
>>> +       struct clk *core_clk;
>>> +       struct clk *pclk;
>>> +       struct clk *spdif_clk;
>>> +       struct reset_control *spdif_rst;
>>> +       struct audio_info audio_info;
>>> +       struct video_info video_info;
>>> +       struct extcon_dev *extcon[MAX_PHY];
>>> +       struct phy *phy[MAX_PHY];
>>> +       struct notifier_block event_nb;
>>> +       struct delayed_work event_wq;
>>> +
>>> +       u8 port_id;
>>> +       u8 cap_lanes;
>>> +       bool hpd_status;
>>> +       bool phy_status[MAX_PHY];
>>> +
>>> +       int dpms_mode;
>>> +       struct drm_dp_link link;
>>> +       bool sink_has_audio;
>>> +};
>>> +
>>> +void dp_clock_reset_seq(struct cdn_dp_device *dp);
>>
>> cdn_ prefix here?
>>
>>> +
>>> +void cdn_dp_set_fw_clk(struct cdn_dp_device *dp, int clk);
>>> +int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
>>> +                        u32 i_size, const u32 *d_mem, u32 d_size);
>>> +int cdn_dp_active(struct cdn_dp_device *dp, bool enable);
>>> +int cdn_dp_set_host_cap(struct cdn_dp_device *dp);
>>> +int cdn_dp_event_config(struct cdn_dp_device *dp);
>>> +int cdn_dp_get_event(struct cdn_dp_device *dp);
>>> +int cdn_dp_get_hpd_status(struct cdn_dp_device *dp);
>>> +int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value);
>>> +int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr);
>>> +int cdn_dp_get_edid_block(void *dp, u8 *edid,
>>> +                         unsigned int block, size_t length);
>>> +int cdn_dp_training_start(struct cdn_dp_device *dp);
>>> +int cdn_dp_get_lt_status(struct cdn_dp_device *dp);
>>> +int cdn_dp_set_video_status(struct cdn_dp_device *dp, int active);
>>> +int cdn_dp_config_video(struct cdn_dp_device *dp);
>>> +int cdn_dp_audio_stop(struct cdn_dp_device *dp, struct audio_info
>>> *audio);
>>> +int cdn_dp_audio_mute(struct cdn_dp_device *dp, bool enable);
>>> +int cdn_dp_audio_config_set(struct cdn_dp_device *dp, struct audio_info
>>> *audio);
>>> +
>>
>> I really don't like that you've declared these in core.h, yet defined
>> them in reg.c.
>>
>>> +#endif  /* _ROCKCHIP_EDP_CORE_H */
>>
>> Make sure you update here too
>>
>>
>>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
>>> b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
>>> new file mode 100644
>>> index 0000000..8d5becd
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
>>> @@ -0,0 +1,740 @@
>>> +/*
>>> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
>>> + * Author: Chris Zhong <zyw@rock-chips.com>
>>> + *
>>> + * This software is licensed under the terms of the GNU General Public
>>> + * License version 2, as published by the Free Software Foundation, and
>>> + * may be copied, distributed, and modified under those terms.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/device.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/io.h>
>>> +#include <linux/iopoll.h>
>>> +#include <linux/reset.h>
>>> +
>>> +#include "cdn-dp-core.h"
>>> +#include "cdn-dp-reg.h"
>>> +
>>> +#define CDN_DP_SPDIF_CLK               200000000
>>> +#define FW_ALIVE_TIMEOUT_US            1000000
>>> +#define MAILBOX_TIMEOUT_US             5000000
>>> +
>>> +void cdn_dp_set_fw_clk(struct cdn_dp_device *dp, int clk)
>>> +{
>>> +       writel(clk / 1000000, dp->regs + SW_CLK_H);
>>> +}
>>> +
>>> +void dp_clock_reset_seq(struct cdn_dp_device *dp)
>>> +{
>>> +       writel(0xfff, dp->regs + SOURCE_DPTX_CAR);
>>> +       writel(0x7, dp->regs + SOURCE_PHY_CAR);
>>> +       writel(0xf, dp->regs + SOURCE_PKT_CAR);
>>> +       writel(0xff, dp->regs + SOURCE_AIF_CAR);
>>> +       writel(0xf, dp->regs + SOURCE_CIPHER_CAR);
>>> +       writel(0x3, dp->regs + SOURCE_CRYPTO_CAR);
>>> +       writel(0, dp->regs + APB_INT_MASK);
>>
>> Pull these hardcoded values out into #defines
>>
>>> +}
>>> +
>>> +static int cdn_dp_mailbox_read(struct cdn_dp_device *dp)
>>> +{
>>> +       int val, ret;
>>> +
>>> +       if (!dp->fw_loaded)
>>> +               return 0;
>>
>> This seems like an error. Return -errno and log a message
>
> The audio will call this function before firmware during probe, return err
> cause audio register failed.
>

Hmm, so what happens when you return 0? Isn't that a potentially valid
value that could cause problems on the audio side?

>>
>>> +
>>> +       ret = readx_poll_timeout(readl, dp->regs + MAILBOX_EMPTY_ADDR,
>>> +                                val, !val, 1000, MAILBOX_TIMEOUT_US);
>>
>> Pull the 1000 out into a #define (here and below)
>>
>>> +       if (ret < 0) {
>>> +               dev_err(dp->dev, "failed to read mailbox, keep alive =
>>> %x\n",
>>> +                       readl(dp->regs + KEEP_ALIVE));
>>> +               return ret;
>>> +       }
>>> +
>>> +       return readl(dp->regs + MAILBOX0_RD_DATA) & 0xff;
>>> +}
>>> +
>>> +static int cdp_dp_mailbox_write(struct cdn_dp_device *dp, u8 val)
>>> +{
>>> +       int ret, full;
>>> +
>>> +       if (!dp->fw_loaded)
>>> +               return 0;
>>
>> Same here
>>
>>> +
>>> +       ret = readx_poll_timeout(readl, dp->regs + MAILBOX_FULL_ADDR,
>>> +                                full, !full, 1000, MAILBOX_TIMEOUT_US);
>>> +       if (ret < 0) {
>>> +               dev_err(dp->dev, "mailbox is full, keep alive = %x\n",
>>> +                       readl(dp->regs + KEEP_ALIVE));
>>> +               return ret;
>>> +       }
>>> +
>>> +       writel(val, dp->regs + MAILBOX0_WR_DATA);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int cdn_dp_mailbox_response(struct cdn_dp_device *dp, u8
>>> module_id,
>>
>> I think _receive would be a better name than _response
>>
>>> +                                  u8 opcode, u8 *buff, u8 buff_size)
>>> +{
>>> +       int ret, i = 0;
>>> +       u8 header[4];
>>> +
>>> +       /* read the header of the message */
>>> +       while (i < 4) {
>>
>> for (i = 0; i < 4; i++) {
>>
>>> +               ret = cdn_dp_mailbox_read(dp);
>>> +               if (ret < 0)
>>> +                       return ret;
>>> +
>>> +               header[i++] = ret;
>>
>> header[i] = ret;
>>
>>> +       }
>>> +
>>> +       if (opcode != header[0] || module_id != header[1] ||
>>> +           buff_size != ((header[2] << 8) | header[3])) {
>>
>> pull header[2] << 8 | header[3] out into a local, mbox_size.
>>
>>> +               dev_err(dp->dev, "mailbox response failed");
>>> +
>>> +               /*
>>> +                * If the message in mailbox is not what we want, we need
>>> to
>>> +                * clear the mailbox by read.
>>> +                */
>>> +               i = (header[2] << 8) | header[3];
>>> +               while (i--)
>>
>> for (i = 0; i < mbox_size; i++)
>>
>>> +                       if (cdn_dp_mailbox_read(dp) < 0)
>>> +                               break;
>>> +
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       i = 0;
>>> +       while (i < buff_size) {
>>
>> for (i = 0; i < buff_size; i++) {
>>
>>> +               ret = cdn_dp_mailbox_read(dp);
>>> +               if (ret < 0)
>>> +                       return ret;
>>> +
>>> +               buff[i++] = ret;
>>
>>   buff[i] = ret;
>>
>>> +       }
>>> +
>>> +       return 0;
>>
>>
>> Are you always guaranteed to have the entire message in the mailbox?
>> If not, you might consider supporting partial messages and returning
>> the length read.
>>
>>> +}
>>> +
>>> +static int cdn_dp_mailbox_send(struct cdn_dp_device *dp, u8 module_id,
>>> +                              u8 opcode, u16 size, u8 *message)
>>> +{
>>> +       u8 header[4];
>>> +       int ret, i;
>>> +
>>> +       header[0] = opcode;
>>> +       header[1] = module_id;
>>> +       header[2] = size >> 8;
>>
>> (size >> 8) & 0xff;
>>
>>> +       header[3] = size & 0xff;
>>> +
>>> +       for (i = 0; i < 4; i++) {
>>> +               ret = cdp_dp_mailbox_write(dp, header[i]);
>>> +               if (ret)
>>> +                       return ret;
>>> +       }
>>> +
>>> +       while (size--) {
>>
>> for (i = 0; i < size; i++) {
>>
>>> +               ret = cdp_dp_mailbox_write(dp, *message++);
>>
>> message[i]
>>
>>> +               if (ret)
>>
>> Log something here?
>>
>>> +                       return ret;
>>> +       }
>>> +
>>> +       return 0;
>>
>> Perhaps consider returning the number of bytes that were sent.
>>
>>> +}
>>> +
>>> +static int cdn_dp_reg_write(struct cdn_dp_device *dp, u16 addr, u32 val)
>>> +{
>>> +       u8 msg[6];
>>> +
>>> +       msg[0] = (addr >> 8) & 0xff;
>>> +       msg[1] = addr & 0xff;
>>> +       msg[2] = (val >> 24) & 0xff;
>>> +       msg[3] = (val >> 16) & 0xff;
>>> +       msg[4] = (val >> 8) & 0xff;
>>> +       msg[5] = val & 0xff;
>>> +       return cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
>>> DPTX_WRITE_REGISTER,
>>> +                                  ARRAY_SIZE(msg), msg);
>>> +}
>>> +
>>> +int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
>>> +                        u32 i_size, const u32 *d_mem, u32 d_size)
>>> +{
>>> +       int i, reg, ret;
>>
>> reg should be u32
>>
>>> +
>>> +       /* reset ucpu before load firmware*/
>>> +       writel(APB_IRAM_PATH | APB_DRAM_PATH | APB_XT_RESET,
>>> +              dp->regs + APB_CTRL);
>>> +
>>> +       for (i = 0; i < i_size; i += 4)
>>> +               writel(*i_mem++, dp->regs + ADDR_IMEM + i);
>>> +
>>> +       for (i = 0; i < d_size; i += 4)
>>> +               writel(*d_mem++, dp->regs + ADDR_DMEM + i);
>>> +
>>> +       /* un-reset ucpu */
>>> +       writel(0, dp->regs + APB_CTRL);
>>> +
>>> +       /* check the keep alive register to make sure fw working */
>>> +       ret = readx_poll_timeout(readl, dp->regs + KEEP_ALIVE,
>>> +                                reg, reg, 2000, FW_ALIVE_TIMEOUT_US);
>>> +       if (ret < 0) {
>>> +               dev_err(dp->dev, "failed to loaded the FW reg = %x\n",
>>> reg);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       reg = readl(dp->regs + VER_L) & 0xff;
>>> +       dp->fw_version = reg;
>>> +       reg = readl(dp->regs + VER_H) & 0xff;
>>> +       dp->fw_version |= reg << 8;
>>> +       reg = readl(dp->regs + VER_LIB_L_ADDR) & 0xff;
>>> +       dp->fw_version |= reg << 16;
>>> +       reg = readl(dp->regs + VER_LIB_H_ADDR) & 0xff;
>>> +       dp->fw_version |= reg << 24;
>>> +
>>
>> Are there any sanity checks you can do on the fw_version before returning?
>
> This is first version of firmware, so do not nedd check the number, But I
> think adding a dev_dbg log here is better.
>

Ok, sounds good.

>>
>>> +       dp->fw_loaded = 1;
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +int cdn_dp_reg_write_bit(struct cdn_dp_device *dp, u16 addr, u8
>>> start_bit,
>>> +                        u8 bits_no, u32 val)
>>> +{
>>> +       u8 field[8];
>>> +
>>> +       field[0] = (addr >> 8) & 0xff;
>>> +       field[1] = addr & 0xff;
>>> +       field[2] = start_bit;
>>> +       field[3] = bits_no;
>>> +       field[4] = (val >> 24) & 0xff;
>>> +       field[5] = (val >> 16) & 0xff;
>>> +       field[6] = (val >> 8) & 0xff;
>>> +       field[7] = val & 0xff;
>>> +
>>> +       return cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
>>> DPTX_WRITE_FIELD,
>>> +                           sizeof(field), field);
>>> +}
>>> +
>>> +int cdn_dp_active(struct cdn_dp_device *dp, bool enable)
>>> +{
>>> +       u8 active = enable ? 1 : 0;
>>> +       u8 resp;
>>> +       int ret;
>>> +
>>> +       /* set firmware status, 1: avtive; 0: standby */
>>
>> s/avtive/active/
>>
>>> +       ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_GENERAL,
>>> +                                 GENERAL_MAIN_CONTROL, 1, &active);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       ret = cdn_dp_mailbox_response(dp, MB_MODULE_ID_GENERAL,
>>> +                                     GENERAL_MAIN_CONTROL, &resp, 1);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       return resp ? 0 : -EINVAL;
>>> +}
>>> +
>>> +int cdn_dp_set_host_cap(struct cdn_dp_device *dp)
>>> +{
>>> +       u8 msg[8];
>>> +       int ret;
>>> +
>>> +       msg[0] = DP_LINK_BW_5_4;
>>
>> Why is this always 5.4GHz? Does the hw support any other rates?
>
> It is setting the max rate to 5.4G, not all support rate.
>

Ah, so it will automatically downgrade the link speed in the training
process if the sink doesn't support it?

>>
>>> +       msg[1] = dp->cap_lanes;
>>> +       msg[2] = VOLTAGE_LEVEL_2;
>>> +       msg[3] = PRE_EMPHASIS_LEVEL_3;
>>> +       msg[4] = PRBS7 | D10_2 | TRAINING_PTN1 | TRAINING_PTN2;
>>
>> You don't need to use training pattern 3 for hbr modes?
>
> This is the fault of pattern name, it should be:
>
> msg[4] = TPS1 | TPS2 | TPS3 | TPS4;
>
>
>
>>
>>> +       msg[5] = FAST_LT_NOT_SUPPORT;
>>> +       msg[6] = LANE_MAPPING_NORMAL;
>>> +       msg[7] = ENHANCED;
>>> +
>>> +       ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
>>> +                                 DPTX_SET_HOST_CAPABILITIES,
>>> +                                 ARRAY_SIZE(msg), msg);
>>
>> ARRAY_SIZE counts the number of elements, not the size, so I think
>> you're better off using sizeof instead. This applies to the rest of
>> the dp_mailbox_send instances as well.
>>
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       ret = cdn_dp_reg_write(dp, DP_AUX_SWAP_INVERSION_CONTROL,
>>> +                              AUX_HOST_INVERT);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +int cdn_dp_event_config(struct cdn_dp_device *dp)
>>> +{
>>> +       u8 msg[5] = {0, 0, 0, 0, 0};
>>
>> memset(msg, 0, sizeof(msg));
>>
>>> +
>>> +       msg[0] = DPTX_EVENT_ENABLE_HPD | DPTX_EVENT_ENABLE_TRAINING;
>>> +
>>> +       return cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
>>> DPTX_ENABLE_EVENT,
>>> +                                   ARRAY_SIZE(msg), msg);
>>> +}
>>> +
>>> +int cdn_dp_get_event(struct cdn_dp_device *dp)
>>
>> Should return u32
>>
>>> +{
>>> +       return readl(dp->regs + SW_EVENTS0);
>>> +}
>>> +
>>> +int cdn_dp_get_hpd_status(struct cdn_dp_device *dp)
>>> +{
>>> +       u8 status;
>>> +       int ret;
>>> +
>>> +       ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_HPD_STATE,
>>> +                                 0, NULL);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       ret = cdn_dp_mailbox_response(dp, MB_MODULE_ID_DP_TX,
>>> +                                     DPTX_HPD_STATE, &status, 1);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       return status;
>>> +}
>>> +
>>> +int cdn_dp_get_edid_block(void *data, u8 *edid,
>>> +                         unsigned int block, size_t length)
>>> +{
>>> +       struct cdn_dp_device *dp = data;
>>> +       u8 msg[2], reg[EDID_DATA + EDID_BLOCK_SIZE];
>>> +       int ret;
>>> +
>>> +       if (length != EDID_BLOCK_SIZE)
>>> +               return -EINVAL;
>>> +
>>> +       msg[0] = block / 2;
>>> +       msg[1] = block % 2;
>>> +
>>> +       ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_GET_EDID,
>>> +                                 2, msg);
>>
>> sizeof(msg), msg);
>>
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       ret = cdn_dp_mailbox_response(dp, MB_MODULE_ID_DP_TX,
>>> +                                     DPTX_GET_EDID, reg,
>>> +                                     EDID_DATA + EDID_BLOCK_SIZE);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       if (reg[EDID_LENGTH_BYTE] != EDID_BLOCK_SIZE ||
>>> +           reg[EDID_SEGMENT_BUMBER] != block / 2) {
>>> +               dev_err(dp->dev, "edid block size err\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       memcpy(edid, &reg[EDID_DATA], EDID_BLOCK_SIZE);
>>
>> You can avoid the intermediate reg[] buffer if you restructure the
>> _response/_receive mailbox function. I'd suggest splitting it into a
>> _validate_response() function that reads the header and makes sure the
>> lengths match. The second part would be a _read_response() which
>> simply reads the specified number of bytes from the mailbox. For
>> convenience, you could make cdn_dp_mailbox_receive() a helper which
>> calls both validate and read for times when you're reading the same
>> number as you're validating.
>>
>> So in this function, you'd validate the response has EDID_DATA +
>> EDID_BLOCK_SIZE bytes, then read the EDID_DATA prefix into a local,
>> then read EDID_BLOCK_DATA directly into edid.
>>
>> I think you'll also need a _drain function to clear out the mailbox in
>> case of error (otherwise the next read will fail).
>>
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +int cdn_dp_training_start(struct cdn_dp_device *dp)
>>> +{
>>> +       u8 msg, event[2];
>>> +       unsigned long timeout;
>>> +       int ret;
>>> +
>>> +       msg = LINK_TRAINING_RUN;
>>> +
>>> +       /* start training */
>>> +       ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
>>> DPTX_TRAINING_CONTROL,
>>> +                                 1, &msg);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       /* the whole training should finish in 500ms */
>>> +       timeout = jiffies + msecs_to_jiffies(500);
>>
>> Pull 500 out into a #define
>>
>>> +       while (1) {
>>
>> while(time_before(jiffies, timeout))
>>
>>> +               msleep(20);
>>
>> Pull 20 out into a #define
>>
>>> +               ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
>>> +                                         DPTX_READ_EVENT, 0, NULL);
>>> +               if (ret)
>>> +                       return ret;
>>> +
>>> +               ret = cdn_dp_mailbox_response(dp, MB_MODULE_ID_DP_TX,
>>> +                                             DPTX_READ_EVENT, event, 2);
>>> +               if (ret)
>>> +                       return ret;
>>> +
>>> +               if (event[1] & EQ_PHASE_FINISHED)
>>> +                       break;
>>
>> return 0
>>
>>> +
>>> +               if (time_after(jiffies, timeout))
>>> +                       return -ETIMEDOUT;
>>> +       }
>>> +
>>> +       return 0;
>>
>> return -ETIMEDOUT
>>
>>> +}
>>> +
>>> +int cdn_dp_get_lt_status(struct cdn_dp_device *dp)
>>
>> s/lt/training/
>>
>>> +{
>>> +       u8 status[10];
>>> +       int ret;
>>> +
>>> +       ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
>>> DPTX_READ_LINK_STAT,
>>> +                                 0, NULL);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       ret = cdn_dp_mailbox_response(dp, MB_MODULE_ID_DP_TX,
>>> +                                     DPTX_READ_LINK_STAT, status, 10);
>>
>> s/10/sizeof(status)/
>>
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       dp->link.rate = status[0];
>>> +       dp->link.num_lanes = status[1];
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +int cdn_dp_set_video_status(struct cdn_dp_device *dp, int active)
>>> +{
>>> +       u8 msg;
>>> +
>>> +       msg = !!active;
>>> +
>>> +       return cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
>>> DPTX_SET_VIDEO,
>>> +                                  1, &msg);
>>
>> s/1/sizeof(msg)/
>>
>>> +}
>>> +
>>> +static int cdn_dp_get_msa_misc(struct video_info *video,
>>> +                              struct drm_display_mode *mode)
>>> +{
>>> +       u8 val0, val1;
>>
>> u8 val[2];
>>
>>> +       u32 msa_misc;
>>> +
>>> +       switch (video->color_fmt) {
>>> +       case PXL_RGB:
>>> +       case Y_ONLY:
>>> +               val0 = 0;
>>> +               break;
>>
>> Perhaps this would be better as listed under the default case.
>>
>>> +       case YCBCR_4_4_4:
>>> +               /* set default color space conversion to BT601 */
>>> +               val0 = 6 + BT_601 * 8;
>>> +               break;
>>> +       case YCBCR_4_2_2:
>>> +               /* set default color space conversion to BT601 */
>>> +               val0 = 5 + BT_601 * 8;
>>> +               break;
>>> +       case YCBCR_4_2_0:
>>> +               val0 = 5;
>>> +               break;
>>> +       };
>>> +
>>> +       switch (video->color_depth) {
>>> +       case 6:
>>> +               val1 = 0;
>>> +               break;
>>> +       case 8:
>>> +               val1 = 1;
>>> +               break;
>>> +       case 10:
>>> +               val1 = 2;
>>> +               break;
>>> +       case 12:
>>> +               val1 = 3;
>>> +               break;
>>> +       case 16:
>>> +               val1 = 4;
>>> +               break;
>>> +       };
>>> +
>>> +       msa_misc = 2 * val0 + 32 * val1 +
>>> +                  ((video->color_fmt == Y_ONLY) ? (1 << 14) : 0);
>>
>> Perhaps a stupid question, but is this documented anywhere? If not,
>> could you add a comment describing what you're doing?
>>
>>> +
>>> +       return msa_misc;
>>> +}
>>> +
>>> +int cdn_dp_config_video(struct cdn_dp_device *dp)
>>> +{
>>> +       struct video_info *video = &dp->video_info;
>>> +       struct drm_display_mode *mode = &dp->mode;
>>> +       u64 symbol;
>>> +       u32 val, link_rate;
>>> +       u8 bit_per_pix;
>>> +       u8 tu_size_reg = TU_SIZE;
>>> +       int ret;
>>> +
>>> +       bit_per_pix = (video->color_fmt == YCBCR_4_2_2) ?
>>> +                     (video->color_depth * 2) : (video->color_depth *
>>> 3);
>>> +
>>> +       link_rate = drm_dp_bw_code_to_link_rate(dp->link.rate);
>>> +
>>> +       val = VIF_BYPASS_INTERLACE;
>>> +
>>
>> remove extra line
>>
>>> +       ret = cdn_dp_reg_write(dp, BND_HSYNC2VSYNC, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       ret = cdn_dp_reg_write(dp, HSYNC2VSYNC_POL_CTRL, 0);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       /* get a best tu_size and symbol */
>>> +       do {
>>> +               tu_size_reg += 2;
>>> +               symbol = tu_size_reg * mode->clock * bit_per_pix;
>>> +               symbol /= dp->link.num_lanes * link_rate * 8;
>>> +       } while ((symbol == 1) || (tu_size_reg - symbol < 4));
>>> +
>>> +       val = symbol + (tu_size_reg << 8);
>>> +
>>
>> remove extra line
>>
>>> +       ret = cdn_dp_reg_write(dp, DP_FRAMER_TU, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       switch (video->color_depth) {
>>> +       case 6:
>>> +               val = BCS_6;
>>> +               break;
>>> +       case 8:
>>> +               val = BCS_8;
>>> +               break;
>>> +       case 10:
>>> +               val = BCS_10;
>>> +               break;
>>> +       case 12:
>>> +               val = BCS_12;
>>> +               break;
>>> +       case 16:
>>> +               val = BCS_16;
>>> +               break;
>>> +       };
>>> +
>>> +       val += video->color_fmt << 8;
>>> +       ret = cdn_dp_reg_write(dp, DP_FRAMER_PXL_REPR, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       val = video->h_sync_polarity ? DP_FRAMER_SP_HSP : 0;
>>> +       val |= video->v_sync_polarity ? DP_FRAMER_SP_VSP : 0;
>>> +       ret = cdn_dp_reg_write(dp, DP_FRAMER_SP, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       val = (mode->hsync_start - mode->hdisplay) << 16;
>>> +       val |= mode->htotal - mode->hsync_end;
>>> +       ret = cdn_dp_reg_write(dp, DP_FRONT_BACK_PORCH, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       val = mode->hdisplay * bit_per_pix / 8;
>>> +       ret = cdn_dp_reg_write(dp, DP_BYTE_COUNT, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       val = mode->htotal | ((mode->htotal - mode->hsync_start) << 16);
>>> +       ret = cdn_dp_reg_write(dp, MSA_HORIZONTAL_0, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       val = mode->hsync_end - mode->hsync_start;
>>> +       val |= (mode->hdisplay << 16) | (video->h_sync_polarity << 15);
>>> +       ret = cdn_dp_reg_write(dp, MSA_HORIZONTAL_1, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       val = mode->vtotal;
>>> +       val |= ((mode->vtotal - mode->vsync_start) << 16);
>>> +
>>
>> remove extra line
>>
>>> +       ret = cdn_dp_reg_write(dp, MSA_VERTICAL_0, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       val = mode->vsync_end - mode->vsync_start;
>>> +       val |= mode->vdisplay << 16;
>>> +       val |= (video->v_sync_polarity << 15);
>>
>> Make this consistent with how you assigned val for MSA_HORIZONTAL_1
>> (ie: split both or combine both)
>>
>>> +       ret = cdn_dp_reg_write(dp, MSA_VERTICAL_1, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       val = cdn_dp_get_msa_misc(video, mode);
>>> +       ret = cdn_dp_reg_write(dp, MSA_MISC, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       ret = cdn_dp_reg_write(dp, STREAM_CONFIG, 1);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       val = mode->hsync_end - mode->hsync_start;
>>> +       val |= (mode->hdisplay << 16);
>>> +       ret = cdn_dp_reg_write(dp, DP_HORIZONTAL, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       val = mode->vtotal;
>>> +       val -= (mode->vtotal - mode->vdisplay);
>>> +       val |= (mode->vtotal - mode->vsync_start) << 16;
>>> +
>>
>> extra line
>>
>>> +       ret = cdn_dp_reg_write(dp, DP_VERTICAL_0, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       val = mode->vtotal;
>>> +       ret = cdn_dp_reg_write(dp, DP_VERTICAL_1, val);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       val =  0;
>>> +       return cdn_dp_reg_write_bit(dp, DP_VB_ID, 2, 1, val);
>>> +}
>>> +
>>> +int cdn_dp_audio_stop(struct cdn_dp_device *dp, struct audio_info
>>> *audio)
>>> +{
>>> +       int ret = cdn_dp_reg_write(dp, AUDIO_PACK_CONTROL,
>>> AUDIO_PACK_EN(0));
>>> +
>>
>> remove this empty line
>>
>>> +       if (ret)
>>> +               return ret;
>>
>> insert empy line
>>
>>> +       writel(0x1F0707, dp->regs + SPDIF_CTRL_ADDR);
>>
>> pull this magic value into a #define
>>
>>> +       writel(0, dp->regs + AUDIO_SRC_CNTL);
>>> +       writel(0, dp->regs + AUDIO_SRC_CNFG);
>>> +       writel(1, dp->regs + AUDIO_SRC_CNTL);
>>> +       writel(0, dp->regs + AUDIO_SRC_CNTL);
>>> +
>>> +       writel(0, dp->regs + SMPL2PKT_CNTL);
>>> +       writel(1, dp->regs + SMPL2PKT_CNTL);
>>> +       writel(0, dp->regs + SMPL2PKT_CNTL);
>>> +
>>> +       writel(1, dp->regs + FIFO_CNTL);
>>> +       writel(0, dp->regs + FIFO_CNTL);
>>
>> Can you document why you need to toggle these bits as opposed to just
>> setting them to 0?
>>
>>> +
>>> +       if (audio->format == AFMT_SPDIF)
>>> +               clk_disable_unprepare(dp->spdif_clk);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +int cdn_dp_audio_mute(struct cdn_dp_device *dp, bool enable)
>>> +{
>>> +       return cdn_dp_reg_write_bit(dp, DP_VB_ID, 4, 1, enable);
>>> +}
>>> +
>>> +int cdn_dp_audio_config_set(struct cdn_dp_device *dp, struct audio_info
>>> *audio)
>>> +{
>>> +       int lanes_param, i2s_port_en_val, val, i;
>>
>> int lanes_param = 3, i2s_port_en_val = 0xf, i;
>>
>>> +       int ret;
