From: Dave.Martin@arm.com (Dave P Martin)
Date: Tue, 21 Apr 2015 12:10:43 +0100
Subject: your mail
In-Reply-To: <CAKv+Gu-3iM2+TvAgfV91FzfgAQuZhr=beeJ8RWmmGjTChbUrtQ@mail.gmail.com>
References: <CAKv+Gu9u73+YKn+aR1vk+1eNF_voC71THWRQS96jyAt4HB3BQw@mail.gmail.com>
 <20150421104634.GA3996@e103592.cambridge.arm.com>
 <CAKv+Gu-3iM2+TvAgfV91FzfgAQuZhr=beeJ8RWmmGjTChbUrtQ@mail.gmail.com>
Message-ID: <20150421111042.GB3996@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 11:50:02AM +0100, Ard Biesheuvel wrote:
> On 21 April 2015 at 12:46, Dave P Martin <Dave.Martin@arm.com> wrote:
> > On Tue, Apr 21, 2015 at 11:18:08AM +0100, Ard Biesheuvel wrote:
> >> On 21 April 2015 at 12:13, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Tue, Apr 21, 2015 at 12:08:51PM +0200, Ard Biesheuvel wrote:
> >> >> This updates the PROCINFO offset-to-setup-function fields of the
> >> >> Thumb2 capable CPU definitions to include the Thumb bit when building
> >> >> a Thumb2 kernel. This ensures that these function are always called
> >> >> in the correct mode.
> >> >
> >> > I don't think this is necessary, in fact, I think this is positively
> >> > regression causing.
> >> >
> >> > The symbol 'initfunc' is known to the assembler to be a thumb symbol.
> >> > As we have seen already from the kernel dumps from the V7M kernel, when
> >> > it calculates initfunc - name in a T2 kernel, the resulting value is an
> >> > _odd_ number.
> >> >
> >>
> >> OK, so BSYM() uses '+ 1' rather than ' | 1'? I wasn't expecting that, sorry.
> >
> > '| 1' is more logical, but can't be resolved at link time because
> > there's no relocation for this operation.  Hence '+ 1'.  This matters
> > for local cross-section references that can't be resolved at assembly
> > time.
> >
> 
> OK, that makes sense. But it does appear that the local cross-section
> references are working just fine, i.e., references from other sections
> in the same .o have the thumb bit set correctly even without BSYM()

For branch targets, the set of situations where BSYM must be used and
the set of situations where it must not be used are mutually exclusive:

 * If the assembler resolves the address and the address will be used as a
   branch target, BSYM() must be used.  This applies to non-cross-section
   references within in single object only.

 * If the linker resolves the address, BSYM() must not be used and the
   target label must be annotated with ENDPROC().  This applies to
   all cross-section or cross-object references.

For any address that won't be used as a branch target, BSYM() must not
be used.

Cross-section non-cross-object references where the target is missing
ENDPROC() and BSYM _is_ used will also work, but this should be avoided
-- it's an abuse really.


The reason for these rules is that the assembler doesn't do any Thumb
bit handling when taking the address of a local symbol, irrespective
of the symbol's type.  This can result in a screwup unless the assembler
can't resolve the address and must leave it as a relocation for the
linker to process, or if the correct annotation for the linker to do
the right fixup is missing.


I don't know the history of why this inconsistency exists between the
assembler and linker behaviour, but changing it would likely break
more stuff than it fixes now.

Maybe it would be a good idea to add a comment in asm/unified.h
explaining this, assuming (hopefully) that my explanation was right...

[...]

Cheers
---Dave
