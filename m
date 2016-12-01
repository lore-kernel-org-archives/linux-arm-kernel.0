From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  1 Dec 2016 10:44:33 +0000
Subject: [PATCH 1/2] arm64: Get rid of asm/opcodes.h
In-Reply-To: <1480589074-809-1-git-send-email-marc.zyngier@arm.com>
References: <1480589074-809-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1480589074-809-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The opcodes.h drags in a lot of definition from the 32bit port, most
of which is not required at all. Clean things up a bit by moving
the bare minimum of what is required next to the actual users,
and drop the include file.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/opcodes.h     |  5 -----
 arch/arm64/include/asm/sysreg.h      | 16 ++++++++++------
 arch/arm64/kernel/armv8_deprecated.c |  5 ++++-
 arch/arm64/kernel/insn.c             |  1 -
 4 files changed, 14 insertions(+), 13 deletions(-)
 delete mode 100644 arch/arm64/include/asm/opcodes.h

diff --git a/arch/arm64/include/asm/opcodes.h b/arch/arm64/include/asm/opcodes.h
deleted file mode 100644
index 123f45d..0000000
--- a/arch/arm64/include/asm/opcodes.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#ifdef CONFIG_CPU_BIG_ENDIAN
-#define CONFIG_CPU_ENDIAN_BE8 CONFIG_CPU_BIG_ENDIAN
-#endif
-
-#include <../../arm/include/asm/opcodes.h>
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6c80b36..9e16a18 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -22,8 +22,6 @@
 
 #include <linux/stringify.h>
 
-#include <asm/opcodes.h>
-
 /*
  * ARMv8 ARM reserves the following encoding for system registers:
  * (Ref: ARMv8 ARM, Section: "System instruction class encoding overview",
@@ -37,6 +35,12 @@
 #define sys_reg(op0, op1, crn, crm, op2) \
 	((((op0)&3)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
 
+#ifdef __ASSEMBLY__
+#define __emit_inst(x)			.inst (x)
+#else
+#define __emit_inst(x)			".inst " __stringify((x)) "\n\t"
+#endif
+
 #define SYS_MIDR_EL1			sys_reg(3, 0, 0, 0, 0)
 #define SYS_MPIDR_EL1			sys_reg(3, 0, 0, 0, 5)
 #define SYS_REVIDR_EL1			sys_reg(3, 0, 0, 0, 6)
@@ -81,10 +85,10 @@
 #define REG_PSTATE_PAN_IMM		sys_reg(0, 0, 4, 0, 4)
 #define REG_PSTATE_UAO_IMM		sys_reg(0, 0, 4, 0, 3)
 
-#define SET_PSTATE_PAN(x) __inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
-				     (!!x)<<8 | 0x1f)
-#define SET_PSTATE_UAO(x) __inst_arm(0xd5000000 | REG_PSTATE_UAO_IMM |\
-				     (!!x)<<8 | 0x1f)
+#define SET_PSTATE_PAN(x) __emit_inst(0xd5000000 | REG_PSTATE_PAN_IMM |	\
+				      (!!x)<<8 | 0x1f)
+#define SET_PSTATE_UAO(x) __emit_inst(0xd5000000 | REG_PSTATE_UAO_IMM |	\
+				      (!!x)<<8 | 0x1f)
 
 /* Common SCTLR_ELx flags. */
 #define SCTLR_ELx_EE    (1 << 25)
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index b0988bb..567c397 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -17,7 +17,6 @@
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
 #include <asm/insn.h>
-#include <asm/opcodes.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
 #include <asm/traps.h>
@@ -352,6 +351,10 @@ static int emulate_swpX(unsigned int address, unsigned int *data,
 	return res;
 }
 
+#define ARM_OPCODE_CONDTEST_FAIL   0
+#define ARM_OPCODE_CONDTEST_PASS   1
+#define ARM_OPCODE_CONDTEST_UNCOND 2
+
 #define	ARM_OPCODE_CONDITION_UNCOND	0xf
 
 static unsigned int __kprobes aarch32_check_condition(u32 opcode, u32 psr)
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 6f2ac4f..94b62c1 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -30,7 +30,6 @@
 #include <asm/cacheflush.h>
 #include <asm/debug-monitors.h>
 #include <asm/fixmap.h>
-#include <asm/opcodes.h>
 #include <asm/insn.h>
 
 #define AARCH64_INSN_SF_BIT	BIT(31)
-- 
2.1.4
