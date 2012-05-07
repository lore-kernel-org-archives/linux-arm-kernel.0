From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon,  7 May 2012 11:10:48 +0800
Subject: [PATCH 1/2] mfd: max8925: request resource region
Message-ID: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If resource region isn't requested, component devices will fail to request
their resources.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/mfd/max8925-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index ca881ef..37aadcd 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -578,6 +578,10 @@ int __devinit max8925_device_init(struct max8925_chip *chip,
 {
 	int ret;
 
+	if (!request_region(0, 0xff, "max8925")) {
+		dev_err(chip->dev, "Failed to register resource region\n");
+		return -EBUSY;
+	}
 	max8925_irq_init(chip, chip->i2c->irq, pdata);
 
 	if (pdata && (pdata->power || pdata->touch)) {
-- 
1.7.5.4
