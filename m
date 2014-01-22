From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Jan 2014 13:21:37 -0300
Subject: [PATCH v2 05/15] watchdog: orion: Make RSTOUT register a
 separate resource
In-Reply-To: <3176358.2QFcJHj0fv@wuerfel>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233321.GR18269@obsidianresearch.com>
 <3176358.2QFcJHj0fv@wuerfel>
Message-ID: <20140122162136.GA27273@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Arnd:

On Wed, Jan 22, 2014 at 10:48:37AM +0100, Arnd Bergmann wrote:
> On Tuesday 21 January 2014 16:33:21 Jason Gunthorpe wrote:
> > On Tue, Jan 21, 2014 at 06:12:31AM -0300, Ezequiel Garcia wrote:
> > > In order to support other SoC, it's required to distinguish
> > > the 'control' timer register, from the 'rstout' register
> > > that enables system reset on watchdog expiration.
> > 
> > > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > +     if (!res)
> > > +             return -ENODEV;
> >            ^^^^^^^^^^^^^^^^^^^^^^
> > 
> > This change seems to break compatibility with existing DT files that
> > have only a single entry in reg?
> > 
> > Can the value be defaulted some how if missing?
> 
> I think this is a direct consequence of the attempt to remove the
> header file dependency, since the RSTOUTn_MASK macro is defined
> in mach/bridge-regs.h.
> 

Exactly. Just for the record, I warned about this a while back:

http://www.spinics.net/lists/arm-kernel/msg270163.html

That said, it truly sucks to break compatibility so finding a way to
keep backwards compatibility would be certainly desirable.

> I don't see a good way out that would preserve backwards compatibility,
> other than hardcoding the physical address in the driver, which seems
> just as bad as breaking compatibility. That said, it is always the
> same constant (0xf1000000 + 0x20000 + 0x0108) on Dove, Kirkwood and
> Orion5x (not on mv78xx0, but that doesn't use the wdt), so hardcoding
> a fallback would technically work, but we should print a fat warning at
> boot time if we actually fall back to that.
> 

Yes, I was thinking just about this. Namely:

If the second resource is missing *and* the compatible-string is
"orion-watchdog" (or it's not DT-registered), then use a hardcoded
RSTOUTn_MASK address. And pr_warn() something.

Thanks for the feedback,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
