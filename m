From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Feb 2013 13:04:49 +0000
Subject: [PATCH] ARM: VFP: fix emulation of second VFP instruction
Message-ID: <20130225130449.GM17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Storsj? reports that the sequence:

	ee312ac1	vsub.f32	s4, s3, s2
	ee702ac0	vsub.f32	s5, s1, s0
	e59f0028	ldr		r0, [pc, #40]
	ee111a90	vmov		r1, s3

on Raspberry Pi (implementor 41 architecture 1 part 20 variant b rev 5)
where s3 is a denormal and s2 is zero results in incorrect behaviour -
the instruction "vsub.f32 s5, s1, s0" is not executed:

	VFP: bounce: trigger ee111a90 fpexc d0000780
	VFP: emulate: INST=0xee312ac1 SCR=0x00000000
	...

As we can see, the instruction triggering the exception is the "vmov"
instruction, and we emulate the "vsub.f32 s4, s3, s2" but fail to
properly take account of the FPEXC_FP2V flag in FPEXC.  This is because
the test for the second instruction register being valid is bogus, and
will always skip emulation of the second instruction.

Cc: <stable@vger.kernel.org>
Reported-by: Martin Storsj? <martin@martin.st>
Tested-by: Martin Storsj? <martin@martin.st>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/vfp/vfpmodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 3b44e0d..5dfbb0b 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -413,7 +413,7 @@ void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
 	 * If there isn't a second FP instruction, exit now. Note that
 	 * the FPEXC.FP2V bit is valid only if FPEXC.EX is 1.
 	 */
-	if (fpexc ^ (FPEXC_EX | FPEXC_FP2V))
+	if ((fpexc & (FPEXC_EX | FPEXC_FP2V)) != (FPEXC_EX | FPEXC_FP2V))
 		goto exit;
 
 	/*
