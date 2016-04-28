From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Thu, 28 Apr 2016 15:09:01 +0800
Subject: [PATCH net-next 1/4] net: hns: remove cpld-ctrl-reg and add cell in
 the cpld-syscon property
In-Reply-To: <1461827344-52230-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1461827344-52230-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1461827344-52230-2-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because cpld-ctrl-reg property is offset base on cpld-syscon property,
we make it as a cell in the cpld-syscon property.

Signed-off-by: Yisen Zhuang <yisen.zhuang@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 26 ++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index 1c8fdd3..210ba89 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -647,6 +647,7 @@ static int  hns_mac_get_info(struct hns_mac_cb *mac_cb)
 {
 	struct device_node *np = mac_cb->dev->of_node;
 	struct regmap *syscon;
+	struct of_phandle_args cpld_args;
 	u32 ret;
 
 	mac_cb->link = false;
@@ -713,22 +714,23 @@ static int  hns_mac_get_info(struct hns_mac_cb *mac_cb)
 			mac_cb->mac_id);
 	}
 
-	syscon = syscon_node_to_regmap(
-			of_parse_phandle(to_of_node(mac_cb->fw_port),
-					 "cpld-syscon", 0));
-	if (IS_ERR_OR_NULL(syscon)) {
-		dev_dbg(mac_cb->dev, "no cpld-syscon found!\n");
+	ret = of_parse_phandle_with_fixed_args(to_of_node(mac_cb->fw_port),
+					       "cpld-syscon", 1, 0, &cpld_args);
+	if (ret) {
+		dev_dbg(mac_cb->dev, "mac%d no cpld-syscon found.\n",
+			mac_cb->mac_id);
 		mac_cb->cpld_ctrl = NULL;
 	} else {
-		mac_cb->cpld_ctrl = syscon;
-		ret = fwnode_property_read_u32(mac_cb->fw_port,
-					       "cpld-ctrl-reg",
-					       &mac_cb->cpld_ctrl_reg);
-		if (ret) {
-			dev_err(mac_cb->dev, "get cpld-ctrl-reg fail!\n");
-			return ret;
+		syscon = syscon_node_to_regmap(cpld_args.np);
+		if (IS_ERR_OR_NULL(syscon)) {
+			dev_dbg(mac_cb->dev, "no cpld-syscon found!\n");
+			mac_cb->cpld_ctrl = NULL;
+		} else {
+			mac_cb->cpld_ctrl = syscon;
+			mac_cb->cpld_ctrl_reg = cpld_args.args[0];
 		}
 	}
+
 	return 0;
 }
 
-- 
1.9.1
