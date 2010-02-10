From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 10 Feb 2010 20:20:46 +0800
Subject: [PATCH 1/2] [ARM] pxa: introduce PXA_SSP_LEGACY for legacy SSP API
Message-ID: <f17812d71002100420g736d1720ta52ef43a928f1f1d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit f7ccd8e002ca8a7ad044590da30ad51d163ef0d9
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Wed Feb 10 16:00:11 2010 +0800

    [ARM] pxa: introduce PXA_SSP_LEGACY for legacy SSP API

    The SSP ports are assumed to be used by high-level drivers like SPI or
    Audio SSP instead of being used directly.  The legacy SSP API, i.e.
    those with parameter of 'struct ssp_dev' are of less interesting, thus
    scheduled to be deprecated in a long run.

    The basic SSP ports management code (request/free) is extracted into
    a common directory of plat-pxa/ to be shared amongst all PXA variants.

    This patch introduce a PXA_SSP_LEGACY as a smooth migration path.

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index dee9218..7a92c37 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -435,6 +435,7 @@ config SHARPSL_PM
 config CORGI_SSP_DEPRECATED
 	bool
 	select PXA_SSP
+	select PXA_SSP_LEGACY
 	help
 	  This option will include corgi_ssp.c and corgi_lcd.c
 	  that corgi_ts.c and other legacy drivers (corgi_bl.c
@@ -624,10 +625,10 @@ config PXA_SHARP_Cxx00
 	help
 	  Enable common support for Sharp Cxx00 models

-config PXA_SSP
+config PXA_SSP_LEGACY
 	tristate
 	help
-	  Enable support for PXA2xx SSP ports
+	  Enable support for PXA2xx SSP legacy APIs

 config TOSA_BT
 	tristate "Control the state of built-in bluetooth chip on Sharp SL-6000"
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index f64afda..9b7d356 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_PXA3xx)		+= cpufreq-pxa3xx.o
 endif

 # Generic drivers that other drivers may depend upon
-obj-$(CONFIG_PXA_SSP)		+= ssp.o
+obj-$(CONFIG_PXA_SSP_LEGACY)	+= ssp.o

 # SoC-specific code
 obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o pxa2xx.o pxa25x.o
diff --git a/arch/arm/mach-pxa/corgi_ssp.c b/arch/arm/mach-pxa/corgi_ssp.c
index a5ee707..03775bc 100644
--- a/arch/arm/mach-pxa/corgi_ssp.c
+++ b/arch/arm/mach-pxa/corgi_ssp.c
@@ -21,7 +21,6 @@

 #include <mach/ssp.h>
 #include <mach/pxa2xx-gpio.h>
-#include <mach/regs-ssp.h>
 #include "sharpsl.h"

 static DEFINE_SPINLOCK(corgi_ssp_lock);
diff --git a/arch/arm/mach-pxa/include/mach/regs-ssp.h
b/arch/arm/mach-pxa/include/mach/regs-ssp.h
deleted file mode 100644
index 6a2ed35..0000000
--- a/arch/arm/mach-pxa/include/mach/regs-ssp.h
+++ /dev/null
@@ -1,134 +0,0 @@
-#ifndef __ASM_ARCH_REGS_SSP_H
-#define __ASM_ARCH_REGS_SSP_H
-
-/*
- * SSP Serial Port Registers
- * PXA250, PXA255, PXA26x and PXA27x SSP controllers are all slightly
different.
- * PXA255, PXA26x and PXA27x have extra ports, registers and bits.
- */
-
-#define SSCR0		(0x00)  /* SSP Control Register 0 */
-#define SSCR1		(0x04)  /* SSP Control Register 1 */
-#define SSSR		(0x08)  /* SSP Status Register */
-#define SSITR		(0x0C)  /* SSP Interrupt Test Register */
-#define SSDR		(0x10)  /* SSP Data Write/Data Read Register */
-
-#define SSTO		(0x28)  /* SSP Time Out Register */
-#define SSPSP		(0x2C)  /* SSP Programmable Serial Protocol */
-#define SSTSA		(0x30)  /* SSP Tx Timeslot Active */
-#define SSRSA		(0x34)  /* SSP Rx Timeslot Active */
-#define SSTSS		(0x38)  /* SSP Timeslot Status */
-#define SSACD		(0x3C)  /* SSP Audio Clock Divider */
-
-#if defined(CONFIG_PXA3xx)
-#define SSACDD		(0x40)	/* SSP Audio Clock Dither Divider */
-#endif
-
-/* Common PXA2xx bits first */
-#define SSCR0_DSS	(0x0000000f)	/* Data Size Select (mask) */
-#define SSCR0_DataSize(x)  ((x) - 1)	/* Data Size Select [4..16] */
-#define SSCR0_FRF	(0x00000030)	/* FRame Format (mask) */
-#define SSCR0_Motorola	(0x0 << 4)	/* Motorola's Serial Peripheral
Interface (SPI) */
-#define SSCR0_TI	(0x1 << 4)	/* Texas Instruments' Synchronous Serial
Protocol (SSP) */
-#define SSCR0_National	(0x2 << 4)	/* National Microwire */
-#define SSCR0_ECS	(1 << 6)	/* External clock select */
-#define SSCR0_SSE	(1 << 7)	/* Synchronous Serial Port Enable */
-
-#if defined(CONFIG_PXA25x)
-#define SSCR0_SCR	(0x0000ff00)	/* Serial Clock Rate (mask) */
-#define SSCR0_SerClkDiv(x) ((((x) - 2)/2) << 8) /* Divisor [2..512] */
-#elif defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
-#define SSCR0_SCR	(0x000fff00)	/* Serial Clock Rate (mask) */
-#define SSCR0_SerClkDiv(x) (((x) - 1) << 8) /* Divisor [1..4096] */
-#endif
-
-#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
-#define SSCR0_EDSS	(1 << 20)	/* Extended data size select */
-#define SSCR0_NCS	(1 << 21)	/* Network clock select */
-#define SSCR0_RIM	(1 << 22)	/* Receive FIFO overrrun interrupt mask */
-#define SSCR0_TUM	(1 << 23)	/* Transmit FIFO underrun interrupt mask */
-#define SSCR0_FRDC	(0x07000000)	/* Frame rate divider control (mask) */
-#define SSCR0_SlotsPerFrm(x) (((x) - 1) << 24)	/* Time slots per
frame [1..8] */
-#define SSCR0_ACS	(1 << 30)	/* Audio clock select */
-#define SSCR0_MOD	(1 << 31)	/* Mode (normal or network) */
-#endif
-
-#if defined(CONFIG_PXA3xx)
-#define SSCR0_FPCKE	(1 << 29)	/* FIFO packing enable */
-#endif
-
-#define SSCR1_RIE	(1 << 0)	/* Receive FIFO Interrupt Enable */
-#define SSCR1_TIE	(1 << 1)	/* Transmit FIFO Interrupt Enable */
-#define SSCR1_LBM	(1 << 2)	/* Loop-Back Mode */
-#define SSCR1_SPO	(1 << 3)	/* Motorola SPI SSPSCLK polarity setting */
-#define SSCR1_SPH	(1 << 4)	/* Motorola SPI SSPSCLK phase setting */
-#define SSCR1_MWDS	(1 << 5)	/* Microwire Transmit Data Size */
-#define SSCR1_TFT	(0x000003c0)	/* Transmit FIFO Threshold (mask) */
-#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..16] */
-#define SSCR1_RFT	(0x00003c00)	/* Receive FIFO Threshold (mask) */
-#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..16] */
-
-#define SSSR_TNF	(1 << 2)	/* Transmit FIFO Not Full */
-#define SSSR_RNE	(1 << 3)	/* Receive FIFO Not Empty */
-#define SSSR_BSY	(1 << 4)	/* SSP Busy */
-#define SSSR_TFS	(1 << 5)	/* Transmit FIFO Service Request */
-#define SSSR_RFS	(1 << 6)	/* Receive FIFO Service Request */
-#define SSSR_ROR	(1 << 7)	/* Receive FIFO Overrun */
-
-#define SSCR0_TIM		(1 << 23)	/* Transmit FIFO Under Run Interrupt Mask */
-#define SSCR0_RIM		(1 << 22)	/* Receive FIFO Over Run interrupt Mask */
-#define SSCR0_NCS		(1 << 21)	/* Network Clock Select */
-#define SSCR0_EDSS		(1 << 20)	/* Extended Data Size Select */
-
-/* extra bits in PXA255, PXA26x and PXA27x SSP ports */
-#define SSCR0_TISSP		(1 << 4)	/* TI Sync Serial Protocol */
-#define SSCR0_PSP		(3 << 4)	/* PSP - Programmable Serial Protocol */
-#define SSCR1_TTELP		(1 << 31)	/* TXD Tristate Enable Last Phase */
-#define SSCR1_TTE		(1 << 30)	/* TXD Tristate Enable */
-#define SSCR1_EBCEI		(1 << 29)	/* Enable Bit Count Error interrupt */
-#define SSCR1_SCFR		(1 << 28)	/* Slave Clock free Running */
-#define SSCR1_ECRA		(1 << 27)	/* Enable Clock Request A */
-#define SSCR1_ECRB		(1 << 26)	/* Enable Clock request B */
-#define SSCR1_SCLKDIR		(1 << 25)	/* Serial Bit Rate Clock Direction */
-#define SSCR1_SFRMDIR		(1 << 24)	/* Frame Direction */
-#define SSCR1_RWOT		(1 << 23)	/* Receive Without Transmit */
-#define SSCR1_TRAIL		(1 << 22)	/* Trailing Byte */
-#define SSCR1_TSRE		(1 << 21)	/* Transmit Service Request Enable */
-#define SSCR1_RSRE		(1 << 20)	/* Receive Service Request Enable */
-#define SSCR1_TINTE		(1 << 19)	/* Receiver Time-out Interrupt enable */
-#define SSCR1_PINTE		(1 << 18)	/* Peripheral Trailing Byte Interupt Enable */
-#define SSCR1_IFS		(1 << 16)	/* Invert Frame Signal */
-#define SSCR1_STRF		(1 << 15)	/* Select FIFO or EFWR */
-#define SSCR1_EFWR		(1 << 14)	/* Enable FIFO Write/Read */
-
-#define SSSR_BCE		(1 << 23)	/* Bit Count Error */
-#define SSSR_CSS		(1 << 22)	/* Clock Synchronisation Status */
-#define SSSR_TUR		(1 << 21)	/* Transmit FIFO Under Run */
-#define SSSR_EOC		(1 << 20)	/* End Of Chain */
-#define SSSR_TINT		(1 << 19)	/* Receiver Time-out Interrupt */
-#define SSSR_PINT		(1 << 18)	/* Peripheral Trailing Byte Interrupt */
-
-#if defined(CONFIG_PXA3xx)
-#define SSPSP_EDMYSTOP(x)	((x) << 28)     /* Extended Dummy Stop */
-#define SSPSP_EDMYSTRT(x)	((x) << 26)     /* Extended Dummy Start */
-#endif
-
-#define SSPSP_FSRT		(1 << 25)	/* Frame Sync Relative Timing */
-#define SSPSP_DMYSTOP(x)	((x) << 23)	/* Dummy Stop */
-#define SSPSP_SFRMWDTH(x)	((x) << 16)	/* Serial Frame Width */
-#define SSPSP_SFRMDLY(x)	((x) << 9)	/* Serial Frame Delay */
-#define SSPSP_DMYSTRT(x)	((x) << 7)	/* Dummy Start */
-#define SSPSP_STRTDLY(x)	((x) << 4)	/* Start Delay */
-#define SSPSP_ETDS		(1 << 3)	/* End of Transfer data State */
-#define SSPSP_SFRMP		(1 << 2)	/* Serial Frame Polarity */
-#define SSPSP_SCMODE(x)		((x) << 0)	/* Serial Bit Rate Clock Mode */
-
-#define SSACD_SCDB		(1 << 3)	/* SSPSYSCLK Divider Bypass */
-#define SSACD_ACPS(x)		((x) << 4)	/* Audio clock PLL select */
-#define SSACD_ACDS(x)		((x) << 0)	/* Audio clock divider select */
-#if defined(CONFIG_PXA3xx)
-#define SSACD_SCDX8		(1 << 7)	/* SYSCLK division ratio select */
-#endif
-
-
-#endif /* __ASM_ARCH_REGS_SSP_H */
diff --git a/arch/arm/mach-pxa/include/mach/ssp.h
b/arch/arm/mach-pxa/include/mach/ssp.h
index cb5cb76..6b2f386 100644
--- a/arch/arm/mach-pxa/include/mach/ssp.h
+++ b/arch/arm/mach-pxa/include/mach/ssp.h
@@ -21,30 +21,7 @@

 #include <linux/list.h>
 #include <linux/io.h>
-
-enum pxa_ssp_type {
-	SSP_UNDEFINED = 0,
-	PXA25x_SSP,  /* pxa 210, 250, 255, 26x */
-	PXA25x_NSSP, /* pxa 255, 26x (including ASSP) */
-	PXA27x_SSP,
-};
-
-struct ssp_device {
-	struct platform_device *pdev;
-	struct list_head	node;
-
-	struct clk	*clk;
-	void __iomem	*mmio_base;
-	unsigned long	phys_base;
-
-	const char	*label;
-	int		port_id;
-	int		type;
-	int		use_count;
-	int		irq;
-	int		drcmr_rx;
-	int		drcmr_tx;
-};
+#include <plat/ssp.h>

 /*
  * SSP initialisation flags
@@ -79,29 +56,4 @@ int ssp_init(struct ssp_dev *dev, u32 port, u32 init_flags);
 int ssp_config(struct ssp_dev *dev, u32 mode, u32 flags, u32
psp_flags, u32 speed);
 void ssp_exit(struct ssp_dev *dev);

-/**
- * ssp_write_reg - Write to a SSP register
- *
- * @dev: SSP device to access
- * @reg: Register to write to
- * @val: Value to be written.
- */
-static inline void ssp_write_reg(struct ssp_device *dev, u32 reg, u32 val)
-{
-	__raw_writel(val, dev->mmio_base + reg);
-}
-
-/**
- * ssp_read_reg - Read from a SSP register
- *
- * @dev: SSP device to access
- * @reg: Register to read from
- */
-static inline u32 ssp_read_reg(struct ssp_device *dev, u32 reg)
-{
-	return __raw_readl(dev->mmio_base + reg);
-}
-
-struct ssp_device *ssp_request(int port, const char *label);
-void ssp_free(struct ssp_device *);
 #endif /* __ASM_ARCH_SSP_H */
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index fa527b2..be727ae 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -41,7 +41,6 @@

 #include <mach/pxa300.h>
 #include <mach/pxafb.h>
-#include <mach/ssp.h>
 #include <mach/mmc.h>
 #include <mach/pxa2xx_spi.h>
 #include <mach/pxa27x_keypad.h>
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index fcb0721..ebb0fae 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -29,7 +29,6 @@
 #include <mach/ohci.h>
 #include <mach/pm.h>
 #include <mach/dma.h>
-#include <mach/ssp.h>
 #include <mach/regs-intc.h>
 #include <plat/i2c.h>

diff --git a/arch/arm/mach-pxa/ssp.c b/arch/arm/mach-pxa/ssp.c
index 9ebe658..be2629b 100644
--- a/arch/arm/mach-pxa/ssp.c
+++ b/arch/arm/mach-pxa/ssp.c
@@ -33,7 +33,6 @@
 #include <asm/irq.h>
 #include <mach/hardware.h>
 #include <mach/ssp.h>
-#include <mach/regs-ssp.h>

 #define TIMEOUT 100000

@@ -304,190 +303,6 @@ void ssp_exit(struct ssp_dev *dev)
 	ssp_free(ssp);
 }

-static DEFINE_MUTEX(ssp_lock);
-static LIST_HEAD(ssp_list);
-
-struct ssp_device *ssp_request(int port, const char *label)
-{
-	struct ssp_device *ssp = NULL;
-
-	mutex_lock(&ssp_lock);
-
-	list_for_each_entry(ssp, &ssp_list, node) {
-		if (ssp->port_id == port && ssp->use_count == 0) {
-			ssp->use_count++;
-			ssp->label = label;
-			break;
-		}
-	}
-
-	mutex_unlock(&ssp_lock);
-
-	if (&ssp->node == &ssp_list)
-		return NULL;
-
-	return ssp;
-}
-EXPORT_SYMBOL(ssp_request);
-
-void ssp_free(struct ssp_device *ssp)
-{
-	mutex_lock(&ssp_lock);
-	if (ssp->use_count) {
-		ssp->use_count--;
-		ssp->label = NULL;
-	} else
-		dev_err(&ssp->pdev->dev, "device already free\n");
-	mutex_unlock(&ssp_lock);
-}
-EXPORT_SYMBOL(ssp_free);
-
-static int __devinit ssp_probe(struct platform_device *pdev)
-{
-	const struct platform_device_id *id = platform_get_device_id(pdev);
-	struct resource *res;
-	struct ssp_device *ssp;
-	int ret = 0;
-
-	ssp = kzalloc(sizeof(struct ssp_device), GFP_KERNEL);
-	if (ssp == NULL) {
-		dev_err(&pdev->dev, "failed to allocate memory");
-		return -ENOMEM;
-	}
-	ssp->pdev = pdev;
-
-	ssp->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(ssp->clk)) {
-		ret = PTR_ERR(ssp->clk);
-		goto err_free;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no memory resource defined\n");
-		ret = -ENODEV;
-		goto err_free_clk;
-	}
-
-	res = request_mem_region(res->start, res->end - res->start + 1,
-			pdev->name);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "failed to request memory resource\n");
-		ret = -EBUSY;
-		goto err_free_clk;
-	}
-
-	ssp->phys_base = res->start;
-
-	ssp->mmio_base = ioremap(res->start, res->end - res->start + 1);
-	if (ssp->mmio_base == NULL) {
-		dev_err(&pdev->dev, "failed to ioremap() registers\n");
-		ret = -ENODEV;
-		goto err_free_mem;
-	}
-
-	ssp->irq = platform_get_irq(pdev, 0);
-	if (ssp->irq < 0) {
-		dev_err(&pdev->dev, "no IRQ resource defined\n");
-		ret = -ENODEV;
-		goto err_free_io;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no SSP RX DRCMR defined\n");
-		ret = -ENODEV;
-		goto err_free_io;
-	}
-	ssp->drcmr_rx = res->start;
-
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no SSP TX DRCMR defined\n");
-		ret = -ENODEV;
-		goto err_free_io;
-	}
-	ssp->drcmr_tx = res->start;
-
-	/* PXA2xx/3xx SSP ports starts from 1 and the internal pdev->id
-	 * starts from 0, do a translation here
-	 */
-	ssp->port_id = pdev->id + 1;
-	ssp->use_count = 0;
-	ssp->type = (int)id->driver_data;
-
-	mutex_lock(&ssp_lock);
-	list_add(&ssp->node, &ssp_list);
-	mutex_unlock(&ssp_lock);
-
-	platform_set_drvdata(pdev, ssp);
-	return 0;
-
-err_free_io:
-	iounmap(ssp->mmio_base);
-err_free_mem:
-	release_mem_region(res->start, res->end - res->start + 1);
-err_free_clk:
-	clk_put(ssp->clk);
-err_free:
-	kfree(ssp);
-	return ret;
-}
-
-static int __devexit ssp_remove(struct platform_device *pdev)
-{
-	struct resource *res;
-	struct ssp_device *ssp;
-
-	ssp = platform_get_drvdata(pdev);
-	if (ssp == NULL)
-		return -ENODEV;
-
-	iounmap(ssp->mmio_base);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, res->end - res->start + 1);
-
-	clk_put(ssp->clk);
-
-	mutex_lock(&ssp_lock);
-	list_del(&ssp->node);
-	mutex_unlock(&ssp_lock);
-
-	kfree(ssp);
-	return 0;
-}
-
-static const struct platform_device_id ssp_id_table[] = {
-	{ "pxa25x-ssp",		PXA25x_SSP },
-	{ "pxa25x-nssp",	PXA25x_NSSP },
-	{ "pxa27x-ssp",		PXA27x_SSP },
-	{ },
-};
-
-static struct platform_driver ssp_driver = {
-	.probe		= ssp_probe,
-	.remove		= __devexit_p(ssp_remove),
-	.driver		= {
-		.owner	= THIS_MODULE,
-		.name	= "pxa2xx-ssp",
-	},
-	.id_table	= ssp_id_table,
-};
-
-static int __init pxa_ssp_init(void)
-{
-	return platform_driver_register(&ssp_driver);
-}
-
-static void __exit pxa_ssp_exit(void)
-{
-	platform_driver_unregister(&ssp_driver);
-}
-
-arch_initcall(pxa_ssp_init);
-module_exit(pxa_ssp_exit);
-
 EXPORT_SYMBOL(ssp_write_word);
 EXPORT_SYMBOL(ssp_read_word);
 EXPORT_SYMBOL(ssp_flush);
diff --git a/arch/arm/plat-pxa/Kconfig b/arch/arm/plat-pxa/Kconfig
index b158e98..da53395 100644
--- a/arch/arm/plat-pxa/Kconfig
+++ b/arch/arm/plat-pxa/Kconfig
@@ -1,3 +1,8 @@
 if PLAT_PXA

+config PXA_SSP
+	tristate
+	help
+	  Enable support for PXA2xx SSP ports
+
 endif
diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index 0264bfb..4aacdd1 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PXA3xx)		+= mfp.o
 obj-$(CONFIG_ARCH_MMP)		+= mfp.o

 obj-$(CONFIG_HAVE_PWM)		+= pwm.o
+obj-$(CONFIG_PXA_SSP)		+= ssp.o
diff --git a/arch/arm/plat-pxa/include/plat/ssp.h
b/arch/arm/plat-pxa/include/plat/ssp.h
new file mode 100644
index 0000000..cd6d4dd
--- /dev/null
+++ b/arch/arm/plat-pxa/include/plat/ssp.h
@@ -0,0 +1,186 @@
+#ifndef __PLAT_SSP_H
+#define __PLAT_SSP_H
+
+#include <linux/io.h>
+
+/*
+ * SSP Serial Port Registers
+ * PXA250, PXA255, PXA26x and PXA27x SSP controllers are all slightly
different.
+ * PXA255, PXA26x and PXA27x have extra ports, registers and bits.
+ */
+
+#define SSCR0		(0x00)  /* SSP Control Register 0 */
+#define SSCR1		(0x04)  /* SSP Control Register 1 */
+#define SSSR		(0x08)  /* SSP Status Register */
+#define SSITR		(0x0C)  /* SSP Interrupt Test Register */
+#define SSDR		(0x10)  /* SSP Data Write/Data Read Register */
+
+#define SSTO		(0x28)  /* SSP Time Out Register */
+#define SSPSP		(0x2C)  /* SSP Programmable Serial Protocol */
+#define SSTSA		(0x30)  /* SSP Tx Timeslot Active */
+#define SSRSA		(0x34)  /* SSP Rx Timeslot Active */
+#define SSTSS		(0x38)  /* SSP Timeslot Status */
+#define SSACD		(0x3C)  /* SSP Audio Clock Divider */
+
+#if defined(CONFIG_PXA3xx)
+#define SSACDD		(0x40)	/* SSP Audio Clock Dither Divider */
+#endif
+
+/* Common PXA2xx bits first */
+#define SSCR0_DSS	(0x0000000f)	/* Data Size Select (mask) */
+#define SSCR0_DataSize(x)  ((x) - 1)	/* Data Size Select [4..16] */
+#define SSCR0_FRF	(0x00000030)	/* FRame Format (mask) */
+#define SSCR0_Motorola	(0x0 << 4)	/* Motorola's Serial Peripheral
Interface (SPI) */
+#define SSCR0_TI	(0x1 << 4)	/* Texas Instruments' Synchronous Serial
Protocol (SSP) */
+#define SSCR0_National	(0x2 << 4)	/* National Microwire */
+#define SSCR0_ECS	(1 << 6)	/* External clock select */
+#define SSCR0_SSE	(1 << 7)	/* Synchronous Serial Port Enable */
+
+#if defined(CONFIG_PXA25x)
+#define SSCR0_SCR	(0x0000ff00)	/* Serial Clock Rate (mask) */
+#define SSCR0_SerClkDiv(x) ((((x) - 2)/2) << 8) /* Divisor [2..512] */
+#elif defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
+#define SSCR0_SCR	(0x000fff00)	/* Serial Clock Rate (mask) */
+#define SSCR0_SerClkDiv(x) (((x) - 1) << 8) /* Divisor [1..4096] */
+#endif
+
+#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
+#define SSCR0_EDSS	(1 << 20)	/* Extended data size select */
+#define SSCR0_NCS	(1 << 21)	/* Network clock select */
+#define SSCR0_RIM	(1 << 22)	/* Receive FIFO overrrun interrupt mask */
+#define SSCR0_TUM	(1 << 23)	/* Transmit FIFO underrun interrupt mask */
+#define SSCR0_FRDC	(0x07000000)	/* Frame rate divider control (mask) */
+#define SSCR0_SlotsPerFrm(x) (((x) - 1) << 24)	/* Time slots per
frame [1..8] */
+#define SSCR0_ACS	(1 << 30)	/* Audio clock select */
+#define SSCR0_MOD	(1 << 31)	/* Mode (normal or network) */
+#endif
+
+#if defined(CONFIG_PXA3xx)
+#define SSCR0_FPCKE	(1 << 29)	/* FIFO packing enable */
+#endif
+
+#define SSCR1_RIE	(1 << 0)	/* Receive FIFO Interrupt Enable */
+#define SSCR1_TIE	(1 << 1)	/* Transmit FIFO Interrupt Enable */
+#define SSCR1_LBM	(1 << 2)	/* Loop-Back Mode */
+#define SSCR1_SPO	(1 << 3)	/* Motorola SPI SSPSCLK polarity setting */
+#define SSCR1_SPH	(1 << 4)	/* Motorola SPI SSPSCLK phase setting */
+#define SSCR1_MWDS	(1 << 5)	/* Microwire Transmit Data Size */
+#define SSCR1_TFT	(0x000003c0)	/* Transmit FIFO Threshold (mask) */
+#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..16] */
+#define SSCR1_RFT	(0x00003c00)	/* Receive FIFO Threshold (mask) */
+#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..16] */
+
+#define SSSR_TNF	(1 << 2)	/* Transmit FIFO Not Full */
+#define SSSR_RNE	(1 << 3)	/* Receive FIFO Not Empty */
+#define SSSR_BSY	(1 << 4)	/* SSP Busy */
+#define SSSR_TFS	(1 << 5)	/* Transmit FIFO Service Request */
+#define SSSR_RFS	(1 << 6)	/* Receive FIFO Service Request */
+#define SSSR_ROR	(1 << 7)	/* Receive FIFO Overrun */
+
+#define SSCR0_TIM	(1 << 23)	/* Transmit FIFO Under Run Interrupt Mask */
+#define SSCR0_RIM	(1 << 22)	/* Receive FIFO Over Run interrupt Mask */
+#define SSCR0_NCS	(1 << 21)	/* Network Clock Select */
+#define SSCR0_EDSS	(1 << 20)	/* Extended Data Size Select */
+
+/* extra bits in PXA255, PXA26x and PXA27x SSP ports */
+#define SSCR0_TISSP	(1 << 4)	/* TI Sync Serial Protocol */
+#define SSCR0_PSP	(3 << 4)	/* PSP - Programmable Serial Protocol */
+#define SSCR1_TTELP	(1 << 31)	/* TXD Tristate Enable Last Phase */
+#define SSCR1_TTE	(1 << 30)	/* TXD Tristate Enable */
+#define SSCR1_EBCEI	(1 << 29)	/* Enable Bit Count Error interrupt */
+#define SSCR1_SCFR	(1 << 28)	/* Slave Clock free Running */
+#define SSCR1_ECRA	(1 << 27)	/* Enable Clock Request A */
+#define SSCR1_ECRB	(1 << 26)	/* Enable Clock request B */
+#define SSCR1_SCLKDIR	(1 << 25)	/* Serial Bit Rate Clock Direction */
+#define SSCR1_SFRMDIR	(1 << 24)	/* Frame Direction */
+#define SSCR1_RWOT	(1 << 23)	/* Receive Without Transmit */
+#define SSCR1_TRAIL	(1 << 22)	/* Trailing Byte */
+#define SSCR1_TSRE	(1 << 21)	/* Transmit Service Request Enable */
+#define SSCR1_RSRE	(1 << 20)	/* Receive Service Request Enable */
+#define SSCR1_TINTE	(1 << 19)	/* Receiver Time-out Interrupt enable */
+#define SSCR1_PINTE	(1 << 18)	/* Peripheral Trailing Byte Interupt Enable */
+#define SSCR1_IFS	(1 << 16)	/* Invert Frame Signal */
+#define SSCR1_STRF	(1 << 15)	/* Select FIFO or EFWR */
+#define SSCR1_EFWR	(1 << 14)	/* Enable FIFO Write/Read */
+
+#define SSSR_BCE	(1 << 23)	/* Bit Count Error */
+#define SSSR_CSS	(1 << 22)	/* Clock Synchronisation Status */
+#define SSSR_TUR	(1 << 21)	/* Transmit FIFO Under Run */
+#define SSSR_EOC	(1 << 20)	/* End Of Chain */
+#define SSSR_TINT	(1 << 19)	/* Receiver Time-out Interrupt */
+#define SSSR_PINT	(1 << 18)	/* Peripheral Trailing Byte Interrupt */
+
+#if defined(CONFIG_PXA3xx)
+#define SSPSP_EDMYSTOP(x)	((x) << 28)     /* Extended Dummy Stop */
+#define SSPSP_EDMYSTRT(x)	((x) << 26)     /* Extended Dummy Start */
+#endif
+
+#define SSPSP_FSRT		(1 << 25)	/* Frame Sync Relative Timing */
+#define SSPSP_DMYSTOP(x)	((x) << 23)	/* Dummy Stop */
+#define SSPSP_SFRMWDTH(x)	((x) << 16)	/* Serial Frame Width */
+#define SSPSP_SFRMDLY(x)	((x) << 9)	/* Serial Frame Delay */
+#define SSPSP_DMYSTRT(x)	((x) << 7)	/* Dummy Start */
+#define SSPSP_STRTDLY(x)	((x) << 4)	/* Start Delay */
+#define SSPSP_ETDS		(1 << 3)	/* End of Transfer data State */
+#define SSPSP_SFRMP		(1 << 2)	/* Serial Frame Polarity */
+#define SSPSP_SCMODE(x)		((x) << 0)	/* Serial Bit Rate Clock Mode */
+
+#define SSACD_SCDB		(1 << 3)	/* SSPSYSCLK Divider Bypass */
+#define SSACD_ACPS(x)		((x) << 4)	/* Audio clock PLL select */
+#define SSACD_ACDS(x)		((x) << 0)	/* Audio clock divider select */
+#if defined(CONFIG_PXA3xx)
+#define SSACD_SCDX8		(1 << 7)	/* SYSCLK division ratio select */
+#endif
+
+
+enum pxa_ssp_type {
+	SSP_UNDEFINED = 0,
+	PXA25x_SSP,  /* pxa 210, 250, 255, 26x */
+	PXA25x_NSSP, /* pxa 255, 26x (including ASSP) */
+	PXA27x_SSP,
+};
+
+struct ssp_device {
+	struct platform_device *pdev;
+	struct list_head	node;
+
+	struct clk	*clk;
+	void __iomem	*mmio_base;
+	unsigned long	phys_base;
+
+	const char	*label;
+	int		port_id;
+	int		type;
+	int		use_count;
+	int		irq;
+	int		drcmr_rx;
+	int		drcmr_tx;
+};
+
+/**
+ * ssp_write_reg - Write to a SSP register
+ *
+ * @dev: SSP device to access
+ * @reg: Register to write to
+ * @val: Value to be written.
+ */
+static inline void ssp_write_reg(struct ssp_device *dev, u32 reg, u32 val)
+{
+	__raw_writel(val, dev->mmio_base + reg);
+}
+
+/**
+ * ssp_read_reg - Read from a SSP register
+ *
+ * @dev: SSP device to access
+ * @reg: Register to read from
+ */
+static inline u32 ssp_read_reg(struct ssp_device *dev, u32 reg)
+{
+	return __raw_readl(dev->mmio_base + reg);
+}
+
+struct ssp_device *ssp_request(int port, const char *label);
+void ssp_free(struct ssp_device *);
+
+#endif /* __PLAT_SSP_H */
diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
new file mode 100644
index 0000000..cc22aa6
--- /dev/null
+++ b/arch/arm/plat-pxa/ssp.c
@@ -0,0 +1,201 @@
+/*
+ *  linux/arch/arm/plat-pxa/ssp.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+
+#include <plat/ssp.h>
+
+static DEFINE_MUTEX(ssp_lock);
+static LIST_HEAD(ssp_list);
+
+struct ssp_device *ssp_request(int port, const char *label)
+{
+	struct ssp_device *ssp = NULL;
+
+	mutex_lock(&ssp_lock);
+
+	list_for_each_entry(ssp, &ssp_list, node) {
+		if (ssp->port_id == port && ssp->use_count == 0) {
+			ssp->use_count++;
+			ssp->label = label;
+			break;
+		}
+	}
+
+	mutex_unlock(&ssp_lock);
+
+	if (&ssp->node == &ssp_list)
+		return NULL;
+
+	return ssp;
+}
+EXPORT_SYMBOL(ssp_request);
+
+void ssp_free(struct ssp_device *ssp)
+{
+	mutex_lock(&ssp_lock);
+	if (ssp->use_count) {
+		ssp->use_count--;
+		ssp->label = NULL;
+	} else
+		dev_err(&ssp->pdev->dev, "device already free\n");
+	mutex_unlock(&ssp_lock);
+}
+EXPORT_SYMBOL(ssp_free);
+
+static int __devinit ssp_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct resource *res;
+	struct ssp_device *ssp;
+	int ret = 0;
+
+	ssp = kzalloc(sizeof(struct ssp_device), GFP_KERNEL);
+	if (ssp == NULL) {
+		dev_err(&pdev->dev, "failed to allocate memory");
+		return -ENOMEM;
+	}
+	ssp->pdev = pdev;
+
+	ssp->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ssp->clk)) {
+		ret = PTR_ERR(ssp->clk);
+		goto err_free;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no memory resource defined\n");
+		ret = -ENODEV;
+		goto err_free_clk;
+	}
+
+	res = request_mem_region(res->start, res->end - res->start + 1,
+			pdev->name);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to request memory resource\n");
+		ret = -EBUSY;
+		goto err_free_clk;
+	}
+
+	ssp->phys_base = res->start;
+
+	ssp->mmio_base = ioremap(res->start, res->end - res->start + 1);
+	if (ssp->mmio_base == NULL) {
+		dev_err(&pdev->dev, "failed to ioremap() registers\n");
+		ret = -ENODEV;
+		goto err_free_mem;
+	}
+
+	ssp->irq = platform_get_irq(pdev, 0);
+	if (ssp->irq < 0) {
+		dev_err(&pdev->dev, "no IRQ resource defined\n");
+		ret = -ENODEV;
+		goto err_free_io;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no SSP RX DRCMR defined\n");
+		ret = -ENODEV;
+		goto err_free_io;
+	}
+	ssp->drcmr_rx = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no SSP TX DRCMR defined\n");
+		ret = -ENODEV;
+		goto err_free_io;
+	}
+	ssp->drcmr_tx = res->start;
+
+	/* PXA2xx/3xx SSP ports starts from 1 and the internal pdev->id
+	 * starts from 0, do a translation here
+	 */
+	ssp->port_id = pdev->id + 1;
+	ssp->use_count = 0;
+	ssp->type = (int)id->driver_data;
+
+	mutex_lock(&ssp_lock);
+	list_add(&ssp->node, &ssp_list);
+	mutex_unlock(&ssp_lock);
+
+	platform_set_drvdata(pdev, ssp);
+	return 0;
+
+err_free_io:
+	iounmap(ssp->mmio_base);
+err_free_mem:
+	release_mem_region(res->start, res->end - res->start + 1);
+err_free_clk:
+	clk_put(ssp->clk);
+err_free:
+	kfree(ssp);
+	return ret;
+}
+
+static int __devexit ssp_remove(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct ssp_device *ssp;
+
+	ssp = platform_get_drvdata(pdev);
+	if (ssp == NULL)
+		return -ENODEV;
+
+	iounmap(ssp->mmio_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, res->end - res->start + 1);
+
+	clk_put(ssp->clk);
+
+	mutex_lock(&ssp_lock);
+	list_del(&ssp->node);
+	mutex_unlock(&ssp_lock);
+
+	kfree(ssp);
+	return 0;
+}
+
+static const struct platform_device_id ssp_id_table[] = {
+	{ "pxa25x-ssp",		PXA25x_SSP },
+	{ "pxa25x-nssp",	PXA25x_NSSP },
+	{ "pxa27x-ssp",		PXA27x_SSP },
+	{ },
+};
+
+static struct platform_driver ssp_driver = {
+	.probe		= ssp_probe,
+	.remove		= __devexit_p(ssp_remove),
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "pxa2xx-ssp",
+	},
+	.id_table	= ssp_id_table,
+};
+
+static int __init pxa_ssp_init(void)
+{
+	return platform_driver_register(&ssp_driver);
+}
+
+static void __exit pxa_ssp_exit(void)
+{
+	platform_driver_unregister(&ssp_driver);
+}
+
+arch_initcall(pxa_ssp_init);
+module_exit(pxa_ssp_exit);
+
diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index c2f707e..9b5ca2f 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -35,8 +35,7 @@
 #include <asm/delay.h>

 #include <mach/dma.h>
-#include <mach/regs-ssp.h>
-#include <mach/ssp.h>
+#include <plat/ssp.h>
 #include <mach/pxa2xx_spi.h>

 MODULE_AUTHOR("Stephen Street");
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 376e14a..89de275 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -23,6 +23,7 @@ config SND_PXA2XX_SOC_I2S

 config SND_PXA_SOC_SSP
 	tristate
+	select PXA_SSP_LEGACY

 config SND_PXA2XX_SOC_CORGI
 	tristate "SoC Audio support for Sharp Zaurus SL-C7x0"
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 3bd7712..532277b 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -31,7 +31,6 @@

 #include <mach/hardware.h>
 #include <mach/dma.h>
-#include <mach/regs-ssp.h>
 #include <mach/audio.h>
 #include <mach/ssp.h>
