From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 4 Aug 2016 16:38:37 +0100
Subject: [PATCH 1/8] ARM: assembler: introduce adr_l, ldr_l and str_l
 macros
In-Reply-To: <CAKv+Gu85A12DYh3B9zAPOrNfozgv_Vw+RtSa90rLRn0jdhh5Mg@mail.gmail.com>
References: <20160803180934.GK1041@n2100.armlinux.org.uk>
 <CAKv+Gu9Wyiu38J=K00WKXSeFoDF2vS-3TJAvbz9Yo616GBXSwQ@mail.gmail.com>
 <20160804093851.GD7147@e103592.cambridge.arm.com>
 <CAKv+Gu8_5-VcBxnjLrJxgKcJfVFb785qvVzbB6kryqhhkCfQbA@mail.gmail.com>
 <20160804110832.GF7147@e103592.cambridge.arm.com>
 <CAKv+Gu_JVX3erz6N64EGfu38TDi6PHsQVGY=nkfu7kF-8Hq=6Q@mail.gmail.com>
 <20160804113018.GH7147@e103592.cambridge.arm.com>
 <CAKv+Gu_r4Rx=pvZWNaE1f-_QDiwyn62uS+MzPyNUqndE5jCS2Q@mail.gmail.com>
 <20160804133134.GJ7147@e103592.cambridge.arm.com>
 <CAKv+Gu85A12DYh3B9zAPOrNfozgv_Vw+RtSa90rLRn0jdhh5Mg@mail.gmail.com>
Message-ID: <20160804153837.GK7147@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 03:46:53PM +0200, Ard Biesheuvel wrote:
> On 4 August 2016 at 15:31, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Thu, Aug 04, 2016 at 01:34:03PM +0200, Ard Biesheuvel wrote:
> >> On 4 August 2016 at 13:30, Dave Martin <Dave.Martin@arm.com> wrote:
> >> > On Thu, Aug 04, 2016 at 01:10:55PM +0200, Ard Biesheuvel wrote:

[...]

> >> >> Yes, but how is LD going to perform the arithmetic involved in
> >
> > [...]
> >
> >> >> handling these relocations? That's is the more interesting part, and
> >> >> that is not implemented either in binutils < 2.18
> >> >
> >> > What arithmetic?
> >> >
> >>
> >> The arithmetic involved in populating the immediate fields of these
> >> instructions based on the actual offset between the Place and the
> >> Symbol in the final image.
> >
> > <digression>
> >
> > Just for interest...
> >
> >
> > For the linker this is just ordinary relocation processing -- there's
> > nothing unusual going on, except that neither GCC nor gas usually
> > emit these particular insn relocs automatically.
> >
> 
> There is no such thing as 'ordinary' relocation processing. Each

"Ordinary" in the sense that the linker should cope with any standard
reloc that it might receive, but...

> relocation type requires its own specific handling, and pre-2.18 LD
> simply does not come equipped with the routines to perform the
> calculations that the ARM/ELF spec defines for these particular
> relocation types. Whether GAS or any other assembler can produce them
> is irrelevant, my claim is that pre-2.18 LD does not know how to
> /consume/ them.

you seem to be right about this.

There are some obsolete R_ARM_ALU_PCREL_* relocs which presumably are
the OABI equivalents.

However, ld does no overflow checking for them, silently fails to
handle signed offsets, and also splat the target symbol address over
the affected instruction instead of writing the carefully modified
instruction there.  This has apparently been the behaviour ever since
those relocs were implemented in 2004 (2.16).

So I'm guessing nobody ever really used these :/

The .reloc pseudo-op didn't exist before 2.18 either.

Which just about wraps this one up.


Serves me right for attempting to guess the history ;)

Cheers
---Dave
