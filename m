From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 30 Nov 2009 14:47:02 +0000
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <alpine.LFD.2.00.0911301519120.24119@localhost.localdomain>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<1259589780.26472.18.camel@laptop>
	<alpine.LFD.2.00.0911301519120.24119@localhost.localdomain>
Message-ID: <20091130144702.14bea0ee@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Nov 2009 15:24:40 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 30 Nov 2009, Peter Zijlstra wrote:
> > On Mon, 2009-11-30 at 14:54 +0100, Thomas Gleixner wrote:
> > > The correct solution IMNSHO is to get rid of IRQF_DISABLED and run
> > > interrupt handlers always with interrupts disabled and require them
> > > not to reenable interrupts themself.
> > > 
> > > Thoughts ?
> > 
> > I'm all for removing that brain damage:
> > 
> >   http://lkml.org/lkml/2009/3/2/33
> 
> Darn, I knew that we discussed that before, but my memory tricked me
> into believing that it was years ago :)

Well the patch listed there is utterly bogus and will cause hangs at
startup. The problem case is IRQF_SHARED|IRQF_DISABLED. The patch messes
up all the unshared cases too - and lots of non sharable IRQ hardware just
jams the IRQ line high until you beat it into sense (8530's are notorious
for getting into that kind of state at init for example). You can't simply
remove the disabled from those drivers, you need to be able to allocate a
non-shared IRQ, and then enable it or do major driver restructuring of
obscure old driver code.

SHARED|DISABLED ought to WARN_ON() and if that doesn't motivate people
then return -EINVAL. And with any luck that'll prove 6 months later that
most of the offenders are not used and we can delete them wholesale.

DISABLE without SHARED is fine, and saves waking the dead.
