From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Jun 2014 17:14:01 +0200
Subject: HSI: fix omap ssi driver dependency
Message-ID: <5261510.XDu5DxNnFl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SSI protocol implementation has an incorrect dependency on the OMAP_SSI
driver, which allows SSI to be built-in while the underlying OMAP_SSI
implementation is a loadable module, causing a link error.

This changes the dependency to the simpler 'depends on OMAP_SSI' that also
ensures that SSI-protocol can only be a module if OMAP_SSI is not built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
---
diff --git a/drivers/hsi/clients/Kconfig b/drivers/hsi/clients/Kconfig
index 71b9f9a..bc60dec 100644
--- a/drivers/hsi/clients/Kconfig
+++ b/drivers/hsi/clients/Kconfig
@@ -15,7 +15,7 @@ config NOKIA_MODEM
 
 config SSI_PROTOCOL
 	tristate "SSI protocol"
-	depends on HSI && PHONET && (OMAP_SSI=y || OMAP_SSI=m)
+	depends on HSI && PHONET && OMAP_SSI
 	help
 	If you say Y here, you will enable the SSI protocol aka McSAAB.
 
