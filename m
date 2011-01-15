From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 15 Jan 2011 19:25:57 +0100
Subject: [PATCH 7/8] ARM: pxa: Use gpio arrays in palmld_hdd driver
In-Reply-To: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
References: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1295115958-4811-7-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_request_array() / gpio_free_array(), this makes the code
cleaner and less error prone.

This patch also properly frees GPIOs in case ata_host_activate() call fails.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/ata/pata_palmld.c |   43 ++++++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
index 11fb4cc..fecf527 100644
--- a/drivers/ata/pata_palmld.c
+++ b/drivers/ata/pata_palmld.c
@@ -33,6 +33,11 @@
 
 #define DRV_NAME "pata_palmld"
 
+static struct gpio palmld_hdd_gpios[] = {
+	{ GPIO_NR_PALMLD_IDE_PWEN,	GPIOF_INIT_HIGH,	"HDD Power" },
+	{ GPIO_NR_PALMLD_IDE_RESET,	GPIOF_INIT_LOW,		"HDD Reset" },
+};
+
 static struct scsi_host_template palmld_sht = {
 	ATA_PIO_SHT(DRV_NAME),
 };
@@ -52,28 +57,23 @@ static __devinit int palmld_pata_probe(struct platform_device *pdev)
 
 	/* allocate host */
 	host = ata_host_alloc(&pdev->dev, 1);
-	if (!host)
-		return -ENOMEM;
+	if (!host) {
+		ret = -ENOMEM;
+		goto err1;
+	}
 
 	/* remap drive's physical memory address */
 	mem = devm_ioremap(&pdev->dev, PALMLD_IDE_PHYS, 0x1000);
-	if (!mem)
-		return -ENOMEM;
+	if (!mem) {
+		ret = -ENOMEM;
+		goto err1;
+	}
 
 	/* request and activate power GPIO, IRQ GPIO */
-	ret = gpio_request(GPIO_NR_PALMLD_IDE_PWEN, "HDD PWR");
+	ret = gpio_request_array(palmld_hdd_gpios,
+				ARRAY_SIZE(palmld_hdd_gpios));
 	if (ret)
 		goto err1;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_IDE_PWEN, 1);
-	if (ret)
-		goto err2;
-
-	ret = gpio_request(GPIO_NR_PALMLD_IDE_RESET, "HDD RST");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_IDE_RESET, 0);
-	if (ret)
-		goto err3;
 
 	/* reset the drive */
 	gpio_set_value(GPIO_NR_PALMLD_IDE_RESET, 0);
@@ -96,13 +96,15 @@ static __devinit int palmld_pata_probe(struct platform_device *pdev)
 	ata_sff_std_ports(&ap->ioaddr);
 
 	/* activate host */
-	return ata_host_activate(host, 0, NULL, IRQF_TRIGGER_RISING,
+	ret = ata_host_activate(host, 0, NULL, IRQF_TRIGGER_RISING,
 					&palmld_sht);
+	if (ret)
+		goto err2;
+
+	return ret;
 
-err3:
-	gpio_free(GPIO_NR_PALMLD_IDE_RESET);
 err2:
-	gpio_free(GPIO_NR_PALMLD_IDE_PWEN);
+	gpio_free_array(palmld_hdd_gpios, ARRAY_SIZE(palmld_hdd_gpios));
 err1:
 	return ret;
 }
@@ -116,8 +118,7 @@ static __devexit int palmld_pata_remove(struct platform_device *dev)
 	/* power down the HDD */
 	gpio_set_value(GPIO_NR_PALMLD_IDE_PWEN, 0);
 
-	gpio_free(GPIO_NR_PALMLD_IDE_RESET);
-	gpio_free(GPIO_NR_PALMLD_IDE_PWEN);
+	gpio_free_array(palmld_hdd_gpios, ARRAY_SIZE(palmld_hdd_gpios));
 
 	return 0;
 }
-- 
1.7.2.3
