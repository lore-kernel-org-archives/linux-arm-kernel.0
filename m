From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2016 23:54:09 +0200
Subject: [PATCH 3/9] drm/mediatek: add COMMON_CLK dependency
In-Reply-To: <20160810215424.1926658-1-arnd@arndb.de>
References: <20160810215424.1926658-1-arnd@arndb.de>
Message-ID: <20160810215424.1926658-4-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On kernel builds without COMMON_CLK, the newly added mediatek drm
driver fails to build:

drivers/gpu/drm/mediatek/mtk_mipi_tx.c:130:16: error: field 'pll_hw' has incomplete type
  struct clk_hw pll_hw;
                ^~~~~~
In file included from ../include/linux/clk.h:16:0,
                 from ../drivers/gpu/drm/mediatek/mtk_mipi_tx.c:14:
drivers/gpu/drm/mediatek/mtk_mipi_tx.c: In function 'mtk_mipi_tx_from_clk_hw':
include/linux/kernel.h:831:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
  const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                ^
/drivers/gpu/drm/mediatek/mtk_mipi_tx.c:136:9: note: in expansion of macro 'container_of'
  return container_of(hw, struct mtk_mipi_tx, pll_hw);
         ^~~~~~~~~~~~
drivers/gpu/drm/mediatek/mtk_mipi_tx.c: At top level:
drivers/gpu/drm/mediatek/mtk_mipi_tx.c:302:21: error: variable 'mtk_mipi_tx_pll_ops' has initializer but incomplete type
 static const struct clk_ops mtk_mipi_tx_pll_ops = {

This adds the required Kconfig dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://patchwork.kernel.org/patch/9069061/
---
I originally sent this on May 11 2016 after the driver was added with this
bug, but my fix never made it in.
---
 drivers/gpu/drm/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index 23ac8041c562..5c2163737691 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -2,6 +2,7 @@ config DRM_MEDIATEK
 	tristate "DRM Support for Mediatek SoCs"
 	depends on DRM
 	depends on ARCH_MEDIATEK || (ARM && COMPILE_TEST)
+	depends on COMMON_CLK
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
-- 
2.9.0
