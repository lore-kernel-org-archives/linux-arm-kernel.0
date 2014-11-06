From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Thu, 6 Nov 2014 12:58:55 +0200
Subject: [PATCH] leds: leds-gpio: Convert gpio_blink_set() to use GPIO
 descriptors
In-Reply-To: <CAMuHMdWtcZcpW=r60s9auENZxChiLwr14R0p_soKr7C3yGYOMQ@mail.gmail.com>
References: <1414755658-96293-1-git-send-email-mika.westerberg@linux.intel.com>
 <545843B1.3020101@nvidia.com> <2455157.3p7mHhT8im@vostro.rjw.lan>
 <CAMuHMdXn9W2S7N+YGfjDxQozMtRZCVdTzzdDps6YfOv2FqVBmw@mail.gmail.com>
 <20141106103033.GK1618@lahna.fi.intel.com>
 <CAMuHMdWtcZcpW=r60s9auENZxChiLwr14R0p_soKr7C3yGYOMQ@mail.gmail.com>
Message-ID: <20141106105855.GL1618@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 11:32:19AM +0100, Geert Uytterhoeven wrote:
> Hi Mika,
> 
> On Thu, Nov 6, 2014 at 11:30 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >> "leds: leds-gpio: Add support for GPIO descriptors" broke leds-gpio on
> >> non-DT platforms for me:
> >>
> >>     gpiod_direction_output: invalid GPIO
> >>     leds-gpio: probe of leds-gpio failed with error -22
> >>
> >> (desc is NULL in gpiod_direction_output()).
> >>
> >> DT shmobile reference/multi-platform are fine.
> >>
> >> I noticed the hard way, as I wanted to add some LEDs to a new platform,
> >> but couldn't get it work. It turned out it also had stopped working on
> >> r8a7740/armadillo-legacy, so I started bisecting...
> >
> > Which board file that is?
> >
> > There is a bug that gpio_to_desc() returns NULL instead if ERR_PTR() in
> > that patch but I wonder why gpio_is_valid() and devm_gpio_request_one()
> > do not complain about that prior.
> 
> arch/arm/mach-shmobile/board-armadillo800eva.c

Thanks.

Are you able to put some printks() to the 'if (!template->gpiod)' branch
so that it prints out gpio number and what does devm_gpio_request_one()
return?

Something like:

	if (!template->gpiod) {
		...
		ret = devm_gpio_request_one(parent, template->gpio, flags,
					    template->name);
		dev_info(parent, "GPIO %u, ret: %d\n", template->gpio, ret);
		if (ret < 0)
			...

		led_dat->gpiod = gpio_to_desc(template->gpio);
		dev_info(parent, "GPIOD: %p\n", led_dat->gpiod);
	}
