From: icenowy@aosc.io (icenowy at aosc.io)
Date: Tue, 27 Jun 2017 23:29:10 +0800
Subject: [linux-sunxi] Re: [PATCH v3 2/3] dt-bindings: input: Add R_LRADC
 support for A83T
In-Reply-To: <CAAST=9x+fS41tznuJ9hQ-cQxecKN751=61YkhEt31DvpeqeEcA@mail.gmail.com>
References: <20170624024515.4669-1-techping.chan@gmail.com>
 <20170624024515.4669-3-techping.chan@gmail.com>
 <20170626171524.cqfyasetpsfr6xfg@flea.lan>
 <CAAST=9x+fS41tznuJ9hQ-cQxecKN751=61YkhEt31DvpeqeEcA@mail.gmail.com>
Message-ID: <24845446a80e3542d90a1111a6141415@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-06-27 23:18?Ziping Chen ???
> 2017-06-27 1:15 GMT+08:00 Maxime Ripard 
> <maxime.ripard@free-electrons.com>:
>> Hi,
>> 
>> On Sat, Jun 24, 2017 at 10:45:14AM +0800, Ziping Chen wrote:
>>> From: Ziping Chen <techping.chan@gmail.com>
>>> 
>>> Allwinner A83T SoC has a low res adc like the one
>>> in Allwinner A10 SoC.
>>> 
>>> Add binding for it.
>>> 
>>> Signed-off-by: Ziping Chen <techping.chan@gmail.com>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt | 6 
>>> ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>> 
>>> diff --git 
>>> a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt 
>>> b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
>>> index 4357e498ef04..525d85e3043f 100644
>>> --- a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
>>> +++ b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
>>> @@ -2,12 +2,14 @@ Allwinner sun4i low res adc attached tablet keys
>>>  ------------------------------------------------
>>> 
>>>  Required properties:
>>> - - compatible: "allwinner,sun4i-a10-lradc-keys"
>>> + - compatible: should be one of the following string:
>>> +             "allwinner,sun4i-a10-lradc-keys"
>>> +             "allwinner,sun8i-a83t-r-lradc-keys"
>> 
>> This doesn't really have anything related to keys, and can be used
>> purely as an ADC.
>> 
>> I know this is the compatible that was used for the A10, but I'd
>> rather drop the keys for the the new compatible.
>> 
> 
> Hi,
> LRADC is named KEYADC in some other SoCs' User Manual(such as R40 User
> Manual V1.0), thus LRADC is related to keys.
> 
> Without keys there is another driver named sun4i-gpadc-iio which is
> located at driver/iio/adc/sun4i-gpadc-iio.c

Nope. The general purpose LRADC driver still doesn't land in mainline,
and this driver is for the GPADC related to thermal and resistive
touch screen.

However, the LRADC is possible to be used in general purpose, and
more and more boards are wiring the LRADC pin as a pin on the pinout
(e.g. Pine64 and Lichee Pi Zero) and it may be useful.

And the hardware is not bound to keys -- it's only the Allwinner
reference design which bind the LRADC to keys. Device vendors can
change it if needed.

So it's suggested to have a binding without "-keys".

Maxime, here's another problem: if we have already a GP LRADC driver,
how can we tell the kernel to use it as IIO ADC rather than keys?
Should we introduce a new property for this once ready?
