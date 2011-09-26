From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 26 Sep 2011 15:32:40 +0100
Subject: [RFC PATCH 2/3] ARM: mm: add l2x0 physical address parameter to init
In-Reply-To: <1317047561-11020-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1317047561-11020-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1317047561-11020-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch redefines the l2x0_init function, and it adds a
parameter defining the L2 physical base address in preparation
for L2 resume support. The device tree init code retrieves the
physical address from the "reg" array and converts it to a
physical address pointer.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    3 ++-
 arch/arm/mm/cache-l2x0.c                   |   12 ++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index c48cb1e..54bf625 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -94,7 +94,8 @@
 #define L2X0_ADDR_FILTER_EN		1
 
 #ifndef __ASSEMBLY__
-extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
+extern void __init l2x0_init(void __iomem *base, void __iomem *pbase,
+		__u32 aux_val, __u32 aux_mask);
 extern int l2x0_of_init(__u32 aux_val, __u32 aux_mask);
 #endif
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 0d85d22..46a507a 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -299,7 +299,8 @@ static void __init l2x0_unlock(__u32 cache_id)
 	}
 }
 
-void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
+void __init l2x0_init(void __iomem *base, void __iomem *pbase,
+			__u32 aux_val, __u32 aux_mask)
 {
 	__u32 aux;
 	__u32 cache_id;
@@ -455,6 +456,9 @@ static const struct of_device_id l2x0_ids[] __initconst = {
 int __init l2x0_of_init(__u32 aux_val, __u32 aux_mask)
 {
 	struct device_node *np;
+	u32 reg[2];
+	int ret;
+
 	void (*l2_setup)(const struct device_node *np,
 		__u32 *aux_val, __u32 *aux_mask);
 
@@ -465,13 +469,17 @@ int __init l2x0_of_init(__u32 aux_val, __u32 aux_mask)
 	if (!l2x0_base)
 		return -ENOMEM;
 
+	ret = of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
+	if (ret < 0)
+		return ret;
+
 	/* L2 configuration can only be changed if the cache is disabled */
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
 		l2_setup = of_match_node(l2x0_ids, np)->data;
 		if (l2_setup)
 			l2_setup(np, &aux_val, &aux_mask);
 	}
-	l2x0_init(l2x0_base, aux_val, aux_mask);
+	l2x0_init(l2x0_base, (void __iomem *)reg[0], aux_val, aux_mask);
 	return 0;
 }
 #endif
-- 
1.7.4.4
