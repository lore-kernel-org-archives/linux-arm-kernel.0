From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Mar 2013 17:40:55 +0530
Subject: [PATCH 06/15] ARM: OMAP5: PM: Enable Mercury retention mode on CPUx
 powerdomains
In-Reply-To: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1362139864-9233-7-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In addition to the standard power-management technique, the OMAP5
MPU subsystem also employs an SR3-APG (mercury) power management
technology to reduce leakage.

It allows for full logic and memories retention on MPU_C0 and MPU_C1 and
is controlled by the PRCM_MPU.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index bcd2efb..9fda96b 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -360,6 +360,20 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 
 
 /*
+ * Enable Mercury Fast HG retention mode by default.
+ */
+static void enable_mercury_retention_mode(void)
+{
+	u32 reg;
+
+	reg = omap4_prcm_mpu_read_inst_reg(OMAP54XX_PRCM_MPU_DEVICE_INST,
+			OMAP54XX_PRCM_MPU_PRM_PSCON_COUNT_OFFSET);
+	reg |= BIT(24) | BIT(25);
+	omap4_prcm_mpu_write_inst_reg(reg, OMAP54XX_PRCM_MPU_DEVICE_INST,
+			OMAP54XX_PRCM_MPU_PRM_PSCON_COUNT_OFFSET);
+}
+
+/*
  * Initialise OMAP4 MPUSS
  */
 int __init omap4_mpuss_init(void)
@@ -438,6 +452,9 @@ int __init omap4_mpuss_init(void)
 		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
 	}
 
+	if (soc_is_omap54xx())
+		enable_mercury_retention_mode();
+
 	return 0;
 }
 
-- 
1.7.9.5
