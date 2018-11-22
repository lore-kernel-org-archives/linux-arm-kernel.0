From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 22 Nov 2018 11:53:34 +0000
Subject: compiler code model for the kernel
In-Reply-To: <CAKwvOdmOUHH9BbRV=zfx9LKyfwL41NPDke_uqD_4ZwyGqxJGKg@mail.gmail.com>
References: <CAKv+Gu8LchCWB-b+cDmStwrNf5qDs6ZMQ4drv2HMk-8OyjbzNQ@mail.gmail.com>
 <CAKwvOdmOUHH9BbRV=zfx9LKyfwL41NPDke_uqD_4ZwyGqxJGKg@mail.gmail.com>
Message-ID: <20181122115331.GG3505@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 09:48:16AM -0800, Nick Desaulniers wrote:
> On Mon, Nov 19, 2018 at 9:42 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > Hello all,
> >
> > Some of us (on cc) have discussed this a bit on various occasions, so
> > perhaps it's time to sit down and do something about it :-)
> >
> > The Clang work that Nick is involved in has made explicit some
> > assumptions that we are currently making in the kernel with respect to
> > the behavior of GCC, and it would be good to formalise this so we can
> > keep relying on it in the future, and to clarify to other compiler
> > developers what is needed.
> >
> > GCC for x86 has a -mcmodel=kernel parameter, so perhaps we should
> > introduce the same for AArch64. Under this model, we should be able to
> > make the following assumptions:
> > - symbol references are emitted as ADRP/ADD pairs
> > -  no absolute references in generated code like jump tables etc (like
> > -fpic/-fpie) [*]
> > - no shared library semantics (no GOT indirections to support symbol
> > preemption, or to reduce the CoW footprint and/or avoid text
> > relocations)
> > - resulting objects can be linked in -pie mode by ld.bfd
> >
> > Another thing that came up is that we currently rely on the stack
> > pointer never to assume a value that is not 16-byte aligned, even
> > transiently.
> >
> > Other things I've missed?
> >
> > [*] This is only strictly required in parts of the code that may
> > execute at a different offset than the linked offset, even after
> > processing dynamic relocations at boot time (e.g., KVM hyp code
> > running in a different exception level) but avoiding those altogether
> > is reasonable. Note that GCC does the right thing for us here already,
> > but Clang current;y needs -fno-jump-tables to build the KVM hyp code.
> 
> Just following up on the KVM hyp code. At plumbers Mark and I took a
> look at that case and were no longer able to reproduce.  Mark was able
> to boot a Clang compiled kernel at EL2.  IIRC, the code in question
> had been changed.  Note: Clang still probably does the wrong thing for
> jump tables, so we should pursue this code model, I just don't think
> this previous example is still the case.  Since it could always come
> back, we should fix the issue on the compiler side though.

We should absolutely document it as a requirement either way,
and the putative gcc -mcmodel=kernel for arm64 should guarantee it.

Is this a requirement for non-hyp code though?

KASLR doesn't strictly need it, since we could keep the relocation info
around and fix the kernel up at boot time (though obviously life is
easier if we don't need to do this).

Currently the lack of relocations seems to be an accidental side-effect
of -mcmodel=small.  It's not clear to me whether we rely on this because
it's advantageous, or whether we rely on it by accident because it
happens to be the default.

My question is: should there be just one kernel memory model, or do we
want position-independent (for hyp-like stuff) and non-position-
independent variants (for everything else)?

Cheers
---Dave
