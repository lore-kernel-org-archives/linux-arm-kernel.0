From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 05 Aug 2013 11:22:04 -0600
Subject: [PATCH v10] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <20130805151351.GB13091@e106331-lin.cambridge.arm.com>
References: <1374139586-6344-1-git-send-email-p.zabel@pengutronix.de>
 <20130802092823.GA2884@e106331-lin.cambridge.arm.com>
 <51FC11FF.4060604@wwwdotorg.org>
 <20130805151351.GB13091@e106331-lin.cambridge.arm.com>
Message-ID: <51FFDF3C.4030001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2013 09:13 AM, Mark Rutland wrote:
> On Fri, Aug 02, 2013 at 09:09:35PM +0100, Stephen Warren wrote:
>> On 08/02/2013 03:28 AM, Mark Rutland wrote:
>>> On Thu, Jul 18, 2013 at 10:26:26AM +0100, Philipp Zabel wrote:
>>>> This driver implements a reset controller device that toggle a gpio
>>>> connected to a reset pin of a peripheral IC. The delay between assertion
>>>> and de-assertion of the reset signal can be configured via device tree.
>>
>>>> diff --git a/Documentation/devicetree/bindings/reset/gpio-reset.txt b/Documentation/devicetree/bindings/reset/gpio-reset.txt
>>
>>>> +GPIO reset controller
>>>> +=====================
>>>> +
>>>> +A GPIO reset controller controls a single GPIO that is connected to the reset
>>>> +pin of a peripheral IC. Please also refer to reset.txt in this directory for
>>>> +common reset controller binding usage.
>>>> +
>>>> +Required properties:
>>>> +- compatible: Should be "gpio-reset"
>>>> +- reset-gpios: A gpio used as reset line. The gpio specifier for this property
>>>> +               depends on the gpio controller that provides the gpio.
>>>> +- #reset-cells: 0, see below
>>>> +
>>>> +Optional properties:
>>>> +- reset-delay-us: delay in microseconds. The gpio reset line will be asserted for
>>>> +                  this duration to reset.
>>>> +- initially-in-reset: boolean. If not set, the initial state should be a
>>>> +                      deasserted reset line. If this property exists, the
>>>> +                      reset line should be kept in reset.
>>>> +
>>>> +example:
>>>> +
>>>> +sii902x_reset: gpio-reset {
>>>> +	compatible = "gpio-reset";
>>>> +	reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
>>>> +	reset-delay-us = <10000>;
>>>> +	initially-in-reset;
>>>> +	#reset-cells = <0>;
>>>> +};
>>>> +
>>>> +/* Device with nRESET pin connected to GPIO5_0 */
>>>> +sii902x at 39 {
>>>> +	/* ... */
>>>> +	resets = <&sii902x_reset>; /* active-low GPIO5_0, 10 ms delay */
>>>> +};
>>>
>>> I don't like the approach here. The reset GPIO line is not a device in
>>> itself, and surely the way in which it must be toggled to reset a device
>>> is a property of that device, not the GPIO. We're leaking a Linux
>>> internal abstraction rather than describing the hardware.
>>
>> At first, I was going to say I disagree completely, but I do see your point.
>>
>> I don't think that having a separate reset controller concept in DT, and
>> having a GPIO implementation of that, is purely exposing Linux concepts
>> in the DT. It's just one way of looking at the HW. As you say, another
>> is that any external chip that needs reset has a GPIO input.
>>
>> The history here is that we have to concept of IP modules inside a chip
>> that can be reset, and that reset is driven by some external entity to
>> the IP block, and hence there's a concept of a "reset controller" that
>> drives that reset. That enables arbitrary different implementations to
>> cover the case of the IP block being dropped into different SoCs with
>> different ways of resetting it.
>>
>> Extend that same concept to external chips that happen to have GPIOs
>> driving the chip's reset inputs, and you get this GPIO reset controller
>> binding.
>>
>> On the surface, any external chip is going to be reset by a GPIO, and
>> hence that should be represented by a property in that external chip's
>> DT node, just as you say.
>>
>> But what if the reset pin is /not/ hooked up to a GPIO? What if there's
>> a dedicated "reset" HW device that drives the reset input, and all it
>> can do is pulse the reset, not maintain it at some static level, and
>> hence that signal can't be represented as a GPIO? Or what if the core of
>> the external chip gets integrated into an SoC, which has a reset
>> controller rather than a GPIO input? Of course, I have no idea how
>> likely this would be.
>>
>> To cover those cases, continuing to abstract the reset input
>> semantically as a reset input, rather than as a plain GPIO, might make
>> sense.
> 
> That does sound reasonable. Do we have any of the above cases described
> in any existing DTs?

I haven't explicitly checked, so I don't know. My argument was
admittedly entirely theoretical.

> If I've not misunderstood, there seem to be a lot of *reset-gpio*
> properties Documented (e.g. nvidia,phy-reset-gpio) which look like what
> I was suggesting (though perhaps that's a different meaning of reset,
> I'm not that familiar with PHYs).

I think that nvidia,phy-reset-gpio is exactly what we're talking about here.

> Given it's a common pattern already, I
> think it would make sense to allow for that style of binding (in
> addition to supporting more complex reset devices as required).

Yes, certainly. If for nothing else than "legacy" bindings:-) But I
think explicit properties are a perfectly reasonable approach even going
forward.
