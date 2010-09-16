From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Sep 2010 18:06:14 +0100
Subject: [PATCH] ARM: vexpress: set RAM latencies to 1 cycle for PL310 on
	ct-ca9x4 tile
Message-ID: <1284656774-6299-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL310 on the ct-ca9x4 tile for the Versatile Express does not need
to add additional latency when accessing memory. Unfortunately, the
boot monitor sets this up for an 8-cycle delay on reads and writes,
resulting in restricted access to the bus for devices accessing memory
via uncached mappings. A symptom of this problem is display corruption
when the CLCD controller cannot read the framebuffer quickly enough
to display at a sensible refresh rate due to traffic from the cache
controller locking the bus.

This patch sets the L2 RAM latencies to the correct value of 1 cycle
on the ct-ca9x4 tile before enabling the L2 cache.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Note that this conflicts with patch 6395/1 but I can resolve the trivial
conflict when submitting to the patch system.

 arch/arm/mach-vexpress/ct-ca9x4.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 577df6c..c8ddbc1 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -227,7 +227,13 @@ static void ct_ca9x4_init(void)
 	int i;
 
 #ifdef CONFIG_CACHE_L2X0
-	l2x0_init(MMIO_P2V(CT_CA9X4_L2CC), 0x00000000, 0xfe0fffff);
+	void __iomem *l2x0_base = MMIO_P2V(CT_CA9X4_L2CC);
+
+	/* set RAM latencies to 1 cycle for this core tile. */
+	writel(0, l2x0_base + L2X0_TAG_LATENCY_CTRL);
+	writel(0, l2x0_base + L2X0_DATA_LATENCY_CTRL);
+
+	l2x0_init(l2x0_base, 0x00000000, 0xfe0fffff);
 #endif
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-- 
1.7.0.4
