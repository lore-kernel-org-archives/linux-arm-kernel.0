From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sat, 22 Jul 2017 10:34:57 +0300
Subject: [PATCH 2/2] fsl/qe: Cleanup error paths in ucc_of_parse_tdm()
In-Reply-To: <20170722073335.tb6byaaarqvloh3a@mwanda>
Message-ID: <20170722073457.zyrqoufpopwg6il5@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The most important part of this change is that it not propogates error
codes instead of returning -EINVAL.  There was also a tab missing, and
a couple other minor cleanups which don't affect runtime.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Not tested, but I don't think propogating the errors will cause a
problem.

diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index ec7a853053c3..ce071a78209b 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -42,7 +42,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 		     struct ucc_tdm_info *ut_info)
 {
 	const char *sprop;
-	int ret = 0;
+	int ret;
 	u32 val;
 	struct resource *res;
 	struct device_node *np2;
@@ -68,7 +68,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 		if ((ut_info->uf_info.tx_sync < QE_CLK_NONE) ||
 		    (ut_info->uf_info.tx_sync > QE_TSYNC_PIN)) {
 			pr_err("QE-TDM: Invalid tx-sync-clock property\n");
-		return -EINVAL;
+			return -EINVAL;
 		}
 	} else {
 		pr_err("QE-TDM: Invalid tx-sync-clock property\n");
@@ -78,13 +78,12 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	ret = of_property_read_u32_index(np, "fsl,tx-timeslot-mask", 0, &val);
 	if (ret) {
 		pr_err("QE-TDM: Invalid tx-timeslot-mask property\n");
-		return -EINVAL;
+		return ret;
 	}
 	utdm->tx_ts_mask = val;
 
 	ret = of_property_read_u32_index(np, "fsl,rx-timeslot-mask", 0, &val);
 	if (ret) {
-		ret = -EINVAL;
 		pr_err("QE-TDM: Invalid rx-timeslot-mask property\n");
 		return ret;
 	}
@@ -92,7 +91,6 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 
 	ret = of_property_read_u32_index(np, "fsl,tdm-id", 0, &val);
 	if (ret) {
-		ret = -EINVAL;
 		pr_err("QE-TDM: No fsl,tdm-id property for this UCC\n");
 		return ret;
 	}
@@ -106,18 +104,16 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 
 	sprop = of_get_property(np, "fsl,tdm-framer-type", NULL);
 	if (!sprop) {
-		ret = -EINVAL;
 		pr_err("QE-TDM: No tdm-framer-type property for UCC\n");
-		return ret;
+		return -EINVAL;
 	}
 	ret = set_tdm_framer(sprop);
 	if (ret < 0)
-		return -EINVAL;
+		return ret;
 	utdm->tdm_framer_type = ret;
 
 	ret = of_property_read_u32_index(np, "fsl,siram-entry-id", 0, &val);
 	if (ret) {
-		ret = -EINVAL;
 		pr_err("QE-TDM: No siram entry id for UCC\n");
 		return ret;
 	}
@@ -164,7 +160,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 		siram_init_flag = 1;
 	}
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(ucc_of_parse_tdm);
 
