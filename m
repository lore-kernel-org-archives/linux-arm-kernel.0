From: geoff@infradead.org (Geoff Levand)
Date: Fri, 04 Mar 2016 23:51:14 +0000
Subject: [PATCH v14 10/20] Revert "arm64: mm: remove unused
 cpu_set_idmap_tcr_t0sz function"
In-Reply-To: <cover.1457135058.git.geoff@infradead.org>
References: <cover.1457135058.git.geoff@infradead.org>
Message-ID: <7cda4b8dd98e3b56c4a565228b7ad7f00e9a4ddd.1457135058.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit c51e97d89e526368eb697f87cd4d391b9e19f369.

Add back the cpu_set_idmap_tcr_t0sz function needed by setup_mmu_for_reboot.
---
 arch/arm64/include/asm/mmu_context.h | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 2416578..7567030 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -70,23 +70,34 @@ static inline bool __cpu_uses_extended_idmap(void)
 		unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS)));
 }
 
+static inline void __cpu_set_tcr_t0sz(u64 t0sz)
+{
+	unsigned long tcr;
+
+	if (__cpu_uses_extended_idmap())
+		asm volatile (
+		"	mrs	%0, tcr_el1	;"
+		"	bfi	%0, %1, %2, %3	;"
+		"	msr	tcr_el1, %0	;"
+		"	isb"
+		: "=&r" (tcr)
+		: "r"(t0sz), "I"(TCR_T0SZ_OFFSET), "I"(TCR_TxSZ_WIDTH));
+}
+
+/*
+ * Set TCR.T0SZ to the value appropriate for activating the identity map.
+ */
+static inline void cpu_set_idmap_tcr_t0sz(void)
+{
+	__cpu_set_tcr_t0sz(idmap_t0sz);
+}
+
 /*
  * Set TCR.T0SZ to its default value (based on VA_BITS)
  */
 static inline void cpu_set_default_tcr_t0sz(void)
 {
-	unsigned long tcr;
-
-	if (!__cpu_uses_extended_idmap())
-		return;
-
-	asm volatile (
-	"	mrs	%0, tcr_el1	;"
-	"	bfi	%0, %1, %2, %3	;"
-	"	msr	tcr_el1, %0	;"
-	"	isb"
-	: "=&r" (tcr)
-	: "r"(TCR_T0SZ(VA_BITS)), "I"(TCR_T0SZ_OFFSET), "I"(TCR_TxSZ_WIDTH));
+	__cpu_set_tcr_t0sz(TCR_T0SZ(VA_BITS));
 }
 
 /*
-- 
2.5.0
