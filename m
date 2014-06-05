From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Jun 2014 23:05:48 +0200
Subject: [PATCH 2/3] pcmcia: pxa2xx: fix logic for lubbock
In-Reply-To: <1402002349-1984057-1-git-send-email-arnd@arndb.de>
References: <1402002349-1984057-1-git-send-email-arnd@arndb.de>
Message-ID: <1402002349-1984057-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The lubbock platform uses the sa1111 companion chip with a pxa250
CPU, which means it requires both the PCMCIA_SA1111 and the
PCMCIA_PXA2XX code to be built into the kernel. Unfortunately,
the Makefile and Kconfig don't agree on how this is accomplished,
leading to a situation where you get this link error when building
a lubbock kernel with PCMCIA_SA1111 enabled but PCMCIA_PXA2XX
disabled:

ERROR: "pxa2xx_configure_sockets" [drivers/pcmcia/sa1111_cs.ko] undefined!
ERROR: "pxa2xx_drv_pcmcia_ops" [drivers/pcmcia/sa1111_cs.ko] undefined!
ERROR: "pxa2xx_drv_pcmcia_add_one" [drivers/pcmcia/sa1111_cs.ko] undefined!

This patch changes the Kconfig code to disallow that particular
configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pcmcia/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 0c657d6..51cf808 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -202,6 +202,7 @@ config PCMCIA_SA1111
 	depends on ARM && SA1111 && PCMCIA
 	select PCMCIA_SOC_COMMON
 	select PCMCIA_SA11XX_BASE if ARCH_SA1100
+	select PCMCIA_PXA2XX if ARCH_LUBBOCK && SA1111
 	help
 	  Say Y  here to include support for SA1111-based PCMCIA or CF
 	  sockets, found on the Jornada 720, Graphicsmaster and other
@@ -217,7 +218,6 @@ config PCMCIA_PXA2XX
 		    || ARCOM_PCMCIA || ARCH_PXA_ESERIES || MACH_STARGATE2 \
 		    || MACH_VPAC270 || MACH_BALLOON3 || MACH_COLIBRI \
 		    || MACH_COLIBRI320 || MACH_H4700)
-	select PCMCIA_SA1111 if ARCH_LUBBOCK && SA1111
 	select PCMCIA_SOC_COMMON
 	help
 	  Say Y here to include support for the PXA2xx PCMCIA controller
-- 
1.8.3.2
