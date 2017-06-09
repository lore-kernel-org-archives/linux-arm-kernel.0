From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 9 Jun 2017 15:56:39 +0200
Subject: [PATCH 2/4] drm/bridge: dw-hdmi: add cec notifier support
In-Reply-To: <20170609133822.GR4902@n2100.armlinux.org.uk>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3E-0004lh-Pu@rmk-PC.armlinux.org.uk>
 <0c2c4988-37bb-fd01-efee-c6878cc53923@baylibre.com>
 <20170609133822.GR4902@n2100.armlinux.org.uk>
Message-ID: <5b2fdadd-f1fa-c454-b3fe-facf221beb78@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2017 03:38 PM, Russell King - ARM Linux wrote:
> On Fri, Jun 09, 2017 at 02:59:20PM +0200, Neil Armstrong wrote:
>> On 05/30/2017 04:23 PM, Russell King wrote:
>>> Add CEC notifier support to the HDMI bridge driver, so that the CEC
>>> part of the IP can receive its physical address.
>>>
>>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>>> ---
>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 22 +++++++++++++++++++++-
>>>  1 file changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> index 4e1f54a675d8..966422576c44 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> @@ -36,7 +36,10 @@
>>>  #include "dw-hdmi.h"
>>>  #include "dw-hdmi-audio.h"
>>>  
>>> +#include <media/cec-notifier.h>
>>> +
>>>  #define DDC_SEGMENT_ADDR	0x30
>>> +
>>>  #define HDMI_EDID_LEN		512
>>>  
>>>  enum hdmi_datamap {
>>> @@ -173,6 +176,8 @@ struct dw_hdmi {
>>>  
>>>  	unsigned int reg_shift;
>>>  	struct regmap *regm;
>>> +
>>> +	struct cec_notifier *cec_notifier;
>>>  };
>>>  
>>>  #define HDMI_IH_PHY_STAT0_RX_SENSE \
>>> @@ -1870,6 +1875,7 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>>>  		hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
>>>  		hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
>>>  		drm_mode_connector_update_edid_property(connector, edid);
>>> +		cec_notifier_set_phys_addr_from_edid(hdmi->cec_notifier, edid);
>>>  		ret = drm_add_edid_modes(connector, edid);
>>>  		/* Store the ELD */
>>>  		drm_edid_to_eld(connector, edid);
>>> @@ -2108,11 +2114,16 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>>>  	 * ask the source to re-read the EDID.
>>>  	 */
>>>  	if (intr_stat &
>>> -	    (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_IH_PHY_STAT0_HPD))
>>> +	    (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_IH_PHY_STAT0_HPD)) {
>>>  		__dw_hdmi_setup_rx_sense(hdmi,
>>>  					 phy_stat & HDMI_PHY_HPD,
>>>  					 phy_stat & HDMI_PHY_RX_SENSE);
>>>  
>>> +		if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) == 0)
>>> +			cec_notifier_set_phys_addr(hdmi->cec_notifier,
>>> +						   CEC_PHYS_ADDR_INVALID);
>>> +	}
>>> +
>>>  	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
>>>  		dev_dbg(hdmi->dev, "EVENT=%s\n",
>>>  			phy_int_pol & HDMI_PHY_HPD ? "plugin" : "plugout");
>>> @@ -2365,6 +2376,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
>>>  	if (ret)
>>>  		goto err_iahb;
>>>  
>>> +	hdmi->cec_notifier = cec_notifier_get(dev);
>>> +	if (!hdmi->cec_notifier) {
>>> +		ret = -ENOMEM;
>>> +		goto err_iahb;
>>> +	}
>>> +
>>>  	/*
>>>  	 * To prevent overflows in HDMI_IH_FC_STAT2, set the clk regenerator
>>>  	 * N and cts values before enabling phy
>>> @@ -2437,6 +2454,9 @@ __dw_hdmi_probe(struct platform_device *pdev,
>>>  		hdmi->ddc = NULL;
>>>  	}
>>>  
>>> +	if (hdmi->cec_notifier)
>>> +		cec_notifier_put(hdmi->cec_notifier);
>>> +
>>>  	clk_disable_unprepare(hdmi->iahb_clk);
>>>  err_isfr:
>>>  	clk_disable_unprepare(hdmi->isfr_clk);
>>>
>>
>> Hi Archit,
>>
>> I think this one could go through drm-next since it's quite
>> standalone and will reduce the DW-HDMI CEC patchset and dependencies.
> 
> Not a good idea.  If you read all the comments, Hans is suggesting that
> CEC should be part of dw-hdmi itself, not stand-alone.  That would mean
> this patch probably changes - basically, with CEC support built-in to
> dw-hdmi, we don't need the notifier stuff.

Hi Russell,

Yes, but on the Amlogic Meson plarform, the DW-HDMI CEC controller is not used,
but a custom one, so this notifier is actually useful for this platform and
maybe others.

> 
> So, I'd suggest _not_ merging it at the moment, because the patch could
> well become obsolete.

It won't since the Meson platform needs it...

> 
> Wait until the CEC changes that Hans has talked about have hit mainline
> and I've had a chance to rework this for those.  We're waiting on Mauro
> for that at the moment.
> 
> (I do find it rather frustrating that CEC seems to evolve very rapidly,
> it makes it quite difficult to publish a patch set, and get it merged.)
> 

Should we really wait until I push the Amlogic AO CEC driver ? Having a
notifier in the DW-HDMI driver won't harm anybody since it *will be used*.

Neil
