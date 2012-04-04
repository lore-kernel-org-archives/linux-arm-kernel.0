From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Apr 2012 13:23:36 +0000
Subject: [PATCH v2 1/3] PATA host controller driver for ep93xx
In-Reply-To: <4F7C4142.1010709@metasoft.pl>
References: <4F7B0C54.8010804@metasoft.pl> <201204032008.00509.arnd@arndb.de>
 <4F7C4142.1010709@metasoft.pl>
Message-ID: <201204041323.36695.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 April 2012, Rafal Prylowski wrote:
> On 2012-04-03 22:08, Arnd Bergmann wrote:
> >>> +static void ep93xx_pata_wait_for_iordy(void __iomem *base)
> >>> +{
> >>> +     unsigned long deadline = jiffies + msecs_to_jiffies(1000);
> >>> +     while (!ep93xx_pata_check_iordy(base) &&
> >>> +             time_is_before_jiffies(deadline))
> >>> +             cpu_relax();
> >>> +}
> > 
> > Much better for a delay than the previous version. However, it's
> > still a busy wait, which is bad for realtime behavior, especially
> > since this can potentially take many milliseconds. If possible,
> > it should have an msleep() or at least cond_resched() instead of
> > the cpu_relax(). Obviously that will only work when no spinlocks
> > are held.
> > 
> 
> Unfortunately, we can't use msleep() or cond_resched() here
> - ep93xx_pata_wait_for_iordy() is called from interrupt handler.

Well, it also seems inappropriate to have a one second delay timeout
inside of the interrupt handler.

I suppose if you are emulating what a regular read of the status
register does, there isn't much to improve here though.

	Arnd
