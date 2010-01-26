From: utx@penguin.cz (Stanislav Brabec)
Date: Tue, 26 Jan 2010 13:50:42 +0100
Subject: gpio_keys and how PXA27x sets gpio_set_wake() (was Re: sharp
	c-3000 aka spitz: fix warn_on introduced in 2.6.32-rc1)
In-Reply-To: <f17812d71001260339h6184c82bj25ff13a168284c24@mail.gmail.com>
References: <20100106071026.GD1382@ucw.cz>
	<f17812d71001052317h2bf25fady6bd729b35ef6db63@mail.gmail.com>
	<20100107065230.GA1303@ucw.cz>
	<f17812d71001062333y2e49fa21scf91718da9ae3091@mail.gmail.com>
	<1264275669.9100.11.camel@utx.utx.cz>
	<1264286611.11766.49.camel@utx.utx.cz>
	<f17812d71001251958t377e158bxc64aac0cb426110b@mail.gmail.com>
	<1264500824.4480.79.camel@utx.utx.cz>
	<f17812d71001260220v5d03b0e1u1e3bc229827c37c8@mail.gmail.com>
	<1264502668.4480.97.camel@utx.utx.cz>
	<f17812d71001260339h6184c82bj25ff13a168284c24@mail.gmail.com>
Message-ID: <1264510242.25072.269.camel@hammer.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:
> 2010/1/26 Stanislav Brabec <utx@penguin.cz>:
> > Eric Miao wrote:
> >> 2010/1/26 Stanislav Brabec <utx@penguin.cz>:
> >
> >> > Handling platform specific edge/level wake setup would only complicate
> >> > the code. (In fact, even the PXA270 platform code does not exist yet -
> >> > arch/arm/mach-pxa/mfp-pxa2xx.c:__mfp_config_gpio() is not capable to
> >> > configure Power Manager Keyboard Wake-Up Enable Register (PKWR).)
> >> That's why WAKEUP_ON_EDGE_* is introduced, no need for gpio-keys
> >> to know this.
> >
> > But WAKEUP_ON_EDGE_* is impossible for GPIO 95,
> > enable_irq_wake()/gpio_set_wake() returns EINVAL and disable_irq_wake()
> > complains on "Unbalanced IRQ 191".

> Now I see, but I don't know why disable_irq_wake() will complains about
> unbalance since it should really manage it well.

Because gpio_set_wake() returned EINVAL, set_irq_wake() assumed error
and did not increment wake_depth, the whole enable_irq_wake() was a big
NOP. disable_irq_wake() seen wake_depth being zero and complains.

> A quick dirty solution would be the platform to call keypad_set_wake()
> directly somewhere. Otherwise we have to let gpio_set_wake() to handle
> those keypad GPIOs and to live together with keypad_set_wake() happily,
> which is really difficult.

I was thinking about it as well (and even tested that it works):
gpio_set_wake():
if (d->keypad_gpio)
	return keypad_set_wake(on);

But keypad_set_wake() always sets all keypad GPIOs, not just a single
one. And there is GPIO 36, that can be configured in more ways.

gpio_set_wake() and only set wake, keeping the mode as it was before.
(Well, it's again impossible for GPIO 36 without storing this
information somewhere.)

But well, another idea:

Only matrix_keypad driver should be aware of level triggered wakeup. All
other drivers could follow *_irq_wake documentation and not care about
it. If edge triggered interrupt is available, it should be preferred
there, if not, level triggered wake should be used instead. Hardware
designers should know what they are doing.


-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec at suse.cz
Lihovarsk? 1060/12           tel: +420 284 028 966, +49 911 740538747
190 00 Praha 9                                  fax: +420 284 028 951
Czech Republic                                    http://www.suse.cz/
