From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 4 Mar 2015 05:20:45 +0100
Subject: [PATCH v2 0/5] split ET_DYN ASLR from mmap ASLR
In-Reply-To: <CAGXu5j+qJLeRx2xx=890OxHp8kjd=ws8zg3_JYPNJd_6p2xoYQ@mail.gmail.com>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <20150303073132.GA30602@gmail.com>
 <CAGXu5j+qJLeRx2xx=890OxHp8kjd=ws8zg3_JYPNJd_6p2xoYQ@mail.gmail.com>
Message-ID: <20150304042044.GA25354@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Kees Cook <keescook@chromium.org> wrote:

> On Mon, Mar 2, 2015 at 11:31 PM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Kees Cook <keescook@chromium.org> wrote:
> >
> >> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
> >> ASLR from mmap ASLR, as already done on s390. The architectures
> >> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
> >> and x86), have their various forms of arch_mmap_rnd() made available
> >> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
> >> arch_randomize_brk() is collapsed as well.
> >>
> >> This is an alternative to the solutions in:
> >> https://lkml.org/lkml/2015/2/23/442
> >
> > Looks good so far:
> >
> > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> >
> > While reviewing this series I also noticed that the following code
> > could be factored out from architecture mmap code as well:
> >
> >   - arch_pick_mmap_layout() uses very similar patterns across the
> >     platforms, with only few variations. Many architectures use
> >     the same duplicated mmap_is_legacy() helper as well. There's
> >     usually just trivial differences between mmap_legacy_base()
> >     approaches as well.
> 
> I was nervous to start refactoring this code, but it's true: most of 
> it is the same.

Well, it still needs to be done if we want to add new randomization 
features: code fractured over multiple architectures is a receipe for 
bugs, as this series demonstrates. So it first has to be made more 
maintainable.

> >   - arch_mmap_rnd(): the PF_RANDOMIZE checks are needlessly
> >     exposed to the arch routine - the arch routine should only
> >     concentrate on arch details, not generic flags like
> >     PF_RANDOMIZE.
> 
> Yeah, excellent point. I will send a follow-up patch to move this 
> into binfmt_elf instead. I'd like to avoid removing it in any of the 
> other patches since each was attempting a single step in the 
> refactoring.

Finegrained patches are ideal!

> > In theory the mmap layout could be fully parametrized as well: 
> > i.e. no callback functions to architectures by default at all: 
> > just declarations of bits of randomization desired (or, available 
> > address space bits), and perhaps an arch helper to allow 32-bit 
> > vs. 64-bit address space distinctions.
> 
> Yeah, I was considering that too, since each architecture has a 
> nearly identical arch_mmap_rnd() at this point. Only the size of the 
> entropy was changing.
>
> > 'Weird' architectures could provide special routines, but only by 
> > overriding the default behavior, which should be generic, safe and 
> > robust.
> 
> Yeah, quite true. Should entropy size be a #define like 
> ELF_ET_DYN_BASE? Something like ASLR_MMAP_ENTROPY and 
> ASLR_MMAP_ENTROPY_32? [...]

That would work I suspect.

> [...] Is there a common function for determining a compat task? That 
> seemed to be per-arch too. Maybe arch_mmap_entropy()?

Compat flags are a bit of a mess, and since they often tie into arch 
low level assembly code, they are hard to untangle. So maybe as an 
intermediate step add an is_compat() generic method, and make that 
obvious and self-defined function a per arch thing?

But I'm just handwaving here - I suspect it has to be tried to see all 
the complications and to determine whether that's the best structure 
and whether it's a win ... Only one thing is certain: the current code 
is not compact and reviewable enough, and VM bits hiding in 
arch/*/mm/mmap.c tends to reduce net attention paid to these details.

Thanks,

	Ingo
