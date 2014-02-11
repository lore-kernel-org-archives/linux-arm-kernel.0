From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 11 Feb 2014 17:03:51 +0100
Subject: [PATCH] phy-core: Don't allow building phy-core as a module
Message-ID: <1392134631-32030-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

include/phy/phy.h has stub code in there for when building without the
phy-core enabled. This is useful for generic drivers such as ahci-platform,
ehci-platoform and ohci-platform which have support for driving an optional
phy passed to them through the devicetree.

Since on some boards this phy functionality is not needed, being able to
disable the phy subsystem without needing a lot of #ifdef magic in the
driver using it is quite useful.

However this breaks when the module using the phy subsystem is build-in and
the phy-core is not, which leads to the build failing with missing symbol
errors in the linking stage of the zImage.

Which leads to gems such as this being added to the Kconfig for achi_platform:

	depends on GENERIC_PHY || !GENERIC_PHY

Rather then duplicating this code in a lot of places using the phy-core,
I believe it is better to simply not allow the phy-core to be built as a
module. The phy core is quite small and has no external dependencies, so
always building it in when enabling it should not be an issue.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 6070c99..6e336b4 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -5,7 +5,7 @@
 menu "PHY Subsystem"
 
 config GENERIC_PHY
-	tristate "PHY Core"
+	bool "PHY Core"
 	help
 	  Generic PHY support.
 
-- 
1.8.5.3
