From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 26 Jan 2010 11:58:30 +0800
Subject: gpio_keys and how PXA27x sets gpio_set_wake() (was Re: sharp
	c-3000 aka spitz: fix warn_on introduced in 2.6.32-rc1)
In-Reply-To: <1264286611.11766.49.camel@utx.utx.cz>
References: <20100106071026.GD1382@ucw.cz>
	<f17812d71001052317h2bf25fady6bd729b35ef6db63@mail.gmail.com>
	<20100107065230.GA1303@ucw.cz>
	<f17812d71001062333y2e49fa21scf91718da9ae3091@mail.gmail.com>
	<1264275669.9100.11.camel@utx.utx.cz>
	<1264286611.11766.49.camel@utx.utx.cz>
Message-ID: <f17812d71001251958t377e158bxc64aac0cb426110b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 2) gpio_keys driver should be capable to set IRQF_TRIGGER_* and no
> settings of wake-up registers in spitz_pm.c would not be needed.
>
> On platforms with shared interrupts it would introduce possible multiple
> trigger initialization (not a big problem). But it would easily
> introduce breakage if programmer makes a mistake and configures
> interrupt with different trigger in different drivers.
>
>
> I am not sure what solution of these two is in spirit of modern kernels.
> I guess that 2. Especially because somebody may want to use gpio_keys on
> a different machine/GPIO layout that would require different
> IRQF_TRIGGER_*.
>

I prefer 2) - the ugly and hardcoded setup in spitz_pm.c should really
be removed. That's why the gpio_set_wake() and keypad_set_wake()
are introduced.

keypad_set_wake() is really specifically introduced for use by pxa27x_keypad
and no generic GPIO stuffs. So it's really annoying a GPIO will use
the PKWR as a wakeup GPIO, I'd recommend one still get this hard coded
into the platform file, with combination of WAKEUP_ON_LEVEL_HIGH (which
is specifically designed for keypad GPIOs) and keypad_set_wake().

The spitz, however, is doing a good job on this though it's using a GPIO
emulated matrix keypad, that there is a separate SPITZ_GPIO_KEY_INT,
which triggers whenever there is any key press on this matrix (I don't
know how that's designed in HW, but it seems to do that job), and
which can be setup as a GPIO wakeup.

>
> Notes:
>
> Automatic PKWR/PWER logic is impossible for PXA270. GPIO 38 can be
> programmed to use both PKWR or PWER.
>

That's a shame of pxa27x, but so far no awkward usage of this
has ever been seen.

> The gpio_keys seems to have problems with debounce - in 50% of all
> resumes, Zaurus goes back to sleep in a second or so.
>

There is a routine checking wakeup source (cause) which will put the
system back into sleep in some cases, I guess you need to check if
something weird there.
