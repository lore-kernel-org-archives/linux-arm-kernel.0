From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Jun 2011 10:33:36 +0200
Subject: [RFC] Consolidation: Replace all led drivers in arch/arm to leds
	trigger drivers
In-Reply-To: <BANLkTimRM=Uq6FUN-tvGrf3HLN3BUYqmOQ@mail.gmail.com>
References: <BANLkTimRM=Uq6FUN-tvGrf3HLN3BUYqmOQ@mail.gmail.com>
Message-ID: <BANLkTi=YS0=6u6OOF-t7zSPzs4r=RqpqdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/1 Bryan Wu <bryan.wu@canonical.com>:

> arch/arm/plat-versatile/leds.c

I converted this to use the LEDS_CLASS and LED triggers as you can
see if you look inside it...

The problem is rather with everything inside #ifdef CONFIG_LEDS in
arch/arm/mach-realview/core.c, that uses arch/arm/kernel/leds.c.

I proposed a patch to delete it, so we have only one LED implementation
using triggers for all plat-versatile but hit the following snag:

> Looks like these led drivers are mainly used in old ARM machines, I
> think at that time there is no led trigger driver.
> in arch/arm/kernel/leds.c, the led usages can be replaced to
> led trigger default-on
> led trigger heartbeat
> led trigger ide-disk
> led trigger timer

There is a trigger usecase missing that Russell brought to
my attention: using the LEDs to indicate which CPUs is online.
For example on the PB11MPcore you can have one LED per
CPU so you see if each of these is running.

That is the purpose of the code in realview_leds_event().

To cover that case a new kind of CPU indicator trigger needs
to be added to the drivers/led/ subsystem.

Yours,
Linus Walleij
