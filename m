From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1=20=C4=8Cech?=)
Date: Mon, 31 Aug 2009 19:25:57 +0200
Subject: [PATCH 1/5] Treo680: pxamci simplify to use GPIO
In-Reply-To: <1251739561-28972-1-git-send-email-sleep_walker@suse.cz>
References: <1251739561-28972-1-git-send-email-sleep_walker@suse.cz>
Message-ID: <1251739561-28972-2-git-send-email-sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tom?? ?ech <sleep walker@suse.cz>


Signed-off-by: Tom?? ?ech <sleep_walker@suse.cz>
---
 arch/arm/mach-pxa/treo680.c |   84 ++----------------------------------------
 1 files changed, 4 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-pxa/treo680.c b/arch/arm/mach-pxa/treo680.c
index a06f19e..050ad8e 100644
--- a/arch/arm/mach-pxa/treo680.c
+++ b/arch/arm/mach-pxa/treo680.c
@@ -153,87 +153,11 @@ static unsigned long treo680_pin_config[] __initdata = {
 /******************************************************************************
  * SD/MMC card controller
  ******************************************************************************/
-static int treo680_mci_init(struct device *dev,
-		irq_handler_t treo680_detect_int, void *data)
-{
-	int err = 0;
-
-	/* Setup an interrupt for detecting card insert/remove events */
-	err = gpio_request(GPIO_NR_TREO680_SD_DETECT_N, "SD IRQ");
-
-	if (err)
-		goto err;
-
-	err = gpio_direction_input(GPIO_NR_TREO680_SD_DETECT_N);
-	if (err)
-		goto err2;
-
-	err = request_irq(gpio_to_irq(GPIO_NR_TREO680_SD_DETECT_N),
-			treo680_detect_int, IRQF_DISABLED | IRQF_SAMPLE_RANDOM |
-			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-			"SD/MMC card detect", data);
-
-	if (err) {
-		dev_err(dev, "%s: cannot request SD/MMC card detect IRQ\n",
-			     __func__);
-		goto err2;
-	}
-
-	err = gpio_request(GPIO_NR_TREO680_SD_POWER, "SD_POWER");
-	if (err)
-		goto err3;
-
-	err = gpio_direction_output(GPIO_NR_TREO680_SD_POWER, 1);
-	if (err)
-		goto err4;
-
-	err = gpio_request(GPIO_NR_TREO680_SD_READONLY, "SD_READONLY");
-	if (err)
-		goto err4;
-
-	err = gpio_direction_input(GPIO_NR_TREO680_SD_READONLY);
-	if (err)
-		goto err5;
-
-	return 0;
-
-err5:
-	gpio_free(GPIO_NR_TREO680_SD_READONLY);
-err4:
-	gpio_free(GPIO_NR_TREO680_SD_POWER);
-err3:
-	free_irq(gpio_to_irq(GPIO_NR_TREO680_SD_DETECT_N), data);
-err2:
-	gpio_free(GPIO_NR_TREO680_SD_DETECT_N);
-err:
-	return err;
-}
-
-static void treo680_mci_exit(struct device *dev, void *data)
-{
-	gpio_free(GPIO_NR_TREO680_SD_READONLY);
-	gpio_free(GPIO_NR_TREO680_SD_POWER);
-	free_irq(gpio_to_irq(GPIO_NR_TREO680_SD_DETECT_N), data);
-	gpio_free(GPIO_NR_TREO680_SD_DETECT_N);
-}
-
-static void treo680_mci_power(struct device *dev, unsigned int vdd)
-{
-	struct pxamci_platform_data *p_d = dev->platform_data;
-	gpio_set_value(GPIO_NR_TREO680_SD_POWER, p_d->ocr_mask & (1 << vdd));
-}
-
-static int treo680_mci_get_ro(struct device *dev)
-{
-	return gpio_get_value(GPIO_NR_TREO680_SD_READONLY);
-}
-
 static struct pxamci_platform_data treo680_mci_platform_data = {
-	.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.setpower	= treo680_mci_power,
-	.get_ro		= treo680_mci_get_ro,
-	.init 		= treo680_mci_init,
-	.exit		= treo680_mci_exit,
+	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.gpio_card_detect	= GPIO_NR_TREO680_SD_DETECT_N,
+	.gpio_card_ro		= GPIO_NR_TREO680_SD_READONLY,
+	.gpio_power		= GPIO_NR_TREO680_SD_POWER,
 };
 
 /******************************************************************************
-- 
1.6.3.3
