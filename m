From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jan 2010 19:03:55 +0000
Subject: [RFC PATCH 04/12] arm: mm: cache-l2x0: add l2x0 suspend and
	resume functions
In-Reply-To: <1264789772.1818.8.camel@c-dwalke-linux.qualcomm.com>
References: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
	<1264763312.4242.47.camel@pc1117.cambridge.arm.com>
	<179C5F34D68DF54C8898E904FC5BAF8C79E15B77C4@NALASEXMB09.na.qualcomm.com>
	<1264787969.1818.6.camel@c-dwalke-linux.qualcomm.com>
	<179C5F34D68DF54C8898E904FC5BAF8C79E15B77CD@NALASEXMB09.na.qualcomm.com>
	<1264789772.1818.8.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100129190355.GA19882@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2010 at 10:29:32AM -0800, Daniel Walker wrote:
> On Fri, 2010-01-29 at 10:23 -0800, Ruan, Willie wrote:
> > > From: Daniel Walker [mailto:dwalker at codeaurora.org] 
> > > Sent: Friday, January 29, 2010 9:59 AM
> > >
> > > What if there are multiple cpu's calling cache_sync() at the same time?
> > > Disable interrupt wouldn't prevent it ..
> > 
> > cache_sync() is calling sync_writel(), which is using spin_lock_irqsave().
> > So, each call of cache_sync() and sync_writel() is SMP safe individually
> > in l2x0_flush_all() as in l2x0_inv_all(), unless we need to protect the
> > two calls together, which seems not necessary to me.
> 
> This is the current version,
> 
> static inline void cache_wait(void __iomem *reg, unsigned long mask)
> {
>         /* wait for the operation to complete */
>         while (readl(reg) & mask)
>                 ;
> }
> 
> static inline void cache_sync(void)
> {
>         void __iomem *base = l2x0_base;
>         writel(0, base + L2X0_CACHE_SYNC);
>         cache_wait(base + L2X0_CACHE_SYNC, 1);
> }
> 
> Maybe cache_sync was recently changed to "writel" instead sync_writel()
> due it getting called with the lock already held.

It's pointless discussing what the current code does, because that's
not what mainline does _today_ - the locking in this file has
completely changed.
