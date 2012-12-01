From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Dec 2012 16:45:25 -0500
Subject: [PATCH] ARM: ixp4xx: Add "ask" handler for timer interrupts
In-Reply-To: <201212012125.51935.arnd@arndb.de>
References: <1354347213-22237-1-git-send-email-shc_work@mail.ru>
 <201212012125.51935.arnd@arndb.de>
Message-ID: <20121201214525.GI12509@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 01, 2012 at 09:25:51PM +0000, Arnd Bergmann wrote:
> On Saturday 01 December 2012, Alexander Shiyan wrote:
> > +       switch (d->irq) {
> > +       case IRQ_IXP4XX_TIMER1:
> > +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
> > +               break;
> > +       case IRQ_IXP4XX_TIMER2:
> > +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_2_PEND;
> > +               break;
> > +       case IRQ_IXP4XX_TIMESTAMP:
> > +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_TS_PEND;
> > +               break;
> > +       case IRQ_IXP4XX_WDOG:
> > +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_WDOG_PEND;
> > +               break;
> 
> Since you are touching these lines, it probably makes sense to convert them
> to use writel_relaxed() in the process. Dereferencing a volatile pointer
> in order to do MMIO is strongly discouraged, see
> Documentation/volatile-considered-harmful.txt

Arnd,

I took a quick look at the ixp4xx code when I saw this.  It appears the
entire sub-arch is written this way :-(  Perhaps it would be better to
do a cleanup patch before this one?  I didn't mention it in my initial
comment because it looks like quite a bit of work.

In either case, it's all cleanup, so it shouldn't cause a dependency
headache.

Alexander, if you're so inclined, a cleanup series would be much
appreciated.  If you don't have the time, no problem, just make the
changes suggested by Arnd and I and we'll get to the cleanup eventually.

thx,

Jason.
