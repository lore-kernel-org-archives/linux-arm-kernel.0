From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Nov 2013 19:51:55 +0000
Subject: [PATCH 0/9] ARM: sa1100: Rework IRQ handling
In-Reply-To: <CALT56yNPmjje=8w2-3xo-80nVum2bhedMio8kp+gvizeGxQ5Kw@mail.gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdZU3_EqhBjV68+okJwh7QONuxWVjKkrUO4PkwJhKrP+mQ@mail.gmail.com>
 <528B811A.1030501@gmail.com>
 <CACRpkdbgn22xDX4nJZSDSE9-h+u1j5DQt=8arO7oS-UCBdBMUQ@mail.gmail.com>
 <20131120002007.GR16735@n2100.arm.linux.org.uk>
 <CALT56yP-LsO_8qgpa3R6JQSWW2pGkNWBUtab8L2hQnC5UdoKvQ@mail.gmail.com>
 <20131122175814.GC16735@n2100.arm.linux.org.uk>
 <CALT56yNPmjje=8w2-3xo-80nVum2bhedMio8kp+gvizeGxQ5Kw@mail.gmail.com>
Message-ID: <20131122195154.GD16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 11:12:05PM +0400, Dmitry Eremin-Solenikov wrote:
> On Fri, Nov 22, 2013 at 9:58 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Nov 20, 2013 at 04:45:40AM +0400, Dmitry Eremin-Solenikov wrote:
> >> On Wed, Nov 20, 2013 at 4:20 AM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > Also note that we _do_ have sa11x0 platforms which request their GPIOs
> >> > in their arch_initcall callback, so the sa11x0 GPIO driver better be
> >> > around at that point otherwise things *will* fail.
> >>
> >> Which ones if you have them in your mind?
> >>
> >> > I suspect that means the SA11x0 GPIO driver must be initialised early.
> >>
> >> Anyway in these patches gpio-sa1100 driver is registered at postcore
> >> initcall, so gpios should
> >> be available before arch_initcall functions.
> >
> > No it won't - quite simply because the platforms get called before
> > sa1100_init() is run - they have to be because the platforms get to
> > customise the platform data passed to the SA11x0 devices, which has
> > to happen before sa1100_init() registers the devices.
> 
> They both belong to arch_initicall level, aren't they? So ordering is
> guarded only by having customize_machine(which calls init_machine)
> from arch/arm/kernel/ before sa1100_init from arch/arm/mach-sa1100/?

Here:

c05b5194 T __initcall3_start
c05b5194 t __initcall_gate_vma_init3
c05b5198 t __initcall_customize_machine3
c05b519c t __initcall_exceptions_init3
c05b51a0 t __initcall_sa1100_init3
c05b51a4 t __initcall_dma_bus_init3
c05b51a8 t __initcall_dma_channel_table_init3
c05b51ac t __initcall_sa1110_clk_init3

* There we can see customize_machine() is called before sa1100_init().

* customize_machine() calls the machine specific .init_machine function.

* Several platforms call gpio_request() from their .init_machine function
  for SA11x0 GPIOs.

* You're adding the SA11x0 GPIO device in sa1100_init().

Therefore, those platforms which call gpio_request() will fail.

What is soo difficult to understand about this?

> For sa1100 there are only 2.5 platforms which use gpiolib - collie and h3xxx.
> (The half is for simpad, which registers gpio chip from platform code, but
> doesn't use it otherwise -- in platform code, of course).

Oh well, I guess it doesn't matter then, if we're only breaking 2.5
platforms.

No.  It does matter.  This needs fixing.
