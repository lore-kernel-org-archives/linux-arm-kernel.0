From: jamie@shareable.org (Jamie Lokier)
Date: Sat, 24 Apr 2010 04:04:11 +0100
Subject: [PATCH v2] MTD: Fix Orion NAND driver compilation with ARM OABI
In-Reply-To: <20100424025858.GJ15349@shareable.org>
References: <20100325152505.17612.40158.stgit@pauliusz>
	<20100325204619.GC19308@shareable.org>
	<alpine.LFD.2.00.1004231443340.7232@xanadu.home>
	<20100424025858.GJ15349@shareable.org>
Message-ID: <20100424030411.GK15349@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Lokier wrote:
> Nicolas Pitre wrote:
> > On Thu, 25 Mar 2010, Jamie Lokier wrote:
> > > Any one of these should fix it:
> > > 
> > >    - Make io_base a pointer-to-volatile-u64 or cast it in the asm, and
> > >      make sure to dereference it and use an "m" constraint (or
> > >      tighter, such as "Q", if ldrd needs it).  It must be u64, not
> > >      pointer-to-void, to tell GCC the size.  That tells GCC which memory
> > >      the asm accesses, and the volatile dereference should tell GCC
> > >      not to reorder them in principle (but the GCC manual doesn't
> > >      make a specific promise about this for asms).
> > 
> > The LDRD has special range constraints on its addressing mode which is 
> > not expressable with any of the available gcc memory constraints.
> 
>     'Q'
>           A memory reference where the exact address is in a single
>           register (''m'' is preferable for 'asm' statements)
> 
> If 'r' is good enough for io_base, 'Q' should be good enough for *io_base.

And if that doesn't work, it's possible to pass both the pointer, and
the dereference, as separate input operands, and only use the pointer
in the asm template.  GCC will still treat the dereference input as a
dependency.

-- Jamie
