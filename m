From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  5 Aug 2014 11:25:56 +0200
Subject: [PATCH v2 2/3] arm64: add helper functions to read I-cache attributes
In-Reply-To: <1407230757-15305-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1407230757-15305-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1407230757-15305-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds helper functions and #defines to <asm/cachetype.h> to read the
line size and the number of sets from the level 1 instruction cache.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v2: put () around macro args, use 64-bit types for asm() mrs/msr calls

 arch/arm64/include/asm/cachetype.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
index 7a2e0762cb40..e59c0c25b307 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -39,6 +39,34 @@
 
 extern unsigned long __icache_flags;
 
+#define CCSIDR_EL1_LINESIZE_MASK	0x7
+#define CCSIDR_EL1_LINESIZE(x)		((x) & CCSIDR_EL1_LINESIZE_MASK)
+
+#define CCSIDR_EL1_NUMSETS_SHIFT	13
+#define CCSIDR_EL1_NUMSETS_MASK		(0x7fff << CCSIDR_EL1_NUMSETS_SHIFT)
+#define CCSIDR_EL1_NUMSETS(x) \
+	(((x) & CCSIDR_EL1_NUMSETS_MASK) >> CCSIDR_EL1_NUMSETS_SHIFT)
+
+static inline __attribute_const__ u64 icache_get_ccsidr(void)
+{
+	u64 ccsidr;
+
+	/* Select L1 I-cache and read its size ID register */
+	asm("msr csselr_el1, %1; isb; mrs %0, ccsidr_el1"
+	    : "=r"(ccsidr) : "r"(1L));
+	return ccsidr;
+}
+
+static inline int icache_get_linesize(void)
+{
+	return 16 << CCSIDR_EL1_LINESIZE(icache_get_ccsidr());
+}
+
+static inline int icache_get_numsets(void)
+{
+	return 1 + CCSIDR_EL1_NUMSETS(icache_get_ccsidr());
+}
+
 /*
  * Whilst the D-side always behaves as PIPT on AArch64, aliasing is
  * permitted in the I-cache.
-- 
1.8.3.2
