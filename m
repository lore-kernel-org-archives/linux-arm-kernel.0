From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2016 23:54:11 +0200
Subject: [PATCH 5/9] drm/mediatek: add ARM_SMCCC dependency
In-Reply-To: <20160810215424.1926658-1-arnd@arndb.de>
References: <20160810215424.1926658-1-arnd@arndb.de>
Message-ID: <20160810215424.1926658-6-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM SMCCC is only set for ARMv7 and ARMv8 CPUs, but we currently
allow the driver to be build for older architecture levels as
well, which results in a link failure:

drivers/gpu/built-in.o: In function `mtk_hdmi_hw_make_reg_writable':
:(.text+0x1e737c): undefined reference to `arm_smccc_smc'

This adds a Kconfig dependency. The patch applies on my two
previous fixes that are not yet applied, so please apply all
three to get randconfig builds to work correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
Sent first on June 27 when it first broke in linux-next.
Two other dependencies were already missing, so I'm sending
all three patches again now.
---
 drivers/gpu/drm/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index 96ebf8bb6024..294de4549922 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -3,6 +3,7 @@ config DRM_MEDIATEK
 	depends on DRM
 	depends on ARCH_MEDIATEK || (ARM && COMPILE_TEST)
 	depends on COMMON_CLK
+	depends on HAVE_ARM_SMCCC
 	depends on OF
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_HELPER
-- 
2.9.0
