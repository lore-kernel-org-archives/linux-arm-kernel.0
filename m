From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 18 Aug 2015 09:06:39 +0200
Subject: [PATCH] ARM: tegra: Enable CROS_EC_PROTO for ChromeOS EC mfd driver
Message-ID: <1439881599-22348-1-git-send-email-javier@osg.samsung.com>
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

Also enable CHROME_PLATFORMS since the CROS_EC_PROTO symbol is inside
that submenu.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/configs/tegra_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 9808581176cc..03e775a70c6e 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -254,6 +254,8 @@ CONFIG_KEYBOARD_NVEC=y
 CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
+CONFIG_CHROME_PLATFORMS=y
+CONFIG_CROS_EC_PROTO=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_MEMORY=y
-- 
2.4.3
