From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:23:16 +0000
Subject: [PATCH 18/19] PCMCIA: make lubbock socket driver part of sa1111_cs
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBcq-0005ic-3r@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lubbock is just another SA1111 socket driver, so now that Kconfig has
better control of which files get built, we can sanitize the build
for this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/Kconfig  |    5 +++--
 drivers/pcmcia/Makefile |    3 +--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index b7f3d29..bba3ab2 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -200,9 +200,9 @@ config PCMCIA_SA1100
 
 config PCMCIA_SA1111
 	tristate "SA1111 support"
-	depends on ARM && ARCH_SA1100 && SA1111 && PCMCIA
+	depends on ARM && SA1111 && PCMCIA
 	select PCMCIA_SOC_COMMON
-	select PCMCIA_SA11XX_BASE
+	select PCMCIA_SA11XX_BASE if ARCH_SA1100
 	help
 	  Say Y  here to include support for SA1111-based PCMCIA or CF
 	  sockets, found on the Jornada 720, Graphicsmaster and other
@@ -218,6 +218,7 @@ config PCMCIA_PXA2XX
 		    || ARCOM_PCMCIA || ARCH_PXA_ESERIES || MACH_STARGATE2 \
 		    || MACH_VPAC270 || MACH_BALLOON3 || MACH_COLIBRI \
 		    || MACH_COLIBRI320)
+	select PCMCIA_SA1111 if ARCH_LUBBOCK && SA1111
 	select PCMCIA_SOC_COMMON
 	help
 	  Say Y here to include support for the PXA2xx PCMCIA controller
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index 05136dd..49d79f7 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -43,6 +43,7 @@ sa1111_cs-y					+= sa1111_generic.o
 sa1111_cs-$(CONFIG_ASSABET_NEPONSET)		+= sa1100_neponset.o
 sa1111_cs-$(CONFIG_SA1100_BADGE4)		+= sa1100_badge4.o
 sa1111_cs-$(CONFIG_SA1100_JORNADA720)		+= sa1100_jornada720.o
+sa1111_cs-$(CONFIG_ARCH_LUBBOCK)		+= pxa2xx_lubbock.o
 
 sa1100_cs-y					+= sa1100_generic.o
 sa1100_cs-$(CONFIG_SA1100_ASSABET)		+= sa1100_assabet.o
@@ -53,9 +54,7 @@ sa1100_cs-$(CONFIG_SA1100_NANOENGINE)		+= sa1100_nanoengine.o
 sa1100_cs-$(CONFIG_SA1100_SHANNON)		+= sa1100_shannon.o
 sa1100_cs-$(CONFIG_SA1100_SIMPAD)		+= sa1100_simpad.o
 
-pxa2xx_lubbock_cs-y				+= pxa2xx_lubbock.o sa1111_generic.o
 pxa2xx_cm_x2xx_cs-y				+= pxa2xx_cm_x2xx.o pxa2xx_cm_x255.o pxa2xx_cm_x270.o
-pxa2xx-obj-$(CONFIG_ARCH_LUBBOCK)		+= pxa2xx_lubbock_cs.o
 pxa2xx-obj-$(CONFIG_MACH_MAINSTONE)		+= pxa2xx_mainstone.o
 pxa2xx-obj-$(CONFIG_PXA_SHARPSL)		+= pxa2xx_sharpsl.o
 pxa2xx-obj-$(CONFIG_MACH_ARMCORE)		+= pxa2xx_cm_x2xx_cs.o
-- 
1.7.4.4
