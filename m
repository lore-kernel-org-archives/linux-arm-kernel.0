From: robherring2@gmail.com (Rob Herring)
Date: Mon, 17 Sep 2012 08:59:58 -0500
Subject: [PATCH v2] ARM: l2x0: make background cache ops optional for clean
 and flush range
In-Reply-To: <1347306334-781-1-git-send-email-robherring2@gmail.com>
References: <1347306334-781-1-git-send-email-robherring2@gmail.com>
Message-ID: <1347890398-22088-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

All but background ops are atomic on the pl310, so a spinlock is not
needed for a cache sync if background operations are not used. Using
background ops was an optimization for flushing large buffers, but that's
not needed for platforms where i/o is coherent and/or that have a larger
cache size than likely to flush at once. The cache sync spinlock is
taken on every readl/writel and can be a bottleneck for code paths with
register accesses.

The default behaviour is unchanged. Platforms can enable using atomic
cache ops only by adding "arm,use-atomic-ops" to pl310 device-tree
node.

It is assumed that remaining background ops are only used in non-SMP
code paths.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/devicetree/bindings/arm/l2cc.txt |    3 +++
 arch/arm/mm/cache-l2x0.c                       |   18 +++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index 7ca5216..907c066 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -29,6 +29,9 @@ Optional properties:
   filter. Addresses in the filter window are directed to the M1 port. Other
   addresses will go to the M0 port.
 - interrupts : 1 combined interrupt.
+- arm,use-atomic-ops : If present only use atomic cache flush operations and
+  don't use background operations except for non-SMP safe locations (boot and
+  shutdown).
 
 Example:
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 2a8e380..e3b2ac2 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -33,6 +33,7 @@ static DEFINE_RAW_SPINLOCK(l2x0_lock);
 static u32 l2x0_way_mask;	/* Bitmask of active ways */
 static u32 l2x0_size;
 static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
+static bool use_background_ops = true;
 
 struct l2x0_regs l2x0_saved_regs;
 
@@ -130,6 +131,11 @@ static void l2x0_cache_sync(void)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+static void l2x0_cache_sync_nolock(void)
+{
+	cache_sync();
+}
+
 static void __l2x0_flush_all(void)
 {
 	debug_writel(0x03);
@@ -219,7 +225,7 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
-	if ((end - start) >= l2x0_size) {
+	if (use_background_ops && ((end - start) >= l2x0_size)) {
 		l2x0_clean_all();
 		return;
 	}
@@ -249,7 +255,7 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
-	if ((end - start) >= l2x0_size) {
+	if (use_background_ops && ((end - start) >= l2x0_size)) {
 		l2x0_flush_all();
 		return;
 	}
@@ -379,7 +385,8 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 	outer_cache.inv_range = l2x0_inv_range;
 	outer_cache.clean_range = l2x0_clean_range;
 	outer_cache.flush_range = l2x0_flush_range;
-	outer_cache.sync = l2x0_cache_sync;
+	if (!outer_cache.sync)
+		outer_cache.sync = l2x0_cache_sync;
 	outer_cache.flush_all = l2x0_flush_all;
 	outer_cache.inv_all = l2x0_inv_all;
 	outer_cache.disable = l2x0_disable;
@@ -456,6 +463,11 @@ static void __init pl310_of_setup(const struct device_node *np,
 		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L2X0_ADDR_FILTER_EN,
 			       l2x0_base + L2X0_ADDR_FILTER_START);
 	}
+
+	if (of_property_read_bool(np, "arm,use-atomic-ops")) {
+		use_background_ops = false;
+		outer_cache.sync = l2x0_cache_sync_nolock;
+	}
 }
 
 static void __init pl310_save(void)
-- 
1.7.9.5
