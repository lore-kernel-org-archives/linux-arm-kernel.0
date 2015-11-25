From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 16:37:50 +0100
Subject: [PATCH 2/7] ARM: make xscale iwmmxt code multiplatform aware
In-Reply-To: <1448465875-435039-1-git-send-email-arnd@arndb.de>
References: <1448465875-435039-1-git-send-email-arnd@arndb.de>
Message-ID: <1448465875-435039-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a multiplatform configuration, we may end up building a kernel for
both Marvell PJ1 and an ARMv4 CPU implementation. In that case, the
xscale-cp0 code is built with gcc -march=armv4{,t}, which results in a
build error from the coprocessor instructions.

Since we know this code will only have to run on an actual xscale
processor, we can simply build the entire file for ARMv5TE.

Related to this, we need to handle the iWMMXT initialization sequence
differently during boot, to ensure we don't try to touch xscale
specific registers on other CPUs from the xscale_cp0_init initcall.
cpu_is_xscale() used to be hardcoded to '1' in any configuration that
enables any XScale-compatible core, but this breaks once we can have a
combined kernel with MMP1 and something else.

In this patch, I replace the existing cpu_is_xscale() macro with a new
cpu_is_xscale_family() macro that evaluates true for xscale, xsc3 and
mohawk, which makes the behavior more deterministic.

The two existing users of cpu_is_xscale() are modified accordingly,
but slightly change behavior for kernels that enable CPU_MOHAWK without
also enabling CPU_XSCALE or CPU_XSC3. Previously, these would leave leave
PMD_BIT4 in the page tables untouched, now they clear it as we've always
done for kernels that enable both MOHAWK and the support for the older
CPU types.

Since the previous behavior was inconsistent, I assume it was
unintentional.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/cputype.h | 22 +++++++++++++++++++---
 arch/arm/kernel/xscale-cp0.c   |  7 +++++++
 arch/arm/mm/idmap.c            |  2 +-
 arch/arm/mm/mmu.c              |  2 +-
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 85e374f873ac..b23c6c81c9ad 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -228,10 +228,26 @@ static inline int cpu_is_xsc3(void)
 }
 #endif
 
-#if !defined(CONFIG_CPU_XSCALE) && !defined(CONFIG_CPU_XSC3)
-#define	cpu_is_xscale()	0
+#if !defined(CONFIG_CPU_XSCALE) && !defined(CONFIG_CPU_XSC3) && \
+    !defined(CONFIG_CPU_MOHAWK)
+#define	cpu_is_xscale_family() 0
 #else
-#define	cpu_is_xscale()	1
+static inline int cpu_is_xscale_family(void)
+{
+	unsigned int id;
+	id = read_cpuid_id() & 0xffffe000;
+
+	switch (id) {
+	case 0x69052000: /* Intel XScale 1 */
+	case 0x69054000: /* Intel XScale 2 */
+	case 0x69056000: /* Intel XScale 3 */
+	case 0x56056000: /* Marvell XScale 3 */
+	case 0x56158000: /* Marvell Mohawk */
+		return 1;
+	}
+
+	return 0;
+}
 #endif
 
 /*
diff --git a/arch/arm/kernel/xscale-cp0.c b/arch/arm/kernel/xscale-cp0.c
index bdbb8853a19b..77a2eef72115 100644
--- a/arch/arm/kernel/xscale-cp0.c
+++ b/arch/arm/kernel/xscale-cp0.c
@@ -15,6 +15,9 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <asm/thread_notify.h>
+#include <asm/cputype.h>
+
+asm("	.arch armv5te\n");
 
 static inline void dsp_save_state(u32 *state)
 {
@@ -152,6 +155,10 @@ static int __init xscale_cp0_init(void)
 {
 	u32 cp_access;
 
+	/* do not attempt to probe iwmmxt on non-xscale family CPUs */
+	if (!cpu_is_xscale_family())
+		return 0;
+
 	cp_access = xscale_cp_access_read() & ~3;
 	xscale_cp_access_write(cp_access | 1);
 
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index e7a81cebbb2e..d65909697165 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -86,7 +86,7 @@ static void identity_mapping_add(pgd_t *pgd, const char *text_start,
 
 	prot |= PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
 
-	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
+	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale_family())
 		prot |= PMD_BIT4;
 
 	pgd += pgd_index(addr);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4867f5daf82c..e0e911ea32e6 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -477,7 +477,7 @@ static void __init build_mem_type_table(void)
 	 * "update-able on write" bit on ARM610).  However, Xscale and
 	 * Xscale3 require this bit to be cleared.
 	 */
-	if (cpu_is_xscale() || cpu_is_xsc3()) {
+	if (cpu_is_xscale_family()) {
 		for (i = 0; i < ARRAY_SIZE(mem_types); i++) {
 			mem_types[i].prot_sect &= ~PMD_BIT4;
 			mem_types[i].prot_l1 &= ~PMD_BIT4;
-- 
2.1.0.rc2
