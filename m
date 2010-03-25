From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 25 Mar 2010 20:46:19 +0000
Subject: [PATCH v2] MTD: Fix Orion NAND driver compilation with ARM OABI
In-Reply-To: <20100325152505.17612.40158.stgit@pauliusz>
References: <20100325152505.17612.40158.stgit@pauliusz>
Message-ID: <20100325204619.GC19308@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paulius Zaleckas wrote:
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>

It's probably worth including the people who weighed in on the
discussion with 'Cc:' headers.

> -		uint64_t x;
> +		/*
> +		 * Since GCC has no proper constraint (PR 43518)
> +		 * force x variable to r2/r3 registers as ldrd instruction
> +		 * requires first register to be even.
> +		 */
> +		register uint64_t x asm ("r2");
> +
>  		asm volatile ("ldrd\t%0, [%1]" : "=&r" (x) : "r" (io_base));
>  		buf64[i++] = x;

The "register...asm" looks fine, but it occurs to me the constraints
are too weak (and they were before), so GCC could optimise that to the
wrong behaviour.

The "volatile" prevents GCC deleting the asm if it's output isn't
used, but it doesn't stop GCC from reordering the asms, for example if
it decides to unroll the loop.  It probably won't reorder in that
case, but it could.  The result would be out of order values stored
into buf[].  It could even move the ldrd earlier than the prior byte
accesses, or after the later byte accesses.

Any one of these should fix it:

   - Make io_base a pointer-to-volatile-u64 or cast it in the asm, and
     make sure to dereference it and use an "m" constraint (or
     tighter, such as "Q", if ldrd needs it).  It must be u64, not
     pointer-to-void, to tell GCC the size.  That tells GCC which memory
     the asm accesses, and the volatile dereference should tell GCC
     not to reorder them in principle (but the GCC manual doesn't
     make a specific promise about this for asms).

     With a proper memory input with the correct size, in principle
     "asm volatile" can be changed to just "asm", but I'm not entirely
     convinced GCC will honour the volatile on the pointer, so I'd
     leave it on the asm too.

   - Add "memory" to the asm's clobbers.  Although it doesn't write,
     it does change the visible memory that *io_base sees, and anyway
     GCC's manual says to use "memory" clobber when the asm does
     unpredictable memory reads too.  With that added, you still need
     the volatile keyword after asm, because the memory is not listed
     in the inputs or outputs (only the address is).  The GCC manual
     explains that "asm volatile" is needed in that case.

     This is slightly less good because it'd prevent reordering writes
     to buf[i++] if GCC unrolled the loop.

   - Put barrier() before and after the asm, which is equivalent to
     adding a "memory" clobber (least good).

You aren't supposed to dereference pointers used with read{b,w,l}
anyway.  It doesn't matter in this driver because we "know" it's only
used on an SoC where read{b,w,l} don't do any address translation.
But will that always be true?  I suppose the cleanest approach is to
define readq, the 64-bit analogue of readl, and use that here.  x86
already defines readq, so it's got precedent.

-- Jamie
