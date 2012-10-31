From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 31 Oct 2012 16:26:50 -0600
Subject: [PATCH v2 5/9] document: devicetree: bind pinconf with pin-single
In-Reply-To: <CAN1soZy8xXGs8zEiZV0kV0dGVdXfZ9ogx83sFgPG76d0i8yH4A@mail.gmail.com>
References: <1350922139-3693-1-git-send-email-haojian.zhuang@gmail.com>
 <1350922139-3693-6-git-send-email-haojian.zhuang@gmail.com>
 <5085CC3F.30708@wwwdotorg.org>
 <CAN1soZy8xXGs8zEiZV0kV0dGVdXfZ9ogx83sFgPG76d0i8yH4A@mail.gmail.com>
Message-ID: <5091A5AA.7000207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2012 10:58 AM, Haojian Zhuang wrote:
> On Tue, Oct 23, 2012 at 6:44 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 10/22/2012 10:08 AM, Haojian Zhuang wrote:
>>> Add comments with pinconf & gpio range in the document of
>>> pinctrl-single.
...
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
...
>>> @@ -17,6 +17,36 @@ Optional properties:
>>>  - pinctrl-single,bit-per-mux : boolean to indicate that one register controls
>>>    more than one pin
>>>
>>> +- pinctrl-single,gpio-ranges : gpio range list
>>> +
>>> +- pinctrl-single,gpio : array with gpio range start, size & register
>>> +  offset
>>> +
>>> +- pinctrl-single,gpio-func : gpio function value in the pinmux register
...
>> 2) pinctrl-single,gpio is listed as optional. Presumably it's not; every
>> GPIO range node must have this property?
>>
> Yes, they must be included in GPIO range node. But if GPIO feature
> isn't supported in the pinctrl device, pinctrl-single,gpio is still optional.
> I'll add more comments on this.
> 
>> 3) Why is pinctrl-single,gpio-func optional? Presumably you always need
>> to program the pinmux HW to select the GPIO function. Yet, the driver
>> code in an earlier patch seems to deliberately do nothing if this
>> property is missing. Shouldn't the DT parsing return an error instead?
>>
> pinctrl-single,gpio-func is optional for above reason.

Presumably the node that contains the pinctrl-single,gpio-func property
is optional, but once you have such a node, pinctrl-single,gpio-func is
required?

>>> +- pinctrl-single,power-source-mask : mask of setting power source in
>>> +  the pinmux register
>>> +
>>> +- pinctrl-single,power-source : value of setting power source field
>>> +  in the pinmux register
...
>> I suppose it's OK that a generic pin controller binding would use the
>> generic pin configuration config options. I'm still not convinced that
>> the semantics of generic pin control make sense. Maybe if they're just
>> arbitrary names for SoC-specific things it's fine though.
>>
>> Do these patches expose /all/ generic pin configuration options? It
>> doesn't seem worth exposing only some of them and ignoring others.
>
> I believe general pinconf can't support all cases in different silicons.

I tend to agree.

> And we still have some common features that could be covered in general
> pinconf. So we need a structure to support both pinconf & specific pinconf.

But that tends to imply that adding support for generic pinconf into the
pinctrl-simple driver isnt' actually going to be useful for anyone. If
pinctrl-single only supports some part of your HW, how can you use it?
Or, do you intend to somehow make pinctrl-single support both the common
generic pinconf stuff, and somehow be extensible to support any
SoC-specific pin config fields?
