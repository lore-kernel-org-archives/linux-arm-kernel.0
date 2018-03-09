From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:06:45 +0800
Subject: [PATCH 02/39] arm64: barrier: Add CSDB macros to control data-value
 prediction
In-Reply-To: <20180309090722.26279-1-alex.shi@linaro.org>
References: <20180309090722.26279-1-alex.shi@linaro.org>
Message-ID: <20180309090722.26279-3-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit 669474e772b9 upstream.

For CPUs capable of data value prediction, CSDB waits for any outstanding
predictions to architecturally resolve before allowing speculative execution
to continue. Provide macros to expose it to the arch code.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 26 ++++++++++++++++++++++++++
 arch/arm64/include/asm/barrier.h   |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 12eff928ef8b..229b37ddf52c 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -94,6 +94,32 @@
 	dmb	\opt
 	.endm
 
+/*
+ * Value prediction barrier
+ */
+	.macro	csdb
+	hint	#20
+	.endm
+
+/*
+ * NOP sequence
+ */
+	.macro	nops, num
+	.rept	\num
+	nop
+	.endr
+	.endm
+
+/*
+ * Emit an entry into the exception table
+ */
+	.macro		_asm_extable, from, to
+	.pushsection	__ex_table, "a"
+	.align		3
+	.long		(\from - .), (\to - .)
+	.popsection
+	.endm
+
 #define USER(l, x...)				\
 9999:	x;					\
 	.section __ex_table,"a";		\
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index f2d2c0bbe21b..574486634c62 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -28,6 +28,8 @@
 #define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
 #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 
+#define csdb()		asm volatile("hint #20" : : : "memory")
+
 #define mb()		dsb(sy)
 #define rmb()		dsb(ld)
 #define wmb()		dsb(st)
-- 
2.16.2.440.gc6284da
