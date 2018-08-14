From: peda@axentia.se (Peter Rosin)
Date: Tue, 14 Aug 2018 08:35:30 +0200
Subject: [PATCH v8 3/4] drm/atmel-hlcdc: iterate over all output endpoints
In-Reply-To: <CAL_JsqJPzwpN2TFghy-FfHZppexG9gW4qBy6iYtGpyP_Bp6dUA@mail.gmail.com>
References: <20180810130359.9882-1-peda@axentia.se>
 <20180810130359.9882-4-peda@axentia.se>
 <20180813135949.32vrlrevtazr5x7d@apu3b.nibble.pw>
 <0baac94e-f3d2-53fd-4af9-854bb4498345@axentia.se>
 <CAL_JsqJPzwpN2TFghy-FfHZppexG9gW4qBy6iYtGpyP_Bp6dUA@mail.gmail.com>
Message-ID: <5c9853fc-e2ea-6983-ac88-b52b6e9e6ecd@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-08-13 22:52, Rob Herring wrote:
> On Mon, Aug 13, 2018 at 8:25 AM Peter Rosin <peda@axentia.se> wrote:
>>
>> On 2018-08-13 15:59, jacopo mondi wrote:
>>> Hi Peter,
>>>
>>> On Fri, Aug 10, 2018 at 03:03:58PM +0200, Peter Rosin wrote:
>>>> This enables more flexible devicetrees. You can e.g. have two output
>>>> nodes where one is not enabled, without the ordering affecting things.
> 
> Your DTs are not supposed to be flexible. They should be well defined
> by the binding.

I feel the need to explain the situation with more words...

We have a board with this atmel-hlcdc wired to both an LVDS encoder
and an HDMI encoder. Depending on how we integrate this board, only
one of these paths make sense. Hence, I would like to do the following
in a .dtsi for that board:

/ {
	hlcdc-display-controller {
		...
		port at 0 {
			hlcdc_lvds: endpoint at 0 {
				reg = <0>;
				remote-endpoint = <&lvds_encoder_input>;
			};

			hlcdc_hdmi: endpoint at 1 {
				reg = <1>;
				remote-endpoint = <&hdmi_encoder_input>;
			};
		};
	};

	lvds_encoder: lvds-encoder {
		status = "disabled";

		...

		ports {
			#address-cells = <1>;
			#size-cells = <0>;

			port at 0 {
				reg = <0>;

				lvds_encoder_input: endpoint {
					remote-endpoint = <&hlcdc_lvds>;
				};
			};

			port at 1 {
				reg = <1>;

				lvds_encoder_output: endpoint {
				};
			};
		};
	};
};

&i2c2 {
	...
	hdmi_encoder: hdmi-encoder at 70 {
		status = "disabled";

		...

		port {
			hdmi_encoder_input: endpoint {
				remote-endpoint = <&hlcdc_hdmi>;
			};
		};
	};
};


And then, depending on what components are fitted and what LVDS panel has
been attached to the LVDS encoder output, this can be used as follows
in the .dts file for LVDS case:

/ {
	panel: panel {
		compatible = "litemax,dlf2118", "panel-lvds";

		...

		port {
			panel_input: endpoint {
				remote-endpoint = <&lvds_encoder_output>;
			};
		};
	};
};


&lvds_encoder {
	status = "okay";
};

&lvds_encoder_output {
	remote-endpoint = <&panel_input>;
};


For the HDMI case, it would be this in the .dts file:

&hdmi_encoder {
	status = "okay";
};


The above seem so much better than just having the following in
the .dtsi file

/ {
	hlcdc-display-controller {
		...
		port at 0 {
			hlcdc_lvds: endpoint {
				remote-endpoint = <&encoder_input>;
			};
		};
	};
};

and pushing the lvds-encoder and hdmi-encoder nodes (slightly modified) down
to the relevant .dts files. Especially so since we have to this point
delivered several variants with different LVDS panels. The duplication
is ugly, and the number of different panels is expected to grow...

But maybe I have misunderstood what endpoints are all about, but to me
the actual endpoint id is not that interesting and I see nothing in the
graph binding that suggests that endpoint id 0 has to be up and kicking
in order for endpoint id 1 to be examined at all.

For ports, yes, you are right that the port id needs to be defined and
fixed for a specific function, so scratch that. It was just a "maybe"
question anyway...

>>>>
>>>> Prior to this patch the active node had to have endpoint id zero.
>>>>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 32 ++++++++++++++++++------
>>>>  1 file changed, 25 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>>>> index 8db51fb131db..16c1b2f54b42 100644
>>>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>>>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>>>> @@ -31,14 +31,16 @@ static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
>>>>      .destroy = drm_encoder_cleanup,
>>>>  };
>>>>
>>>> -static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>>>> +static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
>>>> +                                   struct of_endpoint *endpoint)
>>>>  {
>>>>      struct drm_encoder *encoder;
>>>>      struct drm_panel *panel;
>>>>      struct drm_bridge *bridge;
>>>>      int ret;
>>>>
>>>> -    ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
>>>> +    ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
>>>> +                                      endpoint->port, endpoint->id,
>>>
>>> You are refusing endpoint->port != 0 in the caller, so that could be
>>> 0.
>>
>> Yes, it could. However, I intentionally did not write 0 here, so that
>> the logic related to "port has to be zero" was in one place and not
>> scattered about. I guess it's up to Boris?
>>
>> Maybe the port do not actually have to be zero at all? With the old
>> code, it was kind of understandable that the port number was fixed,
>> but for the code in my patch it does not matter at all AFAICT. There
>> is nothing in the binding docs (except for the example) that hints
>> that port has to be zero, so that's one thing in favor of just getting
>> rid of the port number checking altogether...
> 
> The port numbering must be defined and fixed. If that is not clear in
> the binding, fix the binding.

Ok, so the code in my patch does the right thing forcing the port
number to zero.

>>>> @@ -77,13 +79,29 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>>>>
>>>>  int atmel_hlcdc_create_outputs(struct drm_device *dev)
>>>>  {
>>>> -    int endpoint, ret = 0;
>>>> -
>>>> -    for (endpoint = 0; !ret; endpoint++)
>>>> -            ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
>>>> +    struct of_endpoint endpoint;
>>>> +    struct device_node *node = NULL;
>>>> +    int count = 0;
>>>> +    int ret = 0;
>>>> +
>>>> +    for_each_endpoint_of_node(dev->dev->of_node, node) {
>>>> +            of_graph_parse_endpoint(node, &endpoint);
> 
> I'd really like to kill off of_graph_parse_endpoint, not add more
> users (check the git history on this code). You should know what are
> possible port and endpoint numbers, so iterate over those.

So, add a comment to that effect in the docs of the of_graph_parse_endpoint
function.

How can the hlcdc driver know the actual number of endpoints? It's a
one-way signal path out from that port, and it can easily be routed to
1, 2, 3 or even more places. As shown above, forcing the endpoint id
to start at zero is a nuisance, and I don't see the point of it.

But I welcome suggestions on how to arrange the above dtsi/dts fragments
in a world where the endpoint id absolutely has to start at zero.

Cheers,
Peter

>>>> +
>>>> +            if (endpoint.port)
>>>> +                    continue;
>>>> +
>>>> +            ret = atmel_hlcdc_attach_endpoint(dev, &endpoint);
>>>> +            if (ret == -ENODEV)
>>>> +                    continue;
>>>> +            if (ret) {
>>>> +                    of_node_put(node);
>>>> +                    break;
>>>> +            }
>>>> +            count++;
>>>> +    }
>>>>
>>>>      /* At least one device was successfully attached.*/
>>>> -    if (ret == -ENODEV && endpoint)
>>>> +    if (ret == -ENODEV && count)
>>>>              return 0;
>>>>
>>>>      return ret;
>>>> --
>>>> 2.11.0
>>>>
>>
