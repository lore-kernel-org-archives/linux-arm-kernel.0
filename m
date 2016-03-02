From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Mar 2016 16:59:04 +0100
Subject: [PATCH 12/14] keyboard: snvs-pwrkey: use __maybe_unused to hide pm
 functions
In-Reply-To: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
Message-ID: <1456934350-1389172-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SNVS power key driver has suspend/resume functions that
are accessed using SIMPLE_DEV_PM_OPS, which hide the reference
when CONFIG_PM_SLEEP is not set, resulting in a warning about
unused functions:

drivers/input/keyboard/snvs_pwrkey.c:183:12: error: 'imx_snvs_pwrkey_suspend' defined but not used [-Werror=unused-function]
drivers/input/keyboard/snvs_pwrkey.c:194:12: error: 'imx_snvs_pwrkey_resume' defined but not used [-Werror=unused-function]

This adds __maybe_unused annotations to let the compiler know
it can silently drop the function definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/keyboard/snvs_pwrkey.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 9adf13a5864a..b0ffadeb208c 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -180,7 +180,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int imx_snvs_pwrkey_suspend(struct device *dev)
+static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
@@ -191,7 +191,7 @@ static int imx_snvs_pwrkey_suspend(struct device *dev)
 	return 0;
 }
 
-static int imx_snvs_pwrkey_resume(struct device *dev)
+static int __maybe_unused imx_snvs_pwrkey_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
-- 
2.7.0
