From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 13 Mar 2015 22:40:52 +0800
Subject: [PATCH v3] pinctrl: mediatek: Adjust mt8173 pinctrl kconfig
In-Reply-To: <1425623091-30478-2-git-send-email-yingjoe.chen@mediatek.com>
References: <1425623091-30478-2-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1426257652-16779-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Yet another version. Changed based on Arnd's suggestion to make config
options for PINCTRL_MT8135 & PINCTRL_MT8173 more consist. This is based
on mtk-staging in your tree. If you think this is OK, please applied or
squash this into previous change. Thanks.

Old patch can be found at:
http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000057.html

Joe.C

8<-------------------------------------------------------
ARM64 maintainer doesn't want to add MACH_* for each SoC.
Adjust mt8173 pinctrl kconfig entry so user can manually select it.

Also make PINCTRL_MT8135 selectable when COMPILE_TEST is enabled.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/pinctrl/mediatek/Kconfig | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 49b8649..5983cf5 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -1,4 +1,4 @@
-if ARCH_MEDIATEK
+if ARCH_MEDIATEK || COMPILE_TEST
 
 config PINCTRL_MTK_COMMON
 	bool
@@ -7,12 +7,17 @@ config PINCTRL_MTK_COMMON
 	select GPIOLIB
 	select OF_GPIO
 
+# For ARMv7 SoCs
 config PINCTRL_MT8135
-	def_bool MACH_MT8135
+	bool "Mediatek MT8135 pin control" if COMPILE_TEST && !MACH_MT8135
+	default MACH_MT8135
 	select PINCTRL_MTK_COMMON
 
+# For ARMv8 SoCs
 config PINCTRL_MT8173
-	def_bool MACH_MT8173
+	bool "Mediatek MT8173 pin control"
+	depends on ARM64 || COMPILE_TEST
+	default ARM64 && ARCH_MEDIATEK
 	select PINCTRL_MTK_COMMON
 
 endif
-- 
1.8.1.1.dirty
