From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 4 Jul 2011 14:15:34 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110704130521.GF8286@n2100.arm.linux.org.uk>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
	<20110704130521.GF8286@n2100.arm.linux.org.uk>
Message-ID: <20110704131533.GA27320@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 02:05:21PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 04, 2011 at 11:43:29AM +0100, Catalin Marinas wrote:
> > On Mon, Jul 04, 2011 at 11:02:21AM +0100, Russell King - ARM Linux wrote:
> > > The single-TLB model works fairly well, but as I thought the lack of
> > > mcr%? processing by GCC makes the asm/tlbflush.h code fairly disgusting
> > > even for a v6+v7 kernel.  Luckily, we can play some tricks and sort
> > > some of that out.  The patch below is not complete (and can result in
> > > some rules of the architecture being violated - namely the requirement
> > > for an ISB after the BTB flush without a branch between) but it
> > > illustrates the idea:
> > 
> > I'm not sure about this rule, I can ask for some clarification (we are
> > not changing the memory map of the branch we execute).
> 
> There's no need for clarification on the BTB and branch issue, the
> ARM ARM is quite clear on this topic:
> 
> Branch predictor maintenance operations and the memory order model
> The following rule describes the effect of the memory order model on
> the branch predictor maintenance operations:
> ? Any invalidation of the branch predictor is guaranteed to take effect only
>   after one of the following:
>   ? execution of a ISB instruction
>   ? taking an exception
>   ? return from an exception.
> Therefore, if a branch instruction appears between an invalidate branch
> prediction instruction and an ISB operation, exception entry or exception
> return, it is UNPREDICTABLE whether the branch instruction is affected by
> the invalidate. Software must avoid this ordering of instructions, because
> it might lead to UNPREDICTABLE behavior.

So my this rule should we always use an ISB even if we only flushed user
TLB entries? Otherwise we get some branches before the exception return.

My reading is that it only affects the branch in the TLB op function for
which we don't change any mapping, so there isn't any risk of
mis-prediction. That's why I think I should ask for clarification if we
can't avoid the branch.

-- 
Catalin
