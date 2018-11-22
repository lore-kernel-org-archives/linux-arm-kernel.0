From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 22 Nov 2018 13:06:43 +0100
Subject: compiler code model for the kernel
In-Reply-To: <20181122115331.GG3505@e103592.cambridge.arm.com>
References: <CAKv+Gu8LchCWB-b+cDmStwrNf5qDs6ZMQ4drv2HMk-8OyjbzNQ@mail.gmail.com>
 <CAKwvOdmOUHH9BbRV=zfx9LKyfwL41NPDke_uqD_4ZwyGqxJGKg@mail.gmail.com>
 <20181122115331.GG3505@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu-hFv+pmbx1cnTUC2PESTFq7NJ28n1ENq0FyVfBBhh=Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Nov 2018 at 12:53, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Mon, Nov 19, 2018 at 09:48:16AM -0800, Nick Desaulniers wrote:
> > On Mon, Nov 19, 2018 at 9:42 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > Hello all,
> > >
> > > Some of us (on cc) have discussed this a bit on various occasions, so
> > > perhaps it's time to sit down and do something about it :-)
> > >
> > > The Clang work that Nick is involved in has made explicit some
> > > assumptions that we are currently making in the kernel with respect to
> > > the behavior of GCC, and it would be good to formalise this so we can
> > > keep relying on it in the future, and to clarify to other compiler
> > > developers what is needed.
> > >
> > > GCC for x86 has a -mcmodel=kernel parameter, so perhaps we should
> > > introduce the same for AArch64. Under this model, we should be able to
> > > make the following assumptions:
> > > - symbol references are emitted as ADRP/ADD pairs
> > > -  no absolute references in generated code like jump tables etc (like
> > > -fpic/-fpie) [*]
> > > - no shared library semantics (no GOT indirections to support symbol
> > > preemption, or to reduce the CoW footprint and/or avoid text
> > > relocations)
> > > - resulting objects can be linked in -pie mode by ld.bfd
> > >
> > > Another thing that came up is that we currently rely on the stack
> > > pointer never to assume a value that is not 16-byte aligned, even
> > > transiently.
> > >
> > > Other things I've missed?
> > >
> > > [*] This is only strictly required in parts of the code that may
> > > execute at a different offset than the linked offset, even after
> > > processing dynamic relocations at boot time (e.g., KVM hyp code
> > > running in a different exception level) but avoiding those altogether
> > > is reasonable. Note that GCC does the right thing for us here already,
> > > but Clang current;y needs -fno-jump-tables to build the KVM hyp code.
> >
> > Just following up on the KVM hyp code. At plumbers Mark and I took a
> > look at that case and were no longer able to reproduce.  Mark was able
> > to boot a Clang compiled kernel at EL2.  IIRC, the code in question
> > had been changed.  Note: Clang still probably does the wrong thing for
> > jump tables, so we should pursue this code model, I just don't think
> > this previous example is still the case.  Since it could always come
> > back, we should fix the issue on the compiler side though.
>
> We should absolutely document it as a requirement either way,
> and the putative gcc -mcmodel=kernel for arm64 should guarantee it.
>
> Is this a requirement for non-hyp code though?
>

No. Only code that may execute at a different offset than it was
linked at (build time or runtime) needs this, and then we still need
to apply on our checks on top to ensure that we don't rely on things
like statically aligned function pointers or other quantities that can
only be fixed up through absolute relocations.

> KASLR doesn't strictly need it, since we could keep the relocation info
> around and fix the kernel up at boot time (though obviously life is
> easier if we don't need to do this).
>

We already do that anyway. Every R_AARCH_ABS64 relocation results in a
dynamic R_AARCH64_RELATIVE relocation that is fixed up by the early
boot code. With the default small code model (on GCC) we don't get
R_AARCH64_AB64 relocations in .text but we have lots and lots of them
in .rodata/.data for statically initialized structs with function
pointers or other symbol references.

The problem is that each 8 byte quantity results in a 24-byte RELA
entry in the .rela section, and so absolute references should not be
emitted needlessly.

> Currently the lack of relocations seems to be an accidental side-effect
> of -mcmodel=small.  It's not clear to me whether we rely on this because
> it's advantageous, or whether we rely on it by accident because it
> happens to be the default.
>
> My question is: should there be just one kernel memory model, or do we
> want position-independent (for hyp-like stuff) and non-position-
> independent variants (for everything else)?
>

The current situation is that the non-PIC small code model already
gives us what we need, given that symbol references and branch target
references are always relative by default. Switching to -fpic, which
seems more appropriate semantically, gives us worse code since all
symbol references are now indirected via a GOT entry [i.e., a memory
access] to load an absolute address [which needs to be fixed up and
results in a 24-byte RELA entry]

This -fpic behavior is geared towards shared libraries, which have to
support symbol preemption for externally visible symbols, and try to
avoid dynamic relocations in .text so that .so mappings can share
clean pages between processes except for the GOT entries.

So if -mcmodel=small -fpic -fvisibility=hidden would given use the
right behavior, perhaps we wouldn't need this code model. But it
doesn't: -fvisibility is weaker than #pragma visibility, and so we
still end up with lots of GOT entries.

IOW, if we define a code model for the kernel, there is no point in
having different behavior between EFI stub/HYP code and other parts,
since the code that runs on the former is optimal for the latter
anyway.
