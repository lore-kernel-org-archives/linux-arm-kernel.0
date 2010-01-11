From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:37 -0800
Subject: [RFC 18/18] arm: mm: qsd8x50: Fix incorrect permission faults
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-19-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Estes <cestes@quicinc.com>

Handle incorrectly reported permission faults for qsd8650.  On
permission faults, retry MVA to PA conversion.  If retry detects
translation fault.  Report as translation fault.

Signed-off-by: Dave Estes <cestes@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mm/Kconfig     |    3 ++
 arch/arm/mm/abort-ev7.S |   78 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9c745ca..1f17def 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -575,6 +575,9 @@ config CPU_TLB_V7
 
 config EMULATE_DOMAIN_MANAGER_V7
 	bool
+
+config VERIFY_PERMISSION_FAULT
+	bool
 endif
 
 config CPU_HAS_ASID
diff --git a/arch/arm/mm/abort-ev7.S b/arch/arm/mm/abort-ev7.S
index 2e6dc04..8a75c21 100644
--- a/arch/arm/mm/abort-ev7.S
+++ b/arch/arm/mm/abort-ev7.S
@@ -1,3 +1,60 @@
+/*
+ * Copyright (c) 2009, Code Aurora Forum. All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Code Aurora Forum nor
+ *       the names of its contributors may be used to endorse or promote
+ *       products derived from this software without specific prior written
+ *       permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this software
+ * may be relicensed by the recipient under the terms of the GNU General Public
+ * License version 2 ("GPL") and only version 2, in which case the provisions of
+ * the GPL apply INSTEAD OF those given above.  If the recipient relicenses the
+ * software under the GPL, then the identification text in the MODULE_LICENSE
+ * macro must be changed to reflect "GPLv2" instead of "Dual BSD/GPL".  Once a
+ * recipient changes the license terms to the GPL, subsequent recipients shall
+ * not relicense under alternate licensing terms, including the BSD or dual
+ * BSD/GPL terms.  In addition, the following license statement immediately
+ * below and between the words START and END shall also then apply when this
+ * software is relicensed under the GPL:
+ *
+ * START
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 and only version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ *
+ * END
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 /*
@@ -29,5 +86,26 @@ ENTRY(v7_early_abort)
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
