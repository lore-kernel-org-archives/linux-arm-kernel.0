From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:26 +0200
Subject: [PATCH v4 28/28] ARM: owl: smp: Implement SPS power-gating for CPU2
 and CPU3
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-29-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bring up the two remaining CPUs by calling into PM domain code.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4:
 * Reused PM domain helper code to avoid code duplication
 
 v3: new
 
 arch/arm/mach-actions/Kconfig   |  1 +
 arch/arm/mach-actions/platsmp.c | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-actions/Kconfig b/arch/arm/mach-actions/Kconfig
index 717adc1630a1..ad9c5c89c683 100644
--- a/arch/arm/mach-actions/Kconfig
+++ b/arch/arm/mach-actions/Kconfig
@@ -10,6 +10,7 @@ menuconfig ARCH_ACTIONS
 	select GENERIC_IRQ_CHIP
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
+	select OWL_PM_DOMAINS_HELPER
 	select OWL_TIMER
 	help
 	  This enables support for the Actions Semiconductor S500 SoC family.
diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index 9d3601ebe535..b4806ce0e9bb 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/smp.h>
+#include <linux/soc/actions/owl-sps.h>
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
@@ -28,7 +29,13 @@
 
 #define OWL_CPUx_FLAG_BOOT	0x55aa
 
+#define OWL_SPS_PG_CTL_PWR_CPU2	BIT(5)
+#define OWL_SPS_PG_CTL_PWR_CPU3	BIT(6)
+#define OWL_SPS_PG_CTL_ACK_CPU2	BIT(21)
+#define OWL_SPS_PG_CTL_ACK_CPU3	BIT(22)
+
 static void __iomem *scu_base_addr;
+static void __iomem *sps_base_addr;
 static void __iomem *timer_base_addr;
 static int ncores;
 
@@ -58,14 +65,27 @@ void owl_secondary_startup(void);
 
 static int s500_wakeup_secondary(unsigned int cpu)
 {
+	int ret;
+
 	if (cpu > 3)
 		return -EINVAL;
 
+	/* The generic PM domain driver is not available this early. */
 	switch (cpu) {
 	case 2:
+		ret = owl_sps_set_pg(sps_base_addr,
+		                     OWL_SPS_PG_CTL_PWR_CPU2,
+				     OWL_SPS_PG_CTL_ACK_CPU2, true);
+		if (ret)
+			return ret;
+		break;
 	case 3:
-		/* CPU2/3 are power-gated */
-		return -EINVAL;
+		ret = owl_sps_set_pg(sps_base_addr,
+		                     OWL_SPS_PG_CTL_PWR_CPU3,
+				     OWL_SPS_PG_CTL_ACK_CPU3, true);
+		if (ret)
+			return ret;
+		break;
 	}
 
 	/* wait for CPUx to run to WFE instruction */
@@ -133,6 +153,18 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
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
2.12.3
