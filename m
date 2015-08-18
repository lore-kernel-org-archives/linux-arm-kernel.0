From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 18 Aug 2015 09:01:21 +0200
Subject: [PATCH] ARM: exynos_defconfig: Enable CROS_EC_PROTO for ChromeOS EC
 mfd driver
Message-ID: <1439881281-22054-1-git-send-email-javier@osg.samsung.com>
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
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 1ff2bfa2e183..537391ea37ac 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -177,6 +177,7 @@ CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC_CHARDEV=y
+CONFIG_CROS_EC_PROTO=y
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_MAX77802=y
 CONFIG_COMMON_CLK_S2MPS11=y
-- 
2.4.3
