From: stripathi@amperecomputing.com (Suman Tripathi)
Date: Wed,  5 Sep 2018 21:33:41 -0700
Subject: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing eMAG
 SATA
Message-ID: <1536208421-24867-1-git-send-email-stripathi@amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to hardware errata, Ampere Computing eMAG SATA can't support
AHCI ALPM feature. This patch disables the AHCI ALPM feature for
eMAG SATA.

Changes for v2:

* Introduce the new ata_port_info object which includes ATA_FLAG_NO_LPM.
* Include this object for eMAG SATA inside the acpi match table.
* Retrieve the ata_port_info from the acpi match table.

Changes for v3:

* Fix the indentation and whitespace warnings.

Signed-off-by: Suman Trpathi <stripathi@amperecomputing.com>
Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
---
 drivers/ata/ahci_platform.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 99f9a89..9ba283f 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -33,6 +33,13 @@ static const struct ata_port_info ahci_port_info = {
        .port_ops       = &ahci_platform_ops,
 };

+static const struct ata_port_info ahci_port_info_nolpm = {
+       .flags          = AHCI_FLAG_COMMON | ATA_FLAG_NO_LPM,
+       .pio_mask       = ATA_PIO4,
+       .udma_mask      = ATA_UDMA6,
+       .port_ops       = &ahci_platform_ops,
+};
+
 static struct scsi_host_template ahci_platform_sht = {
        AHCI_SHT(DRV_NAME),
 };
@@ -41,6 +48,7 @@ static int ahci_probe(struct platform_device *pdev)
 {
        struct device *dev = &pdev->dev;
        struct ahci_host_priv *hpriv;
+       const struct ata_port_info *port;
        int rc;

        hpriv = ahci_platform_get_resources(pdev);
@@ -57,7 +65,11 @@ static int ahci_probe(struct platform_device *pdev)
        if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
                hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;

-       rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
+       port = acpi_device_get_match_data(dev);
+       if (!port)
+               port = &ahci_port_info;
+
+       rc = ahci_platform_init_host(pdev, hpriv, port,
                                     &ahci_platform_sht);
        if (rc)
                goto disable_resources;
@@ -85,6 +97,7 @@ static const struct of_device_id ahci_of_match[] = {
 MODULE_DEVICE_TABLE(of, ahci_of_match);

 static const struct acpi_device_id ahci_acpi_match[] = {
+       { "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
        { ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
        {},
 };
--
2.7.4

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is for the sole use of the intended recipient(s) and contains information that is confidential and proprietary to Ampere Computing or its subsidiaries. It is to be used solely for the purpose of furthering the parties' business relationship. Any review, copying, or distribution of this email (or any attachments thereto) is strictly prohibited. If you are not the intended recipient, please contact the sender immediately and permanently delete the original and any copies of this email and any attachments thereto.
