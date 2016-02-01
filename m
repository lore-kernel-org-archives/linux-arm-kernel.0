From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  1 Feb 2016 21:35:55 +0100
Subject: [PATCH 1/4] ARM: davinci: limit DT support to DA850
In-Reply-To: <1454358962-640598-1-git-send-email-arnd@arndb.de>
References: <1454358962-640598-1-git-send-email-arnd@arndb.de>
Message-ID: <1454358962-640598-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When da8xx-dt.c is built with onlu DA830 support but not DA850
support enabled, we get a compiler warning about unused symbols:

arch/arm/mach-davinci/da8xx-dt.c:28:20: warning: 'da8xx_init_irq' defined but not used [-Wunused-function]
 static void __init da8xx_init_irq(void)
arch/arm/mach-davinci/da8xx-dt.c:33:30: warning: 'da850_auxdata_lookup' defined but not used [-Wunused-variable]
 static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {

Obviously none of the file make sense for DA830, so we should not
even attempt this, so we can avoid the warning by ensuring it is
only built for 850, not 830.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-davinci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 83e0f40f9ff1..6124c69154c3 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -68,7 +68,7 @@ comment "DaVinci Board Type"
 config MACH_DA8XX_DT
 	bool "Support DA8XX platforms using device tree"
 	default y
-	depends on ARCH_DAVINCI_DA8XX
+	depends on ARCH_DAVINCI_DA850
 	select PINCTRL
 	help
 	  Say y here to include support for TI DaVinci DA850 based using
-- 
2.7.0
