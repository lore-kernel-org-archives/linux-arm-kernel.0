From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 28 Jan 2010 14:59:37 -0800
Subject: [RFC PATCH 12/12] arm: mm: qsd8x50: Fix incorrect permission faults
Message-ID: <1264719577-5436-13-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Estes <cestes@quicinc.com>

Handle incorrectly reported permission faults for qsd8650.  On
permission faults, retry MVA to PA conversion.  If retry detects
translation fault.  Report as translation fault.

Cc: Jamie Lokier <jamie@shareable.org>
Signed-off-by: Dave Estes <cestes@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mm/Kconfig     |    2 ++
 arch/arm/mm/abort-ev7.S |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 155c7a3..0288749 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -572,6 +572,8 @@ config CPU_TLB_V6
 config CPU_TLB_V7
 	bool
 
+config VERIFY_PERMISSION_FAULT
+	bool
 endif
 
 config CPU_HAS_ASID
diff --git a/arch/arm/mm/abort-ev7.S b/arch/arm/mm/abort-ev7.S
index 2e6dc04..0151c03 100644
--- a/arch/arm/mm/abort-ev7.S
+++ b/arch/arm/mm/abort-ev7.S
@@ -1,3 +1,20 @@
+/* Copyright (c) 2009, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 /*
@@ -29,5 +46,26 @@ ENTRY(v7_early_abort)
 	 * V6 code adjusts the returned DFSR.
 	 * New designs should not need to patch up faults.
 	 */
+
+#if defined(CONFIG_VERIFY_PERMISSION_FAULT)
+	/*
+	 * Detect erroneous permission failures and fix
+	 */
+	ldr	r3, =0x40d			@ On permission fault
+	and	r3, r1, r3
+	cmp	r3, #0x0d
+	movne	pc, lr
+
+	mcr	p15, 0, r0, c7, c8, 0   	@ Retranslate FAR
+	isb
+	mrc	p15, 0, r2, c7, c4, 0   	@ Read the PAR
+	and	r3, r2, #0x7b   		@ On translation fault
+	cmp	r3, #0x0b
+	movne	pc, lr
+	bic	r1, r1, #0xf			@ Fix up FSR FS[5:0]
+	and	r2, r2, #0x7e
+	orr	r1, r1, r2, LSR #1
+#endif
+
 	mov	pc, lr
 ENDPROC(v7_early_abort)
-- 
1.6.3.3
