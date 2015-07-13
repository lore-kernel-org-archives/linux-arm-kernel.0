From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 13 Jul 2015 13:39:46 +0100
Subject: [PATCH V3 08/19] soc: tegra: pmc: Clean-up PMC helper functions
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1436791197-32358-9-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following clean-ups have been made to the PMC code:

1. Add a macro for determining the state of a PMC powergate
2. Use the readx_poll_timeout() function instead of implementing a local
   polling loop with a timeout.
3. Use a case-statement in the function that removes the powergate clamp
   instead of multiple if-statements to improve readability.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 72 ++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index c0635bdd4ee3..180d434deec5 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -28,6 +28,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -56,6 +57,8 @@
 #define  PWRGATE_TOGGLE_START		(1 << 8)
 
 #define REMOVE_CLAMPING			0x34
+#define  REMOVE_CLAMPING_VDEC		(1 << 3)
+#define  REMOVE_CLAMPING_PCIE		(1 << 4)
 
 #define PWRGATE_STATUS			0x38
 
@@ -101,6 +104,8 @@
 
 #define GPU_RG_CNTRL			0x2d4
 
+#define PMC_PWRGATE_STATE(val, id)	(!!(val & BIT(id)))
+
 struct tegra_pmc_soc {
 	unsigned int num_powergates;
 	const char *const *powergates;
@@ -177,15 +182,14 @@ static void tegra_pmc_writel(u32 value, unsigned long offset)
  */
 static int tegra_powergate_set(int id, bool new_state, bool wait)
 {
-	unsigned long timeout;
-	bool status;
 	int ret = 0;
+	u32 val;
 
 	mutex_lock(&pmc->powergates_lock);
 
-	status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
+	val = tegra_pmc_readl(PWRGATE_STATUS);
 
-	if (status == new_state) {
+	if (PMC_PWRGATE_STATE(val, id) == new_state) {
 		mutex_unlock(&pmc->powergates_lock);
 		return 0;
 	}
@@ -193,17 +197,9 @@ static int tegra_powergate_set(int id, bool new_state, bool wait)
 	tegra_pmc_writel(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
 
 	if (wait) {
-		timeout = jiffies + msecs_to_jiffies(100);
-		ret = -ETIMEDOUT;
-
-		while (time_before(jiffies, timeout)) {
-			status = !!(tegra_pmc_readl(PWRGATE_STATUS) & BIT(id));
-			if (status == new_state) {
-				ret = 0;
-				break;
-			}
-			udelay(10);
-		}
+		ret = readx_poll_timeout(tegra_pmc_readl, PWRGATE_STATUS,
+				val, PMC_PWRGATE_STATE(val, id) == new_state,
+				10, 100000);
 	}
 
 	mutex_unlock(&pmc->powergates_lock);
@@ -242,13 +238,10 @@ EXPORT_SYMBOL(tegra_powergate_power_off);
  */
 int tegra_powergate_is_powered(int id)
 {
-	u32 status;
-
 	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
 		return -EINVAL;
 
-	status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
-	return !!status;
+	return PMC_PWRGATE_STATE(tegra_pmc_readl(PWRGATE_STATUS), id);
 }
 
 /**
@@ -257,34 +250,39 @@ int tegra_powergate_is_powered(int id)
  */
 int tegra_powergate_remove_clamping(int id)
 {
-	u32 mask;
+	u32 val, reg;
 
 	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
 		return -EINVAL;
 
 	/*
-	 * On Tegra124 and later, the clamps for the GPU are controlled by a
-	 * separate register (with different semantics).
+	 * In most cases the bit for removing the IO clamping is the same as
+	 * the powergate partition ID, however, this is not always the case.
+	 * Furthermore, on Tegra124 and later, the clamps for the GPU are
+	 * controlled by a separate register (with different semantics). The
+	 * following case-statement handles these exceptions.
 	 */
-	if (id == TEGRA_POWERGATE_3D) {
+	val = 1 << id;
+	reg = REMOVE_CLAMPING;
+
+	switch (id) {
+	case TEGRA_POWERGATE_3D:
 		if (pmc->soc->has_gpu_clamps) {
-			tegra_pmc_writel(0, GPU_RG_CNTRL);
-			return 0;
+			val = 0;
+			reg  = GPU_RG_CNTRL;
 		}
+		break;
+	case TEGRA_POWERGATE_VDEC:
+		val = REMOVE_CLAMPING_VDEC;
+		break;
+	case TEGRA_POWERGATE_PCIE:
+		val = REMOVE_CLAMPING_PCIE;
+		break;
+	default:
+		break;
 	}
 
-	/*
-	 * Tegra 2 has a bug where PCIE and VDE clamping masks are
-	 * swapped relatively to the partition ids
-	 */
-	if (id == TEGRA_POWERGATE_VDEC)
-		mask = (1 << TEGRA_POWERGATE_PCIE);
-	else if (id == TEGRA_POWERGATE_PCIE)
-		mask = (1 << TEGRA_POWERGATE_VDEC);
-	else
-		mask = (1 << id);
-
-	tegra_pmc_writel(mask, REMOVE_CLAMPING);
+	tegra_pmc_writel(val, reg);
 
 	return 0;
 }
-- 
2.1.4
