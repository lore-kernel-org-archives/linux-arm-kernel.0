From: zhongjiang@huawei.com (zhong jiang)
Date: Fri, 14 Sep 2018 23:05:19 +0800
Subject: [PATCH] arm: common: use match_string() helper to simplify the code
Message-ID: <1536937519-31611-1-git-send-email-zhongjiang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm/plat-orion/common.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index a2399fd..d705ffa 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -479,17 +479,14 @@ void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
 
 void __init orion_ge00_switch_init(struct dsa_chip_data *d)
 {
-	unsigned int i;
+	int index;
 
 	if (!IS_BUILTIN(CONFIG_PHYLIB))
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(d->port_names); i++) {
-		if (!strcmp(d->port_names[i], "cpu")) {
-			d->netdev[i] = &orion_ge00.dev;
-			break;
-		}
-	}
+	index = match_string(d->port_names, ARRAY_SIZE(d->port_names), "cpu");
+	if (index >= 0)
+		d->netdev[index] = &orion_ge00.dev;
 
 	orion_ge00_switch_board_info.mdio_addr = d->sw_addr;
 	orion_ge00_switch_board_info.platform_data = d;
-- 
1.7.12.4
