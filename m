From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 25 Apr 2018 20:10:29 +0530
Subject: [PATCH] ARM: locomo: use put_device() instead of kfree()
Message-ID: <76a6e68332d57d67757bf2ba735fb2d3d3118d1f.1524667039.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Never directly free @dev after calling device_register(), even
if it returned an error. Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/arm/common/locomo.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 51936bd..23a5079 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -226,8 +226,7 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 
 	dev = kzalloc(sizeof(struct locomo_dev), GFP_KERNEL);
 	if (!dev) {
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	/*
@@ -256,10 +255,9 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 			NO_IRQ : lchip->irq_base + info->irq[0];
 
 	ret = device_register(&dev->dev);
-	if (ret) {
- out:
-		kfree(dev);
-	}
+	if (ret)
+		put_device(&dev->dev);
+
 	return ret;
 }
 
-- 
2.7.4
