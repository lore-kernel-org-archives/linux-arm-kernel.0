From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 07 Oct 2015 11:40:30 +0800
Subject: [PATCH 06/12] drm: bridge/dw_hdmi: clean up HDMI vs DVI mode
 handling
In-Reply-To: <E1ZO6b8-0002r1-Gr@rmk-PC.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
 <E1ZO6b8-0002r1-Gr@rmk-PC.arm.linux.org.uk>
Message-ID: <5614942E.3010702@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell & Andy

On 08/09/2015 12:03 AM, Russell King wrote:
> The FSL kernel detects the HDMI vendor id, and uses this to set
> hdmi->edid_cfg.hdmi_cap, which is then used to set mdvi appropriately,
> rather than detecting whether we are outputting a CEA mode.  Update
> the dw_hdmi code to use this logic, but lets eliminate the mdvi
> variable, prefering the more verbose "hdmi->sink_is_hdmi" instead.
>
> Use the generic drm_detect_hdmi_monitor() to detect a HDMI sink.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Actually I have posted similarly changes before, feel better about
this one, and I have backport those 06/12 & 07/12 to chrome-3.14
tree, audio still works rightly when I changing the display resolutions.
So I would like to share:

Tested-by: Yakir Yang <ykk@rock-chips.com>

Besides, Andy, would you like to share your ACK here :)

Best regards,
- Yakir
> ---
>   drivers/gpu/drm/bridge/dw_hdmi.c | 26 ++++++++++++--------------
>   1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> index 2e211b8331ed..7f764716f3c4 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> @@ -82,7 +82,6 @@ static const u16 csc_coeff_rgb_in_eitu709[3][4] = {
>   };
>   
>   struct hdmi_vmode {
> -	bool mdvi;
>   	bool mdataenablepolarity;
>   
>   	unsigned int mpixelclock;
> @@ -123,6 +122,7 @@ struct dw_hdmi {
>   
>   	struct i2c_adapter *ddc;
>   	void __iomem *regs;
> +	bool sink_is_hdmi;
>   
>   	spinlock_t audio_lock;
>   	struct mutex audio_mutex;
> @@ -913,11 +913,10 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
>   static int dw_hdmi_phy_init(struct dw_hdmi *hdmi)
>   {
>   	int i, ret;
> -	bool cscon = false;
> +	bool cscon;
>   
>   	/*check csc whether needed activated in HDMI mode */
> -	cscon = (is_color_space_conversion(hdmi) &&
> -			!hdmi->hdmi_data.video_mode.mdvi);
> +	cscon = hdmi->sink_is_hdmi && is_color_space_conversion(hdmi);
>   
>   	/* HDMI Phy spec says to do the phy initialization sequence twice */
>   	for (i = 0; i < 2; i++) {
> @@ -1094,9 +1093,9 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>   		HDMI_FC_INVIDCONF_IN_I_P_INTERLACED :
>   		HDMI_FC_INVIDCONF_IN_I_P_PROGRESSIVE;
>   
> -	inv_val |= (vmode->mdvi ?
> -		HDMI_FC_INVIDCONF_DVI_MODEZ_DVI_MODE :
> -		HDMI_FC_INVIDCONF_DVI_MODEZ_HDMI_MODE);
> +	inv_val |= hdmi->sink_is_hdmi ?
> +		HDMI_FC_INVIDCONF_DVI_MODEZ_HDMI_MODE :
> +		HDMI_FC_INVIDCONF_DVI_MODEZ_DVI_MODE;
>   
>   	hdmi_writeb(hdmi, inv_val, HDMI_FC_INVIDCONF);
>   
> @@ -1236,10 +1235,8 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>   
>   	if (!hdmi->vic) {
>   		dev_dbg(hdmi->dev, "Non-CEA mode used in HDMI\n");
> -		hdmi->hdmi_data.video_mode.mdvi = true;
>   	} else {
>   		dev_dbg(hdmi->dev, "CEA mode used vic=%d\n", hdmi->vic);
> -		hdmi->hdmi_data.video_mode.mdvi = false;
>   	}
>   
>   	if ((hdmi->vic == 6) || (hdmi->vic == 7) ||
> @@ -1275,10 +1272,8 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>   	dw_hdmi_enable_video_path(hdmi);
>   
>   	/* not for DVI mode */
> -	if (hdmi->hdmi_data.video_mode.mdvi) {
> -		dev_dbg(hdmi->dev, "%s DVI mode\n", __func__);
> -	} else {
> -		dev_dbg(hdmi->dev, "%s CEA mode\n", __func__);
> +	if (hdmi->sink_is_hdmi) {
> +		dev_dbg(hdmi->dev, "%s HDMI mode\n", __func__);
>   
>   		/* HDMI Initialization Step E - Configure audio */
>   		hdmi_clk_regenerator_update_pixel_clock(hdmi);
> @@ -1286,6 +1281,8 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>   
>   		/* HDMI Initialization Step F - Configure AVI InfoFrame */
>   		hdmi_config_AVI(hdmi, mode);
> +	} else {
> +		dev_dbg(hdmi->dev, "%s DVI mode\n", __func__);
>   	}
>   
>   	hdmi_video_packetize(hdmi);
> @@ -1294,7 +1291,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>   	hdmi_tx_hdcp_config(hdmi);
>   
>   	dw_hdmi_clear_overflow(hdmi);
> -	if (hdmi->cable_plugin && !hdmi->hdmi_data.video_mode.mdvi)
> +	if (hdmi->cable_plugin && hdmi->sink_is_hdmi)
>   		hdmi_enable_overflow_interrupts(hdmi);
>   
>   	return 0;
> @@ -1444,6 +1441,7 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>   		dev_dbg(hdmi->dev, "got edid: width[%d] x height[%d]\n",
>   			edid->width_cm, edid->height_cm);
>   
> +		hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
>   		drm_mode_connector_update_edid_property(connector, edid);
>   		ret = drm_add_edid_modes(connector, edid);
>   		kfree(edid);
