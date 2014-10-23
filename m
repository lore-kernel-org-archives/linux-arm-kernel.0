From: geoff@infradead.org (Geoff Levand)
Date: Thu, 23 Oct 2014 23:10:58 +0000
Subject: [PATCH 03/10] arm64: Add new hcall HVC_CALL_FUNC
In-Reply-To: <cover.1414099246.git.geoff@infradead.org>
References: <cover.1414099246.git.geoff@infradead.org>
Message-ID: <55067c8e9bb7ccd1db6027e668a6a05e3d66aec3.1414099246.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new hcall HVC_CALL_FUNC that allows execution of a function at EL2.
During CPU reset the CPU must be brought to the exception level it had on
entry to the kernel.  The HVC_CALL_FUNC hcall will provide the mechanism
needed for this exception level switch.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/virt.h | 13 +++++++++++++
 arch/arm64/kernel/hyp-stub.S  | 17 ++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 99c319c..055e8d8 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -41,6 +41,19 @@
 
 #define HVC_CALL_HYP 3
 
+/*
+ * HVC_CALL_FUNC - Execute a function at EL2.
+ *
+ * @x0: Physical address of the funtion to be executed.
+ * @x1: Passed as the first argument to the function.
+ * @x2: Passed as the second argument to the function.
+ * @x3: Passed as the third argument to the function.
+ *
+ * The called function must preserve the contents of register x18.
+ */
+
+#define HVC_CALL_FUNC 4
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 9ce8746..719c726 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -66,9 +66,20 @@ el1_sync:
 	mrs	x0, vbar_el2
 	b	2f
 
-1:	cmp	x18, #HVC_SET_VECTORS
-	b.ne	2f
-	msr	vbar_el2, x0
+1:	cmp     x18, #HVC_SET_VECTORS
+	b.ne    1f
+	msr     vbar_el2, x0
+	b       2f
+
+1:	cmp     x18, #HVC_CALL_FUNC
+	b.ne    2f
+	mov     x18, lr
+	mov     lr, x0
+	mov     x0, x1
+	mov     x1, x2
+	mov     x2, x3
+	blr     lr
+	mov     lr, x18
 
 2:	eret
 ENDPROC(el1_sync)
-- 
1.9.1
