From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 18 Aug 2015 09:10:27 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable CROS_EC_PROTO for ChromeOS EC
 mfd driver
Message-ID: <1439881827-22613-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ChromeOS mfd driver (MFD_CROS_EC) select the CROS_EC_PROTO config
symbol because the driver uses some communication helper functions in
drivers/platform/chrome/cros_ec_proto.c but other drivers depends on
CROS_EC_PROTO instead. Mixing select and depends can lead to circular
Kconfig dependencies so the MFD_CROS_EC select should be changed to a
depends on CROS_EC_PROTO instead.

But doing so will break git bisect-ability since MFD_CROS_EC will not
be enabled anymore unless the default configs first explicitly enable
the CROS_EC_PROTO dependency.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b2facab87399..bd406f660ffe 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -619,6 +619,7 @@ CONFIG_QCOM_PM=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC_CHARDEV=m
+CONFIG_CROS_EC_PROTO=y
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_MAX77802=m
 CONFIG_COMMON_CLK_S2MPS11=m
-- 
2.4.3
