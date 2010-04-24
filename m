From: jamie@shareable.org (Jamie Lokier)
Date: Sat, 24 Apr 2010 03:58:58 +0100
Subject: [PATCH v2] MTD: Fix Orion NAND driver compilation with ARM OABI
In-Reply-To: <alpine.LFD.2.00.1004231443340.7232@xanadu.home>
References: <20100325152505.17612.40158.stgit@pauliusz>
	<20100325204619.GC19308@shareable.org>
	<alpine.LFD.2.00.1004231443340.7232@xanadu.home>
Message-ID: <20100424025858.GJ15349@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> On Thu, 25 Mar 2010, Jamie Lokier wrote:
> > >  		asm volatile ("ldrd\t%0, [%1]" : "=&r" (x) : "r" (io_base));
> > >  		buf64[i++] = x;
> > 
> > The "register...asm" looks fine, but it occurs to me the constraints
> > are too weak (and they were before), so GCC could optimise that to the
> > wrong behaviour.
> > 
> > The "volatile" prevents GCC deleting the asm if it's output isn't
> > used, but it doesn't stop GCC from reordering the asms, for example if
> > it decides to unroll the loop.  It probably won't reorder in that
> > case, but it could.  The result would be out of order values stored
> > into buf[].  It could even move the ldrd earlier than the prior byte
> > accesses, or after the later byte accesses.
> 
> I don't see how that could happen.  The store into buf[] puts a 
> dependency on the output constraint of the inline asm statement.  And by 
> vertue of being volatile, gcc cannot cache the result of the output from 
> the asm as if it was a pure function.

The store into buf[] dependency doesn't stop this, after unrolling:

    asm volatile ("ldrd\t%0, [%1]" : "=&r" (x) : "r" (io_base));
    buf64[i++] = x;
    asm volatile ("ldrd\t%0, [%1]" : "=&r" (x) : "r" (io_base));
    buf64[i++] = x;

from being reordered as this

    asm volatile ("ldrd\t%0, [%1]" : "=&r" (x2) : "r" (io_base));
    asm volatile ("ldrd\t%0, [%1]" : "=&r" (x1) : "r" (io_base));
    buf64[i++] = x1;
    buf64[i++] = x2;

because the asm doesn't depend on memory, just register inputs and
outputs;

I'm not sure what you mean about the volatile stopping gcc from
treating the asm as a pure function.  Is that meaning of volatile in
the asm documentation?  (volatile on asm doesn't mean the same as
volatile on a function, or volatile on a pointer).

> > Any one of these should fix it:
> > 
> >    - Make io_base a pointer-to-volatile-u64 or cast it in the asm, and
> >      make sure to dereference it and use an "m" constraint (or
> >      tighter, such as "Q", if ldrd needs it).  It must be u64, not
> >      pointer-to-void, to tell GCC the size.  That tells GCC which memory
> >      the asm accesses, and the volatile dereference should tell GCC
> >      not to reorder them in principle (but the GCC manual doesn't
> >      make a specific promise about this for asms).
> 
> The LDRD has special range constraints on its addressing mode which is 
> not expressable with any of the available gcc memory constraints.

    'Q'
          A memory reference where the exact address is in a single
          register (''m'' is preferable for 'asm' statements)

If 'r' is good enough for io_base, 'Q' should be good enough for *io_base.

-- Jamie
