From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 20 Nov 2018 14:37:12 +0100
Subject: compiler code model for the kernel
In-Reply-To: <979349c7-e6f1-9a2a-f38a-9631b4a35fce@arm.com>
References: <CAKv+Gu8LchCWB-b+cDmStwrNf5qDs6ZMQ4drv2HMk-8OyjbzNQ@mail.gmail.com>
 <979349c7-e6f1-9a2a-f38a-9631b4a35fce@arm.com>
Message-ID: <CAKv+Gu9yy5Vm9Rrp_zgkkghca7jchCFBG9yxAOjoFZuo=2tPAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Nov 2018 at 14:25, Ramana Radhakrishnan
<Ramana.Radhakrishnan@arm.com> wrote:
>
> Hi Ard,
>
> CC'ing Richard E and James Greenhalgh as well on this thread.
>
>
> On 19/11/2018 17:41, Ard Biesheuvel wrote:
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
>
> I would prefer this is -mcmodel=kernel-small so that it's explicit that
> this is like the small memory model.
>

I don't have a strong preference regarding the name, but I will point
out that other arches have a 'kernel' code model already, also on
Clang (as Peter reports)

> On AArch64 this is what GCC calls the small absolute model in code i.e.
> really all global data accesses from code are really PC relative and
> thus position independent. The problem is data initializers but I
> understand you are able to deal with it by producing relative
> relocations by using hidden attributes.
>
> Thus I wonder if we should go as far as implying -fvisibility=hidden in
> the compiler for all global data. Is that what you do today ?
>

Fortunately, we don't have to do this currently since the non-PIC
small model already gives us what we need.

-fivisibility=hidden isn't quite sufficient though when building with
-fpic, only the visibility pragma affects extern declarations as well
as definition.

> In-fact the patch stack I am carrying for the sp_el0 based canary toyed
> with the idea of adding such a flag and only putting out the symbol name
> for the offset as I really dont' see anyone but the kernel using that
> kind of code generation.
>


> > - symbol references are emitted as ADRP/ADD pairs
>
> Ok.
>
> > -  no absolute references in generated code like jump tables etc (like
> > -fpic/-fpie) [*]
>
> Ok. -fPIC/pie with default hidden visibility just achieves the same
> thing with -mcmodel=small ?
>

Yes, but only if you use the pragma

> > - no shared library semantics (no GOT indirections to support symbol
> > preemption, or to reduce the CoW footprint and/or avoid text
> > relocations)
>
> Ok.
>
> > - resulting objects can be linked in -pie mode by ld.bfd
>
> Ok, but never producing a GOT. Further you probably want to have checks
> on the final binary once a build is completed to ensure this ?
>

In general, having no GOT whatsoever is not a hard requirement. It is
a hard requirement for /some/ pieces of the code (EFI stub, KVM hyp
code) that we have no absolute references whatsoever, but in general,
we simply fix up the R_AARCH64_RELATIVE relocations wherever we
encounter them. Having all symbol references go through the GOT just
bloats the binary needlessly given that we don't require the shared
library semantics.


> >
> > Another thing that came up is that we currently rely on the stack
> > pointer never to assume a value that is not 16-byte aligned, even
> > transiently.
>
> I think we've discussed that to great detail as far as GCC is concerned.
>   I would prefer it is documented in the kernel documentation as a
> requirement for this standard.
>
>
> TL;DR
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/611445.html
>
>
> regards
> Ramana
>
> >
> > Other things I've missed?
> >
> > [*] This is only strictly required in parts of the code that may
> > execute at a different offset than the linked offset, even after
> > processing dynamic relocations at boot time (e.g., KVM hyp code
> > running in a different exception level) but avoiding those altogether
> > is reasonable. Note that GCC does the right thing for us here already,
> > but Clang current;y needs -fno-jump-tables to build the KVM hyp code.
> >
>
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
