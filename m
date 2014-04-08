From: arunks.linux@gmail.com (arunks.linux at gmail.com)
Date: Tue,  8 Apr 2014 19:54:35 +0530
Subject: [PATCH] ARM: Modify ldrt fixup handler to re-execute the userspace
 instruction
Message-ID: <1396967075-11988-1-git-send-email-arunks.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arun KS <arunks.linux@gmail.com>

We will reach fixup handler when one thread(say cpu0) caused an undefined
exception, while another thread(say cpu1) is unmmaping the page.

Fixup handler returns to the next userspace instruction which has caused the
undef execption, rather than going to the same instruction.

ARM ARM says that after undefined exception, the PC will be pointing
to the next instruction.
ie +4 offset in case of ARM and +2 in case of Thumb

And there is no correction offset passed to vector_stub in case of
undef exception.

File: arch/arm/kernel/entry-armv.S +1085
vector_stub     und, UND_MODE

During an undefined exception, in normal scenario(ie when ldrt
instruction does not cause an abort) after resorting the context in
VFP hardware, the PC is modified as show below before jumping to
ret_from_exception which is in r9.

File: arch/arm/vfp/vfphw.S +169
@ The context stored in the VFP hardware is up to date with this thread
vfp_hw_state_valid:
        tst     r1, #FPEXC_EX
        bne     process_exception       @ might as well handle the pending
                                        @ exception before retrying branch
                                        @ out before setting an FPEXC that
                                        @ stops us reading stuff
        VFPFMXR FPEXC, r1               @ Restore FPEXC last
        sub     r2, r2, #4              @ Retry current instruction - if Thumb
        str     r2, [sp, #S_PC]         @ mode it's two 16-bit instructions,
                                        @ else it's one 32-bit instruction, so
                                        @ always subtract 4 from the following
                                        @ instruction address.

But if ldrt results in an abort, we reach the fixup handler and return
to ret_from_execption without correcting the pc.

This patch modifes the fixup handler to re-execute the same instruction which caused
undefined execption.

Signed-off-by: Danesh Petigara <dpetigara@broadcom.com>
Signed-off-by: Vinayak Menon <vinayakm.list@gmail.com>
Signed-off-by: Arun KS <getarunks@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: <stable@vger.kernel.org>    [2.6.32+]
---
 arch/arm/kernel/entry-armv.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 1879e8d..3fa745f 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -484,7 +484,8 @@ ENDPROC(__und_usr)
  */
 	.pushsection .fixup, "ax"
 	.align	2
-4:	mov	pc, r9
+4:	str     r4, [sp, #S_PC]			@ retry current instruction
+	mov	pc, r9
 	.popsection
 	.pushsection __ex_table,"a"
 	.long	1b, 4b
-- 
1.7.9.5
