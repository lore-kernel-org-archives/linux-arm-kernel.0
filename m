From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jul 2011 14:05:21 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110704104329.GD19117@e102109-lin.cambridge.arm.com>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
Message-ID: <20110704130521.GF8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 11:43:29AM +0100, Catalin Marinas wrote:
> On Mon, Jul 04, 2011 at 11:02:21AM +0100, Russell King - ARM Linux wrote:
> > The single-TLB model works fairly well, but as I thought the lack of
> > mcr%? processing by GCC makes the asm/tlbflush.h code fairly disgusting
> > even for a v6+v7 kernel.  Luckily, we can play some tricks and sort
> > some of that out.  The patch below is not complete (and can result in
> > some rules of the architecture being violated - namely the requirement
> > for an ISB after the BTB flush without a branch between) but it
> > illustrates the idea:
> 
> I'm not sure about this rule, I can ask for some clarification (we are
> not changing the memory map of the branch we execute).

There's no need for clarification on the BTB and branch issue, the
ARM ARM is quite clear on this topic:

Branch predictor maintenance operations and the memory order model
The following rule describes the effect of the memory order model on
the branch predictor maintenance operations:
? Any invalidation of the branch predictor is guaranteed to take effect only
  after one of the following:
  ? execution of a ISB instruction
  ? taking an exception
  ? return from an exception.
Therefore, if a branch instruction appears between an invalidate branch
prediction instruction and an ISB operation, exception entry or exception
return, it is UNPREDICTABLE whether the branch instruction is affected by
the invalidate. Software must avoid this ordering of instructions, because
it might lead to UNPREDICTABLE behavior.

The branch predictor maintenance operations must be used to invalidate
entries in the branch predictor after any of the following events:
? enabling or disabling the MMU
? writing new data to instruction locations
? writing new mappings to the translation tables
? changes to the TTBR0, TTBR1, or TTBCR registers, unless accompanied by
  a change to the ContextID or the FCSE ProcessID.

Failure to invalidate entries might give UNPREDICTABLE results, caused by
the execution of old branches.

So:

	mcr	p15, 0, %0, c7, c5, 6 @ BTC invalidate
	tst	%1, #value
	beq	no_dsb_isb
	dsb
	isb
no_dsb_isb:

is strictly not predictable whether the branch will be taken.

The only remaining question is: the operations prior to the BTC invalidate
will not have changed the code path which 'beq' is a part of, so is it
_really_ the case that a BTC invalidate will make such a branch
unpredictable?

I guess the reason for this is that if the BTC is half-way through an
invalidate, its state may not be determinable, and so it is not
determinable whether the branch will be taken irrespective of the
previous BTC state before the invalidate and the new state after the
isb.

Or, to put it another way, the BTC can return random results between
the BTC invalidate and the following ISB.
