From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 12 Feb 2014 16:59:36 +0100
Subject: [PATCH v3 13/13] pinctrl: mvebu: dove: reuse mpp_{set,
 get} in pmu callbacks
In-Reply-To: <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1392220776-30851-14-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dove has pins that can be switched between normal and pmu functions.
Rework pmu_mpp callbacks to reuse normal mpp callbacks.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: Jason Cooper <jason@lakedaemon.net> 
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/pinctrl/mvebu/pinctrl-dove.c | 37 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 2f384d87ea92..3e28096091b0 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -82,14 +82,13 @@ static int dove_pmu_mpp_ctrl_get(unsigned pid, unsigned long *config)
 	unsigned long pmu = readl(DOVE_PMU_MPP_GENERAL_CTRL);
 	unsigned long func;
 
-	if (pmu & (1 << pid)) {
-		func = readl(DOVE_PMU_SIGNAL_SELECT_0 + off);
-		*config = (func >> shift) & MVEBU_MPP_MASK;
-		*config |= CONFIG_PMU;
-	} else {
-		func = readl(DOVE_MPP_VIRT_BASE + off);
-		*config = (func >> shift) & MVEBU_MPP_MASK;
-	}
+	if ((pmu & BIT(pid)) == 0)
+		return dove_mpp_ctrl_get(pid, config);
+
+	func = readl(DOVE_PMU_SIGNAL_SELECT_0 + off);
+	*config = (func >> shift) & MVEBU_MPP_MASK;
+	*config |= CONFIG_PMU;
+
 	return 0;
 }
 
@@ -100,19 +99,17 @@ static int dove_pmu_mpp_ctrl_set(unsigned pid, unsigned long config)
 	unsigned long pmu = readl(DOVE_PMU_MPP_GENERAL_CTRL);
 	unsigned long func;
 
-	if (config & CONFIG_PMU) {
-		writel(pmu | (1 << pid), DOVE_PMU_MPP_GENERAL_CTRL);
-		func = readl(DOVE_PMU_SIGNAL_SELECT_0 + off);
-		func &= ~(MVEBU_MPP_MASK << shift);
-		func |= (config & MVEBU_MPP_MASK) << shift;
-		writel(func, DOVE_PMU_SIGNAL_SELECT_0 + off);
-	} else {
-		writel(pmu & ~(1 << pid), DOVE_PMU_MPP_GENERAL_CTRL);
-		func = readl(DOVE_MPP_VIRT_BASE + off);
-		func &= ~(MVEBU_MPP_MASK << shift);
-		func |= (config & MVEBU_MPP_MASK) << shift;
-		writel(func, DOVE_MPP_VIRT_BASE + off);
+	if ((config & CONFIG_PMU) == 0) {
+		writel(pmu & ~BIT(pid), DOVE_PMU_MPP_GENERAL_CTRL);
+		return dove_mpp_ctrl_set(pid, config);
 	}
+
+	writel(pmu | BIT(pid), DOVE_PMU_MPP_GENERAL_CTRL);
+	func = readl(DOVE_PMU_SIGNAL_SELECT_0 + off);
+	func &= ~(MVEBU_MPP_MASK << shift);
+	func |= (config & MVEBU_MPP_MASK) << shift;
+	writel(func, DOVE_PMU_SIGNAL_SELECT_0 + off);
+
 	return 0;
 }
 
-- 
1.8.5.3
