From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Feb 2017 18:14:07 +0100
Subject: [PATCH] [net-next] ARM: orion: fix PHYLIB dependency
In-Reply-To: <20170209155751.GB29882@lunn.ch>
References: <20170209150834.1158193-1-arnd@arndb.de>
 <20170209155751.GB29882@lunn.ch>
Message-ID: <1967873.WpTcGj2Cy4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 9, 2017 4:57:51 PM CET Andrew Lunn wrote:
> On Thu, Feb 09, 2017 at 04:08:11PM +0100, Arnd Bergmann wrote:
> > The newly introduced mdiobus_register_board_info() function is only available
> > as part of PHYLIB, so we get a link error when we call that from a board while
> > phylib is disabled:
> > 
> > arch/arm/plat-orion/common.o: In function `orion_ge00_switch_init':
> > common.c:(.init.text+0x6a4): undefined reference to `mdiobus_register_board_info'
> > 
> > This adds a workaround that is made up of three parts:
> > 
> > - in plat-orion, the function for declaring the switch is hidden without
> >   PHYLIB.
> > - in mach-orion5x, the caller conditionally stubs out the call to
> >   the removed function, so we can still build other orion5x boards
> >   without PHYLIB
> > - For the boards that actually declare the switch, we select PHYLIB
> >   explicitly from Kconfig if NETDEVICES is set. Without NETDEVICES,
> >   we cannot enable PHYLIB, but we also wouldn't need it.
> 
> Hi Arnd
> 
> Although all correct, would it not be simpler to just select PHYLIB
> and NETDEVICES? These devices are all NAS boxes and WiFi access
> points. What sense does it make to build a kernel without working
> networking for these classes of devices?

Adding a 'select' statement to something as broad as NETDEVICES sounds
really bad, it has a significant risk of introducing dependency loops
and may be confusing if you want to build a multiplatform config without
networking support (note that NETDEVICES in turn depends on NET, which
can also be disabled).

One possibility would be to have a special Kconfig symbol that controls
mdiobus_register_board_info() being present and have that symbol
force PHYLIB to never be "=m". Then we can either have no networking
support and no phylib, turning mdiobus_register_board_info() into a
stub, or we have the function built-in and reachable from the board
code.

	Arnd
