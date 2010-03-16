From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 16 Mar 2010 19:52:48 +0800
Subject: [PATCH 3/8] [ARM] pxa: remove the now legacy SSP API
In-Reply-To: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1268740373-27407-4-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/Kconfig            |    5 -
 arch/arm/mach-pxa/include/mach/ssp.h |   35 ----
 arch/arm/mach-pxa/ssp.c              |  286 ----------------------------------
 3 files changed, 0 insertions(+), 326 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 089579f..8f7eb12 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -653,11 +653,6 @@ config PXA_SSP
 	help
 	  Enable support for PXA2xx SSP ports
 
-config PXA_SSP_LEGACY
-	bool
-	help
-	  Support of legacy SSP API
-
 config TOSA_BT
 	tristate "Control the state of built-in bluetooth chip on Sharp SL-6000"
 	depends on MACH_TOSA
diff --git a/arch/arm/mach-pxa/include/mach/ssp.h b/arch/arm/mach-pxa/include/mach/ssp.h
index be1be5b..8470a73 100644
--- a/arch/arm/mach-pxa/include/mach/ssp.h
+++ b/arch/arm/mach-pxa/include/mach/ssp.h
@@ -46,41 +46,6 @@ struct ssp_device {
 	int		drcmr_tx;
 };
 
-#ifdef CONFIG_PXA_SSP_LEGACY
-/*
- * SSP initialisation flags
- */
-#define SSP_NO_IRQ	0x1		/* don't register an irq handler in SSP driver */
-
-struct ssp_state {
-	u32	cr0;
-	u32 cr1;
-	u32 to;
-	u32 psp;
-};
-
-struct ssp_dev {
-	struct ssp_device *ssp;
-	u32 port;
-	u32 mode;
-	u32 flags;
-	u32 psp_flags;
-	u32 speed;
-	int irq;
-};
-
-int ssp_write_word(struct ssp_dev *dev, u32 data);
-int ssp_read_word(struct ssp_dev *dev, u32 *data);
-int ssp_flush(struct ssp_dev *dev);
-void ssp_enable(struct ssp_dev *dev);
-void ssp_disable(struct ssp_dev *dev);
-void ssp_save_state(struct ssp_dev *dev, struct ssp_state *ssp);
-void ssp_restore_state(struct ssp_dev *dev, struct ssp_state *ssp);
-int ssp_init(struct ssp_dev *dev, u32 port, u32 init_flags);
-int ssp_config(struct ssp_dev *dev, u32 mode, u32 flags, u32 psp_flags, u32 speed);
-void ssp_exit(struct ssp_dev *dev);
-#endif /* CONFIG_PXA_SSP_LEGACY */
-
 /**
  * ssp_write_reg - Write to a SSP register
  *
diff --git a/arch/arm/mach-pxa/ssp.c b/arch/arm/mach-pxa/ssp.c
index a81d6db..6e7df7a 100644
--- a/arch/arm/mach-pxa/ssp.c
+++ b/arch/arm/mach-pxa/ssp.c
@@ -35,278 +35,6 @@
 #include <mach/ssp.h>
 #include <mach/regs-ssp.h>
 
-#ifdef CONFIG_PXA_SSP_LEGACY
-
-#define TIMEOUT 100000
-
-static irqreturn_t ssp_interrupt(int irq, void *dev_id)
-{
-	struct ssp_dev *dev = dev_id;
-	struct ssp_device *ssp = dev->ssp;
-	unsigned int status;
-
-	status = __raw_readl(ssp->mmio_base + SSSR);
-	__raw_writel(status, ssp->mmio_base + SSSR);
-
-	if (status & SSSR_ROR)
-		printk(KERN_WARNING "SSP(%d): receiver overrun\n", dev->port);
-
-	if (status & SSSR_TUR)
-		printk(KERN_WARNING "SSP(%d): transmitter underrun\n", dev->port);
-
-	if (status & SSSR_BCE)
-		printk(KERN_WARNING "SSP(%d): bit count error\n", dev->port);
-
-	return IRQ_HANDLED;
-}
-
-/**
- * ssp_write_word - write a word to the SSP port
- * @data: 32-bit, MSB justified data to write.
- *
- * Wait for a free entry in the SSP transmit FIFO, and write a data
- * word to the SSP port.
- *
- * The caller is expected to perform the necessary locking.
- *
- * Returns:
- *   %-ETIMEDOUT	timeout occurred
- *   0			success
- */
-int ssp_write_word(struct ssp_dev *dev, u32 data)
-{
-	struct ssp_device *ssp = dev->ssp;
-	int timeout = TIMEOUT;
-
-	while (!(__raw_readl(ssp->mmio_base + SSSR) & SSSR_TNF)) {
-	        if (!--timeout)
-	        	return -ETIMEDOUT;
-		cpu_relax();
-	}
-
-	__raw_writel(data, ssp->mmio_base + SSDR);
-
-	return 0;
-}
-
-/**
- * ssp_read_word - read a word from the SSP port
- *
- * Wait for a data word in the SSP receive FIFO, and return the
- * received data.  Data is LSB justified.
- *
- * Note: Currently, if data is not expected to be received, this
- * function will wait for ever.
- *
- * The caller is expected to perform the necessary locking.
- *
- * Returns:
- *   %-ETIMEDOUT	timeout occurred
- *   32-bit data	success
- */
-int ssp_read_word(struct ssp_dev *dev, u32 *data)
-{
-	struct ssp_device *ssp = dev->ssp;
-	int timeout = TIMEOUT;
-
-	while (!(__raw_readl(ssp->mmio_base + SSSR) & SSSR_RNE)) {
-	        if (!--timeout)
-	        	return -ETIMEDOUT;
-		cpu_relax();
-	}
-
-	*data = __raw_readl(ssp->mmio_base + SSDR);
-	return 0;
-}
-
-/**
- * ssp_flush - flush the transmit and receive FIFOs
- *
- * Wait for the SSP to idle, and ensure that the receive FIFO
- * is empty.
- *
- * The caller is expected to perform the necessary locking.
- */
-int ssp_flush(struct ssp_dev *dev)
-{
-	struct ssp_device *ssp = dev->ssp;
-	int timeout = TIMEOUT * 2;
-
-	/* ensure TX FIFO is empty instead of not full */
-	if (cpu_is_pxa3xx()) {
-		while (__raw_readl(ssp->mmio_base + SSSR) & 0xf00) {
-			if (!--timeout)
-				return -ETIMEDOUT;
-			cpu_relax();
-		}
-		timeout = TIMEOUT * 2;
-	}
-
-	do {
-		while (__raw_readl(ssp->mmio_base + SSSR) & SSSR_RNE) {
-		        if (!--timeout)
-		        	return -ETIMEDOUT;
-			(void)__raw_readl(ssp->mmio_base + SSDR);
-		}
-	        if (!--timeout)
-	        	return -ETIMEDOUT;
-	} while (__raw_readl(ssp->mmio_base + SSSR) & SSSR_BSY);
-
-	return 0;
-}
-
-/**
- * ssp_enable - enable the SSP port
- *
- * Turn on the SSP port.
- */
-void ssp_enable(struct ssp_dev *dev)
-{
-	struct ssp_device *ssp = dev->ssp;
-	uint32_t sscr0;
-
-	sscr0 = __raw_readl(ssp->mmio_base + SSCR0);
-	sscr0 |= SSCR0_SSE;
-	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
-}
-
-/**
- * ssp_disable - shut down the SSP port
- *
- * Turn off the SSP port, optionally powering it down.
- */
-void ssp_disable(struct ssp_dev *dev)
-{
-	struct ssp_device *ssp = dev->ssp;
-	uint32_t sscr0;
-
-	sscr0 = __raw_readl(ssp->mmio_base + SSCR0);
-	sscr0 &= ~SSCR0_SSE;
-	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
-}
-
-/**
- * ssp_save_state - save the SSP configuration
- * @ssp: pointer to structure to save SSP configuration
- *
- * Save the configured SSP state for suspend.
- */
-void ssp_save_state(struct ssp_dev *dev, struct ssp_state *state)
-{
-	struct ssp_device *ssp = dev->ssp;
-
-	state->cr0 = __raw_readl(ssp->mmio_base + SSCR0);
-	state->cr1 = __raw_readl(ssp->mmio_base + SSCR1);
-	state->to  = __raw_readl(ssp->mmio_base + SSTO);
-	state->psp = __raw_readl(ssp->mmio_base + SSPSP);
-
-	ssp_disable(dev);
-}
-
-/**
- * ssp_restore_state - restore a previously saved SSP configuration
- * @ssp: pointer to configuration saved by ssp_save_state
- *
- * Restore the SSP configuration saved previously by ssp_save_state.
- */
-void ssp_restore_state(struct ssp_dev *dev, struct ssp_state *state)
-{
-	struct ssp_device *ssp = dev->ssp;
-	uint32_t sssr = SSSR_ROR | SSSR_TUR | SSSR_BCE;
-
-	__raw_writel(sssr, ssp->mmio_base + SSSR);
-
-	__raw_writel(state->cr0 & ~SSCR0_SSE, ssp->mmio_base + SSCR0);
-	__raw_writel(state->cr1, ssp->mmio_base + SSCR1);
-	__raw_writel(state->to,  ssp->mmio_base + SSTO);
-	__raw_writel(state->psp, ssp->mmio_base + SSPSP);
-	__raw_writel(state->cr0, ssp->mmio_base + SSCR0);
-}
-
-/**
- * ssp_config - configure SSP port settings
- * @mode: port operating mode
- * @flags: port config flags
- * @psp_flags: port PSP config flags
- * @speed: port speed
- *
- * Port MUST be disabled by ssp_disable before making any config changes.
- */
-int ssp_config(struct ssp_dev *dev, u32 mode, u32 flags, u32 psp_flags, u32 speed)
-{
-	struct ssp_device *ssp = dev->ssp;
-
-	dev->mode = mode;
-	dev->flags = flags;
-	dev->psp_flags = psp_flags;
-	dev->speed = speed;
-
-	/* set up port type, speed, port settings */
-	__raw_writel((dev->speed | dev->mode), ssp->mmio_base + SSCR0);
-	__raw_writel(dev->flags, ssp->mmio_base + SSCR1);
-	__raw_writel(dev->psp_flags, ssp->mmio_base + SSPSP);
-
-	return 0;
-}
-
-/**
- * ssp_init - setup the SSP port
- *
- * initialise and claim resources for the SSP port.
- *
- * Returns:
- *   %-ENODEV	if the SSP port is unavailable
- *   %-EBUSY	if the resources are already in use
- *   %0		on success
- */
-int ssp_init(struct ssp_dev *dev, u32 port, u32 init_flags)
-{
-	struct ssp_device *ssp;
-	int ret;
-
-	ssp = ssp_request(port, "SSP");
-	if (ssp == NULL)
-		return -ENODEV;
-
-	dev->ssp = ssp;
-	dev->port = port;
-
-	/* do we need to get irq */
-	if (!(init_flags & SSP_NO_IRQ)) {
-		ret = request_irq(ssp->irq, ssp_interrupt,
-				0, "SSP", dev);
-	    	if (ret)
-			goto out_region;
-		dev->irq = ssp->irq;
-	} else
-		dev->irq = NO_IRQ;
-
-	/* turn on SSP port clock */
-	clk_enable(ssp->clk);
-	return 0;
-
-out_region:
-	ssp_free(ssp);
-	return ret;
-}
-
-/**
- * ssp_exit - undo the effects of ssp_init
- *
- * release and free resources for the SSP port.
- */
-void ssp_exit(struct ssp_dev *dev)
-{
-	struct ssp_device *ssp = dev->ssp;
-
-	ssp_disable(dev);
-	if (dev->irq != NO_IRQ)
-		free_irq(dev->irq, dev);
-	clk_disable(ssp->clk);
-	ssp_free(ssp);
-}
-#endif /* CONFIG_PXA_SSP_LEGACY */
-
 static DEFINE_MUTEX(ssp_lock);
 static LIST_HEAD(ssp_list);
 
@@ -491,20 +219,6 @@ static void __exit pxa_ssp_exit(void)
 arch_initcall(pxa_ssp_init);
 module_exit(pxa_ssp_exit);
 
-#ifdef CONFIG_PXA_SSP_LEGACY
-EXPORT_SYMBOL(ssp_write_word);
-EXPORT_SYMBOL(ssp_read_word);
-EXPORT_SYMBOL(ssp_flush);
-EXPORT_SYMBOL(ssp_enable);
-EXPORT_SYMBOL(ssp_disable);
-EXPORT_SYMBOL(ssp_save_state);
-EXPORT_SYMBOL(ssp_restore_state);
-EXPORT_SYMBOL(ssp_init);
-EXPORT_SYMBOL(ssp_exit);
-EXPORT_SYMBOL(ssp_config);
-#endif
-
 MODULE_DESCRIPTION("PXA SSP driver");
 MODULE_AUTHOR("Liam Girdwood");
 MODULE_LICENSE("GPL");
-
-- 
1.6.3.3
