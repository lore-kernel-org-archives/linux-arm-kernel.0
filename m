From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Mar 2016 16:24:07 +0100
Subject: [PATCH 5/6] phy: dm816x: use __maybe_unused to hide pm functions
In-Reply-To: <1456932255-71725-1-git-send-email-arnd@arndb.de>
References: <1456932255-71725-1-git-send-email-arnd@arndb.de>
Message-ID: <1456932255-71725-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dm816x USB PHY driver uses UNIVERSAL_DEV_PM_OPS to access
its suspend/resume functions, which causes a warning about
unused symbols when CONFIG_PM is disabled:

drivers/phy/phy-dm816x-usb.c:121:12: error: 'dm816x_usb_phy_runtime_suspend' defined but not used [-Werror=unused-function]
drivers/phy/phy-dm816x-usb.c:139:12: error: 'dm816x_usb_phy_runtime_resume' defined but not used [-Werror=unused-function]

This adds __maybe_unused annotations to let the compiler know
it can silently drop the function definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/phy-dm816x-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-dm816x-usb.c b/drivers/phy/phy-dm816x-usb.c
index b4bbef664d20..cbcce7cf0028 100644
--- a/drivers/phy/phy-dm816x-usb.c
+++ b/drivers/phy/phy-dm816x-usb.c
@@ -118,7 +118,7 @@ static const struct phy_ops ops = {
 	.owner		= THIS_MODULE,
 };
 
-static int dm816x_usb_phy_runtime_suspend(struct device *dev)
+static int __maybe_unused dm816x_usb_phy_runtime_suspend(struct device *dev)
 {
 	struct dm816x_usb_phy *phy = dev_get_drvdata(dev);
 	unsigned int mask, val;
@@ -136,7 +136,7 @@ static int dm816x_usb_phy_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int dm816x_usb_phy_runtime_resume(struct device *dev)
+static int __maybe_unused dm816x_usb_phy_runtime_resume(struct device *dev)
 {
 	struct dm816x_usb_phy *phy = dev_get_drvdata(dev);
 	unsigned int mask, val;
-- 
2.7.0
