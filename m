From: levex@linux.com (Levente Kurusa)
Date: Thu, 19 Dec 2013 16:03:18 +0100
Subject: [PATCH 07/38] arm: locomo: add missing put_device call
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Message-ID: <1387465429-3568-8-git-send-email-levex@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required so that we give up the last reference to the device.

Also, rework error path to remove the out label by return -ENOMEM explicitly if
kzalloc fails.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/arm/common/locomo.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index b55c362..e17d02c 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -224,10 +224,8 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 	int ret;
 
 	dev = kzalloc(sizeof(struct locomo_dev), GFP_KERNEL);
-	if (!dev) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!dev)
+		return -ENOMEM;
 
 	/*
 	 * If the parent device has a DMA mask associated with it,
@@ -256,8 +254,7 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 
 	ret = device_register(&dev->dev);
 	if (ret) {
- out:
-		kfree(dev);
+ 		put_device(&dev->dev);
 	}
 	return ret;
 }
-- 
1.8.3.1
