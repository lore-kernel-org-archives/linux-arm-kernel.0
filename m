From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Jan 2014 15:05:54 +0000
Subject: [PATCH 2/4] mfd: max8998: Naturalise cross-architecture discrepancies
In-Reply-To: <1390489556-9434-1-git-send-email-lee.jones@linaro.org>
References: <1390489556-9434-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1390489556-9434-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we compile the MAX8998 for a 64bit architecture we receive the following
warnings:

  drivers/mfd/max8998.c: In function ?max8998_i2c_get_driver_data?:
  drivers/mfd/max8998.c:178:10:
    warning: cast from pointer to integer of different size
     return (int)match->data;
            ^

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/max8998.c               | 6 +++---
 include/linux/mfd/max8998-private.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
index f47eaa7..5d5e186 100644
--- a/drivers/mfd/max8998.c
+++ b/drivers/mfd/max8998.c
@@ -169,16 +169,16 @@ static struct max8998_platform_data *max8998_i2c_parse_dt_pdata(
 	return pd;
 }
 
-static inline int max8998_i2c_get_driver_data(struct i2c_client *i2c,
+static inline unsigned long max8998_i2c_get_driver_data(struct i2c_client *i2c,
 						const struct i2c_device_id *id)
 {
 	if (IS_ENABLED(CONFIG_OF) && i2c->dev.of_node) {
 		const struct of_device_id *match;
 		match = of_match_node(max8998_dt_match, i2c->dev.of_node);
-		return (int)match->data;
+		return (unsigned long)match->data;
 	}
 
-	return (int)id->driver_data;
+	return id->driver_data;
 }
 
 static int max8998_i2c_probe(struct i2c_client *i2c,
diff --git a/include/linux/mfd/max8998-private.h b/include/linux/mfd/max8998-private.h
index 4ecb24b..d68ada5 100644
--- a/include/linux/mfd/max8998-private.h
+++ b/include/linux/mfd/max8998-private.h
@@ -163,7 +163,7 @@ struct max8998_dev {
 	int ono;
 	u8 irq_masks_cur[MAX8998_NUM_IRQ_REGS];
 	u8 irq_masks_cache[MAX8998_NUM_IRQ_REGS];
-	int type;
+	unsigned long type;
 	bool wakeup;
 };
 
-- 
1.8.3.2
