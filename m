From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Jan 2014 10:48:37 +0100
Subject: [PATCH v2 05/15] watchdog: orion: Make RSTOUT register a separate
 resource
In-Reply-To: <20140121233321.GR18269@obsidianresearch.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233321.GR18269@obsidianresearch.com>
Message-ID: <3176358.2QFcJHj0fv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 January 2014 16:33:21 Jason Gunthorpe wrote:
> On Tue, Jan 21, 2014 at 06:12:31AM -0300, Ezequiel Garcia wrote:
> > In order to support other SoC, it's required to distinguish
> > the 'control' timer register, from the 'rstout' register
> > that enables system reset on watchdog expiration.
> 
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +     if (!res)
> > +             return -ENODEV;
>            ^^^^^^^^^^^^^^^^^^^^^^
> 
> This change seems to break compatibility with existing DT files that
> have only a single entry in reg?
> 
> Can the value be defaulted some how if missing?

I think this is a direct consequence of the attempt to remove the
header file dependency, since the RSTOUTn_MASK macro is defined
in mach/bridge-regs.h.

I don't see a good way out that would preserve backwards compatibility,
other than hardcoding the physical address in the driver, which seems
just as bad as breaking compatibility. That said, it is always the
same constant (0xf1000000 + 0x20000 + 0x0108) on Dove, Kirkwood and
Orion5x (not on mv78xx0, but that doesn't use the wdt), so hardcoding
a fallback would technically work, but we should print a fat warning at
boot time if we actually fall back to that.

	Arnd
