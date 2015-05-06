From: johan@kernel.org (Johan Hovold)
Date: Wed, 6 May 2015 15:06:15 +0200
Subject: [PATCH 0/2] gpio: Allow userspace export from DT
In-Reply-To: <CACRpkdbFKs8mALw7q2d0EEDkhxKNLgeiFB5TyZ6ZPpfcW-c+oQ@mail.gmail.com>
References: <20150413110515.9681.58848.stgit@localhost>
 <20150504084925.GB4047@localhost>
 <CACRpkdbFKs8mALw7q2d0EEDkhxKNLgeiFB5TyZ6ZPpfcW-c+oQ@mail.gmail.com>
Message-ID: <20150506130615.GB5302@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 09:22:22AM +0200, Linus Walleij wrote:
> On Mon, May 4, 2015 at 10:49 AM, Johan Hovold <johan@kernel.org> wrote:
> > On Mon, Apr 13, 2015 at 01:05:15PM +0200, Martin Fuzzey wrote:
> 
> >> The above means that, in order to export the GPIO to userspace via
> >> /sys/class/gpio/export the userspace code must know the exact hardware and
> >> kernel version information.
> >
> > Not quite. You can still determine the gpio number in the above cases by
> > walking the sysfs tree to find the chip and it's base. This is the only
> > way to do this for dynamic buses such as USB.
> 
> Maybe we should start providing something like an
> "lsgpio" utility in tools/gpio to do this, just as a hint
> to userspace people on how things should be done.

I think we should focus on defining a new user-space interface rather
than make it easier to use the current one (it should really only be
used for development or one-off hacks IMO).

> >> This patch series solves both problems by performing the external
> >> signal => GPIO mapping in the device tree.
> >
> > As Rob already mentioned, what we want is some way to declare pin
> > functions. These could then be requested from userspace (or used in DT,
> > something which should allow for further refactoring there as well)
> > unless a driver has already claimed them.
> 
> We have the ability to name the GPIO lines (I usually refer to
> lines rather than pins, as pins are physical and not all GPIOs
> are, actually) using the array "names" in struct gpio_chip,
> however this has no DT binding, so maybe people should
> work on that. These names appear as named line files
> in sysfs IIRC. Or maybe you're thinking of something else?

Yes, something like that. As you mention above, if it was possibly to
define those names in firmware, even the current sysfs interface would
expose the pins as

	/sys/class/gpio/<function>

rather than say /sys/class/gpio/gpio279, thereby solving the gpio-number
look-up issue. Well, to actually make the pin available *from* userspace
you'd currently still need the number...

Johan
