From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Jul 2011 17:05:51 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110704232019.GK8286@n2100.arm.linux.org.uk>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
	<20110704111338.GD8286@n2100.arm.linux.org.uk>
	<20110704155835.GA30189@e102109-lin.cambridge.arm.com>
	<20110704195819.GG8286@n2100.arm.linux.org.uk>
	<20110704232019.GK8286@n2100.arm.linux.org.uk>
Message-ID: <20110706160551.GH32020@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 12:20:19AM +0100, Russell King - ARM Linux wrote:
> Please can you also check whether BTC invalidation is required when a
> page is removed from the page tables for the purpose of swapping it
> out (so the PTE entry becomes zero).

Not required.

> Also, is BTC invalidation required if the very same page that was
> there before is later restored without any modification to the
> instruction content of that page.  (I'm thinking page is aged to old,
> and so unmapped, then a prefetch abort which reinstates the same page
> that was there previously.)

Not required.

> Finally, is BTC invalidation required if a different physical page
> containing the same instruction content as before is placed at that
> location?

Required (see the comment below).

> Lastly, please check whether population and removal of page table
> entries for NX pages require BTC invalidation.  I expect not.
 
Not required.

Basically the rules for BTC are similar to those for the I-cache, but it
can be either ASID-tagged VIVT or VIPT, independent of the type of the
I-cache. I think current implementations of the BTC are ASID-tagged VIVT
but the architecture doesn't mandate this.

So the mapping of a data page doesn't require BTC invalidation, even if
the page is not marked as XN.

Having a branch between BTC and ISB is OK as long as we don't change the
mapping of the branch.

Mapping a page in a previously unmapped location doesn't generally
require BTC invalidation if we guarantee that there are no BTC entries
for that location (IOW, we got a new ASID or unmapping the page
previously had a BTC invalidation).

-- 
Catalin
