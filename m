From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  4 Apr 2014 15:53:19 +0200
Subject: [PATCH v2 07/10] ARM: mvebu: implement Armada 375 coherency workaround
In-Reply-To: <1396619602-4510-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396619602-4510-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1396619602-4510-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The early revisions of Armada 375 SOCs (Z1 stepping) have a bug in the
I/O coherency unit that prevents using the normal method for the I/O
coherency barrier. The recommended workaround is to use a XOR memset
transfer to act as the I/O coherency barrier.

This involves "borrowing" a XOR engine, which gets disabled in the
Device Tree so the normal XOR driver doesn't use it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 168 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 7ccaf87..75db33e 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -17,6 +17,8 @@
  * supplies basic routines for configuring and controlling hardware coherency
  */
 
+#define pr_fmt(fmt) "mvebu-coherency: " fmt
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of_address.h>
@@ -24,6 +26,9 @@
 #include <linux/smp.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/mbus.h>
+#include <linux/clk.h>
 #include <asm/smp_plat.h>
 #include <asm/cacheflush.h>
 #include "armada-370-xp.h"
@@ -66,8 +71,157 @@ int set_cpu_coherent(unsigned int hw_cpu_id, int smp_group_id)
 	return ll_set_cpu_coherent(coherency_base, hw_cpu_id);
 }
 
+/*
+ * The below code implements the I/O coherency workaround on Armada
+ * 375. This workaround consists in using the two channels of the
+ * first XOR engine to trigger a XOR transaction that serves as the
+ * I/O coherency barrier.
+ */
+
+static void __iomem *xor_base, *xor_high_base;
+static dma_addr_t coherency_wa_buf_phys[CONFIG_NR_CPUS];
+static void *coherency_wa_buf[CONFIG_NR_CPUS];
+static bool coherency_wa_enabled;
+
+#define XOR_CONFIG(chan)            (0x10 + (chan * 4))
+#define XOR_ACTIVATION(chan)        (0x20 + (chan * 4))
+#define WINDOW_BAR_ENABLE(chan)     (0x240 + ((chan) << 2))
+#define WINDOW_BASE(w)              (0x250 + ((w) << 2))
+#define WINDOW_SIZE(w)              (0x270 + ((w) << 2))
+#define WINDOW_REMAP_HIGH(w)        (0x290 + ((w) << 2))
+#define WINDOW_OVERRIDE_CTRL(chan)  (0x2A0 + ((chan) << 2))
+#define XOR_DEST_POINTER(chan)      (0x2B0 + (chan * 4))
+#define XOR_BLOCK_SIZE(chan)        (0x2C0 + (chan * 4))
+#define XOR_INIT_VALUE_LOW           0x2E0
+#define XOR_INIT_VALUE_HIGH          0x2E4
+
+static inline void mvebu_hwcc_armada375_sync_io_barrier_wa(void)
+{
+	int idx = smp_processor_id();
+
+	/* Write '1' to the first word of the buffer */
+	writel(0x1, coherency_wa_buf[idx]);
+
+	/* Wait until the engine is idle */
+	while ((readl(xor_base + XOR_ACTIVATION(idx)) >> 4) & 0x3)
+		;
+
+	dmb();
+
+	/* Trigger channel */
+	writel(0x1, xor_base + XOR_ACTIVATION(idx));
+
+	/* Poll the data until it is cleared by the XOR transaction */
+	while (readl(coherency_wa_buf[idx]))
+		;
+}
+
+static void __init armada_375_coherency_init_wa(void)
+{
+	const struct mbus_dram_target_info *dram;
+	struct device_node *xor_node;
+	struct property *xor_status;
+	struct clk *xor_clk;
+	u32 win_enable = 0;
+	int i;
+
+	pr_warn("enabling coherency workaround for Armada 375 Z1, one XOR engine disabled\n");
+
+	/*
+	 * Since the workaround uses one XOR engine, we grab a
+	 * reference to its Device Tree node first.
+	 */
+	xor_node = of_find_compatible_node(NULL, NULL, "marvell,orion-xor");
+	BUG_ON(!xor_node);
+
+	/*
+	 * Then we mark it as disabled so that the real XOR driver
+	 * will not use it.
+	 */
+	xor_status = kzalloc(sizeof(struct property), GFP_KERNEL);
+	BUG_ON(!xor_status);
+
+	xor_status->value = kstrdup("disabled", GFP_KERNEL);
+	BUG_ON(!xor_status->value);
+
+	xor_status->length = 8;
+	xor_status->name = kstrdup("status", GFP_KERNEL);
+	BUG_ON(!xor_status->name);
+
+	of_update_property(xor_node, xor_status);
+
+	/*
+	 * And we remap the registers, get the clock, and do the
+	 * initial configuration of the XOR engine.
+	 */
+	xor_base = of_iomap(xor_node, 0);
+	xor_high_base = of_iomap(xor_node, 1);
+
+	xor_clk = of_clk_get_by_name(xor_node, NULL);
+	BUG_ON(!xor_clk);
+
+	clk_prepare_enable(xor_clk);
+
+	dram = mv_mbus_dram_info();
+
+	for (i = 0; i < 8; i++) {
+		writel(0, xor_base + WINDOW_BASE(i));
+		writel(0, xor_base + WINDOW_SIZE(i));
+		if (i < 4)
+			writel(0, xor_base + WINDOW_REMAP_HIGH(i));
+	}
+
+	for (i = 0; i < dram->num_cs; i++) {
+		const struct mbus_dram_window *cs = dram->cs + i;
+		writel((cs->base & 0xffff0000) |
+		       (cs->mbus_attr << 8) |
+		       dram->mbus_dram_target_id, xor_base + WINDOW_BASE(i));
+		writel((cs->size - 1) & 0xffff0000, xor_base + WINDOW_SIZE(i));
+
+		win_enable |= (1 << i);
+		win_enable |= 3 << (16 + (2 * i));
+	}
+
+	writel(win_enable, xor_base + WINDOW_BAR_ENABLE(0));
+	writel(win_enable, xor_base + WINDOW_BAR_ENABLE(1));
+	writel(0, xor_base + WINDOW_OVERRIDE_CTRL(0));
+	writel(0, xor_base + WINDOW_OVERRIDE_CTRL(1));
+
+	for (i = 0; i < CONFIG_NR_CPUS; i++) {
+		coherency_wa_buf[i] = kzalloc(PAGE_SIZE, GFP_KERNEL);
+		BUG_ON(!coherency_wa_buf[i]);
+
+		/*
+		 * We can't use the DMA mapping API, since we don't
+		 * have a valid 'struct device' pointer
+		 */
+		coherency_wa_buf_phys[i] =
+			virt_to_phys(coherency_wa_buf[i]);
+		BUG_ON(!coherency_wa_buf_phys[i]);
+
+		/*
+		 * Configure the XOR engine for memset operation, with
+		 * a 128 bytes block size
+		 */
+		writel(0x444, xor_base + XOR_CONFIG(i));
+		writel(128, xor_base + XOR_BLOCK_SIZE(i));
+		writel(coherency_wa_buf_phys[i],
+		       xor_base + XOR_DEST_POINTER(i));
+	}
+
+	writel(0x0, xor_base + XOR_INIT_VALUE_LOW);
+	writel(0x0, xor_base + XOR_INIT_VALUE_HIGH);
+
+	coherency_wa_enabled = true;
+}
+
 static inline void mvebu_hwcc_sync_io_barrier(void)
 {
+	if (coherency_wa_enabled) {
+		mvebu_hwcc_armada375_sync_io_barrier_wa();
+		return;
+	}
+
 	writel(0x1, coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET);
 	while (readl(coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET) & 0x1);
 }
@@ -198,9 +352,17 @@ int __init coherency_init(void)
 
 static int __init coherency_late_init(void)
 {
-	if (coherency_available())
-		bus_register_notifier(&platform_bus_type,
-				      &mvebu_hwcc_platform_nb);
+	int type = coherency_type();
+
+	if (type == COHERENCY_FABRIC_TYPE_NONE)
+		return 0;
+
+	if (type == COHERENCY_FABRIC_TYPE_ARMADA_375)
+		armada_375_coherency_init_wa();
+
+	bus_register_notifier(&platform_bus_type,
+			      &mvebu_hwcc_platform_nb);
+
 	return 0;
 }
 
-- 
1.8.3.2
