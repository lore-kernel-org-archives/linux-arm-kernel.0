From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 22:54:57 +0100
Subject: [PATCH 2/3] tty: cyclades: cyz_interrupt is only used for PCI
In-Reply-To: <1453758918-3577213-1-git-send-email-arnd@arndb.de>
References: <1453758918-3577213-1-git-send-email-arnd@arndb.de>
Message-ID: <1453758918-3577213-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_PCI is not set, enabling CONFIG_CYZ_INTR has no
practical effect other than generating a warning about an
unused function:

drivers/tty/cyclades.c:1184:20: warning: 'cyz_interrupt' defined but not used [-Wunused-function]
 static irqreturn_t cyz_interrupt(int irq, void *dev_id)

This adds a dependency to avoid that warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index c01f45095877..82c4d2e45319 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -226,7 +226,7 @@ config CYCLADES
 
 config CYZ_INTR
 	bool "Cyclades-Z interrupt mode operation"
-	depends on CYCLADES
+	depends on CYCLADES && PCI
 	help
 	  The Cyclades-Z family of multiport cards allows 2 (two) driver op
 	  modes: polling and interrupt. In polling mode, the driver will check
-- 
2.7.0
