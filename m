From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Dec 2017 23:53:47 +0100
Subject: [PATCH 4/4] ARM: dts: vf610-zii-dev-rev-b: add interrupts for
 88e1545 PHY
In-Reply-To: <20171221173235.GK10595@n2100.armlinux.org.uk>
References: <20171220231108.GJ10595@n2100.armlinux.org.uk>
 <E1eRnWr-0006VS-1m@rmk-PC.armlinux.org.uk>
 <CACRpkdas5JJ4KHE4g=sPXag=3vQt4TS5EcZBsy=LRfw8tqcgOw@mail.gmail.com>
 <20171221134058.GA15416@lunn.ch>
 <20171221173235.GK10595@n2100.armlinux.org.uk>
Message-ID: <CACRpkdarS+tPv5CG4bmFcPvc+=SJJcC1pbO7WSbsS5+yCuxh_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 6:32 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> What we have here is _really_ a shared interrupt between four
> separate devices, and we need a way to sanely describe resources
> shared between several device instances to pinmux.  Unfortunately,
> it seems pinmux is designed around one device having exclusive use
> of a resource, which makes it hard to describe shared interrupts in
> DT.
>
> Given that DT should be a description of the hardware, and should be
> independent of the OS implementation, I'd say this is a pinmux bug,
> because pinmux gets in the way of describing the hardware correctly.
> ;)

Hm that would be annoying. But when I look at it I think it would
actually work. Did you try just assigning the same pin control
state to all the PHY's and see what happens?

Just set
pinctrl-names = "default";
pinctrl-0 = <&pinctrl_mv88e1545>;

on all of them?

I don't think DTC would complain at least.

When I look at the driver subsystem, I don't see anything really
stopping you from doing that and even have three devices selecting
the same "default" pin control state. It seems it will just wind up
three times in pinctrl_select_state() and the first time it calls the pin
control driver to actually set it and the three other times it finds the
state is already correct and returns success.

So the way I read it actually several devices can reference the
same pin control state.

That is, unless there is something I missed. Which I often do...

If it happens to work we should probably put a blurb in the
DT binding that this is expected behaviour though.

Yours,
Linus Walleij
