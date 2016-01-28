From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 28 Jan 2016 16:33:42 +0000
Subject: [PATCH V5 04/14] soc: tegra: pmc: Fix testing of powergate state
In-Reply-To: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1453998832-27383-5-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In tegra_powergate_set() the state of the powergates is read and OR'ed
with the bit for the powergate of interest. This unsigned 32-bit value
is then compared with a boolean value to test if the powergate is
already in the desired state. When turning on a powergate, apart from
the powergate that is represented by bit 0, this test will always
return false and so we may attempt to turn on the powergate when it is
already on.

After OR'ing the bit for the powergate, check if the result is not equal
to zero before comparing with the boolean value. Add a helper function
to return the current state of a powergate.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 1dbdcf06a9ad..99cb2fdd29e1 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -174,6 +174,11 @@ static void tegra_pmc_writel(u32 value, unsigned long offset)
 	writel(value, pmc->base + offset);
 }
 
+static inline bool tegra_powergate_state(int id)
+{
+	return (tegra_pmc_readl(PWRGATE_STATUS) & BIT(id)) != 0;
+}
+
 /**
  * tegra_powergate_set() - set the state of a partition
  * @id: partition ID
@@ -181,13 +186,9 @@ static void tegra_pmc_writel(u32 value, unsigned long offset)
  */
 static int tegra_powergate_set(unsigned int id, bool new_state)
 {
-	bool status;
-
 	mutex_lock(&pmc->powergates_lock);
 
-	status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
-
-	if (status == new_state) {
+	if (tegra_powergate_state(id) == new_state) {
 		mutex_unlock(&pmc->powergates_lock);
 		return 0;
 	}
@@ -230,16 +231,16 @@ EXPORT_SYMBOL(tegra_powergate_power_off);
  */
 int tegra_powergate_is_powered(unsigned int id)
 {
-	u32 status;
+	int status;
 
 	if (!pmc->soc || id >= pmc->soc->num_powergates)
 		return -EINVAL;
 
 	mutex_lock(&pmc->powergates_lock);
-	status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
+	status = tegra_powergate_state(id);
 	mutex_unlock(&pmc->powergates_lock);
 
-	return !!status;
+	return status;
 }
 
 /**
-- 
2.1.4
