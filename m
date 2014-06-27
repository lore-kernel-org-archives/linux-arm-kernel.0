From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jun 2014 15:22:50 +0200
Subject: [PATCH 09/16] ARM: mvebu: Make the snoop disable optional in
 mvebu_v7_pmsu_idle_prepare
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1403875377-940-10-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some mvebu v7 SoC (the ones which don't use PJ4B core) there is no
such feature. So add a parameter in mvebu_v7_pmsu_idle_prepare function
to make its use optional.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 8bf737fb3aac..a2869c5daeb0 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -180,7 +180,7 @@ static void mvebu_v7_pmsu_enable_l2_powerdown_onidle(void)
 }
 
 /* No locking is needed because we only access per-CPU registers */
-static void mvebu_v7_pmsu_idle_prepare(bool deepidle)
+static void mvebu_v7_pmsu_idle_prepare(bool deepidle, bool snoopdis)
 {
 	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 	u32 reg;
@@ -211,15 +211,17 @@ static void mvebu_v7_pmsu_idle_prepare(bool deepidle)
 	reg |= PMSU_CONTROL_AND_CONFIG_PWDDN_REQ;
 	writel(reg, pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
 
-	/* Disable snoop disable by HW - SW is taking care of it */
-	reg = readl(pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
-	reg |= PMSU_CPU_POWER_DOWN_DIS_SNP_Q_SKIP;
-	writel(reg, pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
+	if (snoopdis) {
+		/* Disable snoop disable by HW - SW is taking care of it */
+		reg = readl(pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
+		reg |= PMSU_CPU_POWER_DOWN_DIS_SNP_Q_SKIP;
+		writel(reg, pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
+	}
 }
 
 static noinline int do_armada_xp_370_cpu_suspend(unsigned long deepidle)
 {
-	mvebu_v7_pmsu_idle_prepare(deepidle);
+	mvebu_v7_pmsu_idle_prepare(deepidle, true);
 
 	v7_exit_coherency_flush(all);
 
-- 
1.8.1.2
