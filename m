From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Jan 2013 09:55:20 -0700
Subject: [PATCH 2/7] reset: Add reset controller API
In-Reply-To: <1358419524.2411.126.camel@pizza.hi.pengutronix.de>
References: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
 <1358352787-15441-3-git-send-email-p.zabel@pengutronix.de>
 <50F7267E.8090309@wwwdotorg.org>
 <1358419524.2411.126.camel@pizza.hi.pengutronix.de>
Message-ID: <50F82CF8.9090202@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2013 03:45 AM, Philipp Zabel wrote:
> Hi Stephen,
> 
> Am Mittwoch, den 16.01.2013, 15:15 -0700 schrieb Stephen Warren:
>> On 01/16/2013 09:13 AM, Philipp Zabel wrote:
>>> This adds a simple API for devices to request being reset
>>> by separate reset controller hardware and implements the
>>> reset signal device tree binding.
>>
>>
>>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>>
>>> +obj-$(CONFIG_RESET_CONTROLLER) += core.o
>>> +
>>
>> nit: blank line at EOF.
> 
> Ok.
> 
>>> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
>>
>>> +/**
>>> + * reset_control_reset - reset the controlled device
>>> + * @rstc: reset controller
>>> + */
>>> +int reset_control_reset(struct reset_control *rstc)
>>
>> What time period is the reset signal asserted for; should there be a
>> parameter to control this?
> 
> "The reset controller knows".
> 
> On i.MX, the SRC does all necessary things in hardware (and optionally
> causes an interrupt to signal when it's ready - right now the SRC driver
> just polls for the reset line to deassert).

OK, I guess that does make sense. As you say, for an on-SoC reset
controller that auto-clears the reset bit, it obviously has the timing
embedded in HW, and for any other kind of reset controller, we can just
provide configuration to the controller somehow.

> For reset controllers that need to be manually asserted/deasserted, and
> still want to provide the .reset callback, we should think about some
> timing configuration. But IMHO that should be separate from the API.
> 
> I've thought about adding an example gpio-reset controller driver, which
> knows about the necessary delays and just toggles gpios. This could be
> represented in the device tree as follows:
> 
> 	gpio_reset: gpio_reset {
> 		compatible = "gpio-reset"
> 		gpios = <&gpioa 0 0>, <&gpioc 5 0>, <&gpiod 3 1>;
> 		reset-delays = <10>, <100>, <50>;
> 		#reset-cells = <1>;
> 	};
> 
> 	device-to-be-reset {
> 		resets = <&gpio_reset 2>; /* GPIOD3, active-low, 50ms */
> 	};
> 
> Or one could add another reset-cell to configure the delay:
> 
> 	gpio_reset: gpio_reset {
> 		compatible = "gpio-reset"
> 		gpios = <&gpioa 0 0>, <&gpioc 5 0>, <&gpiod 3 1>;
> 		#reset-cells = <2>;
> 	};
> 
> 	device-to-be-reset {
> 		resets = <&gpio_reset 2 50>; /* GPIOD3, active-low, 50ms */
> 	};
> 
> I'd prefer the former over the latter. In any case, I think the timing
> information should reside either in the reset controller or in the
> framework.

Sure. I think the choice of properties in the controller node vs. extra
#reset-cells is probably an individual design decision for the specific
controller driver and DT binding; it would even be possible to have one
driver support either based on its #reset-cells value, but probably
over-complex and not worth doing. Although actually, when you start
thinking about DT overlays and so on, extra #reset-cells begins to make
more sense, since the values are distributed, which makes it easier to
set them from the overlay DT file...
