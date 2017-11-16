From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Nov 2017 11:44:06 +0000
Subject: [PATCH v2 08/18] arm64: don't disable ADR_PREL_PG_HI21* with
 ARM64_ERRATUM_843419
In-Reply-To: <CAKv+Gu-wYwBMV7tdb+Kax_cyPsmAB2R2ZVwJuNi9qM0kaYAs=Q@mail.gmail.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-9-samitolvanen@google.com>
 <CAKv+Gu-wYwBMV7tdb+Kax_cyPsmAB2R2ZVwJuNi9qM0kaYAs=Q@mail.gmail.com>
Message-ID: <20171116114406.GB9361@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 10:29:12PM +0000, Ard Biesheuvel wrote:
> On 15 November 2017 at 21:34, Sami Tolvanen <samitolvanen@google.com> wrote:
> > CONFIG_LTO_CLANG depends on GNU gold, which can generate ADR_PREL_PG_HI21*
> > relocations even with --fix-cortex-a53-843419.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/arm64/kernel/module.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> > index f469e0435903..fec9a578f122 100644
> > --- a/arch/arm64/kernel/module.c
> > +++ b/arch/arm64/kernel/module.c
> > @@ -336,14 +336,12 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
> >                         ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 0, 21,
> >                                              AARCH64_INSN_IMM_ADR);
> >                         break;
> > -#ifndef CONFIG_ARM64_ERRATUM_843419
> >                 case R_AARCH64_ADR_PREL_PG_HI21_NC:
> >                         overflow_check = false;
> >                 case R_AARCH64_ADR_PREL_PG_HI21:
> >                         ovf = reloc_insn_imm(RELOC_OP_PAGE, loc, val, 12, 21,
> >                                              AARCH64_INSN_IMM_ADR);
> >                         break;
> > -#endif
> >                 case R_AARCH64_ADD_ABS_LO12_NC:
> >                 case R_AARCH64_LDST8_ABS_LO12_NC:
> >                         overflow_check = false;
> > --
> > 2.15.0.448.gf294e3d99a-goog
> >
> 
> I think this change is reasonable in itself, but i do wonder how we
> can ensure that the adrp instructions that GNU gold does generate are
> not affected by the erratum, given that modules are partially linked
> object files, not shared libraries.

Right, and this would also mean that we silently load vulnerable modules
that are linked with either LD that doesn't support --fix-cortex-a53-843419
or simply wasn't passed.

Will
