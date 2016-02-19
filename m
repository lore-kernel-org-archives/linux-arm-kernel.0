From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 19 Feb 2016 09:34:42 +0000
Subject: [PATCH 3/3] [RESEND] ARM: kprobes: use "I" constraint for
 inline assembly offsets
In-Reply-To: <56C61486.9070803@arm.com>
References: <1455815113-2562966-1-git-send-email-arnd@arndb.de>
 <1455815113-2562966-4-git-send-email-arnd@arndb.de>
 <1455819135.2958.6.camel@linaro.org> <56C61486.9070803@arm.com>
Message-ID: <1455874482.2864.29.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-02-18 at 18:59 +0000, Robin Murphy wrote:
> On 18/02/16 18:12, Jon Medhurst (Tixy) wrote:
> > On Thu, 2016-02-18 at 18:05 +0100, Arnd Bergmann wrote:
> >> build-testing with clang showed that the "J" constraint does not take
> >> positive arguments on clang when building in for Thumb-2:
> >>
> >> core.c:540:3: error: invalid operand for inline asm constraint 'J'
> >>
> >> This has been reported as llvm bug https://llvm.org/bugs/show_bug.cgi?id=26061
> >>
> >> However, looking at the source code in depth, I found that the
> >> kernel is also wrong, and it should not use "J" at all, but should
> >> use "I" to pass an immediate argument to the inline assembly when that
> >> is used as an offset to an 'ldr' instruction rather than the 'sub'
> >> argument.
> >
> > This patch doesn't seem correct to me.
> >
> > The ARM ARM says the immediate offset to an ARM ldr instructions is "any
> > value in the range 0-4095" and offsets may be added or subtracted,
> > leading to values from ?4095 to 4095".
> >
> > And GCC machine constraints [1] says
> >
> > I
> >      Integer that is valid as an immediate operand in a data processing
> >      instruction. That is, an integer in the range 0 to 255 rotated by a
> >      multiple of 2
> > J
> >      Integer in the range ?4095 to 4095
> >
> > So the current use of 'J' seems correct to me.
> 
> Hmm, Arnd reports the failure when building for Thumb-2, and the code 
> under #ifdef CONFIG_THUMB2_KERNEL contains an ldrd, which takes a 
> different immediate of the form imm8 * 4. Maybe it's just operand %5 
> which needs fixing, although I don't see that a suitable constraint for 
> that actually exists...

Well, under Thumb-2 plain LDR is also different, the offset is up to
+/-255, except for pre-indexed without writeback mode (what the code
uses) which goes up to +4095. I saw this yesterday but also that there
aren't asm constraints for that.

Actually, there is constraint 'Uq' which is "A memory reference suitable
for the ARMv4 ldrsb instruction" and that is a value +/- 255.

In practice, for the code in question, which is getting offsets into
struct pt_regs, either 'I', 'J' or 'Uq' would work. 'Uq' is the one that
expresses the strictest restrictions, that if met, will work with all
assembler instructions used, but as it's documented as being for the
"ARMv4 ldrsb instruction", it would seem a bit confusing to use that to
me.

-- 
Tixy

> 
> Robin.
> 
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html#Machine-Constraints
> >
> >
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>   arch/arm/probes/kprobes/core.c | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> >> index a4ec240ee7ba..4b34b40ca917 100644
> >> --- a/arch/arm/probes/kprobes/core.c
> >> +++ b/arch/arm/probes/kprobes/core.c
> >> @@ -570,10 +570,10 @@ void __kprobes jprobe_return(void)
> >>   		:
> >>   		: "r" (kcb->jprobe_saved_regs.ARM_sp),
> >>   		  "I" (sizeof(struct pt_regs) * 2),
> >> -		  "J" (offsetof(struct pt_regs, ARM_sp)),
> >> -		  "J" (offsetof(struct pt_regs, ARM_pc)),
> >> -		  "J" (offsetof(struct pt_regs, ARM_cpsr)),
> >> -		  "J" (offsetof(struct pt_regs, ARM_lr))
> >> +		  "I" (offsetof(struct pt_regs, ARM_sp)),
> >> +		  "I" (offsetof(struct pt_regs, ARM_pc)),
> >> +		  "I" (offsetof(struct pt_regs, ARM_cpsr)),
> >> +		  "I" (offsetof(struct pt_regs, ARM_lr))
> >>   		: "memory", "cc");
> >>   }
> >>
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
