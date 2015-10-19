From: geoff@infradead.org (Geoff Levand)
Date: Mon, 19 Oct 2015 23:38:53 +0000
Subject: [PATCH 03/16] arm64: Add new hcall HVC_CALL_FUNC
In-Reply-To: <cover.1445297709.git.geoff@infradead.org>
References: <cover.1445297709.git.geoff@infradead.org>
Message-ID: <f064e1c7eac5d7bfc770866fe9c751c4d1a6a2c4.1445297709.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new hcall HVC_CALL_FUNC that allows execution of a function at EL2.
During CPU reset the CPU must be brought to the exception level it had on
entry to the kernel.  The HVC_CALL_FUNC hcall will provide the mechanism
needed for this exception level switch.

To allow the HVC_CALL_FUNC exception vector to work without a stack, which is
needed to support an hcall at CPU reset, this implementation uses register x18
to store the link register across the caller provided function.  This dictates
that the caller provided function must preserve the contents of register x18.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/virt.h | 13 +++++++++++++
 arch/arm64/kernel/hyp-stub.S  | 13 ++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

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
index 017ab519..e8febe9 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -67,8 +67,19 @@ el1_sync:
 	b	2f
 
 1:	cmp	x18, #HVC_SET_VECTORS
-	b.ne	2f
+	b.ne	1f
 	msr	vbar_el2, x0
+	b	2f
+
+1:	cmp	x18, #HVC_CALL_FUNC
+	b.ne	2f
+	mov	x18, lr
+	mov	lr, x0
+	mov	x0, x1
+	mov	x1, x2
+	mov	x2, x3
+	blr	lr
+	mov	lr, x18
 
 2:	eret
 ENDPROC(el1_sync)
-- 
2.5.0
