From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 17 May 2017 15:18:50 +0100
Subject: [RFC PATCH 2/7] ARM: NOMMU: Update MPU accessors to use cp15 helpers
In-Reply-To: <1495030735-22078-1-git-send-email-vladimir.murzin@arm.com>
References: <1495030735-22078-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1495030735-22078-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, inline assembly for accessing to MPU's cp15 lacks volatile
keyword which opens possibility to compiler to optimise such accesses
as soon as we start using them more intensively. Rather than fixing
inline asm, lets move MPU accessors to use cp15 helpers which do the
right thing.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/pmsa-v7.c | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
index ee3cf51..5b55f8f 100644
--- a/arch/arm/mm/pmsa-v7.c
+++ b/arch/arm/mm/pmsa-v7.c
@@ -12,63 +12,67 @@
 
 #include "mm.h"
 
+#define DRBAR	__ACCESS_CP15(c6, 0, c1, 0)
+#define IRBAR	__ACCESS_CP15(c6, 0, c1, 1)
+#define DRSR	__ACCESS_CP15(c6, 0, c1, 2)
+#define IRSR	__ACCESS_CP15(c6, 0, c1, 3)
+#define DRACR	__ACCESS_CP15(c6, 0, c1, 4)
+#define IRACR	__ACCESS_CP15(c6, 0, c1, 5)
+#define RNGNR	__ACCESS_CP15(c6, 0, c2, 0)
+
 /* Region number */
-static void rgnr_write(u32 v)
+static inline void rgnr_write(u32 v)
 {
-	asm("mcr        p15, 0, %0, c6, c2, 0" : : "r" (v));
+	write_sysreg(v, RNGNR);
 }
 
 /* Data-side / unified region attributes */
 
 /* Region access control register */
-static void dracr_write(u32 v)
+static inline void dracr_write(u32 v)
 {
-	asm("mcr        p15, 0, %0, c6, c1, 4" : : "r" (v));
+	write_sysreg(v, DRACR);
 }
 
 /* Region size register */
-static void drsr_write(u32 v)
+static inline void drsr_write(u32 v)
 {
-	asm("mcr        p15, 0, %0, c6, c1, 2" : : "r" (v));
+	write_sysreg(v, DRSR);
 }
 
 /* Region base address register */
-static void drbar_write(u32 v)
+static inline void drbar_write(u32 v)
 {
-	asm("mcr        p15, 0, %0, c6, c1, 0" : : "r" (v));
+	write_sysreg(v, DRBAR);
 }
 
-static u32 drbar_read(void)
+static inline u32 drbar_read(void)
 {
-	u32 v;
-	asm("mrc        p15, 0, %0, c6, c1, 0" : "=r" (v));
-	return v;
+	return read_sysreg(DRBAR);
 }
 /* Optional instruction-side region attributes */
 
 /* I-side Region access control register */
-static void iracr_write(u32 v)
+static inline void iracr_write(u32 v)
 {
-	asm("mcr        p15, 0, %0, c6, c1, 5" : : "r" (v));
+	write_sysreg(v, IRACR);
 }
 
 /* I-side Region size register */
-static void irsr_write(u32 v)
+static inline void irsr_write(u32 v)
 {
-	asm("mcr        p15, 0, %0, c6, c1, 3" : : "r" (v));
+	write_sysreg(v, IRSR);
 }
 
 /* I-side Region base address register */
-static void irbar_write(u32 v)
+static inline void irbar_write(u32 v)
 {
-	asm("mcr        p15, 0, %0, c6, c1, 1" : : "r" (v));
+	write_sysreg(v, IRBAR);
 }
 
-static unsigned long irbar_read(void)
+static inline u32 irbar_read(void)
 {
-	unsigned long v;
-	asm("mrc        p15, 0, %0, c6, c1, 1" : "=r" (v));
-	return v;
+	return read_sysreg(IRBAR);
 }
 
 /* MPU initialisation functions */
-- 
2.0.0
