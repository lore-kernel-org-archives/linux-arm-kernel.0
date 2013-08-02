From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 02 Aug 2013 14:09:35 -0600
Subject: [PATCH v10] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <20130802092823.GA2884@e106331-lin.cambridge.arm.com>
References: <1374139586-6344-1-git-send-email-p.zabel@pengutronix.de>
 <20130802092823.GA2884@e106331-lin.cambridge.arm.com>
Message-ID: <51FC11FF.4060604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2013 03:28 AM, Mark Rutland wrote:
> On Thu, Jul 18, 2013 at 10:26:26AM +0100, Philipp Zabel wrote:
>> This driver implements a reset controller device that toggle a gpio
>> connected to a reset pin of a peripheral IC. The delay between assertion
>> and de-assertion of the reset signal can be configured via device tree.

>> diff --git a/Documentation/devicetree/bindings/reset/gpio-reset.txt b/Documentation/devicetree/bindings/reset/gpio-reset.txt

>> +GPIO reset controller
>> +=====================
>> +
>> +A GPIO reset controller controls a single GPIO that is connected to the reset
>> +pin of a peripheral IC. Please also refer to reset.txt in this directory for
>> +common reset controller binding usage.
>> +
>> +Required properties:
>> +- compatible: Should be "gpio-reset"
>> +- reset-gpios: A gpio used as reset line. The gpio specifier for this property
>> +               depends on the gpio controller that provides the gpio.
>> +- #reset-cells: 0, see below
>> +
>> +Optional properties:
>> +- reset-delay-us: delay in microseconds. The gpio reset line will be asserted for
>> +                  this duration to reset.
>> +- initially-in-reset: boolean. If not set, the initial state should be a
>> +                      deasserted reset line. If this property exists, the
>> +                      reset line should be kept in reset.
>> +
>> +example:
>> +
>> +sii902x_reset: gpio-reset {
>> +	compatible = "gpio-reset";
>> +	reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
>> +	reset-delay-us = <10000>;
>> +	initially-in-reset;
>> +	#reset-cells = <0>;
>> +};
>> +
>> +/* Device with nRESET pin connected to GPIO5_0 */
>> +sii902x at 39 {
>> +	/* ... */
>> +	resets = <&sii902x_reset>; /* active-low GPIO5_0, 10 ms delay */
>> +};
> 
> I don't like the approach here. The reset GPIO line is not a device in
> itself, and surely the way in which it must be toggled to reset a device
> is a property of that device, not the GPIO. We're leaking a Linux
> internal abstraction rather than describing the hardware.

At first, I was going to say I disagree completely, but I do see your point.

I don't think that having a separate reset controller concept in DT, and
having a GPIO implementation of that, is purely exposing Linux concepts
in the DT. It's just one way of looking at the HW. As you say, another
is that any external chip that needs reset has a GPIO input.

The history here is that we have to concept of IP modules inside a chip
that can be reset, and that reset is driven by some external entity to
the IP block, and hence there's a concept of a "reset controller" that
drives that reset. That enables arbitrary different implementations to
cover the case of the IP block being dropped into different SoCs with
different ways of resetting it.

Extend that same concept to external chips that happen to have GPIOs
driving the chip's reset inputs, and you get this GPIO reset controller
binding.

On the surface, any external chip is going to be reset by a GPIO, and
hence that should be represented by a property in that external chip's
DT node, just as you say.

But what if the reset pin is /not/ hooked up to a GPIO? What if there's
a dedicated "reset" HW device that drives the reset input, and all it
can do is pulse the reset, not maintain it at some static level, and
hence that signal can't be represented as a GPIO? Or what if the core of
the external chip gets integrated into an SoC, which has a reset
controller rather than a GPIO input? Of course, I have no idea how
likely this would be.

To cover those cases, continuing to abstract the reset input
semantically as a reset input, rather than as a plain GPIO, might make
sense.

> I think thie linkage of the gpio would be better described on the node
> for the device with the reset input, in a binding-specific property for
> the device (e.g. names for the specific input line on the device):
> 
> I'd imagine the delay required would be fixed for a device (or possibly
> influenced by clock inputs), and can either be knwon by the driver
> without dt information, or discovered elsewhere (e.g. dervied from the
> rates of clock inputs). We shuold be able to derive that from the
> compatible string in most cases.
> 
> I think this should look more like the below:
> 
> /* Device with nRESET pin connected to GPIO5_0 */
> sii902x at 39 {
> 	/* named for the actual input line */
> 	nreset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> 	/* 
> 	 * If there's some configurable property relating to the reset
> 	 * line, we can describe it
> 	 */
> 	vendor,some-optional-reset-gpio-property;
> 	...
> };

If we decide to ignore the case where the reset signal isn't driven by a
GPIO, yes, the above binding does look better.
