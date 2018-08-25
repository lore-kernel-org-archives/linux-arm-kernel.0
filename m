From: stripathi@amperecomputing.com (Suman Tripathi)
Date: Sat, 25 Aug 2018 13:29:58 -0700
Subject: [PATCH] ata: Disable AHCI ALPM feature for Ampere Computing eMAG SATA
Message-ID: <1535228998-9853-1-git-send-email-stripathi@amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to hardware errata, Ampere Computing eMAG SATA can't support
AHCI ALPM feature. This patch disables the AHCI ALPM feature for
eMAG SATA.

Signed-off-by: Suman Tripathi <stripathi@amperecomputing.com>
Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
---
 drivers/ata/ahci_platform.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 99f9a89..0d0233e 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -26,7 +26,7 @@

 #define DRV_NAME "ahci"

-static const struct ata_port_info ahci_port_info = {
+static struct ata_port_info ahci_port_info = {
        .flags          = AHCI_FLAG_COMMON,
        .pio_mask       = ATA_PIO4,
        .udma_mask      = ATA_UDMA6,
@@ -41,6 +41,8 @@ static int ahci_probe(struct platform_device *pdev)
 {
        struct device *dev = &pdev->dev;
        struct ahci_host_priv *hpriv;
+       struct acpi_device_info *info;
+       acpi_status status;
        int rc;

        hpriv = ahci_platform_get_resources(pdev);
@@ -57,6 +59,15 @@ static int ahci_probe(struct platform_device *pdev)
        if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
                hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;

+       status = acpi_get_object_info(ACPI_HANDLE(dev), &info);
+       if (ACPI_SUCCESS(status)) {
+               if (info->valid & ACPI_VALID_HID) {
+                       if (!strcmp("APMC0D33", info->hardware_id.string))
+                               ahci_port_info.flags |= ATA_FLAG_NO_LPM;
+               }
+               ACPI_FREE(info);
+       }
+
        rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
                                     &ahci_platform_sht);
        if (rc)
--
1.8.3.1

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is for the sole use of the intended recipient(s) and contains information that is confidential and proprietary to Ampere Computing or its subsidiaries. It is to be used solely for the purpose of furthering the parties' business relationship. Any review, copying, or distribution of this email (or any attachments thereto) is strictly prohibited. If you are not the intended recipient, please contact the sender immediately and permanently delete the original and any copies of this email and any attachments thereto.
