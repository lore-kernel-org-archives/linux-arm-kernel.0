From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Fri, 8 Aug 2014 02:01:55 +0300
Subject: [PATCH 3/3] cpuidle: big.LITTLE: Use of_match_machine
In-Reply-To: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <1407452515-2390-4-git-send-email-ttynkkynen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new helper function, also fixing a device_node refcount leak.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
Compile tested only.

 drivers/cpuidle/cpuidle-big_little.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index 344d79fa..53524c8 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -172,15 +172,11 @@ static const struct of_device_id compatible_machine_match[] = {
 static int __init bl_idle_init(void)
 {
 	int ret;
-	struct device_node *root = of_find_node_by_path("/");
-
-	if (!root)
-		return -ENODEV;
 
 	/*
 	 * Initialize the driver just for a compliant set of machines
 	 */
-	if (!of_match_node(compatible_machine_match, root))
+	if (!of_match_machine(compatible_machine_match))
 		return -ENODEV;
 	/*
 	 * For now the differentiation between little and big cores
-- 
1.8.1.5
