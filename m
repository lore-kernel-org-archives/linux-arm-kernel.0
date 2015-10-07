From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 07 Oct 2015 11:42:08 +0800
Subject: [PATCH 07/12] drm: bridge/dw_hdmi: enable audio only if sink
 supports audio
In-Reply-To: <E1ZO6bD-0002r7-KP@rmk-PC.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
 <E1ZO6bD-0002r7-KP@rmk-PC.arm.linux.org.uk>
Message-ID: <56149490.60902@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell & Andy

On 08/09/2015 12:03 AM, Russell King wrote:
> Only enable audio support if the sink supports audio in some form, as
> defined via its EDID.  We discover this capability using the generic
> drm_detect_monitor_audio() function.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Some to 06/12 reply.

Tested-by: Yakir Yang <ykk@rock-chips.com>

- Yakir
> ---
>   drivers/gpu/drm/bridge/dw_hdmi.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> index 7f764716f3c4..578d7362cd65 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> @@ -123,6 +123,7 @@ struct dw_hdmi {
>   	struct i2c_adapter *ddc;
>   	void __iomem *regs;
>   	bool sink_is_hdmi;
> +	bool sink_has_audio;
>   
>   	spinlock_t audio_lock;
>   	struct mutex audio_mutex;
> @@ -1271,13 +1272,17 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>   	/* HDMI Initialization Step B.3 */
>   	dw_hdmi_enable_video_path(hdmi);
>   
> -	/* not for DVI mode */
> -	if (hdmi->sink_is_hdmi) {
> -		dev_dbg(hdmi->dev, "%s HDMI mode\n", __func__);
> +	if (hdmi->sink_has_audio) {
> +		dev_dbg(hdmi->dev, "sink has audio support\n");
>   
>   		/* HDMI Initialization Step E - Configure audio */
>   		hdmi_clk_regenerator_update_pixel_clock(hdmi);
>   		hdmi_enable_audio_clk(hdmi);
> +	}
> +
> +	/* not for DVI mode */
> +	if (hdmi->sink_is_hdmi) {
> +		dev_dbg(hdmi->dev, "%s HDMI mode\n", __func__);
>   
>   		/* HDMI Initialization Step F - Configure AVI InfoFrame */
>   		hdmi_config_AVI(hdmi, mode);
> @@ -1442,6 +1447,7 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>   			edid->width_cm, edid->height_cm);
>   
>   		hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
> +		hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
>   		drm_mode_connector_update_edid_property(connector, edid);
>   		ret = drm_add_edid_modes(connector, edid);
>   		kfree(edid);
