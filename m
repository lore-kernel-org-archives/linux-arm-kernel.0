From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jul 2011 00:20:19 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110704195819.GG8286@n2100.arm.linux.org.uk>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
	<20110704111338.GD8286@n2100.arm.linux.org.uk>
	<20110704155835.GA30189@e102109-lin.cambridge.arm.com>
	<20110704195819.GG8286@n2100.arm.linux.org.uk>
Message-ID: <20110704232019.GK8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 08:58:19PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 04, 2011 at 04:58:35PM +0100, Catalin Marinas wrote:
> > With setting and checking the TIF_ flag we penalise newer hardware
> > (Cortex-A8 onwards) where the BTB invalidation is a no-op. But I'll
> > check with the people here if there are any implications with deferring
> > the BTB invalidation.
> 
> Thanks.

Please can you also check whether BTC invalidation is required when a
page is removed from the page tables for the purpose of swapping it
out (so the PTE entry becomes zero).

Also, is BTC invalidation required if the very same page that was
there before is later restored without any modification to the
instruction content of that page.  (I'm thinking page is aged to old,
and so unmapped, then a prefetch abort which reinstates the same page
that was there previously.)

Finally, is BTC invalidation required if a different physical page
containing the same instruction content as before is placed at that
location?

I expect all but the last case requires BTC invalidation.

Lastly, please check whether population and removal of page table
entries for NX pages require BTC invalidation.  I expect not.
