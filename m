From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 May 2015 10:39:28 +0200
Subject: [PATCH] mtd: use cfi-util in jedecprobe
Message-ID: <7230287.A5AxNMN3qP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent change to move cfi helper functions out of line
is causing build errors when cfi-util is a loadable module
and jedecprobe is built-in:

drivers/built-in.o: In function `jedec_reset':
(.text+0x140694): undefined reference to `cfi_send_gen_cmd'
drivers/built-in.o: In function `jedec_probe_chip':
(.text+0x140794): undefined reference to `cfi_build_cmd_addr'

This adds a 'select' for the module containing these functions
from the jedecprobe code, to ensure it is always reachable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4612c715a6ea6 ("mtd: cfi: deinline large functions")

diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
index 6f20977f8cf6..63b6b536b044 100644
--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -16,6 +16,7 @@ config MTD_CFI
 config MTD_JEDECPROBE
 	tristate "Detect non-CFI AMD/JEDEC-compatible flash chips"
 	select MTD_GEN_PROBE
+	select MTD_CFI_UTIL
 	help
 	  This option enables JEDEC-style probing of flash chips which are not
 	  compatible with the Common Flash Interface, but will use the common
