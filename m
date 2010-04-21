From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Apr 2010 22:39:40 +0100
Subject: Simply disabling MMU in cpu_v7_reset doesn't work for kexec
In-Reply-To: <20100421211017.GA27575@shareable.org>
References: <w2mf17812d71004210618vc68963cbn7ed50483a56140b7@mail.gmail.com>
	<n2jf17812d71004210619qee8b8467u135fdbb44ff33049@mail.gmail.com>
	<20100421194844.GF26616@n2100.arm.linux.org.uk>
	<20100421211017.GA27575@shareable.org>
Message-ID: <20100421213940.GJ26616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 10:10:17PM +0100, Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
> > On Wed, Apr 21, 2010 at 09:19:06PM +0800, Eric Miao wrote:
> > > On Wed, Apr 21, 2010 at 9:18 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> > > > Tried the following simple code to disable MMU in cpu_v7_reset() doesn't
> > > > seem to work for kexec reboot. I was expecting the following instructions
> > > > after MMU is disabled are still reachable in the instruction fetching pipe.
> > > >
> > > 
> > > 	.align	5
> > >  ENTRY(cpu_v7_reset)
> > > +	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
> > > +	bic	r1, r1, #0x0001			@ ...............m
> > > +	mcr	p15, 0, r1, c1, c0, 0		@ disable MMU
> > > +	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I and D TLBs
> > >  	mov	pc, r0
> > >  ENDPROC(cpu_v7_reset)
> > 
> > The procedure expected here is:
> > 
> > 1. invalidate caches
> > 2. drain buffers
> > 3. invalidate TLBs
> > 4. disable MMU et.al.
> > 5. jump to the address in r0.
> > 
> > The reason this is permitted is because cpu_v7_proc_fin _must_ be called
> > before hand, which is expected to disable all interrupts, and flush and
> > disable the caches.
> 
> Isn't step 1 above redundant, because caches are already disabled and
> flushed?

No, because they're flushed _then_ disabled, so there will be some cache
valid lines lurking about.

> > It might be worth given the speculative behaviour of V7 to also invalidate
> > TLBs after a dsb and isb after step 4 instead of before step 4 - and (iirc)
> > also doing an isb after invalidating the TLBs.
> 
> Mightn't the CPU refill one entry in the TLB between steps 3 and 4,
> just by fetching the instructions - even non-speculatively?
> 
> Fwiw, the lengthy patch here:
> 
>    http://lists.infradead.org/pipermail/barebox/2010-January/000528.html
> 
> does exactly this in the ARMv7 part:
> 
> 1. Turn off MMU and caches (one mcr).
> 2. Clean and flush caches.
> 3. Invalidate TLBs.
> 4. Invalidate BTC.
> 5. DSB.
> 6. ISB.
> 7. Return to caller / destination.
> 
> I don't know if it expects the final instructions to be direct-mapped.

They must be direct mapped, because it's not clearly defined exactly
when the MMU will be disabled in the above sequence.
