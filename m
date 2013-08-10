From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 10 Aug 2013 19:43:08 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzNdIEFSTTogSW50cm9kdWNlIGF0b21pYyBNTUlPIGNs?=
 =?UTF-8?B?ZWFyL3NldA==?=
In-Reply-To: <20130810140927.GC3080@localhost>
References: <1376138582-7550-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130810140237.GB3080@localhost> <20130810140927.GC3080@localhost>
Message-ID: <1376149388.716003514@f150.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Aug 10, 2013 at 11:02:38AM -0300, Ezequiel Garcia wrote:
> > On Sat, Aug 10, 2013 at 04:49:28PM +0400, Alexander Shiyan wrote:
> > > > Some SoC have MMIO regions that are shared across orthogonal
> > > > subsystems. This commit implements a possible solution for the
> > > > thread-safe access of such regions through a spinlock-protected API
> > > > with clear-set semantics.
> > > > 
> > > > Concurrent access is protected with a single spinlock for the
> > > > entire MMIO address space. While this protects shared-registers,
> > > > it also serializes access to unrelated/unshared registers.
[...]
> > > > +void atomic_io_clear_set(void __iomem *reg, u32 clear, u32 set)
> > > > +{
> > > > +	spin_lock(&__io_lock);
> > > > +	writel((readl(reg) & ~clear) | set, reg);
> > > > +	spin_unlock(&__io_lock);
> > > > +}
> > > > +EXPORT_SYMBOL(atomic_io_clear_set);
> > > 
> > > So, one lock is used to all possible registers?
> > > Seems a regmap-mmio can be used for such access.
> > > 
> > 
> > Thanks for the hint! Quite frankly, I wasn't familiar with regmap-mmio.
> > 
> > However, after reading some code, I fail to see how that helps in this case.
> > 
> > Note that we need to access the *same* MMIO address from completely
> > different (and unrelated) drivers, such as watchdog and clocksource.
> > 
> > So I wonder who would "own" the regmap descriptor, and how does the other
> > one gets aware of that descriptor?
> > 
> > In addition given we can use orion_wdt (originally meant for mach-kirkwood)
> > to support mvebu SoC watchdog, we need to sort this out in a completely
> > multiplatform capable way.
> > 
> > Ideas?
> 
> Answering myself...
> 
> How about using drivers/mfd/syscon.c to create the regmap owner for the shared
> register (TIMER_CTRL in this case, but others might appear) ?
> 
> Or adding a new mfd implementation if syscon does not fit ?
> 
> Does this sound like an overkill ?

Yes, syscon is designed especially for such cases.

---
