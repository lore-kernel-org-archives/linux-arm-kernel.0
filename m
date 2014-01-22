From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Jan 2014 19:21:37 +0100
Subject: [PATCH v2 05/15] watchdog: orion: Make RSTOUT register a separate
 resource
In-Reply-To: <20140122181409.GV18269@obsidianresearch.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140122180100.GE27273@localhost>
 <20140122181409.GV18269@obsidianresearch.com>
Message-ID: <3159777.ZVRLCgpLar@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 January 2014 11:14:09 Jason Gunthorpe wrote:
> On Wed, Jan 22, 2014 at 03:01:01PM -0300, Ezequiel Garcia wrote:
> > On Wed, Jan 22, 2014 at 01:21:36PM -0300, Ezequiel Garcia wrote:
> > > > I don't see a good way out that would preserve backwards compatibility,
> > > > other than hardcoding the physical address in the driver, which seems
> > > > just as bad as breaking compatibility. That said, it is always the
> > > > same constant (0xf1000000 + 0x20000 + 0x0108) on Dove, Kirkwood and
> > > > Orion5x (not on mv78xx0, but that doesn't use the wdt), so hardcoding
> > > > a fallback would technically work, but we should print a fat warning at
> > > > boot time if we actually fall back to that.
> > > > 
> > > 
> > > Yes, I was thinking just about this. Namely:
> > > 
> > [..]
> > 
> > How about something like this?
> 
> I liked Arnd's idea to use an offset from the first register. With the
> mbus driver we can now actually change the 0xF1.. prefix via the DT.

That wasn't actually my idea, but it does sound reasonable.

> > +     dev_warn(&pdev->dev, "falling back to harcoded RSTOUT reg 0x%x\n",
> > +              ORION_RSTOUT_MASK);
> 
> Maybe:
> dev_warn(&pdev->dev, FW_BUG "falling back to harcoded RSTOUT reg 0x%x\n",

I was thinking of WARN_ON(), i.e. something that users will actually notice ;-)

> > @@ -139,10 +166,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
> >       if (!wdt_reg)
> >               return -ENOMEM;
> >  
> > -     res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > -     if (!res)
> > -             return -ENODEV;
> > -     wdt_rstout = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> > +     wdt_rstout = try_compat_rstout_ioremap(pdev);
> >       if (!wdt_rstout)
> >               return -ENOMEM;
> 
> ENOMEM is probably not the right errno? Is there a standard errno for
> malformed DT?

I don't think so. I'd probably use ENODEV, but it's not ideal.

	Arnd
