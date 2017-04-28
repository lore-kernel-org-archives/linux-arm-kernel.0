From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 28 Apr 2017 17:10:28 +0100
Subject: [PATCH 3/4] arm64: entry: improve data abort handling of tagged
 pointers
In-Reply-To: <d886b2b3-f623-9e79-a99a-c51672a80390@arm.com>
References: <1492712234-4950-1-git-send-email-kristina.martsenko@arm.com>
 <1492712234-4950-4-git-send-email-kristina.martsenko@arm.com>
 <20170421182450.GR3750@e103592.cambridge.arm.com>
 <d886b2b3-f623-9e79-a99a-c51672a80390@arm.com>
Message-ID: <20170428161026.GC9082@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 05:34:24PM +0100, Kristina Martsenko wrote:
> On 21/04/17 19:24, Dave Martin wrote:
> > On Thu, Apr 20, 2017 at 07:17:13PM +0100, Kristina Martsenko wrote:
> >> When handling a data abort from EL0, we currently zero the top byte of
> >> the faulting address, as we assume the address is a TTBR0 address, which
> >> may contain a non-zero address tag. However, the address may be a TTBR1
> >> address, in which case we should not zero the top byte. This patch fixes
> >> that. The effect is that the full TTBR1 address is passed to the task's
> >> signal handler (or printed out in the kernel log).
> >>
> >> When handling a data abort from EL1, we leave the faulting address
> >> intact, as we assume it's either a TTBR1 address or a TTBR0 address with
> >> tag 0x00. This is true as far as I'm aware, we don't seem to access a
> >> tagged TTBR0 address anywhere in the kernel. Regardless, it's easy to
> >> forget about address tags, and code added in the future may not always
> >> remember to remove tags from addresses before accessing them. So add tag
> >> handling to the EL1 data abort handler as well. This also makes it
> >> consistent with the EL0 data abort handler.
> > 
> > Possibly it doesn't matter whether the tag bits are cleared for an EL0
> > fault on a TTBR1 address, since userspace can't have a valid pointer in
> > this range to (mis)match the fault address against ... or did I miss
> > something?
> 
> I don't think you've missed anything. But I don't see why userspace
> can't match against an invalid (TTBR1) address, I think that would be a
> valid thing to do (even if unlikely).
> 
> > Factoring out the tag handling makes the intent of the code clearer
> > though, either way.
> 
> I assume this means you're fine with the patch as is.

Yes, the behaviour here seems fine.  I just wanted to check there wasn't
some real use of TTBR1 addresses by userspace that I was missing.


It looks like a minor improvement may be possible (below) but these
aren't hot paths, so it's far from crucial.

> +/*
> + * Remove the address tag from a virtual address, if present.
> + */
> +	.macro	clear_address_tag, addr, tmp
> +	bic	\tmp, \addr, #(0xff << 56)
> +	tst	\addr, #(1 << 55)
> +	csel	\addr, \tmp, \addr, eq
> +	.endm

Minor nit: this may issue better on simpler microarchitectures if the
tst and bic are swapped: this may reduce how far the Z flag needs to
be forwarded.

For beefier microarchitectures it probably doesn't make a difference.

Also, in:

> @@ -594,7 +595,8 @@ el0_da:
>  	// enable interrupts before calling the main handler
>  	enable_dbg_and_irq
>  	ct_user_exit
> -	bic	x0, x26, #(0xff << 56)
> +	mov	x0, x26
> +	clear_address_tag x0, x3

we can lose the mov if clear_address_tag is altered to take "addr out"
and "addr in" arguments instead of "addr in+out" and "tmp": addr out can
store result of the bic, then we can conditionally revert that back to
addr in using the csel.

This change will break el1_da:

> @@ -434,6 +434,7 @@ el1_da:
> 	mrs	x0, far_el1
> 	enable_dbg
> 	// re-enable interrupts if they were enabled in the aborted context
>  	tbnz	x23, #7, 1f			// PSR_I_BIT
>  	enable_irq
>  1:
> +	clear_address_tag x0, x3

... because we want the same register as input and output.  But that can
be fixed if we use a different destination register in the mrs in the
first place (say, x3).

Cheers
---Dave
