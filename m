From: csd@broadcom.com (Christian Daudt)
Date: Tue, 28 May 2013 18:13:35 -0700
Subject: [PATCH V3 2/3] ARM: mmc: bcm281xx SDHCI driver
In-Reply-To: <1369790016-13270-1-git-send-email-csd@broadcom.com>
References: <1369790016-13270-1-git-send-email-csd@broadcom.com>
Message-ID: <1369790016-13270-2-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SDHCI driver for the Broadcom 281xx SoCs. Also
add bindings for it into bcm281xx dts files.
Still missing:
 - power managemement

Changes from V2:
 - Structure cleanups
 - init space from sdhci_pltfm_init
 - replace spinlock_irqsave with mutex on sd_card_emulate
 - Reduce init_74_clocks delay and document it

Changes from V1:
 - split DT into separate patch
 - use gpio_is_valid instead of direct test
 - switch pr_debug calls to dev_dbg
 - use of_property_read_bool

Signed-off-by: Christian Daudt <csd@broadcom.com>

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index e3bf2d6..65edf6d 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -78,6 +78,13 @@ CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+CONFIG_MMC_UNSAFE_RESUME=y
+CONFIG_MMC_BLOCK_MINORS=32
+CONFIG_MMC_TEST=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_BCM_KONA=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 9ab8f8d..2455a35 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -249,6 +249,17 @@ config MMC_SDHCI_S3C_DMA
 
 	  YMMV.
 
+config MMC_SDHCI_BCM_KONA
+	tristate "SDHCI support on Broadcom KONA platform"
+	depends on ARCH_BCM
+	select MMC_SDHCI_PLTFM
+	help
+	  This selects the Broadcom Kona Secure Digital Host Controller
+	  Interface(SDHCI) support.
+	  This is used in Broadcom mobile SoCs.
+
+	  If you have a controller with this interface, say Y or M here.
+
 config MMC_SDHCI_BCM2835
 	tristate "SDHCI platform support for the BCM2835 SD/MMC Controller"
 	depends on ARCH_BCM2835
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index cd32280..cd4c845 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
 obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
 obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
+obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
 obj-$(CONFIG_MMC_SDHCI_BCM2835)		+= sdhci-bcm2835.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
new file mode 100644
index 0000000..1cba006
--- /dev/null
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -0,0 +1,443 @@
+/*
+ * Copyright (C) 2013 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/highmem.h>
+#include <linux/platform_device.h>
+#include <linux/mmc/host.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/clk.h>
+#include <linux/regulator/consumer.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/version.h>
+
+#include "sdhci-pltfm.h"
+#include "sdhci.h"
+
+#define SDHCI_SOFT_RESET			0x01000000
+#define KONA_SDHOST_CORECTRL			0x8000
+#define KONA_SDHOST_CD_PINCTRL			0x00000008
+#define KONA_SDHOST_STOP_HCLK			0x00000004
+#define KONA_SDHOST_RESET			0x00000002
+#define KONA_SDHOST_EN				0x00000001
+
+#define KONA_SDHOST_CORESTAT			0x8004
+#define KONA_SDHOST_WP				0x00000002
+#define KONA_SDHOST_CD_SW			0x00000001
+
+#define KONA_SDHOST_COREIMR			0x8008
+#define KONA_SDHOST_IP				0x00000001
+
+#define KONA_SDHOST_COREISR			0x800C
+#define KONA_SDHOST_COREIMSR			0x8010
+#define KONA_SDHOST_COREDBG1			0x8014
+#define KONA_SDHOST_COREGPO_MASK		0x8018
+
+#define SD_DETECT_GPIO_DEBOUNCE_128MS		128
+
+#define KONA_MMC_AUTOSUSPEND_DELAY		(50)
+
+struct sdhci_bcm_kona_dev {
+	struct clk	*peri_clk;
+	struct clk	*sleep_clk;
+
+	struct mutex	write_lock; /* protect back to back writes */
+	unsigned int	max_freq;
+	int		is_8bit;
+	int		irq;
+	int		cd_gpio;
+	int		wp_gpio;
+	int		non_removable;
+};
+
+
+static int sdhci_bcm_kona_sd_reset(struct sdhci_host *host)
+{
+	unsigned int val;
+	unsigned long timeout;
+
+	/* This timeout should be sufficent for core to reset */
+	timeout = jiffies + msecs_to_jiffies(100);
+
+	/* reset the host using the top level reset */
+	val = sdhci_readl(host, KONA_SDHOST_CORECTRL);
+	val |= KONA_SDHOST_RESET;
+	sdhci_writel(host, val, KONA_SDHOST_CORECTRL);
+
+	while (!(sdhci_readl(host, KONA_SDHOST_CORECTRL) & KONA_SDHOST_RESET)) {
+		if (time_is_before_jiffies(timeout)) {
+			pr_err("Error: sd host is stuck in reset!!!\n");
+			return -EFAULT;
+		}
+	}
+
+	/* bring the host out of reset */
+	val = sdhci_readl(host, KONA_SDHOST_CORECTRL);
+	val &= ~KONA_SDHOST_RESET;
+
+	/*
+	 * Back-to-Back register write needs a delay of 1ms at bootup (min 10uS)
+	 * Back-to-Back writes to same register needs delay when SD bus clock
+	 * is very low w.r.t AHB clock, mainly during boot-time and during card
+	 * insert-removal.
+	 */
+	mdelay(1);
+	sdhci_writel(host, val, KONA_SDHOST_CORECTRL);
+
+	return 0;
+}
+
+static void sdhci_bcm_kona_sd_init(struct sdhci_host *host)
+{
+	unsigned int val;
+
+	/* enable the interrupt from the IP core */
+	val = sdhci_readl(host, KONA_SDHOST_COREIMR);
+	val |= KONA_SDHOST_IP;
+	sdhci_writel(host, val, KONA_SDHOST_COREIMR);
+
+	/* Enable the AHB clock gating module to the host */
+	val = sdhci_readl(host, KONA_SDHOST_CORECTRL);
+	val |= KONA_SDHOST_EN;
+
+	/*
+	 * Back-to-Back register write needs a delay of 1ms at bootup (min 10uS)
+	 * Back-to-Back writes to same register needs delay when SD bus clock
+	 * is very low w.r.t AHB clock, mainly during boot-time and during card
+	 * insert-removal.
+	 */
+	mdelay(1);
+	sdhci_writel(host, val, KONA_SDHOST_CORECTRL);
+}
+
+/*
+ * Software emulation of the SD card insertion/removal. Set insert=1 for insert
+ * and insert=0 for removal. The card detection is done by GPIO. For Broadcom
+ * IP to function properly the bit 0 of CORESTAT register needs to be set/reset
+ * to generate the CD IRQ handled in sdhci.c which schedules card_tasklet.
+ */
+static int sdhci_bcm_kona_sd_card_emulate(struct sdhci_host *host, int insert)
+{
+	struct sdhci_pltfm_host *pltfm_priv = sdhci_priv(host);
+	struct sdhci_bcm_kona_dev *kona_dev = sdhci_pltfm_priv(pltfm_priv);
+	u32 val;
+	unsigned long flags;
+
+	/*
+	 * Back-to-Back register write needs a delay of min 10uS.
+	 * Back-to-Back writes to same register needs delay when SD bus clock
+	 * is very low w.r.t AHB clock, mainly during boot-time and during card
+	 * insert-removal.
+	 * We keep 20uS
+	 */
+	mutex_lock(&kona_dev->write_lock);
+	udelay(20);
+	val = sdhci_readl(host, KONA_SDHOST_CORESTAT);
+
+	if (insert) {
+		if (gpio_is_valid(kona_dev->wp_gpio)) {
+			int wp_status = gpio_get_value(kona_dev->wp_gpio);
+
+			if (wp_status)
+				val |= KONA_SDHOST_WP;
+			else
+				val &= ~KONA_SDHOST_WP;
+		}
+
+		val |= KONA_SDHOST_CD_SW;
+		sdhci_writel(host, val, KONA_SDHOST_CORESTAT);
+	} else {
+		val &= ~KONA_SDHOST_CD_SW;
+		sdhci_writel(host, val, KONA_SDHOST_CORESTAT);
+	}
+	mutex_unlock(&kona_dev->write_lock);
+
+	return 0;
+}
+
+/*
+ * SD card detection interrupt handler
+ */
+static irqreturn_t sdhci_bcm_kona_pltfm_cd_interrupt(int irq, void *h)
+{
+	struct sdhci_host *host = h;
+	struct sdhci_pltfm_host *pltfm_priv = sdhci_priv(host);
+	struct sdhci_bcm_kona_dev *kona_dev = sdhci_pltfm_priv(pltfm_priv);
+
+	if (gpio_get_value_cansleep(kona_dev->cd_gpio) == 0) {
+		dev_dbg(mmc_dev(host->mmc),
+			"card inserted\n");
+		sdhci_bcm_kona_sd_card_emulate(host, 1);
+	} else {
+		dev_dbg(mmc_dev(host->mmc),
+			"card removed\n");
+		sdhci_bcm_kona_sd_card_emulate(host, 0);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Get the base clock. Use central clock source for now. Not sure if different
+ * clock speed to each dev is allowed
+ */
+static unsigned int sdhci_bcm_kona_get_max_clk(struct sdhci_host *host)
+{
+	struct sdhci_bcm_kona_dev *kona_dev;
+	struct sdhci_pltfm_host *pltfm_priv = sdhci_priv(host);
+	kona_dev = sdhci_pltfm_priv(pltfm_priv);
+
+	return kona_dev->max_freq;
+}
+
+static unsigned int sdhci_bcm_kona_get_timeout_clock(struct sdhci_host *host)
+{
+	return sdhci_bcm_kona_get_max_clk(host);
+}
+
+static void sdhci_bcm_kona_init_74_clocks(struct sdhci_host *host,
+				u8 power_mode)
+{
+	/*
+	 *  JEDEC and SD spec specify supplying 74 continuous clocks to
+	 * device after power up. With minimum bus (100KHz) that
+	 * that translates to 740us
+	 */
+	if (power_mode != MMC_POWER_OFF)
+		udelay(740);
+}
+
+static struct sdhci_ops sdhci_bcm_kona_ops = {
+	.get_max_clock = sdhci_bcm_kona_get_max_clk,
+	.get_timeout_clock = sdhci_bcm_kona_get_timeout_clock,
+	.platform_send_init_74_clocks = sdhci_bcm_kona_init_74_clocks,
+};
+
+static struct sdhci_pltfm_data sdhci_pltfm_data_kona = {
+	.ops    = &sdhci_bcm_kona_ops,
+	.quirks = SDHCI_QUIRK_NO_CARD_NO_RESET |
+		SDHCI_QUIRK_BROKEN_TIMEOUT_VAL | SDHCI_QUIRK_32BIT_DMA_ADDR |
+		SDHCI_QUIRK_32BIT_DMA_SIZE | SDHCI_QUIRK_32BIT_ADMA_SIZE |
+		SDHCI_QUIRK_FORCE_BLK_SZ_2048 |
+		SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+};
+
+static const struct of_device_id sdhci_bcm_kona_of_match[] __initdata = {
+	{ .compatible = "bcm,kona-sdhci"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, sdhci_bcm_kona_of_match);
+
+static int __init sdhci_bcm_kona_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct sdhci_bcm_kona_dev *kona_dev = NULL;
+	struct sdhci_pltfm_host *pltfm_priv;
+	struct device *dev = &pdev->dev;
+	struct sdhci_host *host;
+	int ret;
+	unsigned int irq;
+	u32 temp;
+
+	ret = 0;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_pltfm_data_kona,
+			sizeof(*kona_dev));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	dev_dbg(dev, "%s: inited. IOADDR=%p\n", __func__, host->ioaddr);
+
+	pltfm_priv = sdhci_priv(host);
+
+	kona_dev = sdhci_pltfm_priv(pltfm_priv);
+	mutex_init(&kona_dev->write_lock);
+
+	kona_dev->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
+	kona_dev->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
+	if (of_property_read_bool(np, "non-removable"))
+		kona_dev->non_removable = 1;
+
+	if (of_property_read_u32(np, "bus-width", &temp) == 0 && temp == 8)
+		kona_dev->is_8bit = 1;
+
+	if (of_property_read_u32(np, "max-frequency", &kona_dev->max_freq)) {
+		dev_err(&pdev->dev, "Missing max-freq for SDHCI cfg\n");
+		ret = -ENXIO;
+		goto err_pltfm_free;
+	}
+
+	dev_dbg(dev, "non-removable=%c\n",
+		(kona_dev->non_removable) ? 'Y' : 'N');
+	dev_dbg(dev, "cd_gpio %d, wp_gpio %d\n", kona_dev->cd_gpio,
+		kona_dev->wp_gpio);
+
+	if (kona_dev->non_removable) {
+		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+	}
+
+	dev_dbg(dev, "is_8bit=%c\n", (kona_dev->is_8bit) ? 'Y' : 'N');
+	if (kona_dev->is_8bit)
+		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+
+	ret = sdhci_bcm_kona_sd_reset(host);
+	if (ret)
+		goto err_pltfm_free;
+
+	sdhci_bcm_kona_sd_init(host);
+
+	ret = sdhci_add_host(host);
+	if (ret) {
+		dev_err(dev, "Failed sdhci_add_host\n");
+		goto err_reset;
+	}
+
+	/* if device is eMMC, emulate card insert right here */
+	if (kona_dev->non_removable) {
+		ret = sdhci_bcm_kona_sd_card_emulate(host, 1);
+		if (ret) {
+			dev_err(dev,
+				"unable to emulate card insertion\n");
+			goto err_remove_host;
+		}
+	} else if (gpio_is_valid(kona_dev->cd_gpio)) {
+		ret = devm_gpio_request(dev, kona_dev->cd_gpio, "sdio cd");
+		if (ret < 0) {
+			dev_err(mmc_dev(host->mmc),
+				"Unable to request GPIO pin %d\n",
+				kona_dev->cd_gpio);
+			goto err_remove_host;
+		}
+
+		gpio_direction_input(kona_dev->cd_gpio);
+
+		/* Set debounce for SD Card detect to maximum value (128ms)
+		 *
+		 * NOTE-1: If gpio_set_debounce() returns error we still
+		 * continue with the default debounce value set. Another reason
+		 * for doing this is that on rhea-ray boards the SD Detect GPIO
+		 * is on GPIO Expander and gpio_set_debounce() will return error
+		 * and if we return error from here, then probe() would fail and
+		 * SD detection would always fail.
+		 *
+		 * NOTE-2: We also give a msleep() of the "debounce" time here
+		 * so that we give enough time for the debounce to stabilize
+		 * before we read the gpio value in gpio_get_value_cansleep().
+		 */
+		ret = gpio_set_debounce(kona_dev->cd_gpio,
+				(SD_DETECT_GPIO_DEBOUNCE_128MS * 1000));
+		if (ret < 0) {
+			dev_err(mmc_dev(host->mmc),
+				"%s: gpio set debounce failed."
+				"default debounce value assumed\n", __func__);
+		}
+
+		/* Sleep for 128ms to allow debounce to stabilize */
+		msleep(SD_DETECT_GPIO_DEBOUNCE_128MS);
+		/* request irq for cd_gpio after the gpio debounce is
+		 * stabilized, otherwise, some bogus gpio interrupts might be
+		 * triggered.
+		 */
+		irq = gpio_to_irq(kona_dev->cd_gpio);
+		ret = devm_request_threaded_irq(dev,
+				irq,
+				NULL,
+				sdhci_bcm_kona_pltfm_cd_interrupt,
+				IRQF_TRIGGER_FALLING|
+				IRQF_TRIGGER_RISING |
+				IRQF_ONESHOT |
+				IRQF_NO_SUSPEND, "sdio cd", host);
+		if (ret) {
+			dev_err(mmc_dev(host->mmc),
+				"Failed irq %d request for gpio=%d ret=%d\n",
+				gpio_to_irq(kona_dev->cd_gpio),
+				kona_dev->cd_gpio, ret);
+			goto err_remove_host;
+		}
+		if (gpio_is_valid(kona_dev->wp_gpio)) {
+			ret = devm_gpio_request(dev,
+				kona_dev->wp_gpio, "sdio wp");
+			if (ret < 0) {
+				dev_err(&pdev->dev,
+					"Unable to request WP pin %d\n",
+					kona_dev->wp_gpio);
+				kona_dev->wp_gpio = -1;
+			} else {
+				gpio_direction_input(kona_dev->wp_gpio);
+			}
+		}
+
+		/*
+		 * Since the card detection GPIO interrupt is configured to be
+		 * edge sensitive, check the initial GPIO value here, emulate
+		 * only if the card is present
+		 */
+		if (gpio_get_value_cansleep(kona_dev->cd_gpio) == 0)
+			sdhci_bcm_kona_sd_card_emulate(host, 1);
+	}
+
+	dev_dbg(dev, "initialized properly\n");
+	return 0;
+
+err_remove_host:
+	sdhci_remove_host(host, 0);
+
+err_reset:
+	sdhci_bcm_kona_sd_reset(host);
+
+err_pltfm_free:
+	sdhci_pltfm_free(pdev);
+
+	dev_err(dev, "Probing of sdhci-pltfm failed: %d\n", ret);
+	return ret;
+}
+
+static int __exit sdhci_bcm_kona_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	int dead;
+	u32 scratch;
+
+	dead = 0;
+	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
+	if (scratch == (u32)-1)
+		dead = 1;
+	sdhci_remove_host(host, dead);
+
+	sdhci_free_host(host);
+
+	return 0;
+}
+
+static struct platform_driver sdhci_bcm_kona_driver = {
+	.driver		= {
+		.name	= "sdhci-kona",
+		.owner	= THIS_MODULE,
+		.pm	= SDHCI_PLTFM_PMOPS,
+		.of_match_table = of_match_ptr(sdhci_bcm_kona_of_match),
+	},
+	.probe		= sdhci_bcm_kona_probe,
+	.remove		= __exit_p(sdhci_bcm_kona_remove),
+};
+module_platform_driver(sdhci_bcm_kona_driver);
+
+MODULE_DESCRIPTION("SDHCI driver for Broadcom Kona platform");
+MODULE_AUTHOR("Broadcom");
+MODULE_LICENSE("GPL v2");
+
-- 
1.7.10.4
