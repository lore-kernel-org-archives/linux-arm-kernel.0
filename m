From: utx@penguin.cz (Stanislav Brabec)
Date: Tue, 26 Jan 2010 11:13:44 +0100
Subject: gpio_keys and how PXA27x sets gpio_set_wake() (was Re: sharp
	c-3000 aka spitz: fix warn_on introduced in 2.6.32-rc1)
In-Reply-To: <f17812d71001251958t377e158bxc64aac0cb426110b@mail.gmail.com>
References: <20100106071026.GD1382@ucw.cz>
	<f17812d71001052317h2bf25fady6bd729b35ef6db63@mail.gmail.com>
	<20100107065230.GA1303@ucw.cz>
	<f17812d71001062333y2e49fa21scf91718da9ae3091@mail.gmail.com>
	<1264275669.9100.11.camel@utx.utx.cz>
	<1264286611.11766.49.camel@utx.utx.cz>
	<f17812d71001251958t377e158bxc64aac0cb426110b@mail.gmail.com>
Message-ID: <1264500824.4480.79.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrota:

> I prefer 2) - the ugly and hardcoded setup in spitz_pm.c should really
> be removed. That's why the gpio_set_wake() and keypad_set_wake()
> are introduced.

I am unsure, whether gpio_keys driver is interested in the way, how wake
happens. I guess that is interested only in the fact, that wake
happened.

Handling platform specific edge/level wake setup would only complicate
the code. (In fact, even the PXA270 platform code does not exist yet -
arch/arm/mach-pxa/mfp-pxa2xx.c:__mfp_config_gpio() is not capable to
configure Power Manager Keyboard Wake-Up Enable Register (PKWR).)

I talked to Vojt?ch Pavl?k and he told that 1 is correct: Follow
include/linux/interrupt.h. Setting edge/level wake mode should be done
in the platform file. The driver could use just irq_set_wake() and don't
care about details. And irq_set_wake() should do something useful even
for PKWR capable GPIO.

> keypad_set_wake() is really specifically introduced for use by pxa27x_keypad
> and no generic GPIO stuffs. So it's really annoying a GPIO will use
> the PKWR as a wakeup GPIO, I'd recommend one still get this hard coded
> into the platform file, with combination of WAKEUP_ON_LEVEL_HIGH (which
> is specifically designed for keypad GPIOs) and keypad_set_wake().

Well, keypad_set_wake() seems to be possibly broken for GPIO 38. Imagine
a device, that has a small keypad, but GPIO 38 has a different purpose
that requires an edge triggered wakeup (PWER). I think that
keypad_set_wake() reprograms it to PKWR.

The problem affects gpio_keys: It is a driver implementing "one key per
gpio". It now handles On/Off and lid switches on Zaurus. Lid switches
are on "normal" GPIOs, On/Off switch is wired to PKWR capable GPIO.

> The spitz, however, is doing a good job on this though it's using a GPIO
> emulated matrix keypad, that there is a separate SPITZ_GPIO_KEY_INT,
> which triggers whenever there is any key press on this matrix (I don't
> know how that's designed in HW, but it seems to do that job), and
> which can be setup as a GPIO wakeup.

SPITZ_GPIO_KEY_INT happens if AC adapter is connected or key is pressed.
Surprisingly, the key press logic is part of NAND flash controller CPLD.
SPITZ_GPIO_KEY_INT==0 - it makes possible to wake Zaurus even from deep
sleep by any key press. It would be impossible only with PKWR.

I guess that this and implementation of keypad_set_wake() is a reason,
why most devices suspend and resume correctly even if the irq_set_wake()
refuses to configure wake and the warning is only visible symptom.


________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx
