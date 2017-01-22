From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Sun, 22 Jan 2017 13:51:42 +0100
Subject: [PATCH] ARM: dts: imx6q-utilite-pro: enable 2nd display pipeline
In-Reply-To: <7b5acaa225ee4e068ae058e8aaf49a44@rwthex-w2-b.rwth-ad.de>
References: <ec9676f344eb4786a28a3c7b969f0e94@rwthex-s1-b.rwth-ad.de>
 <88bdfd5321484efc82af4132ac2f0d7e@rwthex-s1-b.rwth-ad.de>
 <6ed3f695104044f18e98fc9619aab16e@rwthex-s1-b.rwth-ad.de>
 <17a7f9cea35944288f97735e66859929@rwthex-s1-b.rwth-ad.de>
 <7b5acaa225ee4e068ae058e8aaf49a44@rwthex-w2-b.rwth-ad.de>
Message-ID: <913e928974b942d48b18c52e9059321c@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

sorry for the late answer; I'm quite busy with other stuff these days.

On 01/19/2017 03:34 PM, Philipp Zabel wrote:
> Hi Christopher,
>
> On Wed, 2017-01-18 at 23:20 +0100, Christopher Spinrath wrote:
>> Hi Philipp,
>>
>> turns out I have a question on your comment after all:
>>
>> On 01/17/2017 07:35 PM, Christopher Spinrath wrote:
>>> Hi Philipp,
>>>
>>> thanks for the review!
>>>
>>> On 01/17/2017 09:57 AM, Philipp Zabel wrote:
>>>> [...]
>>>>> +
>>>>> +    parallel-display {
>>>>> +        compatible = "fsl,imx-parallel-display";
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <0>;
>>>>> +        pinctrl-names = "default";
>>>>> +        pinctrl-0 = <&pinctrl_ipu1>;
>>>>> +
>>>>> +        interface-pix-fmt = "rgb24";
>>>>
>>>> This is not necessary if the connector created by the tpf410 has the
>>>> correct media bus format set in its display_info structure. This can be
>>>> done in tfp410_attach, before calling drm_mode_connector_attach_encoder:
>>>>
>>>>         u32 bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>>>>
>>>>     drm_display_info_set_bus_formats(&dvi->connector.display_info,
>>>>                      &bus_format, 1);
>>>>
>>>> After this is done, the above line should be removed in a follow-up
>>>> patch.
>>
>> On closer inspection the tfp410 can handle rgb12, rgb24, and DVI
>> formats. Considering this it feels wrong to hardcode the bus format to
>> rgb24 (isn't it?).
>
> That is a good point, I agree. I have some thoughts on this:
>
>> So a solution might be to add a property specifying the bus format to
>> the tfp410 binding. But then we would effectively just move this
>> property from one node to another. I wonder if this is still desireable...?
>
> If this is configurable on both ends, the necessary setting is neither a
> hardware property of the bridge, nor of the display interface, but
> rather one of the board specific wiring between the two (if at all).
>
> Ideally all possible settings should be known to the drivers and the
> best format should be negotiated. Note that display_info.bus_formats
> already is an array of possible bus formats, even though the parallel
> display driver currently only looks at the first element.
>
> If there is no limitation imposed by the wiring, presenting best format
> first in that array seems reasonable for now.

The tfp410 can be operated either in i2c mode or in dump mode (i2c is 
not wired up). The Linux driver does only support dump mode so far. (In 
essence the driver does nothing but the neccesary boilerplate stuff.) 
While the format can be read and changed neither is possible in the dumb 
mode. The format is configured by connecting some pins of the chip to 
ground. So we have to deal with the "otherwise" case below.

> Otherwise I think the links should describe the parallel bus layout,
> which is specified for the (input) media video interfaces:
>
> Documentation/devicetree/bindings/media/video-interfaces.txt
>
> Using the
> 	bus-width = <24>;
> or
> 	bus-width = <12>;
> property the tfp510 driver could choose which bus_formats to add to the
> display_info.

I see your point that the format is a property of the wiring and, thus, 
it is better to utilizie the bus-width property in the of graph remote 
nodes from a modelling point of view.

On the other hand, the parallel-display already has some data on the 
wiring: the pinctrl settings. This weakens the above reasoning because 
the information is splitted up. Moreover, a quick grep session revealed 
that on all arm platforms the format is obtained from the "SoC-side" 
(read parallel-display) node, if it is dynamic. Is there some effort to 
change that? (essentially, I'm trying to understand here the 
justification for the change we are discussing).

Cheers,
Christopher

> regards
> Philipp
>
