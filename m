From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 12 Jan 2018 13:08:15 -0800
Subject: [PATCH 2/2] soc: bcm: brcmstb: Be multi-platform compatible
In-Reply-To: <20180112210815.9684-1-f.fainelli@gmail.com>
References: <20180112210815.9684-1-f.fainelli@gmail.com>
Message-ID: <20180112210815.9684-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

We were making a bunch of wrong assumptions that turned out to blow out
on non-Broadcom STB platforms:

- we would return -ENODEV from brcmstb_soc_device_early_init() if we
  could not find the sun_top_ctrl device node, this is not an error
  in the context of a multi-platform kernel
- we would still try to register the Broadcom STB SoC device, even if we
  are not running on such a platform

While at it, also fix the sun_top_ctrl device_node leaks while we change
the flow of brcmstb_soc_device_init() and
brcmstb_soc_device_early_init().

Fixes: f780429adfbc ("soc: brcmstb: biuctrl: Move to early_initcall")
Signed-off-by: Thierry Reding <treding@nvidia.com>
[florian: Combine all of Thierry's patch in one go for easier review]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/common.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index 781ada62d0a3..14185451901d 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -70,30 +70,49 @@ static int __init brcmstb_soc_device_early_init(void)
 {
 	struct device_node *sun_top_ctrl;
 	void __iomem *sun_top_ctrl_base;
+	int ret = 0;
 
+	/* We could be on a multi-platform kernel, don't make this fatal but
+	 * bail out early
+	 */
 	sun_top_ctrl = of_find_matching_node(NULL, sun_top_ctrl_match);
 	if (!sun_top_ctrl)
-		return -ENODEV;
+		return ret;
 
 	sun_top_ctrl_base = of_iomap(sun_top_ctrl, 0);
-	if (!sun_top_ctrl_base)
-		return -ENODEV;
+	if (!sun_top_ctrl_base) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	family_id = readl(sun_top_ctrl_base);
 	product_id = readl(sun_top_ctrl_base + 0x4);
 	iounmap(sun_top_ctrl_base);
-	return 0;
+out:
+	of_node_put(sun_top_ctrl);
+	return ret;
 }
 early_initcall(brcmstb_soc_device_early_init);
 
 static int __init brcmstb_soc_device_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
+	struct device_node *sun_top_ctrl;
 	struct soc_device *soc_dev;
+	int ret = 0;
+
+	/* We could be on a multi-platform kernel, don't make this fatal but
+	 * bail out early
+	 */
+	sun_top_ctrl = of_find_matching_node(NULL, sun_top_ctrl_match);
+	if (!sun_top_ctrl)
+		return ret;
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
-		return -ENOMEM;
+	if (!soc_dev_attr) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	soc_dev_attr->family = kasprintf(GFP_KERNEL, "%x",
 					 family_id >> 28 ?
@@ -111,9 +130,10 @@ static int __init brcmstb_soc_device_init(void)
 		kfree(soc_dev_attr->soc_id);
 		kfree(soc_dev_attr->revision);
 		kfree(soc_dev_attr);
-		return -ENOMEM;
+		ret = -ENOMEM;
 	}
-
-	return 0;
+out:
+	of_node_put(sun_top_ctrl);
+	return ret;
 }
 arch_initcall(brcmstb_soc_device_init);
-- 
2.14.1
