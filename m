From: will.deacon@arm.com (Will Deacon)
Date: Fri,  9 Sep 2016 12:16:01 +0100
Subject: [PATCH 2/6] arm64: barriers: introduce nops and __nops macros for NOP
 sequences
In-Reply-To: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
References: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
Message-ID: <1473419765-3437-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NOP sequences tend to get used for padding out alternative sections
and uarch-specific pipeline flushes in errata workarounds.

This patch adds macros for generating these sequences as both inline
asm blocks, but also as strings suitable for embedding in other asm
blocks directly.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/assembler.h | 9 +++++++++
 arch/arm64/include/asm/barrier.h   | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index d5025c69ca81..43a75e2fe931 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -87,6 +87,15 @@
 	.endm
 
 /*
+ * NOP sequence
+ */
+	.macro	nops, num
+	.rept	\num
+	nop
+	.endr
+	.endm
+
+/*
  * Emit an entry into the exception table
  */
 	.macro		_asm_extable, from, to
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 4eea7f618dce..4e0497f581a0 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -20,6 +20,9 @@
 
 #ifndef __ASSEMBLY__
 
+#define __nops(n)	".rept	" #n "\nnop\n.endr\n"
+#define nops(n)		asm volatile(__nops(n))
+
 #define sev()		asm volatile("sev" : : : "memory")
 #define wfe()		asm volatile("wfe" : : : "memory")
 #define wfi()		asm volatile("wfi" : : : "memory")
-- 
2.1.4
