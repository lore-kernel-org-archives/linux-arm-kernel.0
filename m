From: peda@axentia.se (Peter Rosin)
Date: Tue, 27 Mar 2018 14:56:58 +0200
Subject: [PATCH v2 4/5] drm: bridge: lvds-encoder: allow specifying the
 input bus format
In-Reply-To: <20180327102741.GN27746@w540>
References: <20180326212447.7380-1-peda@axentia.se>
 <20180326212447.7380-5-peda@axentia.se> <20180327102741.GN27746@w540>
Message-ID: <e2e4f914-b301-d6ea-3807-05c58849771f@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

Thanks for you feedback!

On 2018-03-27 12:27, jacopo mondi wrote:
> Hi Peter, Laurent,
>    thanks for the patches,
> 
> On Mon, Mar 26, 2018 at 11:24:46PM +0200, Peter Rosin wrote:
>> If the bridge changes the bus format, allow this to be described in
>> the bridge, instead of providing false information about the bus
>> format of the connector or panel.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  .../bindings/display/bridge/lvds-transmitter.txt   |  6 ++++++
>>  drivers/gpu/drm/bridge/lvds-encoder.c              | 25 ++++++++++++++++++++++
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
>> index 50220190c203..8d40a2069252 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
>> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
>> @@ -30,6 +30,12 @@ Required properties:
>>    device-specific version corresponding to the device first
>>    followed by the generic version.
>>
>> +Optional properties:
>> +
>> +- interface-pix-fmt:
>> +  List of valid input bus formats of the encoder. Recognized bus formats
>> +  are listed in ../bus-format.txt
>> +
> 
> This comments applies here and to [3/5] as well.

I'm not sure how the below comments apply to [3/5]? I guess you are
suggesting that [3/5] should be dropped?

> Are we sure we want the supported bridge input format defined in DT
> bindings?

Yes, I'm pretty sure. In my case, it has to be specified manually
*somewhere* (at least I think it has to, but what do I know?). The
bridge is the best position, if you ask me.

> Again, I may be biased, but as I see this, each bridge driver should
> list its supported formats with MEDIA_BUS_FMT_ fourcc codes and return
> the currently 'active' one when requested by the preceding bridge.

In my case this is not possible, the bridge supports maximum rgb888
input, but since it cannot know how much of that is actually wired,
the actual format needs to be provided manually somewhere. In my
case, I know that I want to send rgb565 to the bridge. Sure, the
wiring between the encoder and the bridge chip could be seen as
another "bridge" that goes from rgb565 to rgb888, but adding some
extra layer to the model for this step seems like over-engineering
to me. Especially when the binding for the generic lvds-transmitter
bridge needs to specify the input format anyway. At least, that's
the right thing to do if you ask me. How else should it know what
format to request?

> I understand for this driver, being compatible with both a generic lvds
> encoder and a specific chip, the supported input formats are
> different, but I would have used the 'of_device_id.data' field for
> this and leave this out from DT bindings.

No, the lvds-transmitter accepts parallel input and spits out lvds,
just like the specific chip I'm using. I do not *need* to specify the
specific chip, and the driver does nothing special for it. It is just
good practice to specify the details when they are readily available.

> This makes the translation routine here implemented not required if
> I'm not wrong...

I think you are.

Cheers,
Peter

> Thanks
>    j
> 
>>  Required nodes:
>>
>>  This device has two video ports. Their connections are modeled using the OF
>> diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
>> index 75b0d3f6e4de..b78619b5560a 100644
>> --- a/drivers/gpu/drm/bridge/lvds-encoder.c
>> +++ b/drivers/gpu/drm/bridge/lvds-encoder.c
>> @@ -9,6 +9,7 @@
>>
>>  #include <drm/drmP.h>
>>  #include <drm/drm_bridge.h>
>> +#include <drm/drm_of.h>
>>  #include <drm/drm_panel.h>
>>
>>  #include <linux/of_graph.h>
>> @@ -16,6 +17,8 @@
>>  struct lvds_encoder {
>>  	struct drm_bridge bridge;
>>  	struct drm_bridge *panel_bridge;
>> +	int num_bus_formats;
>> +	u32 *bus_formats;
>>  };
>>
>>  static int lvds_encoder_attach(struct drm_bridge *bridge)
>> @@ -28,8 +31,22 @@ static int lvds_encoder_attach(struct drm_bridge *bridge)
>>  				 bridge);
>>  }
>>
>> +static int lvds_encoder_input_formats(struct drm_bridge *bridge,
>> +				      const u32 **bus_formats)
>> +{
>> +	struct lvds_encoder *lvds_encoder = container_of(bridge,
>> +							 struct lvds_encoder,
>> +							 bridge);
>> +
>> +	if (lvds_encoder->num_bus_formats)
>> +		*bus_formats = lvds_encoder->bus_formats;
>> +
>> +	return lvds_encoder->num_bus_formats;
>> +}
>> +
>>  static struct drm_bridge_funcs funcs = {
>>  	.attach = lvds_encoder_attach,
>> +	.input_formats = lvds_encoder_input_formats,
>>  };
>>
>>  static int lvds_encoder_probe(struct platform_device *pdev)
>> @@ -39,6 +56,7 @@ static int lvds_encoder_probe(struct platform_device *pdev)
>>  	struct device_node *panel_node;
>>  	struct drm_panel *panel;
>>  	struct lvds_encoder *lvds_encoder;
>> +	int ret;
>>
>>  	lvds_encoder = devm_kzalloc(&pdev->dev, sizeof(*lvds_encoder),
>>  				    GFP_KERNEL);
>> @@ -79,6 +97,12 @@ static int lvds_encoder_probe(struct platform_device *pdev)
>>  	if (IS_ERR(lvds_encoder->panel_bridge))
>>  		return PTR_ERR(lvds_encoder->panel_bridge);
>>
>> +	ret = drm_of_bus_formats(pdev->dev.of_node, "interface-pix-fmt",
>> +				 &lvds_encoder->bus_formats);
>> +	if (ret < 0)
>> +		return ret;
>> +	lvds_encoder->num_bus_formats = ret;
>> +
>>  	/* The panel_bridge bridge is attached to the panel's of_node,
>>  	 * but we need a bridge attached to our of_node for our user
>>  	 * to look up.
>> @@ -96,6 +120,7 @@ static int lvds_encoder_remove(struct platform_device *pdev)
>>  {
>>  	struct lvds_encoder *lvds_encoder = platform_get_drvdata(pdev);
>>
>> +	kfree(lvds_encoder->bus_formats);
>>  	drm_bridge_remove(&lvds_encoder->bridge);
>>
>>  	return 0;
>> --
>> 2.11.0
>>
