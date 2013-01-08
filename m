From: josh.coombs@gmail.com (Joshua Coombs)
Date: Tue,  8 Jan 2013 13:16:27 -0500
Subject: [PATCH] Allow Marvell SATA driver to work with LEDS_TRIGGER_IDE_DISK
Message-ID: <1357668987-3610-1-git-send-email-josh.coombs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a call to the IDE LED Trigger within the Marvell SATA driver to allow
Marvell SoC devices to show SATA activity via GPIO connected LEDs.

Signed-off-by: Joshua Coombs <josh.coombs@gmail.com>
---
 drivers/ata/sata_mv.c | 3 +++
 drivers/leds/Kconfig  | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 68f4fb5..4aaf6f0 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -71,6 +71,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
 #include <linux/libata.h>
+#include <linux/leds.h>
 
 #define DRV_NAME	"sata_mv"
 #define DRV_VERSION	"1.28"
@@ -1156,6 +1157,8 @@ static void mv_start_edma(struct ata_port *ap, void __iomem *port_mmio,
 {
 	int want_ncq = (protocol == ATA_PROT_NCQ);
 
+	ledtrig_ide_activity();
+
 	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
 		int using_ncq = ((pp->pp_flags & MV_PP_FLAG_NCQ_EN) != 0);
 		if (want_ncq != using_ncq)
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index b58bc8a..d2071d0 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -496,10 +496,9 @@ config LEDS_TRIGGER_ONESHOT
 
 config LEDS_TRIGGER_IDE_DISK
 	bool "LED IDE Disk Trigger"
-	depends on IDE_GD_ATA
 	depends on LEDS_TRIGGERS
 	help
-	  This allows LEDs to be controlled by IDE disk activity.
+	  This allows LEDs to be controlled by IDE or SATA disk activity.
 	  If unsure, say Y.
 
 config LEDS_TRIGGER_HEARTBEAT
-- 
1.8.0.2
