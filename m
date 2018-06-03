From: Anson.Huang@nxp.com (Anson Huang)
Date: Sun,  3 Jun 2018 10:33:44 +0800
Subject: [PATCH V2 1/3] ARM: imx: add L2 page power control for GPC
Message-ID: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms like i.MX6UL/i.MX6SLL have L2
page power control in GPC, it needs to be
disabled if ARM is power gated and L2 is NOT
flushed, add GPC interface to control it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change since V1.
 arch/arm/mach-imx/common.h |  1 +
 arch/arm/mach-imx/gpc.c    | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index c8d68e9..a2716ec 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -58,6 +58,7 @@ struct device *imx_soc_device_init(void);
 void imx6_enable_rbc(bool enable);
 void imx_gpc_check_dt(void);
 void imx_gpc_set_arm_power_in_lpm(bool power_off);
+void imx_gpc_set_l2_mem_power_in_lpm(bool power_off);
 void imx_gpc_set_arm_power_up_timing(u32 sw2iso, u32 sw);
 void imx_gpc_set_arm_power_down_timing(u32 sw2iso, u32 sw);
 void imx25_pm_init(void);
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index de535cb..e11159d 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -20,6 +20,7 @@
 #include "common.h"
 #include "hardware.h"
 
+#define GPC_CNTR		0x0
 #define GPC_IMR1		0x008
 #define GPC_PGC_CPU_PDN		0x2a0
 #define GPC_PGC_CPU_PUPSCR	0x2a4
@@ -27,6 +28,8 @@
 #define GPC_PGC_SW2ISO_SHIFT	0x8
 #define GPC_PGC_SW_SHIFT	0x0
 
+#define GPC_CNTR_L2_PGE_SHIFT	22
+
 #define IMR_NUM			4
 #define GPC_MAX_IRQS		(IMR_NUM * 32)
 
@@ -51,6 +54,17 @@ void imx_gpc_set_arm_power_in_lpm(bool power_off)
 	writel_relaxed(power_off, gpc_base + GPC_PGC_CPU_PDN);
 }
 
+void imx_gpc_set_l2_mem_power_in_lpm(bool power_off)
+{
+	u32 val;
+
+	val = readl_relaxed(gpc_base + GPC_CNTR);
+	val &= ~(1 << GPC_CNTR_L2_PGE_SHIFT);
+	if (power_off)
+		val |= 1 << GPC_CNTR_L2_PGE_SHIFT;
+	writel_relaxed(val, gpc_base + GPC_CNTR);
+}
+
 void imx_gpc_pre_suspend(bool arm_power_off)
 {
 	void __iomem *reg_imr1 = gpc_base + GPC_IMR1;
-- 
2.7.4
