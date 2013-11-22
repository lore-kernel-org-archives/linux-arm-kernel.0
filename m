From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Nov 2013 17:58:14 +0000
Subject: [PATCH 0/9] ARM: sa1100: Rework IRQ handling
In-Reply-To: <CALT56yP-LsO_8qgpa3R6JQSWW2pGkNWBUtab8L2hQnC5UdoKvQ@mail.gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdZU3_EqhBjV68+okJwh7QONuxWVjKkrUO4PkwJhKrP+mQ@mail.gmail.com>
 <528B811A.1030501@gmail.com>
 <CACRpkdbgn22xDX4nJZSDSE9-h+u1j5DQt=8arO7oS-UCBdBMUQ@mail.gmail.com>
 <20131120002007.GR16735@n2100.arm.linux.org.uk>
 <CALT56yP-LsO_8qgpa3R6JQSWW2pGkNWBUtab8L2hQnC5UdoKvQ@mail.gmail.com>
Message-ID: <20131122175814.GC16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 04:45:40AM +0400, Dmitry Eremin-Solenikov wrote:
> On Wed, Nov 20, 2013 at 4:20 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Also note that we _do_ have sa11x0 platforms which request their GPIOs
> > in their arch_initcall callback, so the sa11x0 GPIO driver better be
> > around at that point otherwise things *will* fail.
> 
> Which ones if you have them in your mind?
> 
> > I suspect that means the SA11x0 GPIO driver must be initialised early.
> 
> Anyway in these patches gpio-sa1100 driver is registered at postcore
> initcall, so gpios should
> be available before arch_initcall functions.

No it won't - quite simply because the platforms get called before
sa1100_init() is run - they have to be because the platforms get to
customise the platform data passed to the SA11x0 devices, which has
to happen before sa1100_init() registers the devices.

By adding the GPIO device to the sa11x0_devices list, you're registering
it afterwards which means that the GPIO driver isn't up and running
at this time.  That means that various platforms (such as the h3xxx
ones which call gpio_request on built-in GPIOs at this time) will fail.
