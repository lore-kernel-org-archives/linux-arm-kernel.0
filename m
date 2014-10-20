From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 20 Oct 2014 23:05:50 +0200
Subject: [PATCH v3 1/2] Revert "mfd: sec-core: Prepare regulators for suspend
 state to reduce power-consumption"
In-Reply-To: <1413839151-10875-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1413839151-10875-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1413839151-10875-2-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit b7cde7078d2344073c310aa65fc2b0a845d2cb5b
("mfd: sec-core: Prepare regulators for suspend state to reduce power-consumption")

Commit b7cde7078d23 called regulator_suspend_prepare() to prepare the
regulators for a suspend state. But it did from the device pm suspend
handler while the regulator suspend prepare function iterates over all
regulators and not only the one managed by this device so it doesn't
seems to be correct to call it from within a device driver.

It is better to call the regulator suspend prepare/finish functions
from platform code instead so this patch reverts the mentioned commit.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/mfd/Kconfig    |  1 -
 drivers/mfd/sec-core.c | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 1456ea7..fd8cc4c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -655,7 +655,6 @@ config MFD_SEC_CORE
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
-	select REGULATOR
 	help
 	 Support for the Samsung Electronics MFD series.
 	 This driver provides common support for accessing the device,
diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index dba7e2b..5993608 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -31,7 +31,6 @@
 #include <linux/mfd/samsung/s2mpu02.h>
 #include <linux/mfd/samsung/s5m8763.h>
 #include <linux/mfd/samsung/s5m8767.h>
-#include <linux/regulator/machine.h>
 #include <linux/regmap.h>
 
 static const struct mfd_cell s5m8751_devs[] = {
@@ -432,15 +431,6 @@ static int sec_pmic_suspend(struct device *dev)
 	 */
 	disable_irq(sec_pmic->irq);
 
-	switch (sec_pmic->device_type) {
-	case S2MPS14X:
-	case S2MPU02:
-		regulator_suspend_prepare(PM_SUSPEND_MEM);
-		break;
-	default:
-		break;
-	}
-
 	return 0;
 }
 
-- 
2.1.0
