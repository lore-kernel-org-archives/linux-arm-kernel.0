From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 15 Nov 2012 16:27:19 +0800
Subject: [PATCH v4 5/9] document: devicetree: bind pinconf with pin-single
In-Reply-To: <50A15E0C.2010903@wwwdotorg.org>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
 <1352301582-12244-6-git-send-email-haojian.zhuang@gmail.com>
 <50A15E0C.2010903@wwwdotorg.org>
Message-ID: <CAN1soZw8Nx7EyNb1FDtwRkA+o8hokQRv_bEQ1W04+rnNMnozHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 4:37 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/07/2012 08:19 AM, Haojian Zhuang wrote:
>> Add comments with pinconf & gpio range in the document of
>> pinctrl-single.
>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
>
>>  Required properties:
>> -- compatible : "pinctrl-single"
>> +- compatible : "pinctrl-single" or "pinconf-single".
>> +  "pinctrl-single" means that pinconf isn't supported.
>> +  "pinconf-single" means that generic pinconf is supported.
>>
>>  - reg : offset and length of the register set for the mux registers
>>
>> @@ -14,9 +16,33 @@ Optional properties:
>>  - pinctrl-single,function-off : function off mode for disabled state if
>>    available and same for all registers; if not specified, disabling of
>>    pin functions is ignored
>> +
>>  - pinctrl-single,bit-per-mux : boolean to indicate that one register controls
>>    more than one pin
>>
>> +- pinctrl-single,power-source-mask : mask of setting power source in
>> +  the pinmux register
>> +
>> +- pinctrl-single,power-source : value of setting power source field
>> +  in the pinmux register
>
> Isn't power-source an enumeration? As such, shouldn't the pinctrl state
> definition supply the value, rather than the pin controller definition?
>
> The above two properties imply to me that you're saying "these bits
> (power-source-mask) in any pin register must be set to this one value
> (power-source)". However, I think you want to say "these bits
> (power-source-mask) are used to configure the power source", and then
> allow the state nodes (what's reference from pinctrl client devices'
> pinctrl-n properties) to define the value.

Got it.

>
> Perhaps that's your intent already, but if so, the properties for the
> two different nodes should be documented separately, not all interleaved
> in a single list, without any indication of which node they get put into.
>
>> +- pinctrl-single,bias-mask : mask of setting bias value in the pinmux
>> +  register
>> +
>> +- pinctrl-single,bias-disable : value of disabling bias in the pinmux
>> +  register
>> +
>> +- pinctrl-single,bias-pull-down : value of setting bias pull down in
>> +  the pinmux register
>> +
>> +- pinctrl-single,bias-pull-up : value of setting bias pull up in the
>> +  pinmux register
>> +
>> +- pinctrl-single,bias : value of setting bias in the pinmux register
>
> If there are bias-disable, bias-pull-down, and bias-pull-up properties,
> what is the plain "bias" property for?
>
Sure. I'll use input bias to explain it.

>> +- pinctrl-single,input-schmitt-mask : mask of setting input schmitt
>> +  in the pinmux register
>
> And if the "value" properties go into the pinctrl state nodes, why isn't
> there a "value" property for schmitt?
>
>> +Optional sub-node: In case some pins could be configured as GPIO in the pinmux
>> +register. If both GPIO nubmer and pin base of those pins are in ascending order,
>> +those pins could be defined as a GPIO range. The sub-node should be defined in
>> +.dtsi files of those silicons.
>
> Pinctrl state definitions are also nodes directly inside the pin
> controller node. How does the pin controller driver know whether a child
> node is a state definition, or a GPIO range? Is the node required to
> have some specific name?

I think that "pinctrl-single,gpio" is enough. If the child node
doesn't contain the
gpio property, it won't be parsed as gpio range sub-node.
