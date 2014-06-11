From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 11 Jun 2014 17:30:11 +0200
Subject: [PATCH 4/5] ARM: EXYNOS: Add .write_sec outer cache callback for
 L2C-310
In-Reply-To: <1402500612-4778-1-git-send-email-t.figa@samsung.com>
References: <1402500612-4778-1-git-send-email-t.figa@samsung.com>
Message-ID: <1402500612-4778-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos4 SoCs equipped with an L2C-310 cache controller and running under
secure firmware require certain registers of aforementioned IP to be
accessed only from secure mode. This means that SMC calls are required
for certain register writes. To handle this, an implementation of
.write_sec callback is provided by this patch.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/firmware.c | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index eb91d23..34f7798 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -14,7 +14,9 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+#include <asm/cputype.h>
 #include <asm/firmware.h>
+#include <asm/hardware/cache-l2x0.h>
 
 #include <mach/map.h>
 
@@ -70,6 +72,55 @@ static const struct firmware_ops exynos_firmware_ops = {
 	.cpu_boot		= exynos_cpu_boot,
 };
 
+static void exynos_l2_write_sec(void __iomem *base, unsigned long val,
+				unsigned reg)
+{
+	switch (reg) {
+	case L2X0_CTRL:
+		exynos_smc(SMC_CMD_L2X0CTRL, val, 0, 0);
+		break;
+
+	case L2X0_AUX_CTRL:
+		exynos_smc(SMC_CMD_L2X0SETUP2,
+				readl_relaxed(base + L310_POWER_CTRL),
+				val, 0);
+		break;
+
+	case L2X0_DEBUG_CTRL:
+		exynos_smc(SMC_CMD_L2X0DEBUG, val, 0, 0);
+		break;
+
+	case L310_TAG_LATENCY_CTRL:
+		exynos_smc(SMC_CMD_L2X0SETUP1,
+				val,
+				readl_relaxed(base + L310_DATA_LATENCY_CTRL),
+				readl_relaxed(base + L310_PREFETCH_CTRL));
+		break;
+
+	case L310_DATA_LATENCY_CTRL:
+		exynos_smc(SMC_CMD_L2X0SETUP1,
+				readl_relaxed(base + L310_TAG_LATENCY_CTRL),
+				val,
+				readl_relaxed(base + L310_PREFETCH_CTRL));
+		break;
+
+	case L310_PREFETCH_CTRL:
+		exynos_smc(SMC_CMD_L2X0SETUP1,
+				readl_relaxed(base + L310_TAG_LATENCY_CTRL),
+				readl_relaxed(base + L310_DATA_LATENCY_CTRL),
+				val);
+		break;
+
+	case L310_POWER_CTRL:
+		exynos_smc(SMC_CMD_L2X0SETUP2, val,
+				readl_relaxed(base + L2X0_AUX_CTRL), 0);
+		break;
+
+	default:
+		WARN_ONCE(1, "%s: ignoring write to reg 0x%x\n", __func__, reg);
+	}
+}
+
 void __init exynos_firmware_init(void)
 {
 	struct device_node *nd;
@@ -89,4 +140,14 @@ void __init exynos_firmware_init(void)
 	pr_info("Running under secure firmware.\n");
 
 	register_firmware_ops(&exynos_firmware_ops);
+
+	/*
+	 * Exynos 4 SoCs (based on Cortex A9 and equipped with L2C-310),
+	 * running under secure firmware, require certain registers of L2
+	 * cache controller to be written in secure mode. Here .write_sec
+	 * callback is provided to perform necessary SMC calls.
+	 */
+	if (IS_ENABLED(CONFIG_CACHE_L2X0)
+	    && read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
+		outer_cache.write_sec = exynos_l2_write_sec;
 }
-- 
1.9.3
