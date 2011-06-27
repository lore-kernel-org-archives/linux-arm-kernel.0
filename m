From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Jun 2011 15:05:06 +0200
Subject: More pinmux feedback, and GPIO vs. pinmux interaction
In-Reply-To: <BANLkTi=kZAww_t6RrxYaAnYBRUUA3e2yLg@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF04992C067D@HQMAIL01.nvidia.com>
	<BANLkTi==jWGxbiW4QZ7SSfAdyShhEgvMig@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04992C07E5@HQMAIL01.nvidia.com>
	<BANLkTi=kZAww_t6RrxYaAnYBRUUA3e2yLg@mail.gmail.com>
Message-ID: <BANLkTikg=iTJsU7-AvoYpSoZec4XRDwjKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2011 at 5:51 AM, Mike Frysinger <vapier.adi@gmail.com> wrote:

> can you guys start cc-ing uclinux-dist-devel at blackfin.uclinux.org on
> future pinmux discussions?

OK!
Please refer to the LKML thread:
[PATCH 1/2] drivers: create a pinmux subsystem v3

For now, I'll include blackfin for the v4 post.

>?we already have a thin layer in the
> Blackfin tree for handling pin muxing that has served us well for a
> few years, so we want to keep tabs on where this is going. ?i just
> happened to stumble across this today.

Aha now it's yet another name, portmux, to add to the happy family
of pinmux, padmux, fingermux, alternate functions and mission mode
terminology soup ;-)

> arch/blackfin/include/asm/portmux.h:
> peripheral_request()
> peripheral_request_list()
> peripheral_free()
> peripheral_free_list()
>
> this lets you pass in an array of pins and it returns success only if
> all were available. ?we find the array request method gets used the
> vast majority of the time, so any proposed API should include that.

I think if you look at the Documentation/pinctrl.txt file from the
last iteration of the framework you find that this is exactly what
the pinmux part of the pinctrl subsystem does. It avoids pin
clashes in a discrete number space.

If I'm not mistaken. (Which happens a lot.)

> we also handle pins that can only be used in peripheral mode. ?this
> allows us to write code that requests UART pins without having to know
> whether the pin is muxed or dedicated or somewhere in between.

This is done with pinmux_get() and pinmux_enable() in this
framework.

>>> Grant does not seem to like the idea of the gpio subsystem
>>> meddeling with all this stuff anyway, so I intend to take all that
>>> into pinctrl, and then gpio only deal with, well GPIO. Setting
>>> bits quickly and such.
>
> but there has to be resource management between the two subsystems
> somewhere. ?on the Blackfin side, if you request a pin as a GPIO using
> the GPIO api, and then try to request it in peripheral mode, you get
> EBUSY back. ?you cant have the two blocks stepping on each others
> toes.

Yes. Avoiding this is exactly the idea behind the
int (*gpio_request_enable) (struct pinmux_dev *pmxdev, unsigned offset);
member in the pinmux_ops vtable. We're discussing the exact
semantics of this call here.

We all agree we need something that can allocate a single pin for
GPIO in the number space, I think.

> some Blackfin parts have this to ease the conflicts between devices
> that customers want. ?if UART0 and SPI0 share PF0, PF1, and PF2,
> sometimes UART0 can be routed to PG3 and PG4 so that SPI0 can be used.

This kind usecase is covered extensively in the documentation
and previous discussion IIUC.

> atm we've made this a Kconfig option. ?obviously that wont fly in the
> "build one image to run on all platforms", but that isnt a problem for
> Blackfin systems today, and customers have been OK with this minor
> limitation.

I think we may be able to fix that limitation, and would like to make sure
we're not engineering in some limitation for Blackfin, so hit us.

> we implemented this on the Blackfin side by encoding things into the
> pin data. ?but that's because we had enough space in u16 to cover all
> of our parts so far.
>
> for example, the PA1 pin can act as GPIO, or as a timer pin, or as
> part of our high speed peripheral SPORT.
> #define P_SPORT2_DTSEC (P_DEFINED | P_IDENT(GPIO_PA1) | P_FUNCT(0))
> #define P_TMR4 (P_DEFINED | P_IDENT(GPIO_PA1) | P_FUNCT(1))
> when someone does peripheral_request(P_TMR4), the code first reserves
> itself with the GPIO core, and then configures the pinmux logic to set
> this pin as "function 1" (it's a 2 bit field).

In ARM we're at the stage now where each mach-foo under arch/arm/*
is running its own show in this regard. For example mach-ux500
magically stuff all its pin configuration into a u32 cleverly reusing bits
here and there.

Everyone is special, just like everybody else...

Basically there are as many pinmux implementations as there are
machines, and then we end up with that other Linus beating us on the
head for not consolidating our stuff into something generic.

So I'm doing this framework using some structs and radix trees
and no magic bitstuffing for now.

> we also have pin grouping logic implemented for the parts which dont
> have per-pin muxing so you cant request different pins in the same
> group for the same mode.

We should be able to solve that I think!

Yours,
Linus Walleij
