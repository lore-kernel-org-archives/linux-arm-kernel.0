From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 9 Jun 2017 16:27:24 +0200
Subject: [PATCH 2/4] drm/bridge: dw-hdmi: add cec notifier support
In-Reply-To: <E1dFi3E-0004lh-Pu@rmk-PC.armlinux.org.uk>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3E-0004lh-Pu@rmk-PC.armlinux.org.uk>
Message-ID: <15a00b10-9525-859e-80af-fe87b78e8fe8@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/17 16:23, Russell King wrote:
> Add CEC notifier support to the HDMI bridge driver, so that the CEC
> part of the IP can receive its physical address.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Given the fact that there are devices that do not use the built-in dw-hdmi
CEC IP but something else, using a notifier here makes a lot of sense.

So:

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 4e1f54a675d8..966422576c44 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -36,7 +36,10 @@
>  #include "dw-hdmi.h"
>  #include "dw-hdmi-audio.h"
>  
> +#include <media/cec-notifier.h>
> +
>  #define DDC_SEGMENT_ADDR	0x30
> +
>  #define HDMI_EDID_LEN		512
>  
>  enum hdmi_datamap {
> @@ -173,6 +176,8 @@ struct dw_hdmi {
>  
>  	unsigned int reg_shift;
>  	struct regmap *regm;
> +
> +	struct cec_notifier *cec_notifier;
>  };
>  
>  #define HDMI_IH_PHY_STAT0_RX_SENSE \
> @@ -1870,6 +1875,7 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>  		hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
>  		hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
>  		drm_mode_connector_update_edid_property(connector, edid);
> +		cec_notifier_set_phys_addr_from_edid(hdmi->cec_notifier, edid);
>  		ret = drm_add_edid_modes(connector, edid);
>  		/* Store the ELD */
>  		drm_edid_to_eld(connector, edid);
> @@ -2108,11 +2114,16 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>  	 * ask the source to re-read the EDID.
>  	 */
>  	if (intr_stat &
> -	    (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_IH_PHY_STAT0_HPD))
> +	    (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_IH_PHY_STAT0_HPD)) {
>  		__dw_hdmi_setup_rx_sense(hdmi,
>  					 phy_stat & HDMI_PHY_HPD,
>  					 phy_stat & HDMI_PHY_RX_SENSE);
>  
> +		if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) == 0)
> +			cec_notifier_set_phys_addr(hdmi->cec_notifier,
> +						   CEC_PHYS_ADDR_INVALID);
> +	}
> +
>  	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
>  		dev_dbg(hdmi->dev, "EVENT=%s\n",
>  			phy_int_pol & HDMI_PHY_HPD ? "plugin" : "plugout");
> @@ -2365,6 +2376,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  	if (ret)
>  		goto err_iahb;
>  
> +	hdmi->cec_notifier = cec_notifier_get(dev);
> +	if (!hdmi->cec_notifier) {
> +		ret = -ENOMEM;
> +		goto err_iahb;
> +	}
> +
>  	/*
>  	 * To prevent overflows in HDMI_IH_FC_STAT2, set the clk regenerator
>  	 * N and cts values before enabling phy
> @@ -2437,6 +2454,9 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  		hdmi->ddc = NULL;
>  	}
>  
> +	if (hdmi->cec_notifier)
> +		cec_notifier_put(hdmi->cec_notifier);
> +
>  	clk_disable_unprepare(hdmi->iahb_clk);
>  err_isfr:
>  	clk_disable_unprepare(hdmi->isfr_clk);
> 
