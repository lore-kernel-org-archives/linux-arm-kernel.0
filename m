From: alexg@meprolight.com (Alex Gershgorin)
Date: Wed, 28 Mar 2012 16:01:13 +0200
Subject: [PATCH] mfd: mc13xxx: add I2C support fix building for v3.4
Message-ID: <1332943273-22447-1-git-send-email-alexg@meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the compilation errors after the patches
from series mc13xxx-add-I2C-support-V4 were applied.

Signed-off-by: Alex Gershgorin <alexg@meprolight.com>
---
 drivers/mfd/Kconfig        |    2 ++
 drivers/mfd/mc13xxx-core.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index c3fbc5e..2119732 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -577,6 +577,8 @@ config MFD_MC13XXX
 	depends on SPI_MASTER || I2C
 	select MFD_CORE
 	select MFD_MC13783
+	select REGMAP_I2C if I2C
+	select REGMAP_SPI if SPI_MASTER
 	help
 	  Enable support for the Freescale MC13783 and MC13892 PMICs.
 	  This driver provides common support for accessing the device,
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 31dbf91..5a60273 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -616,7 +616,7 @@ static int mc13xxx_add_subdevice(struct mc13xxx *mc13xxx, const char *format)
 #ifdef CONFIG_OF
 static int mc13xxx_probe_flags_dt(struct mc13xxx *mc13xxx)
 {
-	struct device_node *np = mc13xxx->dev.of_node;
+	struct device_node *np = mc13xxx->dev->of_node;
 
 	if (!np)
 		return -ENODEV;
-- 
1.7.0.4
