From: robherring2@gmail.com (Rob Herring)
Date: Wed,  1 Jun 2011 11:37:50 -0500
Subject: [PATCH 3/3] ARM: l2x0: Add OF based initialization
In-Reply-To: <1306946270-18379-1-git-send-email-robherring2@gmail.com>
References: <1306946270-18379-1-git-send-email-robherring2@gmail.com>
Message-ID: <1306946270-18379-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This adds probing for pl310 cache controller via device tree. An example
binding looks like this:

L2: l2-cache {
	compatible = "arm,pl310-cache", "cache";
	reg = <0xfff12000 0x1000>;
	aux-value = <0>;
	aux-mask = <0xffffffff>;
	cache-unified;
	cache-level = <2>;
};

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    1 +
 arch/arm/mm/cache-l2x0.c                   |   36 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 16bd480..1d36632 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -74,6 +74,7 @@
 
 #ifndef __ASSEMBLY__
 extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
+extern int l2x0_of_init(void);
 #endif
 
 #endif
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index ef59099..6dd521c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -16,9 +16,12 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -344,3 +347,36 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
 			ways, cache_id, aux, l2x0_size);
 }
+
+#ifdef CONFIG_OF
+static struct of_device_id l2x0_ids[] __initdata = {
+	{ .compatible = "arm,pl310-cache" },
+	{ .compatible = "arm,l220-cache" },
+	{ .compatible = "arm,l210-cache" },
+};
+
+int __init l2x0_of_init(void)
+{
+	struct device_node *np;
+	void __iomem *l2_base;
+	__u32 aux_val = 0;
+	__u32 aux_mask = ~0UL;
+	const __be32 *val;
+
+	np = of_find_matching_node(NULL, l2x0_ids);
+	if (!np)
+		return -ENODEV;
+	l2_base = of_iomap(np, 0);
+	if (!l2_base)
+		return -ENOMEM;
+
+	if ((val = of_get_property(np, "aux-value", NULL)) != NULL);
+		aux_val = of_read_ulong(val, 1);
+
+	if ((val = of_get_property(np, "aux-mask", NULL)) != NULL);
+		aux_mask = of_read_ulong(val, 1);
+
+	l2x0_init(l2_base, aux_val, aux_mask);
+	return 0;
+}
+#endif
-- 
1.7.4.1
