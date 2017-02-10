From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Feb 2017 14:05:43 +0100
Subject: [PATCH 1/2] ARM: add ARM_SINGLE_ARMV7 as config option
In-Reply-To: <SG2PR06MB11650C805DD754EE5C9E56C78A450@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170209033044.19513-1-chris.brandt@renesas.com>
 <5d90aff5-63b7-83a8-7529-2ac61ef82021@gmail.com>
 <SG2PR06MB11650C805DD754EE5C9E56C78A450@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <25202835.AdbHsoUg0y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 9, 2017 8:21:43 PM CET Chris Brandt wrote:
> On Thursday, February 09, 2017, Florian Fainelli worte:
> > > I think the closest I might have come was to purposely break the build
> > > if more then 1 was select, but that still didn't stop you from making
> > > the selection.
> > >
> > > If someone smarter than me has a way to do (not just an idea...I
> > received
> > > lots of ideas but none of them worked), I'd be happy to hear it.
> > 
> > I am definitively not a Kbuild expert, but it would almost necessarily
> > require introduce some kind of new type in the Kconfig/Kbuild syntax
> > that does something like that:
> > 
> > - have a way to count the number of symbols that are selected and do a
> > "if ARCH_MULTI_V6_V7" (or an arbitrary expression) this most likely
> > should exist internally within Kconfig
> > 
> > - introduce a new type of Kconfig type which is a "count", and gets
> > assigned this value that we just counted, something that could look like
> > this:
> > 
> > count ARCH_MULTI_V6_V7_COUNT
> >       tracks ARCH_MULTI_V6_V7
> 
> I did try the counting thing, but couldn't get it to work.
> I admit though, I did stop when the next step was to create a new type
> kind of thing that I could use for counting. That seemed to start going
> down a deeper path than I was hoping for.

I also couldn't come up with something working when I looked at this,
and it wouldn't solve the related problem of platforms that we want to
be able to use with or without MMU: You can't make the decision of
whether allow an MMU based on the number of platforms since most
platform options can only be offered depending on the setting of
CONFIG_MMU.

> However,
> I am hesitant to go and try anything else because everything I've submitted
> so far has been NACKed. The only thing Russell said he'd agree to is a top
> level single-platform option. But, since that all got taken out, I assume
> there's some resistance to putting it back in.

And I really don't like adding new top-level for a platform here, it
brings us back to the same problems we had before we moved most platforms
to ARCH_MULTIPLATFORM, and it doesn't solve the remaining problems we still
have:

- In some platforms, the decision would have to be done on a per-board
  level, as each board can have its memory at a different location
  base on which chipselect line got connected to the RAM and NOR flash
  respectively

- Some (few) platforms actually have separate top-level Kconfig options
  but are actually very closely related and you could have a kernel
  for all of them even with !MMU and XIP_KERNEL. The most important
  one here is ARM Versatile/Realview/Integrator/Vexpress that have
  more in common than things we put behind a common Kconfig option in
  other platforms.

- CONFIG_DEBUG_UNCOMPRESS has a very similar requirements to
  XIP_KERNEL and !MMU, and we currently allow it for any machine,
  with a lot of flexibility in configuring that always breaks
  running on any machine other than the one you are targetting.

	Arnd
