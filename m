From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  1 Jun 2015 18:47:55 -0700
Subject: [PATCH 2/6] regulator: core: Print at debug level on debugfs creation
 failure
In-Reply-To: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1433209679-31389-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Failure to create a debugfs node is not an error, but we print a
warning upon failure to create the node. Downgrade this to a
debug printk so that we're quiet here. This allows multiple
drivers to request a CPU's regulator so that CPUfreq and AVSish
drivers can coexist.

The downside of this approach is that whoever gets to debugfs first
the others who come later to not have any debugfs attributes associated
with them.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f6989485c382..9dba0a3d4526 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1208,7 +1208,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	regulator->debugfs = debugfs_create_dir(regulator->supply_name,
 						rdev->debugfs);
 	if (!regulator->debugfs) {
-		rdev_warn(rdev, "Failed to create debugfs directory\n");
+		rdev_dbg(rdev, "Failed to create debugfs directory\n");
 	} else {
 		debugfs_create_u32("uA_load", 0444, regulator->debugfs,
 				   &regulator->uA_load);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
