From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Apr 2013 22:30:42 +0800
Subject: [PATCH 1/2] ARM: add diagnostic register access helpers
Message-ID: <1366122643-1961-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CP15 diagnostic register holds many ARM errata bits.  Add a pair of
access helpers for it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/include/asm/cp15.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index 5ef4d80..0b14dfb 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -82,6 +82,19 @@ static inline void set_copro_access(unsigned int val)
 	isb();
 }
 
+static inline unsigned int get_diag_reg(void)
+{
+	unsigned int val;
+	asm("mrc p15, 0, %0, c15, c0, 1" : "=r" (val) : : "cc");
+	return val;
+}
+
+static inline void set_diag_reg(unsigned int val)
+{
+	asm volatile("mcr p15, 0, %0, c15, c0, 1" : : "r" (val) : "cc");
+	isb();
+}
+
 #endif
 
 #endif
-- 
1.7.9.5
