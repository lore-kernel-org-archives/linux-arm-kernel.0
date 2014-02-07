From: vinayakm.list@gmail.com (vinayak menon)
Date: Fri, 7 Feb 2014 15:30:13 +0530
Subject: [PATCH] ARM: enable IRQs in user undefined instruction vector
In-Reply-To: <20140206205447.GX26684@n2100.arm.linux.org.uk>
References: <1391545146-8320-1-git-send-email-kevin@bracey.fi>
 <20140206112039.GA31054@arm.com> <52F3D024.5020804@bracey.fi>
 <20140206205447.GX26684@n2100.arm.linux.org.uk>
Message-ID: <CAOaiJ-kY_VwsY0iHSMVQZx=zvP5is1LRkir5_zP6Jnttv+O1VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can we do something similar to what pagefault_disable does ? So that
we jump directly to fixup, after the in_atomic() check in
do_page_fault.

-------------------- >8 ----------------------------------------
Disable pagefault (preemption) before executing ldrt/ldrht
instructions in __und_usr, to tell the page fault
handler that we are in atomic context and need to
jump directly to the fixup.

In the fixup, correct the PC to re-execute the
faulted instruction (from Kevein Bracey's patch).

Signed-off-by: Vinayak Menon <vinayakm.list@gmail.com>
Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 arch/arm/include/asm/assembler.h |   26 ++++++++++++++++++++++++++
 arch/arm/kernel/entry-armv.S     |    8 ++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 5c22851..cba5f2c 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -23,6 +23,7 @@
 #include <asm/ptrace.h>
 #include <asm/domain.h>
 #include <asm/opcodes-virt.h>
+#include <asm/asm-offsets.h>

 #define IOMEM(x)       (x)

@@ -85,6 +86,31 @@
 #endif

 /*
+ * Enable/Disable page fault
+ */
+#ifdef CONFIG_PREEMPT_COUNT
+       .macro  pgflt_disable, ti, tmp
+       get_thread_info \ti
+       ldr     \tmp, [\ti, #TI_PREEMPT]
+       add     \tmp, \tmp, #1
+       str     \tmp, [\ti, #TI_PREEMPT]
+       .endm
+
+       .macro  pgflt_enable, ti, tmp
+       get_thread_info \ti
+       ldr     \tmp, [\ti, #TI_PREEMPT]
+       sub     \tmp, \tmp, #1
+       str     \tmp, [\ti, #TI_PREEMPT]
+       .endm
+#else
+       .macro  pgflt_disable, ti, tmp
+       .endm
+
+       .macro  pgflt_enable, ti, tmp
+       .endm
+#endif
+
+/*
  * Enable and disable interrupts
  */
 #if __LINUX_ARM_ARCH__ >= 6
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 1879e8d..5ed57d8 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -416,7 +416,9 @@ __und_usr:
        tst     r3, #PSR_T_BIT                  @ Thumb mode?
        bne     __und_usr_thumb
        sub     r4, r2, #4                      @ ARM instr at LR - 4
+       pgflt_disable r10, r3
 1:     ldrt    r0, [r4]
+       pgflt_enable r10, r3
  ARM_BE8(rev   r0, r0)                         @ little endian instruction

        @ r0 = 32-bit ARM instruction which caused the exception
@@ -450,11 +452,15 @@ __und_usr_thumb:
  */
        .arch   armv6t2
 #endif
+       pgflt_disable r10, r3
 2:     ldrht   r5, [r4]
+       pgflt_enable r10, r3
 ARM_BE8(rev16  r5, r5)                         @ little endian instruction
        cmp     r5, #0xe800                     @ 32bit instruction if xx != 0
        blo     __und_usr_fault_16              @ 16bit undefined instruction
+       pgflt_disable r10, r3
 3:     ldrht   r0, [r2]
+       pgflt_enable r10, r3
 ARM_BE8(rev16  r0, r0)                         @ little endian instruction
        add     r2, r2, #2                      @ r2 is PC + 2, make it PC + 4
        str     r2, [sp, #S_PC]                 @ it's a 2x16bit instr, update
@@ -484,6 +490,8 @@ ENDPROC(__und_usr)
  */
        .pushsection .fixup, "ax"
        .align  2
+       str     r4, [sp, #S_PC]
+       pgflt_enable r10, r3
 4:     mov     pc, r9
        .popsection
        .pushsection __ex_table,"a"
--

On Fri, Feb 7, 2014 at 2:24 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Feb 06, 2014 at 08:10:44PM +0200, Kevin Bracey wrote:
>> The VFP code did take pains to increment the pre-emption count before
>> enabling interrupts, but it's not obvious whether it requires no
>> pre-emption between the bounce and handler, or just no pre-emption
>> during the handler.
>
> Just take a moment to think about this.
>
> - Userspace raises an undefined instruction exception, running on CPU 0.
> - The kernel starts to handle the exception by saving the ARM state.
> - Enables interrupts.
> - Context switch occurs.
> - VFP state is saved and the VFP is disabled.
>
> Now, on CPU1...
> - Context switch occurs to the above thread (due to thread migration).
> - VFP will be in a disabled state.
> - We read FPEXC, find that the VFP is disabled
> - Load saved state into the VFP
> - Check for an exception recorded in the VFP state, and handle it.
>
> So, that seems to work.  I suspect most things will work just fine in
> this case.  What /can't/ be allowed to happen is we can't start
> reading state from the hardware to handle the exception (or even be
> mid-restoring the state) and be preempted - if we do, we'll end up
> in a right mess because we'll end up with inconsistent state.
>
>> What about the iwmmxt and the crunchbits? They are only lazy-enable
>> routines, to activate an inactive coprocessor. Which I think makes them
>> safe. If we schedule before reaching the handler, when this context is
>> returned to, the coprocessor must still be disabled in our context - the
>> handler can proceed to enable it. And there can't be any other context
>> state to worry about, assuming the lazy enable scheme works.
>
> Again, the restore needs to happen with preemption disabled so that
> you don't end up with the state half-restored, and then when you
> resume the thread, you restore the other half.
>
> This is actually the case I'm more worried about - whether all the
> various handlers are safe being entered with preemption enabled.
> They weren't written for it so the current answer is that they
> aren't safe.
>
>> I share Alexey's Ignatov's concern that your patch ends up running the
>> support code with interrupts either on or off depending on whether you
>> came from user or supervisor mode, which feels a little odd. But then,
>> always enabling interrupts like the current code does, when they might
>> have been off in the SVC mode context, also seems wrong.
>
> That is indeed wrong, but then we /used/ to have the requirement that
> the kernel will _never_ execute VFP instructions.  That's changed
> recently since we now permit neon instructions to be executed.
>
> However, the requirements to execute these instructions is very strict:
> preemption disabled, it must not fault.  If you do fault, none of the
> standard handlers get invoked, instead you get a critical kernel message.
> So, if it does happen, then it's quite a bug already.
>
> The only case where the kernel intentionally provokes such a fault
> (which won't even reach the normal VFP handler) is when testing for the
> presence of VFP and there is no hardware fitted.
>
> --
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
