From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Nov 2015 15:22:23 +0100
Subject: [PATCH v3] scsi: advansys needs ISA dma api for ISA support
Message-ID: <4355540.BF55dNX7U7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The advansys drvier uses the request_dma function that is used on ISA
machines for the internal DMA controller, which causes build errors
on platforms that have ISA slots but do not provide the ISA DMA API:

drivers/scsi/advansys.c: In function 'advansys_board_found':
drivers/scsi/advansys.c:11300:10: error: implicit declaration of function 'request_dma' [-Werror=implicit-function-declaration]

The problem now showed up in ARM randconfig builds after commit
6571fb3f8b7f ("advansys: Update to version 3.5 and remove compilation
warning") made it possible to build on platforms that have neither
VIRT_TO_BUS nor ISA_DMA_API but that do have ISA.

This adds the missing dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is identical to v1 of the patch. We had gone through several iterations
of this in October before concluding that everything else was more problematic.

Please apply.

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 5f692ae40749..04a720686516 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -499,6 +499,7 @@ config SCSI_ADVANSYS
 	tristate "AdvanSys SCSI support"
 	depends on SCSI
 	depends on ISA || EISA || PCI
+	depends on ISA_DMA_API || !ISA
 	help
 	  This is a driver for all SCSI host adapters manufactured by
 	  AdvanSys. It is documented in the kernel source in
