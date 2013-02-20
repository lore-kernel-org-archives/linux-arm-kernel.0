From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Feb 2013 10:14:58 -0700
Subject: [PATCH v3 8/8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1361359326.4937.38.camel@pizza.hi.pengutronix.de>
References: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
 <1361273732-23357-9-git-send-email-p.zabel@pengutronix.de>
 <5123F541.4020407@wwwdotorg.org>
 <1361359326.4937.38.camel@pizza.hi.pengutronix.de>
Message-ID: <51250492.2010008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2013 04:22 AM, Philipp Zabel wrote:
> Am Dienstag, den 19.02.2013, 14:57 -0700 schrieb Stephen Warren:
>> On 02/19/2013 04:35 AM, Philipp Zabel wrote:
>>> This driver implements a reset controller device that toggles gpios
>>> connected to reset pins of peripheral ICs. The delay between assertion
>>> and de-assertion of the reset signal can be configured.

>>> +		/*
>>> +		 * The flags are also used to remember whether a given GPIO
>>> +		 * reset is active-low.
>>> +		 */
>>> +		if (flags & OF_GPIO_ACTIVE_LOW)
>>> +			drvdata->gpios[i].flags = GPIOF_OUT_INIT_HIGH;
>>> +		else
>>> +			drvdata->gpios[i].flags = GPIOF_OUT_INIT_LOW;
>>
>> That raises the question: What is the initial reset state expected to
>> be? Some devices might want to stay in reset until their driver
>> explicitly removes the reset signal.
>>
>> We could handle that by adding another (optional) property indicating
>> the initial reset state of each GPIO; default to initially not-in-reset
>> unless that property exists and specifies initially-in-reset.
> 
> As with the time parameter, I wonder if this configuration is something
> we want to have in the consumer device tree node, or in the gpio-reset
> device node:
> 
> 	gpio_reset: gpio-reset {
> 		compatible = "gpio-reset";
> 		reset-gpios = <&gpio2 15 0>;
> 		reset-delays = <1000>; /* 1 ms */
> 		initially-in-reset = <1>;
> 	}
> 	some-device {
> 		resets = <&gpio_reset 0>;
> 	}
> vs.
> 	gpio_reset: gpio-reset {
> 		compatible = "gpio-reset";
> 		reset-gpios = <&gpio2 15 0>;
> 	}
> 	some-device {
> 		resets = <&gpio_reset 0 1000>; /* 1 ms */
> 		initially-in-reset;
> 	}

I think that the initially-in-reset state has to be represented in the
gpio-reset node, since that's the only node that the GPIO reset driver
will have access to during its probe(), and you're setting up the GPIOs
as outputs during probe(). You can't rely on the drivers for the client
DT nodes to be probed first and provide the information to the reset
controller driver, since probe ordering is undefined. In fact those
probe()s won't have run first, because those devices depend on resources
from the reset controller driver and hence can't probe before it.

If the initially-in-reset properties are in the client device nodes,
then the GPIO reset driver would need to search all nodes for a resets
property that references the appropriate gpio-reset node, then search
for an initially-in-reset property there too. That all seems quite messy.
