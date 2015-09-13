From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 13 Sep 2015 12:14:31 +0100
Subject: [PATCH 1/3] irqchip/GIC: Add workaround for aliased GIC400
In-Reply-To: <1442142873-20213-1-git-send-email-marc.zyngier@arm.com>
References: <1442142873-20213-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1442142873-20213-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GICv2 architecture mandates that the two 4kB GIC regions are
contiguous, and on two separate physical pages (so that access to
the second page can be trapped by a hypervisor). This doesn't work
very well when PAGE_SIZE is 64kB.

A relatively common hack^Wway to work around this is to alias each
4kB region over its own 64kB page. Of course in this case, the base
address you want to use is not really the begining of the region,
but base + 60kB (so that you get a contiguous 8kB region over two
distinct pages).

Normally, this would be described in DT with a new property, but
some HW is already out there, and the firmware makes sure that
it will override whatever you put in the GIC node. Duh. And of course,
said firmware source code is not available, despite being based
on u-boot.

The workaround is to detect the case where the CPU interface size
is set to 128kB, and verify the aliasing by checking that the ID
register for GIC400 (which is the only GIC wired this way so far)
is the same at base and base + 0xF000. In this case, we update
the GIC base address and let it roll.

And if you feel slightly sick by looking at this, rest assured that
I do too...

Reported-by: Julien Grall <julien.grall@citrix.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index e6b7ed5..a947057 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1119,12 +1119,49 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 #ifdef CONFIG_OF
 static int gic_cnt __initdata;
 
+static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
+{
+	struct resource cpuif_res;
+
+	of_address_to_resource(node, 1, &cpuif_res);
+
+	if (!is_hyp_mode_available())
+		return false;
+	if (resource_size(&cpuif_res) < SZ_8K)
+		return false;
+	if (resource_size(&cpuif_res) == SZ_128K) {
+		u32 val_low, val_high;
+
+		/*
+		 * Verify that we have the first 4kB of a GIC400
+		 * aliased over the first 64kB by checking the
+		 * GICC_IIDR register on both ends.
+		 */
+		val_low = readl_relaxed(*base + GIC_CPU_IDENT);
+		val_high = readl_relaxed(*base + GIC_CPU_IDENT + 0xf000);
+		if ((val_low & 0xffff0fff) != 0x0202043B ||
+		    val_low != val_high)
+			return false;
+
+		/*
+		 * Move the base up by 60kB, so that we have a 8kB
+		 * contiguous region, which allows us to use GICC_DIR
+		 *@its normal offset. Please pass me that bucket.
+		 */
+		*base += 0xf000;
+		cpuif_res.start += 0xf000;
+		pr_warn("GIC: Adjusting CPU interface base to %pa",
+			&cpuif_res.start);
+	}
+
+	return true;
+}
+
 static int __init
 gic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *cpu_base;
 	void __iomem *dist_base;
-	struct resource cpu_res;
 	u32 percpu_offset;
 	int irq;
 
@@ -1137,14 +1174,11 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	cpu_base = of_iomap(node, 1);
 	WARN(!cpu_base, "unable to map gic cpu registers\n");
 
-	of_address_to_resource(node, 1, &cpu_res);
-
 	/*
 	 * Disable split EOI/Deactivate if either HYP is not available
 	 * or the CPU interface is too small.
 	 */
-	if (gic_cnt == 0 && (!is_hyp_mode_available() ||
-			     resource_size(&cpu_res) < SZ_8K))
+	if (gic_cnt == 0 && !gic_check_eoimode(node, &cpu_base))
 		static_key_slow_dec(&supports_deactivate);
 
 	if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
-- 
2.1.4
