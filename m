From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 1 Mar 2013 10:51:26 -0800
Subject: [PATCH RFC] arm: l2x0: Leverage power saving features
Message-ID: <da92149b-159b-40e3-87b4-a0a448d1da8b@CO1EHSMHS031.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the 'dynamic clock stop' and 'standby mode' features in the
l2x0 disable path.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
Hi,

we are currently implementing a suspend to RAM like low power mode for
Zynq.
The code for entering suspend looks like this:
	outer_disable();                                                 
        cpu_suspend(0, zynq_pm_suspend);                                 
        outer_resume();

In our low power guidelines we mention the pl310's standby and clock stop
feature and that they should be enabled for low power modes. The question
arising here now is: Does the outer_disable() make these features redundant,
or does it make sense to add it like shown in this patch?

	Thanks,
	S?ren

 arch/arm/mm/cache-l2x0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c2f3739..3565df1 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -286,8 +286,20 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 static void l2x0_disable(void)
 {
 	unsigned long flags;
+	unsigned long reg;
+	u32 l2x0_revision;
 
 	raw_spin_lock_irqsave(&l2x0_lock, flags);
+
+	l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
+		L2X0_CACHE_ID_RTL_MASK;
+
+	if (l2x0_revision >= L2X0_CACHE_ID_RTL_R3P0) {
+		reg = readl_relaxed(l2x0_base + L2X0_POWER_CTRL);
+		reg |= L2X0_STNDBY_MODE_EN | L2X0_DYNAMIC_CLK_GATING_EN;
+		writel_relaxed(reg, l2x0_base + L2X0_POWER_CTRL);
+	}
+
 	__l2x0_flush_all();
 	writel_relaxed(0, l2x0_base + L2X0_CTRL);
 	dsb();
-- 
1.8.1.3
