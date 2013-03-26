From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Mar 2013 17:00:56 +0000
Subject: [PATCH v2 01/30] arm64: add explicit symbols to ESR_EL1 decoding
In-Reply-To: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
References: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1364317285-20937-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ESR_EL1 decoding process is a bit cryptic, and KVM has also
a need for the same constants.

Add a new esr.h file containing the appropriate exception classes
constants, and change entry.S to use it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/esr.h | 55 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/entry.S    | 53 +++++++++++++++++++++---------------------
 2 files changed, 82 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm64/include/asm/esr.h

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
new file mode 100644
index 0000000..7883412
--- /dev/null
+++ b/arch/arm64/include/asm/esr.h
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2013 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_ESR_H
+#define __ASM_ESR_H
+
+#define ESR_EL1_EC_SHIFT	(26)
+#define ESR_EL1_IL		(1U << 25)
+
+#define ESR_EL1_EC_UNKNOWN	(0x00)
+#define ESR_EL1_EC_WFI		(0x01)
+#define ESR_EL1_EC_CP15_32	(0x03)
+#define ESR_EL1_EC_CP15_64	(0x04)
+#define ESR_EL1_EC_CP14_MR	(0x05)
+#define ESR_EL1_EC_CP14_LS	(0x06)
+#define ESR_EL1_EC_FP_ASIMD	(0x07)
+#define ESR_EL1_EC_CP10_ID	(0x08)
+#define ESR_EL1_EC_CP14_64	(0x0C)
+#define ESR_EL1_EC_ILL_ISS	(0x0E)
+#define ESR_EL1_EC_SVC32	(0x11)
+#define ESR_EL1_EC_SVC64	(0x15)
+#define ESR_EL1_EC_SYS64	(0x18)
+#define ESR_EL1_EC_IABT_EL0	(0x20)
+#define ESR_EL1_EC_IABT_EL1	(0x21)
+#define ESR_EL1_EC_PC_ALIGN	(0x22)
+#define ESR_EL1_EC_DABT_EL0	(0x24)
+#define ESR_EL1_EC_DABT_EL1	(0x25)
+#define ESR_EL1_EC_SP_ALIGN	(0x26)
+#define ESR_EL1_EC_FP_EXC32	(0x28)
+#define ESR_EL1_EC_FP_EXC64	(0x2C)
+#define ESR_EL1_EC_SERRROR	(0x2F)
+#define ESR_EL1_EC_BREAKPT_EL0	(0x30)
+#define ESR_EL1_EC_BREAKPT_EL1	(0x31)
+#define ESR_EL1_EC_SOFTSTP_EL0	(0x32)
+#define ESR_EL1_EC_SOFTSTP_EL1	(0x33)
+#define ESR_EL1_EC_WATCHPT_EL0	(0x34)
+#define ESR_EL1_EC_WATCHPT_EL1	(0x35)
+#define ESR_EL1_EC_BKPT32	(0x38)
+#define ESR_EL1_EC_BRK64	(0x3C)
+
+#endif /* __ASM_ESR_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 514d609..2d861b1 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -24,6 +24,7 @@
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/errno.h>
+#include <asm/esr.h>
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
 #include <asm/unistd32.h>
@@ -239,18 +240,18 @@ ENDPROC(el1_error_invalid)
 el1_sync:
 	kernel_entry 1
 	mrs	x1, esr_el1			// read the syndrome register
-	lsr	x24, x1, #26			// exception class
-	cmp	x24, #0x25			// data abort in EL1
+	lsr	x24, x1, #ESR_EL1_EC_SHIFT	// exception class
+	cmp	x24, #ESR_EL1_EC_DABT_EL1	// data abort in EL1
 	b.eq	el1_da
-	cmp	x24, #0x18			// configurable trap
+	cmp	x24, #ESR_EL1_EC_SYS64		// configurable trap
 	b.eq	el1_undef
-	cmp	x24, #0x26			// stack alignment exception
+	cmp	x24, #ESR_EL1_EC_SP_ALIGN	// stack alignment exception
 	b.eq	el1_sp_pc
-	cmp	x24, #0x22			// pc alignment exception
+	cmp	x24, #ESR_EL1_EC_PC_ALIGN	// pc alignment exception
 	b.eq	el1_sp_pc
-	cmp	x24, #0x00			// unknown exception in EL1
+	cmp	x24, #ESR_EL1_EC_UNKNOWN	// unknown exception in EL1
 	b.eq	el1_undef
-	cmp	x24, #0x30			// debug exception in EL1
+	cmp	x24, #ESR_EL1_EC_BREAKPT_EL0	// debug exception in EL1
 	b.ge	el1_dbg
 	b	el1_inv
 el1_da:
@@ -346,27 +347,27 @@ el1_preempt:
 el0_sync:
 	kernel_entry 0
 	mrs	x25, esr_el1			// read the syndrome register
-	lsr	x24, x25, #26			// exception class
-	cmp	x24, #0x15			// SVC in 64-bit state
+	lsr	x24, x25, #ESR_EL1_EC_SHIFT	// exception class
+	cmp	x24, #ESR_EL1_EC_SVC64		// SVC in 64-bit state
 	b.eq	el0_svc
 	adr	lr, ret_from_exception
-	cmp	x24, #0x24			// data abort in EL0
+	cmp	x24, #ESR_EL1_EC_DABT_EL0	// data abort in EL0
 	b.eq	el0_da
-	cmp	x24, #0x20			// instruction abort in EL0
+	cmp	x24, #ESR_EL1_EC_IABT_EL0	// instruction abort in EL0
 	b.eq	el0_ia
-	cmp	x24, #0x07			// FP/ASIMD access
+	cmp	x24, #ESR_EL1_EC_FP_ASIMD	// FP/ASIMD access
 	b.eq	el0_fpsimd_acc
-	cmp	x24, #0x2c			// FP/ASIMD exception
+	cmp	x24, #ESR_EL1_EC_FP_EXC64	// FP/ASIMD exception
 	b.eq	el0_fpsimd_exc
-	cmp	x24, #0x18			// configurable trap
+	cmp	x24, #ESR_EL1_EC_SYS64		// configurable trap
 	b.eq	el0_undef
-	cmp	x24, #0x26			// stack alignment exception
+	cmp	x24, #ESR_EL1_EC_SP_ALIGN	// stack alignment exception
 	b.eq	el0_sp_pc
-	cmp	x24, #0x22			// pc alignment exception
+	cmp	x24, #ESR_EL1_EC_PC_ALIGN	// pc alignment exception
 	b.eq	el0_sp_pc
-	cmp	x24, #0x00			// unknown exception in EL0
+	cmp	x24, #ESR_EL1_EC_UNKNOWN	// unknown exception in EL0
 	b.eq	el0_undef
-	cmp	x24, #0x30			// debug exception in EL0
+	cmp	x24, #ESR_EL1_EC_BREAKPT_EL0	// debug exception in EL0
 	b.ge	el0_dbg
 	b	el0_inv
 
@@ -375,21 +376,21 @@ el0_sync:
 el0_sync_compat:
 	kernel_entry 0, 32
 	mrs	x25, esr_el1			// read the syndrome register
-	lsr	x24, x25, #26			// exception class
-	cmp	x24, #0x11			// SVC in 32-bit state
+	lsr	x24, x25, #ESR_EL1_EC_SHIFT	// exception class
+	cmp	x24, #ESR_EL1_EC_SVC32		// SVC in 32-bit state
 	b.eq	el0_svc_compat
 	adr	lr, ret_from_exception
-	cmp	x24, #0x24			// data abort in EL0
+	cmp	x24, #ESR_EL1_EC_DABT_EL0	// data abort in EL0
 	b.eq	el0_da
-	cmp	x24, #0x20			// instruction abort in EL0
+	cmp	x24, #ESR_EL1_EC_IABT_EL0	// instruction abort in EL0
 	b.eq	el0_ia
-	cmp	x24, #0x07			// FP/ASIMD access
+	cmp	x24, #ESR_EL1_EC_FP_ASIMD	// FP/ASIMD access
 	b.eq	el0_fpsimd_acc
-	cmp	x24, #0x28			// FP/ASIMD exception
+	cmp	x24, #ESR_EL1_EC_FP_EXC32	// FP/ASIMD exception
 	b.eq	el0_fpsimd_exc
-	cmp	x24, #0x00			// unknown exception in EL0
+	cmp	x24, #ESR_EL1_EC_UNKNOWN	// unknown exception in EL0
 	b.eq	el0_undef
-	cmp	x24, #0x30			// debug exception in EL0
+	cmp	x24, #ESR_EL1_EC_BREAKPT_EL0	// debug exception in EL0
 	b.ge	el0_dbg
 	b	el0_inv
 el0_svc_compat:
-- 
1.8.1.4
