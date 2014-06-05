From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Jun 2014 23:29:46 +0200
Subject: [PATCH 1/4] [SCSI] Don't build AdvanSys on ARM
In-Reply-To: <1402003789-1990031-1-git-send-email-arnd@arndb.de>
References: <1402003789-1990031-1-git-send-email-arnd@arndb.de>
Message-ID: <1402003789-1990031-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The advansys SCSI driver uses the dma_cache_sync function, which is
not available on the ARM architecture, and cannot be implemented
correctly, so we always get this build error:

drivers/scsi/advansys.c: In function 'advansys_get_sense_buffer_dma':
drivers/scsi/advansys.c:7882:2: error: implicit declaration of function 'dma_cache_sync' [-Werror=implicit-function-declaration]
  dma_cache_sync(board->dev, scp->sense_buffer,
  ^

It seems nobody has missed this driver so far, so let's just
disable it for ARM to help randconfig builds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Matthew Wilcox <matthew@wil.cx>
---
 drivers/scsi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index baca589..8368e00 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -528,7 +528,7 @@ config SCSI_DPT_I2O
 
 config SCSI_ADVANSYS
 	tristate "AdvanSys SCSI support"
-	depends on SCSI && VIRT_TO_BUS
+	depends on SCSI && VIRT_TO_BUS && !ARM
 	depends on ISA || EISA || PCI
 	help
 	  This is a driver for all SCSI host adapters manufactured by
-- 
1.8.3.2
