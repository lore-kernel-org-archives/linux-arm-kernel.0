From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 7 Nov 2012 23:04:36 +0800
Subject: [PATCH v3 5/9] document: devicetree: bind pinconf with pin-single
In-Reply-To: <5092B9A0.9000204@wwwdotorg.org>
References: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
 <1351724661-29050-6-git-send-email-haojian.zhuang@gmail.com>
 <5092B9A0.9000204@wwwdotorg.org>
Message-ID: <CAN1soZxJFOLUDSCBuk8z7GVUFszLtV3gdhNb6q_zLmESMbJupA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 2, 2012 at 2:04 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 10/31/2012 05:04 PM, Haojian Zhuang wrote:
>> Add comments with pinconf & gpio range in the document of
>> pinctrl-single.
>
> I'd tend to suggest separating the series to add GPIO range support and
> pinconf support, especially since didn't Tony suggest a separate driver
> for pinconf? Perhaps that was just for non-generic properties.
>
>> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
>
>> +- pinctrl-single,gpio-ranges : gpio range list of phandles.
>> +  Must be present if gpio range phandle is specified.
>> +  This property should be existing in .dtsi files for those silicons.
>> +
>> +- pinctrl-single,gpio : array with gpio range start, size & register
>> +  offset. Must be present if gpio range phandle is specified.
>> +  This property should be existing in .dts files for those boards.
>> +
>> +- pinctrl-single,gpio-func : gpio function value in the pinmux register.
>> +  Must be present if gpio range phandle is specified.
>> +  This property should be existing in .dts files for those boards.
>
> I don't see any reason why pinctrl-single,gpio or
> pinctrl-single,gpio-func are board-specific rather than SoC-specific.

Oh, I wrote it with error. It should be SoC-specific.

> Surely it's the Soc HW construction that defines how the pinctrl and
> GPIO modules relate to each-other? I would simply remove the last
> sentence from each of the three descriptions above.
>
> Also, isn't this list a list of properties for the main pinctrl-single
> node itself? I think you should split the list up as follows:
>
> 1) A description of the main node
> 2) A list of required and optional properties for the main node
> 3) A description of what a GPIO range node is
> 4) A list of required and optional properties for a GPIO range node.
>
> I think that would explain the whole structure a lot more clearly.
>
> Oh, and why not just get rid of the pinctrl-single,gpio-ranges property
> entirely, and simply make the GPIO range definitions be child nodes of
> the pinctrl-single node? That would require them to either be named
> according to some scheme or have some compatible property to
> differentiate them from any other nodes, but I think that's workable.
>
Em. Removing pinctrl-single,gpio-ranges should be better. Now I define
range as sub node. There're two properties in this sub-node: reg &
pinctrl-single,gpio.

>> @@ -42,6 +77,15 @@ Where 0xdc is the offset from the pinctrl register base address for the
>>  device pinctrl register, 0x18 is the desired value, and 0xff is the sub mask to
>>  be used when applying this change to the register.
>>
>> +In case pinctrl device supports gpio function, it needs to define gpio range.
>> +All the phandles of gpio range list should be set in below:
>> +
>> +     pinctrl-single,gpio-ranges = <[phandle of gpio range]>;
>> +
>> +     [phandle of gpio range]: {
>
> That's a label, not a phandle. The reference to the label gets compiled
> to a phandle in the DTB. The node name is missing. you should probably
> just use an example label and re-write the last 3 lines as:
>
>         pinctrl-single,gpio-ranges = <&range0>;
>
>         range0: range0 {
>
Updated.
