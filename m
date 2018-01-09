From: sxwjean@me.com (Xiongwei Song)
Date: Tue, 09 Jan 2018 22:37:55 +0800
Subject: [PATCH] ARM: locomo: fix free dev incorrectly
Message-ID: <20180109143755.16931-1-sxwjean@me.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In function locomo_init_one_child, If kzalloc call is failed for dev we
would goto out label, then call kfree for dev, however, dev is NULL, we
shouldn't do this.

Signed-off-by: Xiongwei Song <sxwjean@me.com>
---
 arch/arm/common/locomo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 51936bde1eb2..fb21b5ade391 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -256,10 +256,9 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 			NO_IRQ : lchip->irq_base + info->irq[0];
 
 	ret = device_register(&dev->dev);
-	if (ret) {
- out:
+	if (ret)
 		kfree(dev);
-	}
+ out:
 	return ret;
 }
 
-- 
2.15.1
