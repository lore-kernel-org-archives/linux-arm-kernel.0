From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  2 Jul 2014 16:28:36 +0100
Subject: [PATCH 04/12] mfd: stmpe: Rid data size incompatibility warn when
 building for 64bit
In-Reply-To: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
References: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1404314924-23564-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extinguishes:

../drivers/mfd/stmpe-i2c.c: In function ?stmpe_i2c_probe?:
../drivers/mfd/stmpe-i2c.c:88:13:
	warning: cast from pointer to integer of different size
	partnum = (int)of_id->data;

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/stmpe-i2c.c | 4 ++--
 drivers/mfd/stmpe.c     | 2 +-
 drivers/mfd/stmpe.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index a45f9c0..5c05403 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -68,7 +68,7 @@ MODULE_DEVICE_TABLE(of, stmpe_of_match);
 static int
 stmpe_i2c_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 {
-	int partnum;
+	enum stmpe_partnum partnum;
 	const struct of_device_id *of_id;
 
 	i2c_ci.data = (void *)id;
@@ -85,7 +85,7 @@ stmpe_i2c_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 		dev_info(&i2c->dev, "matching on node name, compatible is preferred\n");
 		partnum = id->driver_data;
 	} else
-		partnum = (int)of_id->data;
+		partnum = (enum stmpe_partnum)of_id->data;
 
 	return stmpe_probe(&i2c_ci, partnum);
 }
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 3b6bfa7..02a17c3 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1147,7 +1147,7 @@ static void stmpe_of_probe(struct stmpe_platform_data *pdata,
 }
 
 /* Called from client specific probe routines */
-int stmpe_probe(struct stmpe_client_info *ci, int partnum)
+int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 {
 	struct stmpe_platform_data *pdata = dev_get_platdata(ci->dev);
 	struct device_node *np = ci->dev->of_node;
diff --git a/drivers/mfd/stmpe.h b/drivers/mfd/stmpe.h
index 9e4d21d..2d045f2 100644
--- a/drivers/mfd/stmpe.h
+++ b/drivers/mfd/stmpe.h
@@ -97,7 +97,7 @@ struct stmpe_client_info {
 	void (*init)(struct stmpe *stmpe);
 };
 
-int stmpe_probe(struct stmpe_client_info *ci, int partnum);
+int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum);
 int stmpe_remove(struct stmpe *stmpe);
 
 #define STMPE_ICR_LSB_HIGH	(1 << 2)
-- 
1.8.3.2
