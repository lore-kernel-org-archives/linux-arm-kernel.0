From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 24 Mar 2014 17:17:51 +0100
Subject: [PATCH 2/3] ARM: mm: add support for HW coherent systems in PL310
In-Reply-To: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1395677872-32741-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a PL310 cache is used on a system that provides hardware
coherency, the outer cache sync operation is useless, and can be
skipped. Moreover, on some systems, it is harmful as it causes
deadlocks between the Marvell coherency mechanism, the Marvell PCIe
controller and the Cortex-A9.

This commit adds a new l2x0_of_init_coherent() variant of
l2x0_of_init(), which allows the caller to tell the L2 cache
initialization that the system has hardware coherency support enabled,
and that therefore the outer cache sync operation can be skipped if
possible.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |  1 +
 arch/arm/mm/cache-l2x0.c                   | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 6795ff7..d7db409 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -110,6 +110,7 @@
 extern void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask);
 #if defined(CONFIG_CACHE_L2X0) && defined(CONFIG_OF)
 extern int l2x0_of_init(u32 aux_val, u32 aux_mask);
+extern int l2x0_of_init_coherent(u32 aux_val, u32 aux_mask);
 #else
 static inline int l2x0_of_init(u32 aux_val, u32 aux_mask)
 {
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 7abde2c..76ec012 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -968,7 +968,7 @@ static const struct of_device_id l2x0_ids[] __initconst = {
 	{}
 };
 
-int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
+int __init l2x0_of_init_common(u32 aux_val, u32 aux_mask, bool is_coherent)
 {
 	struct device_node *np;
 	const struct l2x0_of_data *data;
@@ -1005,8 +1005,28 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 
 	of_init = true;
 	memcpy(&outer_cache, &data->outer_cache, sizeof(outer_cache));
+
+	/*
+	 * PL310 doesn't need an outer cache sync operation when the
+	 * system is operating with hardware coherency enabled, as it
+	 * is done directly in hardware.
+	 */
+	if (of_device_is_compatible(np, "arm,pl310-cache") && is_coherent)
+		outer_cache.sync = NULL;
+
 	l2x0_init(l2x0_base, aux_val, aux_mask);
 
 	return 0;
 }
+
+int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
+{
+	return l2x0_of_init_common(aux_val, aux_mask, false);
+}
+
+int __init l2x0_of_init_coherent(u32 aux_val, u32 aux_mask)
+{
+	return l2x0_of_init_common(aux_val, aux_mask, true);
+}
+
 #endif
-- 
1.8.3.2
