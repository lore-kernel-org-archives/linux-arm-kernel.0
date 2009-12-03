From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 03 Dec 2009 06:45:46 -0700
Subject: [PATCH 9/9] OMAP clock/hwmod: fix off-by-one errors
In-Reply-To: <20091203134321.16229.87539.stgit@localhost.localdomain>
References: <20091203134321.16229.87539.stgit@localhost.localdomain>
Message-ID: <20091203134544.16229.26195.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix loop bailout off-by-one bugs reported by Juha Lepp?nen
<juha_motorsportcom@luukku.com>.

This second version incorporates comments from Russell King
<linux@arm.linux.org.uk>.  A new macro, 'omap_test_timeout', has
been created, with cleaner code, and existing code has been converted
to use it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Juha Lepp?nen <juha_motorsportcom@luukku.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-omap2/cm.c                 |    7 ++++---
 arch/arm/mach-omap2/omap_hwmod.c         |   13 +++++--------
 arch/arm/mach-omap2/prcm.c               |    5 ++---
 arch/arm/plat-omap/include/plat/common.h |   20 ++++++++++++++++++++
 4 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.c b/arch/arm/mach-omap2/cm.c
index 8eb2dab..58e4a1c 100644
--- a/arch/arm/mach-omap2/cm.c
+++ b/arch/arm/mach-omap2/cm.c
@@ -21,6 +21,8 @@
 
 #include <asm/atomic.h>
 
+#include <plat/common.h>
+
 #include "cm.h"
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
@@ -61,9 +63,8 @@ int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
 	mask = 1 << idlest_shift;
 
 	/* XXX should be OMAP2 CM */
-	while (((cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) != ena) &&
-	       (i++ < MAX_MODULE_READY_TIME))
-		udelay(1);
+	omap_test_timeout(((cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) == ena),
+			  MAX_MODULE_READY_TIME, i);
 
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 633b216..7aaf5f1 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -45,6 +45,7 @@
 #include <linux/mutex.h>
 #include <linux/bootmem.h>
 
+#include <plat/common.h>
 #include <plat/cpu.h>
 #include <plat/clockdomain.h>
 #include <plat/powerdomain.h>
@@ -736,7 +737,7 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 static int _reset(struct omap_hwmod *oh)
 {
 	u32 r, v;
-	int c;
+	int c = 0;
 
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_SOFTRESET) ||
@@ -758,13 +759,9 @@ static int _reset(struct omap_hwmod *oh)
 		return r;
 	_write_sysconfig(v, oh);
 
-	c = 0;
-	while (c < MAX_MODULE_RESET_WAIT &&
-	       !(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
-		 SYSS_RESETDONE_MASK)) {
-		udelay(1);
-		c++;
-	}
+	omap_test_timeout((omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
+			   SYSS_RESETDONE_MASK),
+			  MAX_MODULE_RESET_WAIT, c);
 
 	if (c == MAX_MODULE_RESET_WAIT)
 		WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 9208b6e..79637c2 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -241,9 +241,8 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, const char *name)
 		BUG();
 
 	/* Wait for lock */
-	while (((__raw_readl(reg) & mask) != ena) &&
-	       (i++ < MAX_MODULE_ENABLE_WAIT))
-		udelay(1);
+	omap_test_timeout(((__raw_readl(reg) & mask) == ena),
+			  MAX_MODULE_ENABLE_WAIT, i);
 
 	if (i < MAX_MODULE_ENABLE_WAIT)
 		pr_debug("cm: Module associated with clock %s ready after %d "
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 064f173..e977967 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -71,4 +71,24 @@ void omap2_set_globals_sdrc(struct omap_globals *);
 void omap2_set_globals_control(struct omap_globals *);
 void omap2_set_globals_prcm(struct omap_globals *);
 
+/**
+ * omap_test_timeout - busy-loop, testing a condition
+ * @cond: condition to test until it evaluates to true
+ * @timeout: maximum number of microseconds in the timeout
+ * @index: loop index (integer)
+ *
+ * Loop waiting for @cond to become true or until@least @timeout
+ * microseconds have passed.  To use, define some integer @index in the
+ * calling code.  After running, if @index == @timeout, then the loop has
+ * timed out.
+ */
+#define omap_test_timeout(cond, timeout, index)			\
+({								\
+	for (index = 0; index < timeout; index++) {		\
+		if (cond)					\
+			break;					\
+		udelay(1);					\
+	}							\
+})
+
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
