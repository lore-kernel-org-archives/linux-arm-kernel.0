From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 21 Jul 2015 09:31:11 +0200
Subject: [PATCH] thermal: consistently use int for temperatures
In-Reply-To: <9hhd1zrc9yb.fsf@e105922-lin.cambridge.arm.com>
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
 <9hhd1zrc9yb.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20150721073111.GH5161@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punit,

On Fri, Jul 17, 2015 at 12:14:36PM +0100, Punit Agrawal wrote:
> Hi Sascha,
> 
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > The thermal code uses int, long and unsigned long for temperatures
> > in different places.
> >
> > Using an unsigned type limits the thermal framework to positive
> > temperatures without need. Also several drivers currently will report
> > temperatures near UINT_MAX for temperatures below 0?C. This will probably
> > immediately shut the machine down due to overtemperature if started below
> > 0?C.
> >
> > 'long' is 64bit on several architectures. This is not needed since INT_MAX ?mC
> > is above the melting point of all known materials.
> >
> > Consistently use a plain 'int' for temperatures throughout the thermal code and
> > the drivers. This only changes the places in the drivers where the temperature
> > is passed around as pointer, when drivers internally use another type this is
> > not changed.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Thanks for moving over the thermal sub-system in Linux to consistently
> use a single type.
> 
> In your patch, you missed migrating over power_allocator governor and
> it's associated trace events. It got merged for v4.2.
> 
> Could you incorporate something like below in your next version?

It seems I have changed drivers/thermal/power_allocator.c but missed
include/trace/events/thermal_power_allocator.h. Please check out the v2
patch I just sent.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
