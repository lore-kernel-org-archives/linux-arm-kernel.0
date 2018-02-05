From: will.deacon@arm.com (Will Deacon)
Date: Mon,  5 Feb 2018 15:34:16 +0000
Subject: [PATCH 1/9] arm64: barrier: Add CSDB macros to control data-value
 prediction
In-Reply-To: <1517844864-15887-1-git-send-email-will.deacon@arm.com>
References: <1517844864-15887-1-git-send-email-will.deacon@arm.com>
Message-ID: <1517844864-15887-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For CPUs capable of data value prediction, CSDB waits for any outstanding
predictions to architecturally resolve before allowing speculative execution
to continue. Provide macros to expose it to the arch code.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/assembler.h | 7 +++++++
 arch/arm64/include/asm/barrier.h   | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 794fe8122602..709adde9e80f 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -116,6 +116,13 @@
 	.endm
 
 /*
+ * Value prediction barrier
+ */
+	.macro	csdb
+	hint	#20
+	.endm
+
+/*
  * NOP sequence
  */
 	.macro	nops, num
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 77651c49ef44..c0a846d2c602 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -32,6 +32,7 @@
 #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 
 #define psb_csync()	asm volatile("hint #17" : : : "memory")
+#define csdb()		asm volatile("hint #20" : : : "memory")
 
 #define mb()		dsb(sy)
 #define rmb()		dsb(ld)
-- 
2.1.4
