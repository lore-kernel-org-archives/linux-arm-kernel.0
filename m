From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 May 2015 11:07:08 +0200
Subject: [PATCH] ASoC: qcom: remove incorrect dependencies
Message-ID: <2324031.cqS0mEEEhQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compile-tests show a warning for the newly added SND_SOC_STORM
symbol:

warning: (SND_SOC_STORM) selects SND_SOC_LPASS_CPU which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && SND_SOC_QCOM)

The problem is that it can be selected for COMPILE_TEST on non-QCOM
builds, but the symbols it selects have a dependency.
Dropping the dependencies makes it work without warnings and no
other side-effects, because these are not user-visible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: f380dd3f3cd ("ASoC: qcom: Add ability to build QCOM drivers")

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 5f58e4f1bca9..b07f183fc47f 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -6,12 +6,10 @@ config SND_SOC_QCOM
 
 config SND_SOC_LPASS_CPU
 	tristate
-	depends on SND_SOC_QCOM
 	select REGMAP_MMIO
 
 config SND_SOC_LPASS_PLATFORM
 	tristate
-	depends on SND_SOC_QCOM
 	select REGMAP_MMIO
 
 config SND_SOC_STORM
