From: cat.schulze@alice-dsl.net (Christopher Alexander Tobias Schulze)
Date: Sat, 21 Mar 2015 17:40:00 +0100
Subject: RFC: [PATCH] arm: vfp: vfp_save_state() crashes on VFP11 when
 FPEXC.EX bit is set
Message-ID: <201503211740.01106.cat.schulze@alice-dsl.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This mail is a request for comment for a patch I used to fix a kernel
crash on Raspberry Pi 1 machines using a VFP11 FPU. As I do not have
too intimate knowledge of ARM VFP (and in particular all VFP variants
out there), I want to ask for your feedback, remarks and possibly
corrections, to avoid potential incompatibilities with other VFP
implementations, or any subtile flaws in my patch which might only
trigger under circumstances not covered by my tests.

Patch follows below - remove this header when committing.

-----------------------------------------------------------------------

The ARM1176JZF-S CPU used on Raspberry Pi generation 1 boards includes
a VFP11 floating point unit. Several users have reported kernel crashes
("BUG: unsupported FP instruction in kernel mode") under certain
circumstances, which are fixed by this patch.

A precondition to see the crashes is that floating point exception
traps are enabled. In this case, the VFP11 might determine that a FPU
operation needs to trap at a point in time when it is not possible to
signal this to the ARM11 core any more. The VFP11 will then set the
FPEXC.EX bit and store the trapped opcode in FPINST. (In some cases,
a second opcode might have been accepted by the VFP11 before the
exception was detected and could be reported to the ARM11 - in this
case, the VFP11 also sets FPEXC.FP2V and stores the second opcode in
FPINST2.)

If FPEXC.EX is set, the VFP11 will "bounce" the next FPU opcode issued
by the ARM11 CPU, which will be seen by the ARM11 as an undefined opcode
trap. The VFP support code examines the FPEXC.EX and FPEXC.FP2V bits
to decide what actions to take, i.e., whether to emulate the opcodes
found in FPINST and FPINST2, and whether to retry the bounced instruction.

If a user space application has left the VFP11 in this "pending trap"
state, the next FPU opcode issued to the VFP11 might actually be the
VSTMIA operation vfp_save_state() uses to store the FPU registers
to memory (in our test cases, when building the signal stack frame).
In this case, the kernel crashes as described above.

This patch fixes the problem by making sure that vfp_save_state() is
always entered with FPEXC.EX cleared. (The current value of FPEXC has
already been saved, so this does not corrupt the context. Clearing
FPEXC.EX has no effects on FPINST or FPINST2. Also note that many
callers already modify FPEXC by setting FPEXC.EN before invoking
vfp_save_state().)

This patch also addresses a second problem related to FPEXC.EX: After
returning from signal handling, the kernel reloads the VFP context
from the user mode stack. However, the current code explicitly clears
both FPEXC.EX and FPEXC.FP2V during reload. As VFP11 requires these
bits to be preserved, this patch disables clearing them for VFP
implementations belonging to architecture 1. There should be no
negative side effects: the user can set both bits by executing FPU
opcodes anyway, and while user code may now place arbitrary values
into FPINST and FPINST2 (e.g., non-VFP ARM opcodes) the VFP support
code knows which instructions can be emulated, and rejects other
opcodes with "unhandled bounce" messages, so there should be no
security impact from allowing reloading FPEXC.EX and FPEXC.FP2V.

Signed-off-by: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
---
--- vfpmodule-3.18.9.c  2015-03-20 13:51:32.000000000 +0100
+++ vfpmodule-patched.c 2015-03-21 09:58:03.027806844 +0100
@@ -183,8 +183,11 @@ static int vfp_notifier(struct notifier_
                 * case the thread migrates to a different CPU. The
                 * restoring is done lazily.
                 */
-               if ((fpexc & FPEXC_EN) && vfp_current_hw_state[cpu])
+               if ((fpexc & FPEXC_EN) && vfp_current_hw_state[cpu]) {
+                       /* vfp_save_state oopses on VFP11 if EX bit set */
+                       fmxr(FPEXC, fpexc & ~FPEXC_EX);
                        vfp_save_state(vfp_current_hw_state[cpu], fpexc);
+               }
 #endif
 
                /*
@@ -454,13 +457,16 @@ static int vfp_pm_suspend(void)
        /* if vfp is on, then save state for resumption */
        if (fpexc & FPEXC_EN) {
                pr_debug("%s: saving vfp state\n", __func__);
+               /* vfp_save_state oopses on VFP11 if EX bit set */
+               fmxr(FPEXC, fpexc & ~FPEXC_EX);
                vfp_save_state(&ti->vfpstate, fpexc);
 
                /* disable, just in case */
                fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
        } else if (vfp_current_hw_state[ti->cpu]) {
 #ifndef CONFIG_SMP
-               fmxr(FPEXC, fpexc | FPEXC_EN);
+               /* vfp_save_state oopses on VFP11 if EX bit set */
+               fmxr(FPEXC, (fpexc & ~FPEXC_EX) | FPEXC_EN);
                vfp_save_state(vfp_current_hw_state[ti->cpu], fpexc);
                fmxr(FPEXC, fpexc);
 #endif
@@ -523,7 +529,8 @@ void vfp_sync_hwstate(struct thread_info
                /*
                 * Save the last VFP state on this CPU.
                 */
-               fmxr(FPEXC, fpexc | FPEXC_EN);
+               /* vfp_save_state oopses on VFP11 if EX bit set */
+               fmxr(FPEXC, (fpexc & ~FPEXC_EX) | FPEXC_EN);
                vfp_save_state(&thread->vfpstate, fpexc | FPEXC_EN);
                fmxr(FPEXC, fpexc);
        }
@@ -595,6 +602,7 @@ int vfp_restore_user_hwstate(struct user
        struct vfp_hard_struct *hwstate = &thread->vfpstate.hard;
        unsigned long fpexc;
        int err = 0;
+       u32 fpsid = fmrx(FPSID);
 
        /* Disable VFP to avoid corrupting the new thread state. */
        vfp_flush_hwstate(thread);
@@ -618,8 +626,12 @@ int vfp_restore_user_hwstate(struct user
        /* Ensure the VFP is enabled. */
        fpexc |= FPEXC_EN;
 
-       /* Ensure FPINST2 is invalid and the exception flag is cleared. */
-       fpexc &= ~(FPEXC_EX | FPEXC_FP2V);
+       /* Mask FPXEC_EX and FPEXC_FP2V if not required by VFP arch */
+       if ((fpsid & FPSID_ARCH_MASK) != (1 << FPSID_ARCH_BIT)) {
+               /* Ensure FPINST2 is invalid and the exception flag is cleared. */
+               fpexc &= ~(FPEXC_EX | FPEXC_FP2V);
+       }
+
        hwstate->fpexc = fpexc;
 
        __get_user_error(hwstate->fpinst, &ufp_exc->fpinst, err);
@@ -689,7 +701,8 @@ void kernel_neon_begin(void)
        cpu = get_cpu();
 
        fpexc = fmrx(FPEXC) | FPEXC_EN;
-       fmxr(FPEXC, fpexc);
+       /* vfp_save_state oopses on VFP11 if EX bit set */
+       fmxr(FPEXC, fpexc & ~FPEXC_EX);
 
        /*
         * Save the userland NEON/VFP state. Under UP,
