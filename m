From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 19:52:34 +0200
Subject: [PATCH, RFC 16/22] USB: UHCI: clarify Kconfig dependencies
In-Reply-To: <Pine.LNX.4.44L0.1305021304500.1436-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1305021304500.1436-100000@iolanthe.rowland.org>
Message-ID: <201305021952.35040.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Alan Stern wrote:
> On Thu, 2 May 2013, Arnd Bergmann wrote:
> 
> 	It relies more on "depends" than "select".  I don't know how 
> 	important this is in the end.

'select' is sometimes problematic, but the only use that I try to
avoid is having one Kconfig symbol that is both user-selectable
standalone and selected by something else.

> 	It doesn't add a new USB_UHCI_GRLIB symbol; instead it uses
> 	SPARC_LEON in several places.  I tend to think the new symbol
> 	is nicer.
> 
> 	It doesn't add a new USB_UHCI_PCI symbol.
> 
> 	It improves the dependency list for USB_UHCI_HCD.
> 
> 	It removes the help text for USB_UHCI_PLATFORM, thereby making
> 	that symbol not user-configurable.  I don't see any reason why
> 	the user should need to worry about this -- the choice should
> 	be a very simple one: build UHCI support or don't build it.  If
> 	the user chooses to build it then it should include support for
> 	all the compatible bus glues.  (This last decision may need to 
> 	be changed if more bus glues get added.)
>
> What do you think of my patch as compared to yours? 

I think in the end it comes down to the question where you want to
head with your driver. The way I did my version was going towards
making it similar to EHCI, with stand-alone bus glue drivers
and a core that is just a library module but does not register
a device_driver by itself.

Given that there are just three bus glues from UHCI, and at most
two of them enabled at the same time, I don't see a direct need
for UHCI to go down the same route as EHCI. If you want to just
leave this driver alone, your patch is simpler and has the same
effect in the end. Otherwise I think my patch avoids changing it
all again once the driver gets reworked.

Things might also get a little messy if we are seeing a lot
of other platforms beside VIA VT8500 use UHCI, but I think that
is rather unlikely.

	Arnd
