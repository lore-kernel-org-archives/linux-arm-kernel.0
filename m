From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Nov 2017 18:06:20 +0000
Subject: [PATCH 13/15] arm64: fix mrs_s/msr_s macros for clang LTO
In-Reply-To: <CAKwvOd=mG-X1DpUk+6hNXkoE-5hLGHe654ZKGEv=Dx1mnVJt5w@mail.gmail.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-18-samitolvanen@google.com>
 <CAKwvOd=mG-X1DpUk+6hNXkoE-5hLGHe654ZKGEv=Dx1mnVJt5w@mail.gmail.com>
Message-ID: <20171103180620.47yrko7apk52imri@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 10:53:08AM -0700, Nick Desaulniers wrote:
> These mrs_s and msr_s macros in particular were preventing us from
> linking arm64 with Clang's integrated assembler, regardless of LTO.
> Those macros ran into: https://bugs.llvm.org/show_bug.cgi?id=19749.
> So while I appreciate how clever they are, they prevent us from
> assembling with Clang so I would like to see them go.

They're necessary to work with some currently-supported toolchains
(which don't support the s*_*_c*_c*_* syntax), so they're not going to
go completely.

If you could suggest something that clang might prefer, which doesn't
adversely affect GCC, I'm all ears.

Thanks,
Mark.

> 
> On Fri, Nov 3, 2017 at 10:12 AM, Sami Tolvanen <samitolvanen@google.com> wrote:
> > Clang's integrated assembler does not allow assembly macros defined
> > in one inline asm block using the .macro directive to be used across
> > separate asm blocks. LLVM developers consider this a feature and not a
> > bug, recommending code refactoring:
> >
> >   https://bugs.llvm.org/show_bug.cgi?id=19749
> >
> > As binutils doesn't allow macros to be redefined, this change adds C
> > preprocessor macros that define the assembly macros globally for binutils
> > and locally for clang's integrated assembler.
> >
> > Suggested-by: Greg Hackmann <ghackmann@google.com>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_hyp.h |  2 ++
> >  arch/arm64/include/asm/sysreg.h  | 71 ++++++++++++++++++++++++++++++----------
> >  2 files changed, 56 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> > index 4572a9b560fa..6840704ea894 100644
> > --- a/arch/arm64/include/asm/kvm_hyp.h
> > +++ b/arch/arm64/include/asm/kvm_hyp.h
> > @@ -29,6 +29,7 @@
> >         ({                                                              \
> >                 u64 reg;                                                \
> >                 asm volatile(ALTERNATIVE("mrs %0, " __stringify(r##nvh),\
> > +                                        DEFINE_MRS_S                   \
> >                                          "mrs_s %0, " __stringify(r##vh),\
> >                                          ARM64_HAS_VIRT_HOST_EXTN)      \
> >                              : "=r" (reg));                             \
> > @@ -39,6 +40,7 @@
> >         do {                                                            \
> >                 u64 __val = (u64)(v);                                   \
> >                 asm volatile(ALTERNATIVE("msr " __stringify(r##nvh) ", %x0",\
> > +                                        DEFINE_MSR_S                   \
> >                                          "msr_s " __stringify(r##vh) ", %x0",\
> >                                          ARM64_HAS_VIRT_HOST_EXTN)      \
> >                                          : : "rZ" (__val));             \
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index f707fed5886f..1588ac3f3690 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -463,21 +463,58 @@
> >
> >  #include <linux/types.h>
> >
> > -asm(
> > -"      .irp    num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
> > -"      .equ    .L__reg_num_x\\num, \\num\n"
> > -"      .endr\n"
> > +#define ___MRS_MSR_S_REGNUM                                    \
> > +"      .irp    num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n" \
> > +"      .equ    .L__reg_num_x\\num, \\num\n"                    \
> > +"      .endr\n"                                                \
> >  "      .equ    .L__reg_num_xzr, 31\n"
> > -"\n"
> > -"      .macro  mrs_s, rt, sreg\n"
> > -       __emit_inst(0xd5200000|(\\sreg)|(.L__reg_num_\\rt))
> > +
> > +#define ___MRS_S                                               \
> > +"      .macro  mrs_s, rt, sreg\n"                              \
> > +       __emit_inst(0xd5200000|(\\sreg)|(.L__reg_num_\\rt))     \
> >  "      .endm\n"
> > -"\n"
> > -"      .macro  msr_s, sreg, rt\n"
> > -       __emit_inst(0xd5000000|(\\sreg)|(.L__reg_num_\\rt))
> > +
> > +#define ___MSR_S                                               \
> > +"      .macro  msr_s, sreg, rt\n"                              \
> > +       __emit_inst(0xd5000000|(\\sreg)|(.L__reg_num_\\rt))     \
> >  "      .endm\n"
> > +
> > +/*
> > + * llvm-as doesn't allow macros defined in an asm block to be used in other
> > + * asm blocks, which means we cannot define them globally.
> > + */
> > +#if !defined(CONFIG_CLANG_LTO)
> > +asm(
> > +       ___MRS_MSR_S_REGNUM
> > +       ___MRS_S
> > +       ___MSR_S
> >  );
> >
> > +#undef  ___MRS_MSR_S_REGNUM
> > +#define ___MRS_MSR_S_REGNUM
> > +#undef  ___MRS_S
> > +#define ___MRS_S
> > +#undef  ___MSR_S
> > +#define ___MSR_S
> > +#endif
> > +
> > +#define DEFINE_MRS_S           \
> > +       ___MRS_MSR_S_REGNUM     \
> > +       ___MRS_S
> > +
> > +#define DEFINE_MSR_S           \
> > +       ___MRS_MSR_S_REGNUM     \
> > +       ___MSR_S
> > +
> > +
> > +#define __mrs_s(r, v)                                          \
> > +       DEFINE_MRS_S                                            \
> > +"      mrs_s %0, " __stringify(r) : "=r" (v)
> > +
> > +#define __msr_s(r, v)                                          \
> > +       DEFINE_MSR_S                                            \
> > +"      msr_s " __stringify(r) ", %0" : : "r" (v)
> > +
> >  /*
> >   * Unlike read_cpuid, calls to read_sysreg are never expected to be
> >   * optimized away or replaced with synthetic values.
> > @@ -502,15 +539,15 @@ asm(
> >   * For registers without architectural names, or simply unsupported by
> >   * GAS.
> >   */
> > -#define read_sysreg_s(r) ({                                            \
> > -       u64 __val;                                                      \
> > -       asm volatile("mrs_s %0, " __stringify(r) : "=r" (__val));       \
> > -       __val;                                                          \
> > +#define read_sysreg_s(r) ({                                    \
> > +       u64 __val;                                              \
> > +       asm volatile(__mrs_s(r, __val));                        \
> > +       __val;                                                  \
> >  })
> >
> > -#define write_sysreg_s(v, r) do {                                      \
> > -       u64 __val = (u64)(v);                                           \
> > -       asm volatile("msr_s " __stringify(r) ", %x0" : : "rZ" (__val)); \
> > +#define write_sysreg_s(v, r) do {                              \
> > +       u64 __val = (u64)(v);                                   \
> > +       asm volatile(__msr_s(r, __val));                        \
> >  } while (0)
> >
> >  static inline void config_sctlr_el1(u32 clear, u32 set)
> > --
> > 2.15.0.403.gc27cc4dac6-goog
> >
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
