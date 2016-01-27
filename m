From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Jan 2016 16:57:17 +0100
Subject: [PATCH 1/7] scsi: fdomain: drop fdomain_pci_tbl when built-in
In-Reply-To: <1453910247-3447628-1-git-send-email-arnd@arndb.de>
References: <1453910247-3447628-1-git-send-email-arnd@arndb.de>
Message-ID: <1453910247-3447628-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fdomain SCSI host driver is one of the last remaining
drivers that manually search the PCI bus using pci_get_device
rather than registering a pci_driver instance.

This means the module device table is unused when the driver is
built-in, and we get a warning about it:

drivers/scsi/fdomain.c:1773:29: warning: 'fdomain_pci_tbl' defined but not used [-Wunused-variable]

To avoid the warning, this adds another #ifdef around the table
definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/fdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fdomain.c b/drivers/scsi/fdomain.c
index eefe14d453db..b87ab38a4530 100644
--- a/drivers/scsi/fdomain.c
+++ b/drivers/scsi/fdomain.c
@@ -1768,7 +1768,7 @@ struct scsi_host_template fdomain_driver_template = {
 };
 
 #ifndef PCMCIA
-#ifdef CONFIG_PCI
+#if defined(CONFIG_PCI) && defined(MODULE)
 
 static struct pci_device_id fdomain_pci_tbl[] = {
 	{ PCI_VENDOR_ID_FD, PCI_DEVICE_ID_FD_36C70,
-- 
2.7.0
