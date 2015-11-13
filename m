From: eddie.huang@mediatek.com (Eddie Huang)
Date: Fri, 13 Nov 2015 18:50:35 +0800
Subject: [PATCH] soc: Mediatek: Enable SCPSYS power domain driver by default
Message-ID: <1447411835-19035-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If enable Mediatek 8173 SoC, it should also enable power domain
driver. Otherwise access clk subsystem register will fail.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>

---
MT8173 clk driver is enabled by default, but power domain driver
is not. If MM subsystem power on, mm_sel topckgen mux is off,
then access any MM subsystem register will cause system hang. Enable
SCPSYS driver to make sure both MM subsystem power and mm_sel to
on/off together to avoid system hang.

This patch fix current linux-next mt8173-evb boot to shell fail
problem.
---
 drivers/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 9d50682..0a4ea80 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -23,6 +23,7 @@ config MTK_PMIC_WRAP
 config MTK_SCPSYS
 	bool "MediaTek SCPSYS Support"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	default ARM64 && ARCH_MEDIATEK
 	select REGMAP
 	select MTK_INFRACFG
 	select PM_GENERIC_DOMAINS if PM
-- 
1.9.1
