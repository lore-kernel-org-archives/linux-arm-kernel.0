From: peda@axentia.se (Peter Rosin)
Date: Wed, 4 Apr 2018 14:35:34 +0200
Subject: [PATCH v2 0/5] allow override of bus format in bridges
In-Reply-To: <1563250.XEJxFDuW0h@avalon>
References: <20180326212447.7380-1-peda@axentia.se> <2233231.my6BbD3pcT@avalon>
 <CAKMK7uH-=BqU+vuePTq4joY3XS2ypvtSKYvpv1LLyovPpSXv6A@mail.gmail.com>
 <1563250.XEJxFDuW0h@avalon>
Message-ID: <9af25e5a-7334-b07c-ff49-46530df6b1aa@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-04 11:07, Laurent Pinchart wrote:
> Hi Daniel,
> 
> On Wednesday, 4 April 2018 09:34:41 EEST Daniel Vetter wrote:
>> On Wed, Apr 4, 2018 at 12:28 AM, Laurent Pinchart wrote:
>>> On Wednesday, 28 March 2018 10:08:26 EEST Daniel Vetter wrote:
>>>> On Mon, Mar 26, 2018 at 11:24:42PM +0200, Peter Rosin wrote:
>>>>> Hi!
>>>>>
>>>>> [I got to v2 sooner than expected]
>>>>>
>>>>> I have an Atmel sama5d31 hooked up to an lvds encoder and then
>>>>> on to an lvds panel. Which seems like something that has been
>>>>> done one or two times before...
>>>>>
>>>>> The problem is that the bus_format of the SoC and the panel do
>>>>> not agree. The SoC driver (atmel-hlcdc) can handle the
>>>>> rgb444, rgb565, rgb666 and rgb888 bus formats. The hardware is
>>>>> wired for the rgb565 case. The lvds encoder supports rgb888 on
>>>>> its input side with the LSB wires for each color simply pulled
>>>>> down internally in the encoder in my case which means that the
>>>>> rgb565 bus_format is the format that works best. And the panel
>>>>> is expecting lvds (vesa-24), which is what the encoder outputs.
>>>>>
>>>>> The reason I "blame" the bus_format of the drm_connector is that
>>>>> with the below DT snippet, things do not work *exactly* due to
>>>>> that. At least, it starts to work if I hack the panel-lvds driver
>>>>> to report the rgb565 bus_format instead of vesa-24.
>>>>>
>>>>>     panel: panel {
>>>>>             compatible = "panel-lvds";
>>>>>             
>>>>>             width-mm = <304>;
>>>>>             height-mm = <228;
>>>>>             
>>>>>             data-mapping = "vesa-24";
>>>>>             
>>>>>             panel-timing {
>>>>>                     // 1024x768 @ 60Hz (typical)
>>>>>                     clock-frequency = <52140000 65000000 71100000>;
>>>>>                     hactive = <1024>;
>>>>>                     vactive = <768>;
>>>>>                     hfront-porch = <48 88 88>;
>>>>>                     hback-porch = <96 168 168>;
>>>>>                     hsync-len = <32 64 64>;
>>>>>                     vfront-porch = <8 13 14>;
>>>>>                     vback-porch = <8 13 14>;
>>>>>                     vsync-len = <8 12 14>;
>>>>>             };
>>>>>             
>>>>>             port {
>>>>>                     panel_input: endpoint {
>>>>>                             remote-endpoint = <&lvds_encoder_output>;
>>>>>                     };
>>>>>             };
>>>>>     };
>>>>>     
>>>>>     lvds-encoder {
>>>>>             compatible = "ti,ds90c185", "lvds-encoder";
>>>>>             
>>>>>             ports {
>>>>>                     #address-cells = <1>;
>>>>>                     #size-cells = <0>;
>>>>>                     
>>>>>                     port at 0 {
>>>>>                             reg = <0>;
>>>>>                             
>>>>>                             lvds_encoder_input: endpoint {
>>>>>                                     remote-endpoint = <&hlcdc_output>;
>>>>>                             };
>>>>>                     };
>>>>>                     
>>>>>                     port at 1 {
>>>>>                             reg = <1>;
>>>>>                             
>>>>>                             lvds_encoder_output: endpoint {
>>>>>                                     remote-endpoint = <&panel_input>;
>>>>>                             };
>>>>>                     };
>>>>>             };
>>>>>     };
>>>>>
>>>>> But, instead of perverting the panel-lvds driver with support
>>>>> for a totally fake non-lvds bus_format, I intruduce an API that allows
>>>>> display controller drivers to query the required bus_format of any
>>>>> intermediate bridges, and match up with that instead of the formats
>>>>> given by the drm_connector. I trigger this with this addition to the
>>>>>
>>>>> lvds-encoder DT node:
>>>>>             interface-pix-fmt = "rgb565";
>>>>>
>>>>> Naming is hard though, so I'm not sure if that's good?
>>>>>
>>>>> I threw in the first patch, since that is the actual lvds encoder
>>>>> I have in this case.
>>>>>
>>>>> Suggestions welcome.
>>>>
>>>> Took a quick look, feels rather un-atomic. And there's beend discussing
>>>> for other bridge related state that we might want to track (like the full
>>>> adjusted_mode that might need to be adjusted at each stage in the chain).
>>>> So here's my suggestions:
>>>>
>>>> - Add an optional per-bridge internal state struct using the support in
>>>>   https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#handling-driver-> >>   private-state
>>>>
>>>>   Yes it says "driver private", but since bridge is just helper stuff
>>>>   that's all included. "driver private" == "not exposed as uapi" here.
>>>>   Include all the usual convenience wrappers to get at the state for a
>>>>   bridge.
>>>>
>>>> - Then stuff your bus_format into that new drm_bridge_state struct.
>>>>
>>>> - Add a new bridge callback atomic_check, which gets that bridge state as
>>>>   parameter (similar to all the other atomic_check functions).
>>>>
>>>> This way we can even handle the bus_format dynamically, through the
>>>> atomic framework your bridge's atomic_check callback can look at the
>>>> entire atomic state (both up and down the chain if needed), it all neatly
>>>> fits into atomic overall and it's much easier to extend.
>>>
>>> While I think we'll eventually need bridge states, I don't think that's
>>> need yet. The bus formats reported by this patch series are static. We're
>>> not talking about the currently configured format for a bridge, but about
>>> the list of supported formats. This is similar to the bus_formats field
>>> present in the drm_display_info structure. There is thus in my opinion no
>>> need to interface this with atomic until we need to track the current
>>> format (and I think that will indeed happen at some point, but I don't
>>> think Peter needs this feature for now). That's why I've told Peter that
>>> I would like a bridge API to report the information and haven't requested
>>> a state-based implementation.
>>
>> If it's static, why a dynamic callback? Just add it to struct
>> drm_bridge, require it's filled out before registering the bridge,
>> done.
> 
> If I remember correctly I mentioned both options in my initial proposal, 
> without a personal preference. A new field in struct drm_bridge would 
> certainly work for me.

You did. Ok, so v3 coming up...

Cheers,
Peter
