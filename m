From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 31 Jul 2015 15:15:41 +0100
Subject: [PATCH v7 5/7] arm64: Add trampoline code for kretprobes
In-Reply-To: <55918B68.7030900@redhat.com>
References: <1434395229-6654-1-git-send-email-dave.long@linaro.org>
 <1434395229-6654-6-git-send-email-dave.long@linaro.org>
 <CAPvkgC1hSRrzp_pR98qwnKvBspg1WizCm_Pzt0c1=dPWci1pjg@mail.gmail.com>
 <55918B68.7030900@redhat.com>
Message-ID: <20150731141540.GQ407@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 02:16:08PM -0400, William Cohen wrote:
> On 06/29/2015 01:25 PM, Steve Capper wrote:
> > On 15 June 2015 at 20:07, David Long <dave.long@linaro.org> wrote:
> >> diff --git a/arch/arm64/kernel/kprobes-arm64.h b/arch/arm64/kernel/kprobes-arm64.h
> >> index ff8a55f..bdcfa62 100644
> >> --- a/arch/arm64/kernel/kprobes-arm64.h
> >> +++ b/arch/arm64/kernel/kprobes-arm64.h
> >> @@ -27,4 +27,45 @@ extern kprobes_pstate_check_t * const kprobe_condition_checks[16];
> >>  enum kprobe_insn __kprobes
> >>  arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi);
> >>
> >> +#define SAVE_REGS_STRING\
> >> +       "       stp x0, x1, [sp, #16 * 0]\n"    \
> >> +       "       stp x2, x3, [sp, #16 * 1]\n"    \
> >> +       "       stp x4, x5, [sp, #16 * 2]\n"    \
> >> +       "       stp x6, x7, [sp, #16 * 3]\n"    \
> >> +       "       stp x8, x9, [sp, #16 * 4]\n"    \
> >> +       "       stp x10, x11, [sp, #16 * 5]\n"  \
> >> +       "       stp x12, x13, [sp, #16 * 6]\n"  \
> >> +       "       stp x14, x15, [sp, #16 * 7]\n"  \
> >> +       "       stp x16, x17, [sp, #16 * 8]\n"  \
> >> +       "       stp x18, x19, [sp, #16 * 9]\n"  \
> >> +       "       stp x20, x21, [sp, #16 * 10]\n" \
> >> +       "       stp x22, x23, [sp, #16 * 11]\n" \
> >> +       "       stp x24, x25, [sp, #16 * 12]\n" \
> >> +       "       stp x26, x27, [sp, #16 * 13]\n" \
> >> +       "       stp x28, x29, [sp, #16 * 14]\n" \
> >> +       "       str x30,   [sp, #16 * 15]\n"    \
> >> +       "       mrs x0, nzcv\n"                 \
> >> +       "       str x0, [sp, #8 * 33]\n"
> >> +
> >> +
> >> +#define RESTORE_REGS_STRING\
> >> +       "       ldr x0, [sp, #8 * 33]\n"        \
> >> +       "       msr nzcv, x0\n"                 \
> >> +       "       ldp x0, x1, [sp, #16 * 0]\n"    \
> >> +       "       ldp x2, x3, [sp, #16 * 1]\n"    \
> >> +       "       ldp x4, x5, [sp, #16 * 2]\n"    \
> >> +       "       ldp x6, x7, [sp, #16 * 3]\n"    \
> >> +       "       ldp x8, x9, [sp, #16 * 4]\n"    \
> >> +       "       ldp x10, x11, [sp, #16 * 5]\n"  \
> >> +       "       ldp x12, x13, [sp, #16 * 6]\n"  \
> >> +       "       ldp x14, x15, [sp, #16 * 7]\n"  \
> >> +       "       ldp x16, x17, [sp, #16 * 8]\n"  \
> >> +       "       ldp x18, x19, [sp, #16 * 9]\n"  \
> >> +       "       ldp x20, x21, [sp, #16 * 10]\n" \
> >> +       "       ldp x22, x23, [sp, #16 * 11]\n" \
> >> +       "       ldp x24, x25, [sp, #16 * 12]\n" \
> >> +       "       ldp x26, x27, [sp, #16 * 13]\n" \
> >> +       "       ldp x28, x29, [sp, #16 * 14]\n" \
> >> +       "       ldr x30,   [sp, #16 * 15]\n"
> > 
> > Do we need to restore x19..x28 as they are callee-saved?
> 
> The goal was to make the trampoline not affect the values in any of
> the registers, so if the calling conventions ever change the code will
> still work. Figured it was safer and clearer just to save everything
> rather than assuming that the compiler's code generated for
> trampoline_probe_handler is going to save certain registers.

If the PCS ever changes, we have other issues like cpu_switch_to(). So
it's safe to assume that x19..x29 are callee-saved.

-- 
Catalin
