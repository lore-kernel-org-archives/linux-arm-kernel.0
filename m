From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:20:34 +0000
Subject: [PATCH 72/75] ARM: l2c: trial at enabling some Cortex-A9 optimisations
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYaA-0007Hp-Ki@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |  8 +++++
 arch/arm/mm/cache-l2x0.c                   | 51 ++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 3f2a9987b96c..c47ac8f3b12e 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -134,6 +134,14 @@
 
 #define L310_ADDR_FILTER_EN		1
 
+#define L310_PREFETCH_CTRL_OFFSET_MASK		0x1f
+#define L310_PREFETCH_CTRL_DBL_LINEFILL_INCR	BIT(23)
+#define L310_PREFETCH_CTRL_PREFETCH_DROP	BIT(24)
+#define L310_PREFETCH_CTRL_DBL_LINEFILL_WRAP	BIT(27)
+#define L310_PREFETCH_CTRL_DATA_PREFETCH	BIT(28)
+#define L310_PREFETCH_CTRL_INSTR_PREFETCH	BIT(29)
+#define L310_PREFETCH_CTRL_DBL_LINEFILL		BIT(30)
+
 #define L2X0_CTRL_EN			1
 
 #define L2X0_WAY_SIZE_SHIFT		3
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c1750f1bf572..49155da7a8c4 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -16,14 +16,17 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
+#include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/smp.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cp15.h>
 #include <asm/cputype.h>
 #include <asm/hardware/cache-l2x0.h>
 #include "cache-tauros3.h"
@@ -691,6 +694,19 @@ static void l2c310_resume(void)
 	}
 }
 
+static int l2c310_cpu_enable_flz(struct notifier_block *nb, unsigned long act, void *data)
+{
+	switch (act & ~CPU_TASKS_FROZEN) {
+	case CPU_STARTING:
+		set_auxcr(get_auxcr() | BIT(3) | BIT(2) | BIT(1));
+		break;
+	case CPU_DYING:
+		set_auxcr(get_auxcr() & ~(BIT(3) | BIT(2) | BIT(1)));
+		break;
+	}
+	return NOTIFY_OK;
+}
+
 static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
 {
 	unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_PART_MASK;
@@ -706,7 +722,42 @@ static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
 		}
 	}
 
+	if (cortex_a9) {
+		u32 aux_cur = readl_relaxed(base + L2X0_AUX_CTRL);
+		u32 acr = get_auxcr();
+
+		pr_debug("Cortex-A9 ACR=0x%08x\n", acr);
+
+		if (acr & BIT(3) && !(aux_cur & L310_AUX_CTRL_FULL_LINE_ZERO))
+			pr_err("L2C-310: full line of zeros enabled in Cortex-A9 but not L2C-310 - invalid\n");
+
+		if (aux & L310_AUX_CTRL_FULL_LINE_ZERO && !(acr & BIT(3)))
+			pr_err("L2C-310: enabling full line of zeros but not enabled in Cortex-A9\n");
+
+		if (!(aux & L310_AUX_CTRL_FULL_LINE_ZERO) && !outer_cache.write_sec) {
+			aux |= L310_AUX_CTRL_FULL_LINE_ZERO;
+			pr_info("L2C-310 full line of zeros enabled for Cortex-A9\n");
+		}
+	} else if (aux & (L310_AUX_CTRL_FULL_LINE_ZERO | L310_AUX_CTRL_EARLY_BRESP)) {
+		pr_err("L2C-310: disabling Cortex-A9 specific feature bits\n");
+		aux &= ~(L310_AUX_CTRL_FULL_LINE_ZERO | L310_AUX_CTRL_EARLY_BRESP);
+	}
+
+	if (aux & (L310_AUX_CTRL_DATA_PREFETCH | L310_AUX_CTRL_INSTR_PREFETCH)) {
+		u32 prefetch = readl_relaxed(base + L310_PREFETCH_CTRL);
+
+		pr_info("L2C-310 %s%s prefetch enabled, offset %u lines\n",
+			aux & L310_AUX_CTRL_INSTR_PREFETCH ? "I" : "",
+			aux & L310_AUX_CTRL_DATA_PREFETCH ? "D" : "",
+			1 + (prefetch & L310_PREFETCH_CTRL_OFFSET_MASK));
+	}
+
 	l2c_enable(base, aux, num_lock);
+
+	if (aux & L310_AUX_CTRL_FULL_LINE_ZERO) {
+		set_auxcr(get_auxcr() | BIT(3) | BIT(2) | BIT(1));
+		cpu_notifier(l2c310_cpu_enable_flz, 0);
+	}
 }
 
 static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
-- 
1.8.3.1
