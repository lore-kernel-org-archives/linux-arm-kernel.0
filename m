From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 13 Sep 2013 12:06:38 +0200
Subject: [PATCH v2 09/12] ARM: mvebu: Add the PMSU related part of the cpu
 idle functions
In-Reply-To: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1379066801-16276-10-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu idle support will need to access to the Power Management
Service Unit. This commit adds and exports the prepare and restore
functions that will be used by the CPU idle.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c         | 73 ++++++++++++++++++++++++++++++++++++++
 include/linux/armada-370-xp-pmsu.h |  2 ++
 2 files changed, 75 insertions(+)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index fc3374d..29ea8c5 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -30,6 +30,24 @@ static void __iomem *pmsu_fabric_base;
 #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x24)
 #define PMSU_RESET_CTL_OFFSET(cpu)		(cpu * 0x8)
 
+#define PM_CONTROL_AND_CONFIG(cpu)	((cpu * 0x100) + 0x4)
+#define PM_CONTROL_AND_CONFIG_DFS_REQ		BIT(18)
+#define PM_CONTROL_AND_CONFIG_PWDDN_REQ	BIT(16)
+#define PM_CONTROL_AND_CONFIG_L2_PWDDN		BIT(20)
+
+#define PM_CPU_POWER_DOWN_CONTROL(cpu)	((cpu * 0x100) + 0x8)
+
+#define PM_CPU_POWER_DOWN_DIS_SNP_Q_SKIP	BIT(0)
+
+#define PM_STATUS_AND_MASK(cpu)	((cpu * 0x100) + 0xc)
+#define PM_STATUS_AND_MASK_CPU_IDLE_WAIT	BIT(16)
+#define PM_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT	BIT(17)
+#define PM_STATUS_AND_MASK_IRQ_WAKEUP		BIT(20)
+#define PM_STATUS_AND_MASK_FIQ_WAKEUP		BIT(21)
+#define PM_STATUS_AND_MASK_DBG_WAKEUP		BIT(22)
+#define PM_STATUS_AND_MASK_IRQ_MASK		BIT(24)
+#define PM_STATUS_AND_MASK_FIQ_MASK		BIT(25)
+
 #define L2C_NFABRIC_PM_CTL		    0x4
 #define L2C_NFABRIC_PM_CTL_PWR_DOWN	    BIT(20)
 
@@ -91,4 +109,59 @@ void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void)
 }
 EXPORT_SYMBOL_GPL(armada_370_xp_pmsu_enable_l2_powerdown_onidle);
 
+void armada_370_xp_pmsu_idle_prepare(bool deepidle)
+{
+	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
+	int reg;
+	/*
+	 * Adjust the PMSU configuration to wait for WFI signal, enable
+	 * IRQ and FIQ as wakeup events, set wait for snoop queue empty
+	 * indication and mask IRQ and FIQ from CPU
+	 */
+	reg = readl(pmsu_mp_base + PM_STATUS_AND_MASK(hw_cpu));
+	reg |= PM_STATUS_AND_MASK_CPU_IDLE_WAIT    |
+	       PM_STATUS_AND_MASK_IRQ_WAKEUP       |
+	       PM_STATUS_AND_MASK_FIQ_WAKEUP       |
+	       PM_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT |
+	       PM_STATUS_AND_MASK_IRQ_MASK         |
+	       PM_STATUS_AND_MASK_FIQ_MASK;
+	writel(reg, pmsu_mp_base + PM_STATUS_AND_MASK(hw_cpu));
+
+	reg = readl(pmsu_mp_base + PM_CONTROL_AND_CONFIG(hw_cpu));
+	/* ask HW to power down the L2 Cache if needed */
+	if (deepidle)
+		reg |= PM_CONTROL_AND_CONFIG_L2_PWDDN;
+
+	/* request power down */
+	reg |= PM_CONTROL_AND_CONFIG_PWDDN_REQ;
+	writel(reg, pmsu_mp_base + PM_CONTROL_AND_CONFIG(hw_cpu));
+
+	/* Disable snoop disable by HW - SW is taking care of it */
+	reg = readl(pmsu_mp_base + PM_CPU_POWER_DOWN_CONTROL(hw_cpu));
+	reg |= PM_CPU_POWER_DOWN_DIS_SNP_Q_SKIP;
+	writel(reg, pmsu_mp_base + PM_CPU_POWER_DOWN_CONTROL(hw_cpu));
+}
+EXPORT_SYMBOL_GPL(armada_370_xp_pmsu_idle_prepare);
+
+noinline void armada_370_xp_pmsu_idle_restore(void)
+{
+	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
+	int reg;
+
+	/* cancel ask HW to power down the L2 Cache if possible */
+	reg = readl(pmsu_mp_base + PM_CONTROL_AND_CONFIG(hw_cpu));
+	reg &= ~PM_CONTROL_AND_CONFIG_L2_PWDDN;
+	writel(reg, pmsu_mp_base + PM_CONTROL_AND_CONFIG(hw_cpu));
+
+	/* cancel Enable wakeup events */
+	reg = readl(pmsu_mp_base + PM_STATUS_AND_MASK(hw_cpu));
+	reg &= ~(PM_STATUS_AND_MASK_IRQ_WAKEUP | PM_STATUS_AND_MASK_FIQ_WAKEUP);
+	reg &= ~PM_STATUS_AND_MASK_CPU_IDLE_WAIT;
+	reg &= ~PM_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT;
+	/* Mask interrupts */
+	reg &= ~(PM_STATUS_AND_MASK_IRQ_MASK | PM_STATUS_AND_MASK_FIQ_MASK);
+	writel(reg, pmsu_mp_base + PM_STATUS_AND_MASK(hw_cpu));
+}
+EXPORT_SYMBOL_GPL(armada_370_xp_pmsu_idle_restore);
+
 early_initcall(armada_370_xp_pmsu_init);
diff --git a/include/linux/armada-370-xp-pmsu.h b/include/linux/armada-370-xp-pmsu.h
index f85cbf7..235a40c 100644
--- a/include/linux/armada-370-xp-pmsu.h
+++ b/include/linux/armada-370-xp-pmsu.h
@@ -12,5 +12,7 @@
 #define __ARMADA_370_XP__PMSU_H
 
 void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void);
+void armada_370_xp_pmsu_idle_prepare(bool deepidle);
+void armada_370_xp_pmsu_idle_restore(void);
 
 #endif	/* __ARMADA_370_XP__PMSU_H */
-- 
1.8.1.2
