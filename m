From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 28 Feb 2017 07:35:35 +0100
Subject: [PATCH v3 25/25] ARM: owl: smp: Reimplement SPS power-gating for CPU2
 and CPU3
In-Reply-To: <20170228063535.32069-1-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
Message-ID: <20170228063535.32069-26-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bring up the two remaining CPUs.

Based on LeMaker linux-actions tree.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3: new
 
 arch/arm/mach-actions/platsmp.c | 67 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index 9d3601e..45b4bc5 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -28,7 +28,15 @@
 
 #define OWL_CPUx_FLAG_BOOT	0x55aa
 
+#define OWL_SPS_PG_CTL	0x0
+
+#define OWL_SPS_PG_CTL_PWR_CPU2	BIT(5)
+#define OWL_SPS_PG_CTL_PWR_CPU3	BIT(6)
+#define OWL_SPS_PG_CTL_ACK_CPU2	BIT(21)
+#define OWL_SPS_PG_CTL_ACK_CPU3	BIT(22)
+
 static void __iomem *scu_base_addr;
+static void __iomem *sps_base_addr;
 static void __iomem *timer_base_addr;
 static int ncores;
 
@@ -42,6 +50,39 @@ static void write_pen_release(int val)
 	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
 }
 
+/* The generic PM domain driver is not available this early. */
+static int owl_sps_set_pg(u32 pwr_mask, u32 ack_mask, bool enable)
+{
+	u32 val;
+	bool ack;
+	int timeout;
+
+	val = readl(sps_base_addr + OWL_SPS_PG_CTL);
+	ack = val & ack_mask;
+	if (ack == enable)
+		return 0;
+
+	if (enable)
+		val |= pwr_mask;
+	else
+		val &= ~pwr_mask;
+
+	writel(val, sps_base_addr + OWL_SPS_PG_CTL);
+
+	for (timeout = 5000; timeout > 0; timeout -= 50) {
+		val = readl(sps_base_addr + OWL_SPS_PG_CTL);
+		if ((val & ack_mask) == (enable ? ack_mask : 0))
+			break;
+		udelay(50);
+	}
+	if (timeout <= 0)
+		return -ETIMEDOUT;
+
+	udelay(10);
+
+	return 0;
+}
+
 static void s500_smp_secondary_init(unsigned int cpu)
 {
 	/*
@@ -58,14 +99,24 @@ void owl_secondary_startup(void);
 
 static int s500_wakeup_secondary(unsigned int cpu)
 {
+	int ret;
+
 	if (cpu > 3)
 		return -EINVAL;
 
 	switch (cpu) {
 	case 2:
+		ret = owl_sps_set_pg(OWL_SPS_PG_CTL_PWR_CPU2,
+				     OWL_SPS_PG_CTL_ACK_CPU2, true);
+		if (ret)
+			return ret;
+		break;
 	case 3:
-		/* CPU2/3 are power-gated */
-		return -EINVAL;
+		ret = owl_sps_set_pg(OWL_SPS_PG_CTL_PWR_CPU3,
+				     OWL_SPS_PG_CTL_ACK_CPU3, true);
+		if (ret)
+			return ret;
+		break;
 	}
 
 	/* wait for CPUx to run to WFE instruction */
@@ -133,6 +184,18 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 		return;
 	}
 
+	node = of_find_compatible_node(NULL, NULL, "actions,s500-sps");
+	if (!node) {
+		pr_err("%s: missing sps\n", __func__);
+		return;
+	}
+
+	sps_base_addr = of_iomap(node, 0);
+	if (!sps_base_addr) {
+		pr_err("%s: could not map sps registers\n", __func__);
+		return;
+	}
+
 	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
 		node = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 		if (!node) {
-- 
2.10.2
