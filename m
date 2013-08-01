From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 01 Aug 2013 23:19:14 +0100
Subject: [PATCH RFC 45/51] DMA-API: firmware/google/gsmi.c: avoid direct
 access to DMA masks
In-Reply-To: <20130801213420.GL23006@n2100.arm.linux.org.uk>
References: <20130801213420.GL23006@n2100.arm.linux.org.uk>
Message-ID: <E1V51DG-0006uI-7o@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver doesn't need to directly access DMA masks if it uses the
platform_device_register_full() API rather than
platform_device_register_simple() - the former function can initialize
the DMA mask appropriately.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/firmware/google/gsmi.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index acba0b9..72e350f 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -764,6 +764,13 @@ static __init int gsmi_system_valid(void)
 static struct kobject *gsmi_kobj;
 static struct efivars efivars;
 
+static const struct platform_device_info gsmi_dev_info = {
+	.name		= "gsmi",
+	.id		= -1,
+	/* SMI callbacks require 32bit addresses */
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
 static __init int gsmi_init(void)
 {
 	unsigned long flags;
@@ -776,7 +783,7 @@ static __init int gsmi_init(void)
 	gsmi_dev.smi_cmd = acpi_gbl_FADT.smi_command;
 
 	/* register device */
-	gsmi_dev.pdev = platform_device_register_simple("gsmi", -1, NULL, 0);
+	gsmi_dev.pdev = platform_device_register_full(&gsmi_dev_info);
 	if (IS_ERR(gsmi_dev.pdev)) {
 		printk(KERN_ERR "gsmi: unable to register platform device\n");
 		return PTR_ERR(gsmi_dev.pdev);
@@ -785,10 +792,6 @@ static __init int gsmi_init(void)
 	/* SMI access needs to be serialized */
 	spin_lock_init(&gsmi_dev.lock);
 
-	/* SMI callbacks require 32bit addresses */
-	gsmi_dev.pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	gsmi_dev.pdev->dev.dma_mask =
-		&gsmi_dev.pdev->dev.coherent_dma_mask;
 	ret = -ENOMEM;
 	gsmi_dev.dma_pool = dma_pool_create("gsmi", &gsmi_dev.pdev->dev,
 					     GSMI_BUF_SIZE, GSMI_BUF_ALIGN, 0);
-- 
1.7.4.4
