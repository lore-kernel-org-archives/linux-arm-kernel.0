From: jani.nikula@linux.intel.com (Jani Nikula)
Date: Thu, 09 Nov 2017 10:27:02 +0200
Subject: [PATCH] drm/bridge: dw-hdmi: fix EDID parsing
In-Reply-To: <E1eC22L-0003sN-Dw@rmk-PC.armlinux.org.uk>
References: <E1eC22L-0003sN-Dw@rmk-PC.armlinux.org.uk>
Message-ID: <87tvy3amcp.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 07 Nov 2017, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> Parsing the EDID for HDMI and audio information in the get_modes()
> callback is incorrect - this only parses the EDID read from the
> connector, not any override or firmware provided EDID.
>
> The correct place to parse the EDID for these parameters is the
> fill_modes() callback, after we've called the helper.  Move the parsing
> there.  This caused problems for Lu?s Mendes.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: Lu?s Mendes <luis.p.mendes@gmail.com>
> Tested-by: Lu?s Mendes <luis.p.mendes@gmail.com>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Is this still needed after 53fd40a90f3c ("drm: handle override and
firmware EDID at drm_do_get_edid() level") that is headed for v4.15? I'm
thinking this might be applicable only for current Linus master and
stable.

BR,
Jani.


> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 9fe407f49986..2516a1c18a10 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1905,10 +1905,7 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>  		dev_dbg(hdmi->dev, "got edid: width[%d] x height[%d]\n",
>  			edid->width_cm, edid->height_cm);
>  
> -		hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
> -		hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
>  		drm_mode_connector_update_edid_property(connector, edid);
> -		cec_notifier_set_phys_addr_from_edid(hdmi->cec_notifier, edid);
>  		ret = drm_add_edid_modes(connector, edid);
>  		/* Store the ELD */
>  		drm_edid_to_eld(connector, edid);
> @@ -1920,6 +1917,29 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>  	return ret;
>  }
>  
> +static int dw_hdmi_connector_fill_modes(struct drm_connector *connector,
> +					uint32_t maxX, uint32_t maxY)
> +{
> +	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
> +					    connector);
> +	int ret;
> +
> +	ret = drm_helper_probe_single_connector_modes(connector, maxX, maxY);
> +
> +	if (connector->edid_blob_ptr) {
> +		struct edid *edid = (void *)connector->edid_blob_ptr->data;
> +
> +		hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
> +		hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
> +		cec_notifier_set_phys_addr_from_edid(hdmi->cec_notifier, edid);
> +	} else {
> +		hdmi->sink_is_hdmi = false;
> +		hdmi->sink_has_audio = false;
> +	}
> +
> +	return ret;
> +}
> +
>  static void dw_hdmi_connector_force(struct drm_connector *connector)
>  {
>  	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
> @@ -1933,7 +1953,7 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>  }
>  
>  static const struct drm_connector_funcs dw_hdmi_connector_funcs = {
> -	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.fill_modes = dw_hdmi_connector_fill_modes,
>  	.detect = dw_hdmi_connector_detect,
>  	.destroy = drm_connector_cleanup,
>  	.force = dw_hdmi_connector_force,

-- 
Jani Nikula, Intel Open Source Technology Center
