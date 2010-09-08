From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed,  8 Sep 2010 09:44:34 -0400
Subject: [PATCH 3/5] mfd: update chip id of 88pm8607
In-Reply-To: <1283953476-2395-2-git-send-email-haojian.zhuang@marvell.com>
References: <1283953476-2395-1-git-send-email-haojian.zhuang@marvell.com>
	<1283953476-2395-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1283953476-2395-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chipid of 88pm8607 is 0x40 or 0x50.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Samuel Ortiz <sameo@openedhand.com>
---
 drivers/mfd/88pm860x-core.c  |    7 +++++--
 include/linux/mfd/88pm860x.h |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 4db10a1..20895e7 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -645,10 +645,13 @@ static void __devinit device_8607_init(struct pm860x_chip *chip,
 		dev_err(chip->dev, "Failed to read CHIP ID: %d\n", ret);
 		goto out;
 	}
-	if ((ret & PM8607_VERSION_MASK) == PM8607_VERSION)
+	switch (ret & PM8607_VERSION_MASK) {
+	case 0x40:
+	case 0x50:
 		dev_info(chip->dev, "Marvell 88PM8607 (ID: %02x) detected\n",
 			 ret);
-	else {
+		break;
+	default:
 		dev_err(chip->dev, "Failed to detect Marvell 88PM8607. "
 			"Chip ID: %02x\n", ret);
 		goto out;
diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index bfd23be..4db1fbd 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -138,7 +138,7 @@ enum {
 	PM8607_ID_RG_MAX,
 };
 
-#define PM8607_VERSION			(0x40)	/* 8607 chip ID */
+/* 8607 chip ID is 0x40 or 0x50 */
 #define PM8607_VERSION_MASK		(0xF0)	/* 8607 chip ID mask */
 
 /* Interrupt Registers */
-- 
1.5.6.5
