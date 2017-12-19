From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 19 Dec 2017 11:22:46 -0800
Subject: [PATCH v2 8/9] soc: brcmstb: Split initialization
In-Reply-To: <20171219192247.29799-1-f.fainelli@gmail.com>
References: <20171219192247.29799-1-f.fainelli@gmail.com>
Message-ID: <20171219192247.29799-9-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We may need access to family_id and product_id fairly early on boot for
other parts of the code (e.g: biuctrl.c), so split the initialization
between an early_init() and an arch_initcall() which allows us to do
that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/common.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index a71730da6385..781ada62d0a3 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -66,13 +66,10 @@ static const struct of_device_id sun_top_ctrl_match[] = {
 	{ }
 };
 
-static int __init brcmstb_soc_device_init(void)
+static int __init brcmstb_soc_device_early_init(void)
 {
-	struct soc_device_attribute *soc_dev_attr;
-	struct soc_device *soc_dev;
 	struct device_node *sun_top_ctrl;
 	void __iomem *sun_top_ctrl_base;
-	int ret = 0;
 
 	sun_top_ctrl = of_find_matching_node(NULL, sun_top_ctrl_match);
 	if (!sun_top_ctrl)
@@ -84,12 +81,19 @@ static int __init brcmstb_soc_device_init(void)
 
 	family_id = readl(sun_top_ctrl_base);
 	product_id = readl(sun_top_ctrl_base + 0x4);
+	iounmap(sun_top_ctrl_base);
+	return 0;
+}
+early_initcall(brcmstb_soc_device_early_init);
+
+static int __init brcmstb_soc_device_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!soc_dev_attr)
+		return -ENOMEM;
 
 	soc_dev_attr->family = kasprintf(GFP_KERNEL, "%x",
 					 family_id >> 28 ?
@@ -107,14 +111,9 @@ static int __init brcmstb_soc_device_init(void)
 		kfree(soc_dev_attr->soc_id);
 		kfree(soc_dev_attr->revision);
 		kfree(soc_dev_attr);
-		ret = -ENODEV;
-		goto out;
+		return -ENOMEM;
 	}
 
 	return 0;
-
-out:
-	iounmap(sun_top_ctrl_base);
-	return ret;
 }
 arch_initcall(brcmstb_soc_device_init);
-- 
2.9.3
