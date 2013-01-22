From: Barry.Song@csr.com (Barry Song)
Date: Tue, 22 Jan 2013 20:20:40 +0800
Subject: [PATCH v3 3/9] ARM: PRIMA2: initialize l2x0 according to mach from DT
In-Reply-To: <1358857241-10052-1-git-send-email-Barry.Song@csr.com>
References: <1358857241-10052-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1358857241-10052-3-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

prima2 and marco have diffetent l2 cache configuration, so
we initialize l2x0 cache based on dtb given to kernel.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/mach-prima2/l2x0.c |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
index c998377..cbcbe9c 100644
--- a/arch/arm/mach-prima2/l2x0.c
+++ b/arch/arm/mach-prima2/l2x0.c
@@ -11,19 +11,38 @@
 #include <linux/of.h>
 #include <asm/hardware/cache-l2x0.h>
 
-static struct of_device_id prima2_l2x0_ids[]  = {
-	{ .compatible = "sirf,prima2-pl310-cache" },
+struct l2x0_aux
+{
+	u32 val;
+	u32 mask;
+};
+
+static struct l2x0_aux prima2_l2x0_aux __initconst = {
+	.val = 2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT,
+	.mask =	0,
+};
+
+static struct l2x0_aux marco_l2x0_aux __initconst = {
+	.val = (2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
+		(1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT),
+	.mask = L2X0_AUX_CTRL_MASK,
+};
+
+static struct of_device_id sirf_l2x0_ids[] __initconst = {
+	{ .compatible = "sirf,prima2-pl310-cache", .data = &prima2_l2x0_aux, },
+	{ .compatible = "sirf,marco-pl310-cache", .data = &marco_l2x0_aux, },
 	{},
 };
 
 static int __init sirfsoc_l2x0_init(void)
 {
 	struct device_node *np;
+	const struct l2x0_aux *aux;
 
-	np = of_find_matching_node(NULL, prima2_l2x0_ids);
+	np = of_find_matching_node(NULL, sirf_l2x0_ids);
 	if (np) {
-		pr_info("Initializing prima2 L2 cache\n");
-		return l2x0_of_init(0x40000, 0);
+		aux = of_match_node(sirf_l2x0_ids, np)->data;
+		return l2x0_of_init(aux->val, aux->mask);
 	}
 
 	return 0;
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
