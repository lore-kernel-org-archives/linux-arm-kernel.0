From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 13 Jul 2017 15:35:02 -0700
Subject: [PATCH 0/3] USB Mux support for Chipidea
In-Reply-To: <fc1f2836-cd9b-0905-21fc-d2d3029d1f52@axentia.se>
References: <20170712010255.26855-1-stephen.boyd@linaro.org>
 <fc1f2836-cd9b-0905-21fc-d2d3029d1f52@axentia.se>
Message-ID: <149998530228.4532.1798948469358915658@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Rosin (2017-07-11 22:04:46)
> On 2017-07-12 03:02, Stephen Boyd wrote:
> > This patchset adds support for the TC7USB40MU usb mux found on 
> > db410c 96boards platforms via the new multiplexer framework and
> > hooks that into the chipidea driver. This allows us to properly
> > control host or device mode on this board via the sysfs knob.
> > 
> > So far I've only tested this on db410c, and there are some rough
> > edges to finish off before it can merge. Also I'm experiencing
> > odd behavior with switching the role while gadget is enabled and
> > the micro-usb cable is kept connected. Not sure what's wrong but
> > it seems like the gadget never gets disconnected? I'll investigate
> > more.
> > 
> > TODO:
> > 
> >  1. The mux framework has to be selected for consumers to use it. We'll
> >     need some stubs in the consumer header file to allow compilation to
> >     continue without mux always enabled by consumers.
> 
> Instead of "depends on MULTIPLEXER", just add "select MULTIPLEXER"
> to the Kconfig. Otherwise, you'll have to convince Linus that we
> really do need a Kconfig question for the subsystem :-)
> 
> https://lkml.org/lkml/2017/7/4/118

Ok. I'll add a select to the chipidea driver.

> 
> >  2. We probably need some sort of mux_control_get_optional() API so that
> >     we know if there was an error getting the mux control, instead of just
> >     ignoring errors. For now I can pass up EPROBE_DEFER errors and ignore
> >     other errors and consider it "missing from DT".
> 
> Yes, mux_control_get_optional should be easy to add.
> 
> >  3. Maybe we can get rid of the mux driver and just use mux-gpio.c with
> >     a compatible string update? I split it off because we may want to
> >     support the "S" pin on the TC7USB40MU one day that shuts off both

Oh this is a typo. I mean "OE" pin.

> >     mux outputs.
> 
> Maybe no need for a compatible update either, if it works to do something
> like this in the DT?
> 
>         usb_switch: usb-switch {
>                 compatible = "gpio-mux";
>                 mux-gpios = <&pm8916_gpios 4 GPIO_ACTIVE_HIGH>,
>                             <&pm8916_gpios XXX GPIO_ACTIVE_XXX>;
>                 idle-state = <2>;
>                 #mux-control-cells = <0>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&usb_sw_sel_pm>;
>         };
> 
> But I obviously know little about how things are wired and really works,
> so that might be totally off...
> 
> Otherwise, maybe a generic mux-pinctrl driver would do the trick?
> (compare with drivers/i2c/muxes/i2c-mux-pinctrl.c)
> 

Agreed. On the board I have the "OE" pin is shorted so that it always
outputs a signal. For someone else they could do what you say and add
another pin to gpio-mux binding and things will still work.
