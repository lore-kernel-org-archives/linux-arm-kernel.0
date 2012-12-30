From: robherring2@gmail.com (Rob Herring)
Date: Sun, 30 Dec 2012 10:15:06 -0600
Subject: [PATCH 5/6] ARM: highbank: add a power request clear
In-Reply-To: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
References: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
Message-ID: <1356884107-30991-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

When we fail to power down, we need to clear out the power request.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/sysregs.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-highbank/sysregs.h b/arch/arm/mach-highbank/sysregs.h
index 707cfd3..70af9d1 100644
--- a/arch/arm/mach-highbank/sysregs.h
+++ b/arch/arm/mach-highbank/sysregs.h
@@ -44,6 +44,15 @@ static inline void highbank_set_core_pwr(void)
 		writel_relaxed(1, sregs_base + SREG_CPU_PWR_CTRL(cpu));
 }
 
+static inline void highbank_clear_core_pwr(void)
+{
+	int cpu = cpu_logical_map(smp_processor_id());
+	if (scu_base_addr)
+		scu_power_mode(scu_base_addr, SCU_PM_NORMAL);
+	else
+		writel_relaxed(0, sregs_base + SREG_CPU_PWR_CTRL(cpu));
+}
+
 static inline void highbank_set_pwr_suspend(void)
 {
 	writel(HB_PWR_SUSPEND, sregs_base + HB_SREG_A9_PWR_REQ);
@@ -68,4 +77,10 @@ static inline void highbank_set_pwr_hard_reset(void)
 	highbank_set_core_pwr();
 }
 
+static inline void highbank_clear_pwr_request(void)
+{
+	writel(~0UL, sregs_base + HB_SREG_A9_PWR_REQ);
+	highbank_clear_core_pwr();
+}
+
 #endif
-- 
1.7.10.4
