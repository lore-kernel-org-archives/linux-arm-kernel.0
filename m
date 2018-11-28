From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 28 Nov 2018 11:11:58 +0000
Subject: [PATCH 5/8] ARM: pxa/mainstone: switch PCMCIA to MAX1600 library and
 gpiod APIs
In-Reply-To: <20181128111041.GG30658@n2100.armlinux.org.uk>
Message-ID: <E1gRxl8-0001uz-6u@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert mainstone to use the MAX1600 library and gpiod APIs for socket
status and control signals.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-pxa/Kconfig                  |   1 +
 arch/arm/mach-pxa/include/mach/mainstone.h |   4 +
 arch/arm/mach-pxa/mainstone.c              |  53 ++++++++++++++
 drivers/pcmcia/Kconfig                     |   1 +
 drivers/pcmcia/pxa2xx_mainstone.c          | 113 +++++++++--------------------
 5 files changed, 93 insertions(+), 79 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index a68b34183107..fd724a71c2e1 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -46,6 +46,7 @@ config ARCH_LUBBOCK
 
 config MACH_MAINSTONE
 	bool "Intel HCDDBBVA0 Development Platform (aka Mainstone)"
+	select GPIO_REG
 	select PXA27x
 
 config MACH_ZYLONITE
diff --git a/arch/arm/mach-pxa/include/mach/mainstone.h b/arch/arm/mach-pxa/include/mach/mainstone.h
index e82a7d31104e..474041a83d80 100644
--- a/arch/arm/mach-pxa/include/mach/mainstone.h
+++ b/arch/arm/mach-pxa/include/mach/mainstone.h
@@ -119,6 +119,10 @@
 #define MST_PCMCIA_PWR_VCC_33   0x8	   /* voltage VCC = 3.3V */
 #define MST_PCMCIA_PWR_VCC_50   0x4	   /* voltage VCC = 5.0V */
 
+#define MST_PCMCIA_INPUTS \
+	(MST_PCMCIA_nIRQ | MST_PCMCIA_nSPKR_BVD2 | MST_PCMCIA_nSTSCHG_BVD1 | \
+	 MST_PCMCIA_nVS2 | MST_PCMCIA_nVS1 | MST_PCMCIA_nCD)
+
 /* board specific IRQs */
 #define MAINSTONE_NR_IRQS	IRQ_BOARD_START
 
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index afd62a94fdbf..d40de190d630 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -13,6 +13,7 @@
  *  published by the Free Software Foundation.
  */
 #include <linux/gpio.h>
+#include <linux/gpio/gpio-reg.h>
 #include <linux/gpio/machine.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -507,12 +508,64 @@ static void __init mainstone_init_keypad(void)
 static inline void mainstone_init_keypad(void) {}
 #endif
 
+static int mst_pcmcia0_irqs[11] = {
+	[0 ... 10] = -1,
+	[5] = MAINSTONE_S0_CD_IRQ,
+	[8] = MAINSTONE_S0_STSCHG_IRQ,
+	[10] = MAINSTONE_S0_IRQ,
+};
+
+static int mst_pcmcia1_irqs[11] = {
+	[0 ... 10] = -1,
+	[5] = MAINSTONE_S1_CD_IRQ,
+	[8] = MAINSTONE_S1_STSCHG_IRQ,
+	[10] = MAINSTONE_S1_IRQ,
+};
+
+static struct gpiod_lookup_table mainstone_pcmcia_gpio_table = {
+	.dev_id = "pxa2xx-pcmcia",
+	.table = {
+		GPIO_LOOKUP("mst-pcmcia0",  0, "a0vpp",   GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia0",  1, "a1vpp",   GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia0",  2, "a0vcc",   GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia0",  3, "a1vcc",   GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia0",  4, "areset",  GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia0",  5, "adetect", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("mst-pcmcia0",  6, "avs1",    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("mst-pcmcia0",  7, "avs2",    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("mst-pcmcia0",  8, "abvd1",   GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia0",  9, "abvd2",   GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia0", 10, "aready",  GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia1",  0, "b0vpp",   GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia1",  1, "b1vpp",   GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia1",  2, "b0vcc",   GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia1",  3, "b1vcc",   GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia1",  4, "breset",  GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia1",  5, "bdetect", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("mst-pcmcia1",  6, "bvs1",    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("mst-pcmcia1",  7, "bvs2",    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("mst-pcmcia1",  8, "bbvd1",   GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia1",  9, "bbvd2",   GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("mst-pcmcia1", 10, "bready",  GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static void __init mainstone_init(void)
 {
 	int SW7 = 0;  /* FIXME: get from SCR (Mst doc section 3.2.1.1) */
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(mainstone_pin_config));
 
+	/* Register board control register(s) as GPIOs */
+	gpio_reg_init(NULL, (void __iomem *)&MST_PCMCIA0, -1, 11,
+		      "mst-pcmcia0", MST_PCMCIA_INPUTS, 0, NULL,
+		      NULL, mst_pcmcia0_irqs);
+	gpio_reg_init(NULL, (void __iomem *)&MST_PCMCIA1, -1, 11,
+		      "mst-pcmcia1", MST_PCMCIA_INPUTS, 0, NULL,
+		      NULL, mst_pcmcia1_irqs);
+	gpiod_add_lookup_table(&mainstone_pcmcia_gpio_table);
+
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 8e8db3aa9fce..9ac3d4a68075 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -211,6 +211,7 @@ config PCMCIA_PXA2XX
 		    || MACH_VPAC270 || MACH_BALLOON3 || MACH_COLIBRI \
 		    || MACH_COLIBRI320 || MACH_H4700)
 	select PCMCIA_SOC_COMMON
+	select PCMCIA_MAX1600 if MACH_MAINSTONE
 	help
 	  Say Y here to include support for the PXA2xx PCMCIA controller
 
diff --git a/drivers/pcmcia/pxa2xx_mainstone.c b/drivers/pcmcia/pxa2xx_mainstone.c
index 7e32e25cdcb2..770c7bf0171d 100644
--- a/drivers/pcmcia/pxa2xx_mainstone.c
+++ b/drivers/pcmcia/pxa2xx_mainstone.c
@@ -11,56 +11,55 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/interrupt.h>
 #include <linux/platform_device.h>
 
 #include <pcmcia/ss.h>
 
 #include <asm/mach-types.h>
-#include <asm/irq.h>
-
-#include <mach/pxa2xx-regs.h>
-#include <mach/mainstone.h>
 
 #include "soc_common.h"
-
+#include "max1600.h"
 
 static int mst_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	/*
-	 * Setup default state of GPIO outputs
-	 * before we enable them as outputs.
-	 */
-	if (skt->nr == 0) {
-		skt->socket.pci_irq = MAINSTONE_S0_IRQ;
-		skt->stat[SOC_STAT_CD].irq = MAINSTONE_S0_CD_IRQ;
-		skt->stat[SOC_STAT_CD].name = "PCMCIA0 CD";
-		skt->stat[SOC_STAT_BVD1].irq = MAINSTONE_S0_STSCHG_IRQ;
-		skt->stat[SOC_STAT_BVD1].name = "PCMCIA0 STSCHG";
-	} else {
-		skt->socket.pci_irq = MAINSTONE_S1_IRQ;
-		skt->stat[SOC_STAT_CD].irq = MAINSTONE_S1_CD_IRQ;
-		skt->stat[SOC_STAT_CD].name = "PCMCIA1 CD";
-		skt->stat[SOC_STAT_BVD1].irq = MAINSTONE_S1_STSCHG_IRQ;
-		skt->stat[SOC_STAT_BVD1].name = "PCMCIA1 STSCHG";
-	}
-	return 0;
+	struct device *dev = skt->socket.dev.parent;
+	struct max1600 *m;
+	int ret;
+
+	skt->stat[SOC_STAT_CD].name = skt->nr ? "bdetect" : "adetect";
+	skt->stat[SOC_STAT_BVD1].name = skt->nr ? "bbvd1" : "abvd1";
+	skt->stat[SOC_STAT_BVD2].name = skt->nr ? "bbvd2" : "abvd2";
+	skt->stat[SOC_STAT_RDY].name = skt->nr ? "bready" : "aready";
+	skt->stat[SOC_STAT_VS1].name = skt->nr ? "bvs1" : "avs1";
+	skt->stat[SOC_STAT_VS2].name = skt->nr ? "bvs2" : "avs2";
+
+	skt->gpio_reset = devm_gpiod_get(dev, skt->nr ? "breset" : "areset",
+					 GPIOD_OUT_HIGH);
+	if (IS_ERR(skt->gpio_reset))
+		return PTR_ERR(skt->gpio_reset);
+
+	ret = max1600_init(dev, &m, skt->nr ? MAX1600_CHAN_B : MAX1600_CHAN_A,
+			   MAX1600_CODE_HIGH);
+	if (ret)
+		return ret;
+
+	skt->driver_data = m;
+
+	return soc_pcmcia_request_gpiods(skt);
 }
 
-static unsigned long mst_pcmcia_status[2];
+static unsigned int mst_pcmcia_bvd1_status[2];
 
 static void mst_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 				    struct pcmcia_state *state)
 {
-	unsigned long status, flip;
-
-	status = (skt->nr == 0) ? MST_PCMCIA0 : MST_PCMCIA1;
-	flip = (status ^ mst_pcmcia_status[skt->nr]) & MST_PCMCIA_nSTSCHG_BVD1;
+	unsigned int flip = mst_pcmcia_bvd1_status[skt->nr] ^ state->bvd1;
 
 	/*
 	 * Workaround for STSCHG which can't be deasserted:
@@ -68,62 +67,18 @@ static void mst_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 	 * as needed to avoid IRQ locks.
 	 */
 	if (flip) {
-		mst_pcmcia_status[skt->nr] = status;
-		if (status & MST_PCMCIA_nSTSCHG_BVD1)
-			enable_irq( (skt->nr == 0) ? MAINSTONE_S0_STSCHG_IRQ
-						   : MAINSTONE_S1_STSCHG_IRQ );
+		mst_pcmcia_bvd1_status[skt->nr] = state->bvd1;
+		if (state->bvd1)
+			enable_irq(skt->stat[SOC_STAT_BVD1].irq);
 		else
-			disable_irq( (skt->nr == 0) ? MAINSTONE_S0_STSCHG_IRQ
-						    : MAINSTONE_S1_STSCHG_IRQ );
+			disable_irq(skt->stat[SOC_STAT_BVD2].irq);
 	}
-
-	state->detect = (status & MST_PCMCIA_nCD) ? 0 : 1;
-	state->ready  = (status & MST_PCMCIA_nIRQ) ? 1 : 0;
-	state->bvd1   = (status & MST_PCMCIA_nSTSCHG_BVD1) ? 1 : 0;
-	state->bvd2   = (status & MST_PCMCIA_nSPKR_BVD2) ? 1 : 0;
-	state->vs_3v  = (status & MST_PCMCIA_nVS1) ? 0 : 1;
-	state->vs_Xv  = (status & MST_PCMCIA_nVS2) ? 0 : 1;
 }
 
 static int mst_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 				       const socket_state_t *state)
 {
-	unsigned long power = 0;
-	int ret = 0;
-
-	switch (state->Vcc) {
-	case 0:  power |= MST_PCMCIA_PWR_VCC_0;  break;
-	case 33: power |= MST_PCMCIA_PWR_VCC_33; break;
-	case 50: power |= MST_PCMCIA_PWR_VCC_50; break;
-	default:
-		 printk(KERN_ERR "%s(): bad Vcc %u\n",
-				 __func__, state->Vcc);
-		 ret = -1;
-	}
-
-	switch (state->Vpp) {
-	case 0:   power |= MST_PCMCIA_PWR_VPP_0;   break;
-	case 120: power |= MST_PCMCIA_PWR_VPP_120; break;
-	default:
-		  if(state->Vpp == state->Vcc) {
-			  power |= MST_PCMCIA_PWR_VPP_VCC;
-		  } else {
-			  printk(KERN_ERR "%s(): bad Vpp %u\n",
-					  __func__, state->Vpp);
-			  ret = -1;
-		  }
-	}
-
-	if (state->flags & SS_RESET)
-	       power |= MST_PCMCIA_RESET;
-
-	switch (skt->nr) {
-	case 0:  MST_PCMCIA0 = power; break;
-	case 1:  MST_PCMCIA1 = power; break;
-	default: ret = -1;
-	}
-
-	return ret;
+	return max1600_configure(skt->driver_data, state->Vcc, state->Vpp);
 }
 
 static struct pcmcia_low_level mst_pcmcia_ops __initdata = {
-- 
2.7.4
