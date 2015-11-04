From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Nov 2015 16:00:32 +0100
Subject: [PATCH] bnxt_en: add VXLAN dependency
Message-ID: <10667823.xAtO4QOJMM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VXLAN may be a loadable module, and this driver cannot be built-in
in that case, or we get a link error:

drivers/built-in.o: In function `__bnxt_open_nic':
drivers/net/ethernet/broadcom/bnxt/bnxt.c:4581: undefined reference to `vxlan_get_rx_port'

This adds a Kconfig dependency that ensures that either VXLAN is
disabled (which the driver handles correctly), or we depend on
VXLAN itself and disallow built-in compilation when VXLAN is
a module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index 67a7d520d9f5..8550df189ceb 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -173,6 +173,7 @@ config SYSTEMPORT
 config BNXT
 	tristate "Broadcom NetXtreme-C/E support"
 	depends on PCI
+	depends on VXLAN || VXLAN=n
 	select FW_LOADER
 	select LIBCRC32C
 	---help---
