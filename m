From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 12:11:10 +0100
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <HK2PR06MB05617E2ED835CFE20F65E3D38AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
 <20160218223312.GT19428@n2100.arm.linux.org.uk>
 <HK2PR06MB05617E2ED835CFE20F65E3D38AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <3461274.sjccN4r7lq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 February 2016 03:39:38 Chris Brandt wrote:
> On Thu, 18 Feb 2016, Russell King - ARM Linux wrote:
> 
> > On Thu, Feb 18, 2016 at 07:42:20PM +0000, Chris Brandt wrote:
> > > On Thu, 18 Feb 2016, Nicolas Pitre wrote:
> > > 
> > > > > Is there some way you can do a PLATFORM_COUNTER++ for each device 
> > > > > that is selected, and then XIP_KERNEL would depend on 
> > > > > PLATFORM_COUNTER == 1 ?
> > > >
> > > > I don't know all the Kconfig possibilities.
> > > >
> > > > But would something like this work?
> > > >
> > > > config FOO
> > > >   depends on !(XIP && CHOICE_MADE)
> > > >   select CHOICE_MADE
> > > 
> > > I follow your logic and that might work: If you made multiple choices,
> > > it would just take the first one.
> > > 
> > > However...I just tried it and it crashes.
> > > 
> > > scripts/kconfig/mconf  Kconfig
> > > make[2]: *** [menuconfig] Segmentation fault (core dumped)
> > > make[1]: *** [menuconfig] Error 2
> > > 
> > > 
> > > It looks like you can't depend on something not being set that you are
> > > going to set yourself. Basically..."do as I say, not as I do"
> > 
> > It's missing a bool/tristate.  Every config option needs to be typed.
> 
> 
> Thank you! That makes things better.
> 
> Technically, it seems to work (you can only select 1), but the menu system is a little flakey when you try jumping back and forth between what device to select. Somehow when 2 get selected, I need to get kbuild to go back and do a full refresh or something.
> 
> 
> I'm going to play with it some more before I start shouting victory.

I think Kconfig interprets the above as a circular dependency (using depends
and select on the same symbol), it will print a warning and misbehave randomly.

In a different thread today, I was trying to come up with a way to
reliably pick a PHYS_OFFSET value, and I think it can be done but it
quickly gets ugly without extending the Kconfig language.

Also, the same problem exists in three areas:

a) PHYS_OFFSET / DRAM_BASE
b) XIP_PHYS_ADDR
c) DEBUG_UART_VIRT/DEBUG_UART_PHYS

The last one is already really ugly and by nature causes problems
whenever someone enables DEBUG_LL and tries to boot a compressed
kernel on a platform other than the one that was configured.

XIP_PHYS_ADDR is probably the worst here, because the number does
not just depend on the SoC family but the specific board configuration
and could even change when you rearrange the partitions on your NOR
flash (unless you enforce that the kernel has to start at the
beginning of the ROM or some other fixed location).

It would be nice to handle all three of the above in a similar manner,
and I'm definitely open to a range of solutions for this, like

- always allow turning XIP_KERNEL on for all configurations, and
  expect the user to know what they are doing (as your current
  patch)

- allow turning on XIP_KERNEL as long as Kconfig can figure out that
  this has a chance of working on at least one platform (easy enough
  to implement, and similar to how we handle DEBUG_LL).

- make XIP_KERNEL and DEBUG_LL depend on either CONFIG_EXPERT or
  a new "I know this breaks other platforms and I won't complain
  about that" flag.

- implement a Kconfig method to only allow XIP_KERNEL if exactly
  one platform is enable that supports it, or if all platforms
  use the exact same PHYS_OFFSET and XIP_PHYS_ADDR settings.
  Whether we want to enforce the same thing for DEBUG_LL is a
  separate matter once that infrastructure exists.

	Arnd
