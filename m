From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Mar 2016 16:24:08 +0100
Subject: [PATCH 6/6] phy: twl4030: use __maybe_unused to hide pm functions
In-Reply-To: <1456932255-71725-1-git-send-email-arnd@arndb.de>
References: <1456932255-71725-1-git-send-email-arnd@arndb.de>
Message-ID: <1456932255-71725-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The twl4030 USB PHY driver uses UNIVERSAL_DEV_PM_OPS to access
its suspend/resume functions, which causes a warning about
unused symbols when CONFIG_PM is disabled:

drivers/phy/phy-twl4030-usb.c:394:12: error: 'twl4030_usb_runtime_suspend' defined but not used [-Werror=unused-function]
drivers/phy/phy-twl4030-usb.c:408:12: error: 'twl4030_usb_runtime_resume' defined but not used [-Werror=unused-function]

This adds __maybe_unused annotations to let the compiler know
it can silently drop the function definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/phy-twl4030-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 840f3eae428b..6b6af6cba454 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -391,7 +391,7 @@ static void __twl4030_phy_power(struct twl4030_usb *twl, int on)
 	WARN_ON(twl4030_usb_write_verify(twl, PHY_PWR_CTRL, pwr) < 0);
 }
 
-static int twl4030_usb_runtime_suspend(struct device *dev)
+static int __maybe_unused twl4030_usb_runtime_suspend(struct device *dev)
 {
 	struct twl4030_usb *twl = dev_get_drvdata(dev);
 
@@ -405,7 +405,7 @@ static int twl4030_usb_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int twl4030_usb_runtime_resume(struct device *dev)
+static int __maybe_unused twl4030_usb_runtime_resume(struct device *dev)
 {
 	struct twl4030_usb *twl = dev_get_drvdata(dev);
 	int res;
-- 
2.7.0
