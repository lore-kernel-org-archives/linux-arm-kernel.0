From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Nov 2012 11:58:47 -0700
Subject: [PATCH 1/3] gpio: Add simple poweroff-gpio driver
In-Reply-To: <20121112184340.GA15643@lizard>
References: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
 <1352650891-18356-2-git-send-email-andrew@lunn.ch>
 <50A020C5.4070506@wwwdotorg.org> <20121112082546.GU22029@lunn.ch>
 <50A1212C.2080601@wwwdotorg.org> <20121112181947.GS24583@lunn.ch>
 <20121112184340.GA15643@lizard>
Message-ID: <50A146E7.2040608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2012 11:43 AM, Anton Vorontsov wrote:
> On Mon, Nov 12, 2012 at 07:19:47PM +0100, Andrew Lunn wrote:
> [..]
>>>>>> Given appropriate devicetree bindings, this driver registers a
>>>>>> pm_power_off function to set a GPIO line high/low to power down
>>>>>> your board.
>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
>>>>>
>>>>>> +Required properties:
>>>>>> +- compatible : should be "gpio-poweroff".
>>>>>> +- gpios : The GPIO to set high/low, see "gpios property" in
>>>>>> +  Documentation/devicetree/bindings/gpio/gpio.txt. If the pin should be
>>>>>> +  low to power down the board set it to "Active Low", otherwise set
>>>>>> +  gpio to "Active High".
>>>>>
>>>>> Unfortunately, not all GPIO bindings support active high/low flags in
>>>>> the GPIO specifier. As such, the flags there are basically useless.
>>>>> Other bindings (e.g. IIRC the fixed-regulator binding) have added a
>>>>> separate active-high property to indicate the GPIO polarity. This
>>>>> binding should probably follow suite.
> 
> Should the gpio driver fix its bindings then?.. Polarity is a quite
> generic concept of a GPIO, and flags are there for a reason. I'd rather
> prefer having

There is no "GPIO driver" to fix; each GPIO driver has its own bindings,
and unfortunately, some of the GPIO binding authors chose not to include
any flags cell in the GPIO specifier (e.g. Samsung ARM SoCs IIRC, but
there are probably more).

> 	stuff-gpios = <0 0
> 		       1 0
> 		       2 1
> 		       3 0>;
> 
> Rather than
> 
> 	stuff-gpios = <0 1 2 3>;
> 	stuff-polarity-gpio-map = <0 0 1 0>;
> 
> The first scheme existed like for years already. Has it been discussed
> that it is no longer preferred?
> 
>>>> Humm, so are you saying of_get_named_gpio_flags() is deprecated?
>>>
>>> I don't know if it's deprecated, but it's certainly not useful in
>>> generic code.
>>
>> Hi Linus, Anton
>>
>> How do you see this? 
>>
>> I'm happy to implement an enable-active-high property, but it seems to
>> go against the purpose of of_get_named_gpio_flags(). Is that function
>> deprecated?
> 
> Never heard of any deprecation, and I disagree that it is "not useful in
> generic code". :)

Put more specifically, I meant: It would be useful to have such a
feature. However, since such a feature doesn't exist in all cases, it's
not possible to rely on the feature, and hence trying to isn't useful.
