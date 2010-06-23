From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 23 Jun 2010 23:53:45 +0100
Subject: [RFC PATCH] Rework gpio cansleep (was Re: gpiolib and sleeping
	gpios)
In-Reply-To: <4C21955D.1020502@bluewatersys.com>
References: <191168.5104.qm@web180308.mail.gq1.yahoo.com>
	<4C21955D.1020502@bluewatersys.com>
Message-ID: <20100623225345.GD7058@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ryan Mallon wrote:
> On 06/23/2010 04:37 PM, David Brownell wrote:
> I'm not. Some gpios, such as those on io expanders, may sleep in their
> implementations of the gpio_(set/get) functions.

I'm having a hard time figuring out where some GPIOs I'm using fit
into this picture.

I have some hardware that is currently using a 2.4.26 kernel, but I
look from time to time at forward-porting all the drivers to 2.6.recent.

It has an I2C driven GPIO expander, with a watchdog reset chip hanging
off the expander.

The watchdog is kept alive off the back end of a timer BH, which means
the I2C GPIO routines are written to be safe in BH context (which
isn't sleepable), but they can't be used in IRQ context because the
necessary spin_lock_irqsave() would turn off interrupts for too long
for other subsystems to function properly.

How should I flag those GPIO routines in your scheme?  They're safe to
use in some non-sleeping contexts, but not safe in irq context.

Thanks,
-- Jamie
