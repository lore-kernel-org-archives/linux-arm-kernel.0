From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Mar 2012 14:42:50 +0000
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <CAOh2x=mtjvitkhz=BXOZPAaKZ2i3QQuKrYA3HcHNERHhF5xFoA@mail.gmail.com>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203211404.35847.arnd@arndb.de>
 <CAOh2x=mtjvitkhz=BXOZPAaKZ2i3QQuKrYA3HcHNERHhF5xFoA@mail.gmail.com>
Message-ID: <201203211442.50683.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 March 2012, viresh kumar wrote:
> On Wed, Mar 21, 2012 at 7:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 21 March 2012, viresh kumar wrote:
> >> - Pinmux: I would remove our padmux and use pinmux, but what about its
> >> DT support.
> >>   I know stephen had few patches for it, but don't know there
> >> progress. I don't want to
> >>   do stuff twice. First add support for it in board and the *.dts files.
> >
> > AFAICT, the pinmux DT binding should be ready for v3.5, I don't think it
> > made it into v3.4.
> 
> So, i can add stuff in board file for pinmux for now?

Probably yes. It depends on the scale though: if you add more code than
what is needed to convert to the pinctrl framework, we might decide that
it's not worth it.

Note that moving to the pinctrl subsystem can be done independent from
doing the device tree conversion, and it does not depend on the
pinctrl dt binding even if you already have DT support.

> > I've looked at this earlier today out of curiosity and found:
> >
> > clock.c: almost identical, can be easily merged, or both copies
> >         kept around during transition.
> 
> Would make it very confusing if we merge these two. Some clock
> structures are same, but others are not. Mostly differences are in the
> macros (or bit positions in registers), rather than hierarchy. So, i would
> like to keep them separate. But still have a look again to see if they can
> really be merged.

Ok, I see.

> > misc_regs.h: can be merged into clock.c
> 
> it has more than clock stuff. it is used in pinmux and some other places too,
> that may not be in mainline for now.

Right, I was only looking at the stuff that is actually being used in mainline.
However I think this file should not be needed at all -- any contents that
are specific to one driver can just live in that driver, and stuff that is
shared across multiple drivers generally looks like it is also shared between
3xx and 6xx.

> > Once you have taken care of these, files, you can enable building 3xx
> > and 6xx together, and move the contents of mach-spear3xx, mach-spear6xx
> > and plat-spear into one directory.
> 
> plat-spear would be required for 13xx too. So, merging 3xx and 6xx only would
> be possible.

There is not all that much that can be shared here:

* clock.c would go into drivers/clk/ for spear13xx and possibly for the others
  too.
* padmux.c would go into drivers/pinctrl
* time.c would go into drivers/clocksource
* shirq.c is potentially shared, but we've discussed in the past about
  creating a new drivers/irqchip where this can live.
* restart.c is very small, there is no harm in duplicating this.
* The header files will have to go elsewhere, too, as we move towards
  have a single multiplatform zImage.

> > Ok, excellent. Note that there is no requirement to do it all in the order
> > you line out above. You can always get support for new stuff into the
> > existing platform without cleaning up all of it right away, as long as you
> > have a good balance between cleanups and new functionality.
> 
> Ya. I just wanted to get some hands on experience with this new stuff, before
> touching 13xx.

Good idea. As Stefan has shown, it's not really all that hard to get a lot
done for the older platforms, and spear13xx will likely be much harder
because of the increased hardware complexity.

> > In particular, you don't have to start using pinctrl and the common clk
> > immediately for spear3xx, although you might find that it helps you.
> 
> But, can i update padmux and clock framework of SPEAr platform? Because
> without the latest code for both padmux and clock, other code for SPEAr
> might not be that effective or usable.

Yes, you can do updates in there that are logical and keep the current
basic structure or improve it. I would only object if you do a more or
less complete rewrite of those files but don't use the common infrastructure
in the process.

	Arnd
