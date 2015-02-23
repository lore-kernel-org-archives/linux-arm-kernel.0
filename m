From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Feb 2015 11:08:50 +0100
Subject: [PATCH] NVMe: add explicit BLK_DEV_INTEGRITY dependency
Message-ID: <6241161.LKiT8yUlIj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A patch that was added to 4.0-rc1 in the last minute caused a
build break in the NVMe driver unless integrity support is
also enabled:

drivers/block/nvme-core.c: In function 'nvme_dif_remap':
drivers/block/nvme-core.c:523:24: error: dereferencing pointer to incomplete type
  pmap = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec->bv_offset;
                        ^
drivers/block/nvme-core.c:523:49: error: dereferencing pointer to incomplete type
  pmap = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec->bv_offset;
                                                 ^

This changes the Kconfig entry for NVMe to depend on that
support, to avoid the build error. Using 'select' would work
as well, but might have unintended side-effects when users
do not actually want the integerity support.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e1e5e5641e6f ("NVMe: Metadata format support")
---
Found on ARM randconfig builds

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1b8094d4d7af..e386dd5b94e9 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -312,7 +312,7 @@ config BLK_DEV_NBD
 
 config BLK_DEV_NVME
 	tristate "NVM Express block device"
-	depends on PCI
+	depends on PCI && BLK_DEV_INTEGRITY
 	---help---
 	  The NVM Express driver is for solid state drives directly
 	  connected to the PCI or PCI Express bus.  If you know you
