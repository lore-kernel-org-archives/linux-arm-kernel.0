From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 8 Aug 2017 23:44:01 +0200
Subject: linux-next 2017-08-08 keyboard failure on Nokia N900
In-Reply-To: <alpine.DEB.2.20.1708082228400.4939@hadrien>
References: <20170808101756.GA12922@amd> <20170808103444.GA18247@amd>
 <20170808111243.GA20328@amd>
 <61264d43-eda3-df9d-0c06-28611f373ce7@ti.com>
 <alpine.DEB.2.20.1708082203510.2095@hadrien>
 <43d915d2-3260-88b6-095d-4de8240ff29e@ti.com>
 <alpine.DEB.2.20.1708082228400.4939@hadrien>
Message-ID: <20170808214400.GA18961@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > I've not precisely checked it, but smth is telling me that below
> > > > patch  can cause this:
> > > >
> > > > commit 78daaca78ee57dead0f4aa5ee399f0499e81cd9e
...
> > > >      mfd: twl4030-irq: Drop unnecessary static
> > > >
> > > >      Drop static on a local variable, when the variable is initialized
> > > > before
> > > >      any use, on every possible execution path through the function.
> > > >
> > > > --- a/drivers/mfd/twl4030-irq.c
> > > > +++ b/drivers/mfd/twl4030-irq.c
...
> > > >   int twl4030_init_irq(struct device *dev, int irq_num)
> > > >   {
> > > > -       static struct irq_chip  twl4030_irq_chip;
> > > > +       struct irq_chip twl4030_irq_chip;
> > > >
> > > >
> > > > but if we will look at code - it can be seen that this variable is passed
> > > > by reference to
> > > > irq_set_chip_and_handler().
> > > > Ops. And what will happen when twl4030_init_irq() returns ;)
> > >
> > > The patch is not correct as was already noted when it was submitted:
..
> > Hm. This one is in linux-next, but shouldn't. Right?
> >
> >  git log --oneline  -10 linux-next/master
> > c0b96db Add linux-next specific files for 20170808
> >
> > git log --oneline  linux-next/master | grep "Drop unnecessary static"
> > 78daaca mfd: twl4030-irq: Drop unnecessary static
> 
> OK, it seems like the patch was made twice, the second one was commented
> on and the first one was applied.  78daaca should not be there.

Lee, it has your sign-off, can you drop the patch from your tree? It
is known bad.

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170808/bff17b2d/attachment.sig>
