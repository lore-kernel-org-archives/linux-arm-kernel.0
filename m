From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 22 Jul 2015 10:54:17 +0100
Subject: [PATCH] arm64: sys_reg() : Fix encoding of system registers
In-Reply-To: <20150721113705.GD7250@e104818-lin.cambridge.arm.com>
References: <20150721113705.GD7250@e104818-lin.cambridge.arm.com>
Message-ID: <1437558857-18433-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

sys_reg() macro encodes Op0 as (Op0 - 2) and pushes it to Bit 19,
leaving Bit 20 uninitialised. As per ARMv8 ARM, (Ref: ARMv8 ARM,
Section: "System instruction class encoding overview", C5.2,
version:ARM DDI 0487A.f), the instruction encoding reserves
bits [20-19] for Op0. Especially, the sys_reg could give wrong
values for using with MSR(Immediate) form, which is only supported
with Op0 == 0 (e.g, PSTATE.x). Fix this to avoid users getting the
wrong encoding.

Cc: James Morse <james.morse@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/sysreg.h |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 0a579b2..9c5f0f1 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -20,8 +20,18 @@
 #ifndef __ASM_SYSREG_H
 #define __ASM_SYSREG_H
 
+/*
+ * ARMv8 ARM reserves the following encoding for system registers:
+ * (Ref: ARMv8 ARM, Section: "System instruction class encoding overview",
+ *  C5.2, version:ARM DDI 0487A.f)
+ *	[20-19] : Op0
+ *	[18-16] : Op1
+ *	[15-12] : CRn
+ *	[11-8]  : CRm
+ *	[7-5]   : Op2
+ */
 #define sys_reg(op0, op1, crn, crm, op2) \
-	((((op0)-2)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
+	((((op0)&3)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
 
 #ifdef __ASSEMBLY__
 
@@ -31,11 +41,11 @@
 	.equ	__reg_num_xzr, 31
 
 	.macro	mrs_s, rt, sreg
-	.inst	0xd5300000|(\sreg)|(__reg_num_\rt)
+	.inst	0xd5200000|(\sreg)|(__reg_num_\rt)
 	.endm
 
 	.macro	msr_s, sreg, rt
-	.inst	0xd5100000|(\sreg)|(__reg_num_\rt)
+	.inst	0xd5000000|(\sreg)|(__reg_num_\rt)
 	.endm
 
 #else
@@ -47,11 +57,11 @@ asm(
 "	.equ	__reg_num_xzr, 31\n"
 "\n"
 "	.macro	mrs_s, rt, sreg\n"
-"	.inst	0xd5300000|(\\sreg)|(__reg_num_\\rt)\n"
+"	.inst	0xd5200000|(\\sreg)|(__reg_num_\\rt)\n"
 "	.endm\n"
 "\n"
 "	.macro	msr_s, sreg, rt\n"
-"	.inst	0xd5100000|(\\sreg)|(__reg_num_\\rt)\n"
+"	.inst	0xd5000000|(\\sreg)|(__reg_num_\\rt)\n"
 "	.endm\n"
 );
 
-- 
1.7.9.5
