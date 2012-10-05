From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  5 Oct 2012 16:55:17 +0200
Subject: [PATCH 03/16] SCSI: ARM: ncr5380/oak uses no interrupts
In-Reply-To: <1349448930-23976-1-git-send-email-arnd@arndb.de>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
Message-ID: <1349448930-23976-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ncr5380 driver is included by multiple board specific
drivers, which may or may not use the interrupt handler.
The oak variant doesn't, and should set the DONT_USE_INTR
macro.

Without this patch, building rpc_defconfig results in:

drivers/scsi/arm/../NCR5380.c:1160:20: warning: 'oakscsi_intr' defined but not used [-Wunused-function]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: "James E.J. Bottomley" <JBottomley@parallels.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-scsi at vger.kernel.org
---
 drivers/scsi/arm/oak.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/arm/oak.c b/drivers/scsi/arm/oak.c
index d25f944..fc6a5aa 100644
--- a/drivers/scsi/arm/oak.c
+++ b/drivers/scsi/arm/oak.c
@@ -21,6 +21,7 @@
 /*#define PSEUDO_DMA*/
 
 #define OAKSCSI_PUBLIC_RELEASE 1
+#define DONT_USE_INTR
 
 #define priv(host)			((struct NCR5380_hostdata *)(host)->hostdata)
 #define NCR5380_local_declare()		void __iomem *_base
-- 
1.7.10
