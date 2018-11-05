From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Nov 2018 13:06:44 +0000
Subject: [PATCH 05/10] arm64: smccc: use asm EXPORT_SYMBOL()
In-Reply-To: <20181105130649.29429-1-mark.rutland@arm.com>
References: <20181105130649.29429-1-mark.rutland@arm.com>
Message-ID: <20181105130649.29429-6-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For a while now it's been possible to use EXPORT_SYMBOL() in assembly
files, which allows us to place exports immediately after assembly
functions, as we do for C functions.

As a step towards removing arm64ksyms.c, let's move the SMCCC exports to
the assembly file the functions are defined in.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/arm64ksyms.c | 5 -----
 arch/arm64/kernel/smccc-call.S | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index d80e9cfc3062..74e29e69190b 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -26,7 +26,6 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
-#include <linux/arm-smccc.h>
 #include <linux/kprobes.h>
 
 #include <asm/checksum.h>
@@ -64,7 +63,3 @@ EXPORT_SYMBOL(_mcount);
 NOKPROBE_SYMBOL(_mcount);
 #endif
 
-	/* arm-smccc */
-EXPORT_SYMBOL(__arm_smccc_smc);
-EXPORT_SYMBOL(__arm_smccc_hvc);
-
diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index 62522342e1e4..67218e9e8d5e 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -13,7 +13,9 @@
  */
 #include <linux/linkage.h>
 #include <linux/arm-smccc.h>
+
 #include <asm/asm-offsets.h>
+#include <asm/export.h>
 
 	.macro SMCCC instr
 	.cfi_startproc
@@ -40,6 +42,7 @@
 ENTRY(__arm_smccc_smc)
 	SMCCC	smc
 ENDPROC(__arm_smccc_smc)
+EXPORT_SYMBOL(__arm_smccc_smc)
 
 /*
  * void arm_smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
@@ -50,3 +53,4 @@ ENDPROC(__arm_smccc_smc)
 ENTRY(__arm_smccc_hvc)
 	SMCCC	hvc
 ENDPROC(__arm_smccc_hvc)
+EXPORT_SYMBOL(__arm_smccc_hvc)
-- 
2.11.0
