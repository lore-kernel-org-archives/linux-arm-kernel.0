From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 16:58:50 +0100
Subject: [PATCH] regulator: return NULL for dummy bulk_get operation
Message-ID: <1453737537-1960121-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers that call regulator_bulk_get or devm_regulator_bulk_get when
CONFIG_REGULATOR is disabled see the function return successfully, but
cannot use the "consumer" pointers that are meant to be returned from
the functions, as the values are uninitialized. Gcc warns about this:

drivers/usb/phy/phy-qcom-8x16-usb.c: In function 'phy_8x16_probe':
drivers/usb/phy/phy-qcom-8x16-usb.c:284:13: error: 'regs[0].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/usb/phy/phy-qcom-8x16-usb.c:285:13: error: 'regs[1].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/usb/phy/phy-qcom-8x16-usb.c:286:12: error: 'regs[2].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]

To make the code behave in a reproducible way, this changes the
two dummy function to behave like the non-bulk regulator_get
and devm_regulator_get functions to, returning a NULL pointer with
a successful return code. This also gets rid of the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/regulator/consumer.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 48603506f8de..f4774bf707c2 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -404,13 +404,17 @@ static inline int regulator_bulk_get(struct device *dev,
 				     int num_consumers,
 				     struct regulator_bulk_data *consumers)
 {
+	int i;
+	for (i=0; i < num_consumers; i++)
+		consumers[i].consumer = NULL;
+
 	return 0;
 }
 
 static inline int devm_regulator_bulk_get(struct device *dev, int num_consumers,
 					  struct regulator_bulk_data *consumers)
 {
-	return 0;
+	return regulator_bulk_get(dev, num_consumers, consumers);
 }
 
 static inline int regulator_bulk_enable(int num_consumers,
-- 
2.7.0
