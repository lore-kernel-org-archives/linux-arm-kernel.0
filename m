From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 24 Apr 2010 09:02:04 -0400 (EDT)
Subject: [PATCH v2] MTD: Fix Orion NAND driver compilation with ARM OABI
In-Reply-To: <20100424025858.GJ15349@shareable.org>
References: <20100325152505.17612.40158.stgit@pauliusz>
	<20100325204619.GC19308@shareable.org>
	<alpine.LFD.2.00.1004231443340.7232@xanadu.home>
	<20100424025858.GJ15349@shareable.org>
Message-ID: <alpine.LFD.2.00.1004240855570.7232@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 24 Apr 2010, Jamie Lokier wrote:

> Nicolas Pitre wrote:
> > On Thu, 25 Mar 2010, Jamie Lokier wrote:
> > > >  		asm volatile ("ldrd\t%0, [%1]" : "=&r" (x) : "r" (io_base));
> > > >  		buf64[i++] = x;
> > > 
> > > The "register...asm" looks fine, but it occurs to me the constraints
> > > are too weak (and they were before), so GCC could optimise that to the
> > > wrong behaviour.
> > > 
> > > The "volatile" prevents GCC deleting the asm if it's output isn't
> > > used, but it doesn't stop GCC from reordering the asms, for example if
> > > it decides to unroll the loop.  It probably won't reorder in that
> > > case, but it could.  The result would be out of order values stored
> > > into buf[].  It could even move the ldrd earlier than the prior byte
> > > accesses, or after the later byte accesses.
> > 
> > I don't see how that could happen.  The store into buf[] puts a 
> > dependency on the output constraint of the inline asm statement.  And by 
> > vertue of being volatile, gcc cannot cache the result of the output from 
> > the asm as if it was a pure function.
> 
> The store into buf[] dependency doesn't stop this, after unrolling:
> 
>     asm volatile ("ldrd\t%0, [%1]" : "=&r" (x) : "r" (io_base));
>     buf64[i++] = x;
>     asm volatile ("ldrd\t%0, [%1]" : "=&r" (x) : "r" (io_base));
>     buf64[i++] = x;
> 
> from being reordered as this
> 
>     asm volatile ("ldrd\t%0, [%1]" : "=&r" (x2) : "r" (io_base));
>     asm volatile ("ldrd\t%0, [%1]" : "=&r" (x1) : "r" (io_base));
>     buf64[i++] = x1;
>     buf64[i++] = x2;
> 
> because the asm doesn't depend on memory, just register inputs and
> outputs;

I disagree.  The volatile tells gcc that the asm has side effects, and 
therefore 1) they can't be optimized away, and 2) can't be swapped with 
regards to each other like you do in your example.

>     'Q'
>           A memory reference where the exact address is in a single
>           register (''m'' is preferable for 'asm' statements)

Hmmm... Is this something new?  I must have missed it before.


Nicolas
