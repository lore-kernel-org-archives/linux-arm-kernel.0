From: geoff@infradead.org (Geoff Levand)
Date: Mon, 14 Mar 2016 17:48:00 +0000
Subject: [PATCH v15 04/20] arm64: Add new hcall HVC_CALL_FUNC
In-Reply-To: <cover.1457977401.git.geoff@infradead.org>
References: <cover.1457977401.git.geoff@infradead.org>
Message-ID: <ae755be8b6f8b37f891b9534a5174785ebea4a69.1457977402.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new hcall HVC_CALL_FUNC that allows execution of a function at EL2.
During CPU reset the CPU must be brought to the exception level it had on
entry to the kernel.  The HVC_CALL_FUNC hcall will provide the mechanism
needed for this exception level switch.

To allow the HVC_CALL_FUNC exception vector to work without a stack, which
is needed to support an hcall at CPU reset, this implementation uses
register x18 to store the link register across the caller provided
function.  This dictates that the caller provided function must preserve
the contents of register x18.

Signed-off-by: Geoff Levand <geoff@infradead.org>
[Renumbered labels in el1_sync()]
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/virt.h | 13 +++++++++++++
 arch/arm64/kernel/hyp-stub.S  | 19 +++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index eb10368..3070096 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -45,6 +45,19 @@
 
 #define HVC_SET_VECTORS 2
 
+/*
+ * HVC_CALL_FUNC - Execute a function at EL2.
+ *
+ * @x0: Physical address of the function to be executed.
+ * @x1: Passed as the first argument to the function.
+ * @x2: Passed as the second argument to the function.
+ * @x3: Passed as the third argument to the function.
+ *
+ * The called function must preserve the contents of register x18.
+ */
+
+#define HVC_CALL_FUNC 3
+
 #define BOOT_CPU_MODE_EL1	(0xe11)
 #define BOOT_CPU_MODE_EL2	(0xe12)
 
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 017ab519..cfacfe5 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -59,18 +59,29 @@ el1_sync:
 	and	x18, x18, #ESR_ELx_ISS_MASK
 
 	cmp	x17, #ESR_ELx_EC_HVC64
-	b.ne	2f				// Not an HVC trap
+	b.ne	9f				// Not an HVC trap
 
 	cmp	x18, #HVC_GET_VECTORS
 	b.ne	1f
 	mrs	x0, vbar_el2
-	b	2f
+	b	9f
 
 1:	cmp	x18, #HVC_SET_VECTORS
 	b.ne	2f
 	msr	vbar_el2, x0
-
-2:	eret
+	b	9f
+
+2:	cmp	x18, #HVC_CALL_FUNC
+	b.ne	9f
+	mov	x18, lr
+	mov	lr, x0
+	mov	x0, x1
+	mov	x1, x2
+	mov	x2, x3
+	blr	lr
+	mov	lr, x18
+
+9:	eret
 ENDPROC(el1_sync)
 
 .macro invalid_vector	label
-- 
2.5.0
