From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 25 Apr 2016 16:08:09 -0700
Subject: [PATCH] soc: brcmstb: Unmap sun_top_ctrl_base on errors
Message-ID: <1461625693-22793-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not leak a ioremap()'d cookie around, unmaping it in case of errors

Fixes: cef4bafcea2c ("soc: brcmstb: add SoC driver to brcmstb")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Arnd,

Feel free to squash this one and your patch into the original commit, thanks!

 drivers/soc/brcmstb/common.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/brcmstb/common.c b/drivers/soc/brcmstb/common.c
index daf86acf9d01..94e7335553f4 100644
--- a/drivers/soc/brcmstb/common.c
+++ b/drivers/soc/brcmstb/common.c
@@ -51,6 +51,7 @@ static int __init brcmstb_soc_device_init(void)
 	struct soc_device *soc_dev;
 	struct device_node *sun_top_ctrl;
 	void __iomem *sun_top_ctrl_base;
+	int ret = 0;
 
 	sun_top_ctrl = of_find_matching_node(NULL, sun_top_ctrl_match);
 	if (!sun_top_ctrl)
@@ -64,8 +65,10 @@ static int __init brcmstb_soc_device_init(void)
 	product_id = readl(sun_top_ctrl_base + 0x4);
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
-		return -ENOMEM;
+	if (!soc_dev_attr) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	soc_dev_attr->family = kasprintf(GFP_KERNEL, "%x",
 					 family_id >> 28 ?
@@ -83,9 +86,14 @@ static int __init brcmstb_soc_device_init(void)
 		kfree(soc_dev_attr->soc_id);
 		kfree(soc_dev_attr->revision);
 		kfree(soc_dev_attr);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	return 0;
+
+out:
+	iounmap(sun_top_ctrl_base);
+	return ret;
 }
 arch_initcall(brcmstb_soc_device_init);
-- 
2.1.0
