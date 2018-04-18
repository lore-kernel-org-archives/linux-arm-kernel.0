From: peda@axentia.se (Peter Rosin)
Date: Wed, 18 Apr 2018 09:46:09 +0200
Subject: [PATCH v2 4/6] drm/atmel-hlcdc: support bus-width (12/16/18/24)
 in endpoint nodes
In-Reply-To: <20180418092948.6dace10a@bbrezillon>
References: <20180417131052.16336-1-peda@axentia.se>
 <20180417131052.16336-5-peda@axentia.se> <20180418092948.6dace10a@bbrezillon>
Message-ID: <8c5847d0-cde1-73fa-9ed1-4f4a5420afbd@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-18 09:29, Boris Brezillon wrote:
> On Tue, 17 Apr 2018 15:10:50 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> This beats the heuristic that the connector is involved in what format
>> should be output for cases where this fails.
>>
>> E.g. if there is a bridge that changes format between the encoder and the
>> connector, or if some of the RGB pins between the lcd controller and the
>> encoder are not routed on the PCB.
>>
>> This is critical for the devices that have the "conflicting output
>> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
>> RGB bits move around depending on the selected output mode. For
>> devices that do not have the "conflicting output formats" issue
>> (SAMA5D2, SAMA5D4), this is completely irrelevant.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 85 ++++++++++++++++++++------
>>  1 file changed, 65 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> index d73281095fac..2e718959981e 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> @@ -19,12 +19,14 @@
>>   */
>>  
>>  #include <linux/clk.h>
>> +#include <linux/of_graph.h>
>>  #include <linux/pm.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/pinctrl/consumer.h>
>>  
>>  #include <drm/drm_crtc.h>
>>  #include <drm/drm_crtc_helper.h>
>> +#include <drm/drm_of.h>
>>  #include <drm/drmP.h>
>>  
>>  #include <video/videomode.h>
>> @@ -226,6 +228,68 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>>  #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
>>  #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
>>  
>> +static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
>> +{
>> +	struct drm_connector *connector = state->connector;
>> +	struct drm_display_info *info = &connector->display_info;
>> +	unsigned int supported_fmts = 0;
>> +	struct device_node *ep;
>> +	int j;
>> +
>> +	/*
>> +	 * Use the connector index as an approximation of the
>> +	 * endpoint node index. We know it's true for our case
>> +	 * depending on the driver implementation.
>> +	 */
>> +	ep = of_graph_get_endpoint_by_regs(connector->dev->dev->of_node, 0,
>> +					   connector->index);
>> +
> 
> Hm, this sounds a bit fragile. Can't we have a reference to the of_node
> attached to the connector? Or maybe we can parse this earlier and set a
> constraint on the accepted modes.
> 
>> +	if (ep) {
>> +		int bus_fmt = drm_of_media_bus_fmt(ep);
> 
> Hm, you're extracting this piece of information from the DT every time
> an atomic modeset is done. I'd really prefer to have this done once at

Yes, not happy about it either. I looked for other sensible places too
hook the info at probe time, but this was just the simplest. I'll take
another look...

> probe time. Since this property is attached to the connector, maybe we
> should overwrite the info->bus_formats[] array or mark some of its
> entries as invalid.

I find it very wrong to mix the connector format with what you want to
output. In my mind it's a broken assumption that they are related. It is
only correct for trivial cases. Also note my comment about the connector
index and the endpoint index, they are only coincidentally the same
based on our implementation. If the driver has more than one port or
initializes endpoints out of order for some reason, this is no longer
true.

I think it would be better to store this info somewhere near the encoder,
since that is what I find closest to what I'm trying to change.

As I said, I'll take another look and see if I can hook this in at some
other place.

>> +
>> +		of_node_put(ep);
>> +
>> +		if (bus_fmt < 0)
>> +			return bus_fmt;
>> +
>> +		switch (bus_fmt) {
>> +		case 0:
>> +			break;
>> +		case MEDIA_BUS_FMT_RGB444_1X12:
>> +			return ATMEL_HLCDC_RGB444_OUTPUT;
>> +		case MEDIA_BUS_FMT_RGB565_1X16:
>> +			return ATMEL_HLCDC_RGB565_OUTPUT;
>> +		case MEDIA_BUS_FMT_RGB666_1X18:
>> +			return ATMEL_HLCDC_RGB666_OUTPUT;
>> +		case MEDIA_BUS_FMT_RGB888_1X24:
>> +			return ATMEL_HLCDC_RGB888_OUTPUT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	for (j = 0; j < info->num_bus_formats; j++) {
>> +		switch (info->bus_formats[j]) {
>> +		case MEDIA_BUS_FMT_RGB444_1X12:
>> +			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
>> +			break;
>> +		case MEDIA_BUS_FMT_RGB565_1X16:
>> +			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
>> +			break;
>> +		case MEDIA_BUS_FMT_RGB666_1X18:
>> +			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
>> +			break;
>> +		case MEDIA_BUS_FMT_RGB888_1X24:
>> +			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
>> +	return supported_fmts;
>> +}
>> +
>>  static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>>  {
>>  	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
>> @@ -238,31 +302,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>>  	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
>>  
>>  	for_each_new_connector_in_state(state->state, connector, cstate, i) {
>> -		struct drm_display_info *info = &connector->display_info;
>>  		unsigned int supported_fmts = 0;
>> -		int j;
>>  
>>  		if (!cstate->crtc)
>>  			continue;
>>  
>> -		for (j = 0; j < info->num_bus_formats; j++) {
>> -			switch (info->bus_formats[j]) {
>> -			case MEDIA_BUS_FMT_RGB444_1X12:
>> -				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
>> -				break;
>> -			case MEDIA_BUS_FMT_RGB565_1X16:
>> -				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
>> -				break;
>> -			case MEDIA_BUS_FMT_RGB666_1X18:
>> -				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
>> -				break;
>> -			case MEDIA_BUS_FMT_RGB888_1X24:
>> -				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
>> -				break;
>> -			default:
>> -				break;
>> -			}
>> -		}
>> +		supported_fmts = atmel_hlcdc_connector_output_mode(cstate);
>>  
>>  		if (crtc->dc->desc->conflicting_output_formats)
>>  			output_fmts &= supported_fmts;
> 
