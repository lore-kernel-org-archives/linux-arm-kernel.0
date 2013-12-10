From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 Dec 2013 10:09:42 +0100
Subject: [TRIVIAL PATCH 1/2] regulator: s5m8767: Define symbol for buck control
 mask
Message-ID: <1386666583-3280-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace hard-coded value for mask used in BUCKX_CTRL registers (for
BUCKX_EN field) with a symbol. This also removes two local variables.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/s5m8767.c         |   11 ++++++-----
 include/linux/mfd/samsung/s5m8767.h |    3 ++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index aeb40aad0ae7..58eb7a6c45e6 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -217,7 +217,7 @@ static int s5m8767_reg_is_enabled(struct regulator_dev *rdev)
 {
 	struct s5m8767_info *s5m8767 = rdev_get_drvdata(rdev);
 	int ret, reg;
-	int mask = 0xc0, enable_ctrl;
+	int enable_ctrl;
 	unsigned int val;
 
 	ret = s5m8767_get_register(rdev, &reg, &enable_ctrl);
@@ -230,27 +230,28 @@ static int s5m8767_reg_is_enabled(struct regulator_dev *rdev)
 	if (ret)
 		return ret;
 
-	return (val & mask) == enable_ctrl;
+	return (val & S5M8767_ENCTRL_MASK) == enable_ctrl;
 }
 
 static int s5m8767_reg_enable(struct regulator_dev *rdev)
 {
 	struct s5m8767_info *s5m8767 = rdev_get_drvdata(rdev);
 	int ret, reg;
-	int mask = 0xc0, enable_ctrl;
+	int enable_ctrl;
 
 	ret = s5m8767_get_register(rdev, &reg, &enable_ctrl);
 	if (ret)
 		return ret;
 
-	return sec_reg_update(s5m8767->iodev, reg, enable_ctrl, mask);
+	return sec_reg_update(s5m8767->iodev, reg, enable_ctrl,
+			S5M8767_ENCTRL_MASK);
 }
 
 static int s5m8767_reg_disable(struct regulator_dev *rdev)
 {
 	struct s5m8767_info *s5m8767 = rdev_get_drvdata(rdev);
 	int ret, reg;
-	int  mask = 0xc0, enable_ctrl;
+	int mask = S5M8767_ENCTRL_MASK, enable_ctrl;
 
 	ret = s5m8767_get_register(rdev, &reg, &enable_ctrl);
 	if (ret)
diff --git a/include/linux/mfd/samsung/s5m8767.h b/include/linux/mfd/samsung/s5m8767.h
index 306a95fc558c..9198377ee859 100644
--- a/include/linux/mfd/samsung/s5m8767.h
+++ b/include/linux/mfd/samsung/s5m8767.h
@@ -183,6 +183,7 @@ enum s5m8767_regulators {
 	S5M8767_REG_MAX,
 };
 
-#define S5M8767_ENCTRL_SHIFT  6
+#define S5M8767_ENCTRL_SHIFT		6
+#define S5M8767_ENCTRL_MASK		(0x3 << S5M8767_ENCTRL_SHIFT)
 
 #endif /* __LINUX_MFD_S5M8767_H */
-- 
1.7.9.5
