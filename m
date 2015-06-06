From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  6 Jun 2015 23:11:02 +0200
Subject: [PATCH v2] ARM: pxa: transition to dmaengine phase 1
Message-ID: <1433625062-28306-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to slowly transition pxa to dmaengine, the legacy code will now
rely on dmaengine to request a channel.

This implies that PXA architecture selects DMADEVICES and PXA_DMA,
which is not pretty. Yet it enables PXA drivers to be ported one by one,
with part of them using dmaengine, and the other part using the legacy
code.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

---
Since v1: removed Kconfig selects
          added the mmp_pdma platform devices for legacy platforms
	  fixed the legacy dma interrupt handler to cooperate with mmp_pdma
---
 arch/arm/mach-pxa/devices.c          | 37 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/pxa25x.c           |  1 +
 arch/arm/mach-pxa/pxa27x.c           |  1 +
 arch/arm/mach-pxa/pxa3xx.c           |  1 +
 arch/arm/plat-pxa/dma.c              | 22 ++++++++++-----------
 arch/arm/plat-pxa/include/plat/dma.h | 15 +++++++++++++++
 6 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 3543466..e6ce669 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -17,6 +17,7 @@
 #include <linux/platform_data/camera-pxa.h>
 #include <mach/audio.h>
 #include <mach/hardware.h>
+#include <linux/platform_data/mmp_dma.h>
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
 
 #include "devices.h"
@@ -1193,3 +1194,39 @@ void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master *info)
 	pd->dev.platform_data = info;
 	platform_device_add(pd);
 }
+
+static struct mmp_dma_platdata pxa_dma_pdata = {
+	.dma_channels	= 0,
+};
+
+static struct resource pxa_dma_resource[] = {
+	[0] = {
+		.start	= 0x40000000,
+		.end	= 0x4000ffff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_DMA,
+		.end	= IRQ_DMA,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 pxadma_dmamask = 0xffffffffUL;
+
+static struct platform_device pxa2xx_pxa_dma = {
+	.name		= "pxa-dma",
+	.id		= 0,
+	.dev		= {
+		.dma_mask = &pxadma_dmamask,
+		.coherent_dma_mask = 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(pxa_dma_resource),
+	.resource	= pxa_dma_resource,
+};
+
+void __init pxa2xx_set_dmac_info(int nb_channels)
+{
+	pxa_dma_pdata.dma_channels = nb_channels;
+	pxa_register_device(&pxa2xx_pxa_dma, &pxa_dma_pdata);
+}
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 23a90c6..1dc85ff 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -206,6 +206,7 @@ static int __init pxa25x_init(void)
 		register_syscore_ops(&pxa_irq_syscore_ops);
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
 
+		pxa2xx_set_dmac_info(16);
 		pxa_register_device(&pxa25x_device_gpio, &pxa25x_gpio_info);
 		ret = platform_add_devices(pxa25x_devices,
 					   ARRAY_SIZE(pxa25x_devices));
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index b5abdeb..e6aae9e 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -310,6 +310,7 @@ static int __init pxa27x_init(void)
 		if (!of_have_populated_dt()) {
 			pxa_register_device(&pxa27x_device_gpio,
 					    &pxa27x_gpio_info);
+			pxa2xx_set_dmac_info(32);
 			ret = platform_add_devices(devices,
 						   ARRAY_SIZE(devices));
 		}
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index bd4cbef..aa85ec1 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -431,6 +431,7 @@ static int __init pxa3xx_init(void)
 		if (of_have_populated_dt())
 			return 0;
 
+		pxa2xx_set_dmac_info(32);
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 		if (ret)
 			return ret;
diff --git a/arch/arm/plat-pxa/dma.c b/arch/arm/plat-pxa/dma.c
index d92f07f..de2b061 100644
--- a/arch/arm/plat-pxa/dma.c
+++ b/arch/arm/plat-pxa/dma.c
@@ -289,7 +289,8 @@ int pxa_request_dma (char *name, pxa_dma_prio prio,
 		/* try grabbing a DMA channel with the requested priority */
 		for (i = 0; i < num_dma_channels; i++) {
 			if ((dma_channels[i].prio == prio) &&
-			    !dma_channels[i].name) {
+			    !dma_channels[i].name &&
+			    !pxad_toggle_reserved_channel(i)) {
 				found = 1;
 				break;
 			}
@@ -326,13 +327,14 @@ void pxa_free_dma (int dma_ch)
 	local_irq_save(flags);
 	DCSR(dma_ch) = DCSR_STARTINTR|DCSR_ENDINTR|DCSR_BUSERR;
 	dma_channels[dma_ch].name = NULL;
+	pxad_toggle_reserved_channel(dma_ch);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(pxa_free_dma);
 
 static irqreturn_t dma_irq_handler(int irq, void *dev_id)
 {
-	int i, dint = DINT;
+	int i, dint = DINT, done = 0;
 	struct dma_channel *channel;
 
 	while (dint) {
@@ -341,16 +343,13 @@ static irqreturn_t dma_irq_handler(int irq, void *dev_id)
 		channel = &dma_channels[i];
 		if (channel->name && channel->irq_handler) {
 			channel->irq_handler(i, channel->data);
-		} else {
-			/*
-			 * IRQ for an unregistered DMA channel:
-			 * let's clear the interrupts and disable it.
-			 */
-			printk (KERN_WARNING "spurious IRQ for DMA channel %d\n", i);
-			DCSR(i) = DCSR_STARTINTR|DCSR_ENDINTR|DCSR_BUSERR;
+			done++;
 		}
 	}
-	return IRQ_HANDLED;
+	if (done)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
 }
 
 int __init pxa_init_dma(int irq, int num_ch)
@@ -372,7 +371,8 @@ int __init pxa_init_dma(int irq, int num_ch)
 		spin_lock_init(&dma_channels[i].lock);
 	}
 
-	ret = request_irq(irq, dma_irq_handler, 0, "DMA", NULL);
+	ret = request_irq(irq, dma_irq_handler, IRQF_SHARED, "DMA",
+			  dma_channels);
 	if (ret) {
 		printk (KERN_CRIT "Wow!  Can't register IRQ for DMA\n");
 		kfree(dma_channels);
diff --git a/arch/arm/plat-pxa/include/plat/dma.h b/arch/arm/plat-pxa/include/plat/dma.h
index a7b91dc..33ac1a9e 100644
--- a/arch/arm/plat-pxa/include/plat/dma.h
+++ b/arch/arm/plat-pxa/include/plat/dma.h
@@ -82,4 +82,19 @@ int pxa_request_dma (char *name,
 
 void pxa_free_dma (int dma_ch);
 
+/*
+ * Cooperation with pxa_dma + dmaengine while there remains at least one pxa
+ * driver not converted to dmaengine.
+ */
+#if defined(CONFIG_PXA_DMA)
+extern int pxad_toggle_reserved_channel(int legacy_channel);
+#else
+static inline pxad_toggle_reserved_channel(int legacy_channel)
+{
+	return 0;
+}
+#endif
+
+extern void __init pxa2xx_set_dmac_info(int nb_channels);
+
 #endif /* __PLAT_DMA_H */
-- 
2.1.4
