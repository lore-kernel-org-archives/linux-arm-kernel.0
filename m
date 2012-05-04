From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 May 2012 08:03:42 -0700
Subject: [PATCH] pinctrl: Add generic pinctrl-simple driver that
 supports omap2+ padconf
In-Reply-To: <20120504044305.GD7788@game.jcrosoft.org>
References: <20120502172401.GG3739@atomide.com>
 <20120503065131.GA3738@game.jcrosoft.org>
 <20120503152708.GC5140@atomide.com>
 <4FA30805.5050804@wwwdotorg.org>
 <20120504044305.GD7788@game.jcrosoft.org>
Message-ID: <20120504150342.GI5140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> [120503 22:08]:
> 
> In my mind in the driver we do not have to care how to list
> register/unregister the group. We just need to be able to do this
> 
> pinctrl_register_group(...)
> 
> or 
> 
> pinctrl_unregistewr_group(...)
> 
> On at91 we have this type of controller

Ah I see. Yeah makes sense. Also I think we should let the pinctrl
core eventually manage the pins more too. Right now the pins are
a static array in the driver, which makes things unnecessarily
complex for the DT case. It would be nice to also have something like
pinctrl_register/unregister_pin instead of requiring them all
be registered while registering with the framework initially.

But all that can be improved later on once we get the binding down..
 
> one pin can have multiple function and each function can be on different pin
> and we need to program and represent each of them one by one
> 
> And each pin have different parameter
> 
> so I was thinking to do like on gpio
> 
> uart {
> 	pin = < &pioA 12 {pararms} >
> 
> }

Hmm I assume the "12" above the gpio number?
 
> and use macro as basicaly we are just this
> 
> and this can be applied to tegra too as you will just refer the pin in this hw
> pin block

I was thinking of adding gpio eventually as a separate attribute with
something like the following. Here cam_d10 pin is used as gpio109:

cam_d10.gpio_109 {
	pinctrl-simple,cells = <0xfa 0x104>;	/* OMAP_PIN_INPUT | OMAP_MUX_MODE4 */
	gpio = <&gpio4 13 0>;			/* gpio109 */
};

The reasoning for this is that as we may not care about the gpio number
for all pins, it should be optional. Would that work for you?

Regards,

Tony
