From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Jul 2013 12:11:07 -0600
Subject: Issue with gpio and pinmux
In-Reply-To: <51E667BC.3070804@parrot.com>
References: <51E667BC.3070804@parrot.com>
Message-ID: <51E82FBB.1080905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2013 03:45 AM, Damien Riegel wrote:
> Hi,
> 
> 
> In our ARM-based SoC, we can multiplex up to 4 functions on each pin,
> but we have an issue when using a pin as a gpio: it can still be muxed
> as another function.

It's a good idea to Cc the maintainers of the subsystem you're asking
questions about. See the MAINTAINERS file in the kernel source tree for
clues who that is. I've CC'd LinusW here.

When you say "it can still be muxed as another function", I assume you
mean that SW is allowing someone to do that; it's not that your HW
allows this somehow?

> In the gpio driver, we delegate calls to "request" to
> "pinctrl_request_gpio":
> 
> 	static int p7gpio_request(struct gpio_chip *chip, unsigned int offset)
> 	{
> 		return pinctrl_request_gpio(chip->base + offset);
> 	}
> 
> 	static const struct gpio_chip p7gpio_chip_defaults = {
> 		.request            = p7gpio_request,
> 		[...]
> 	};
> 
> pinctrl_request_gpio will result in a call to pin_request, which behaves
> differently if we request a gpio or another function, so at kernel
> level they are not exclusive, but at hardware level they must be.

Yes, that's how pinctrl is implemented right now.

The issue is that some HW muxes groups of pins at a time, so simply
because that group of pins is "claimed" by a mux function, implies
nothing about which specific pins in that group are actually used; some
may actually still be free for usage as a GPIO.

Now obviously that doesn't make a huge amount of sense if your HW muxes
each pin individually, so there are no groups.

The solution here may be one of:

a) Modify pinctrl /not/ to allow both a GPIO and a mux function to claim
a pin *if* the group that contains the pin only contains a single pin.
This is a bit of a hacky special case though; there are other situations
where "dual claiming" shouldn't be allowed, and this doesn't solve those.

b) Ignore the issue; if the system configuration is correct, the issue
won't cause problems in practice, since nothing will be configured to
"dual claim" any pin.

c) Enhance pinctrl with extra information, so it knows which pins in a
group are usable as GPIO even when the group is claimed by a mux
function. The list of pins could theoretically vary per mux function, so
you'd need a table with lookup key (pin group, mux function) and output
data (list of pins that can be "dual claimed"). This would be a complete
solution. If a list wasn't provided, the pinctrl core could assume that
mean no dual claim was allowed.
