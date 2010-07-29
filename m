From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 29 Jul 2010 05:16:26 +0200
Subject: [PATCH 10/13] [ARM] pxa/balloon3: PCMCIA Support
In-Reply-To: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1280373389-32475-10-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver adds support for the on-board CF socket.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c              |   13 ++-
 arch/arm/mach-pxa/include/mach/balloon3.h |   17 ---
 drivers/pcmcia/Kconfig                    |    2 +-
 drivers/pcmcia/Makefile                   |    1 +
 drivers/pcmcia/pxa2xx_balloon3.c          |  199 +++++++++++++++++++++++++++++
 5 files changed, 213 insertions(+), 19 deletions(-)
 create mode 100644 drivers/pcmcia/pxa2xx_balloon3.c

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 572525c..91ad56d 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -88,6 +88,18 @@ static unsigned long balloon3_pin_config[] __initdata = {
 	/* USB Host */
 	GPIO88_USBH1_PWR,
 	GPIO89_USBH1_PEN,
+
+	/* PC Card */
+	GPIO48_nPOE,
+	GPIO49_nPWE,
+	GPIO50_nPIOR,
+	GPIO51_nPIOW,
+	GPIO85_nPCE_1,
+	GPIO54_nPCE_2,
+	GPIO79_PSKTSEL,
+	GPIO55_nPREG,
+	GPIO56_nPWAIT,
+	GPIO57_nIOIS16,
 };
 
 /******************************************************************************
@@ -405,7 +417,6 @@ static void balloon3_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned long pending = __raw_readl(BALLOON3_INT_CONTROL_REG) &
 					balloon3_irq_enabled;
-
 	do {
 		/* clear useless edge notification */
 		if (desc->chip->ack)
diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h b/arch/arm/mach-pxa/include/mach/balloon3.h
index 1a74106..14f4bd5 100644
--- a/arch/arm/mach-pxa/include/mach/balloon3.h
+++ b/arch/arm/mach-pxa/include/mach/balloon3.h
@@ -26,10 +26,6 @@ enum balloon3_features {
 #define BALLOON3_FPGA_VIRT	(0xf1000000)	/* as per balloon2 */
 #define BALLOON3_FPGA_LENGTH	0x01000000
 
-/* FPGA/CPLD registers */
-#define BALLOON3_PCMCIA0_REG		(BALLOON3_FPGA_VIRT + 0x00e00008)
-/* fixme - same for now */
-#define BALLOON3_PCMCIA1_REG		(BALLOON3_FPGA_VIRT + 0x00e00008)
 #define BALLOON3_NANDIO_IO_REG		(BALLOON3_FPGA_VIRT + 0x00e00000)
 /* fpga/cpld interrupt control register */
 #define BALLOON3_INT_CONTROL_REG	(BALLOON3_FPGA_VIRT + 0x00e0000C)
@@ -58,16 +54,6 @@ enum balloon3_features {
 #define BALLOON3_INT_S0_IRQ		(1 << 0)  /* PCMCIA 0 IRQ */
 #define BALLOON3_INT_S0_STSCHG		(1 << 1)  /* PCMCIA 0 status changed */
 
-/* CF Status Register */
-#define BALLOON3_PCMCIA_nIRQ		(1 << 0)  /* IRQ / ready signal */
-#define BALLOON3_PCMCIA_nSTSCHG_BVD1	(1 << 1)
-					/* VDD sense / card status changed */
-
-/* CF control register (write) */
-#define BALLOON3_PCMCIA_RESET		(1 << 0)   /* Card reset signal */
-#define BALLOON3_PCMCIA_ENABLE		(1 << 1)
-#define BALLOON3_PCMCIA_ADD_ENABLE	(1 << 2)
-
 /* CPLD (and FPGA) interface definitions */
 #define CPLD_LCD0_DATA_SET             0x00
 #define CPLD_LCD0_DATA_CLR             0x10
@@ -132,9 +118,6 @@ enum balloon3_features {
 /* Balloon3 Interrupts */
 #define BALLOON3_IRQ(x)		(IRQ_BOARD_START + (x))
 
-#define BALLOON3_BP_CF_NRDY_IRQ	BALLOON3_IRQ(0)
-#define BALLOON3_BP_NSTSCHG_IRQ	BALLOON3_IRQ(1)
-
 #define BALLOON3_AUX_NIRQ	IRQ_GPIO(BALLOON3_GPIO_AUX_NIRQ)
 #define BALLOON3_CODEC_IRQ	IRQ_GPIO(BALLOON3_GPIO_CODEC_IRQ)
 #define BALLOON3_S0_CD_IRQ	IRQ_GPIO(BALLOON3_GPIO_S0_CD)
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index d0f5ad3..ef2f659 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -215,7 +215,7 @@ config PCMCIA_PXA2XX
 	depends on (ARCH_LUBBOCK || MACH_MAINSTONE || PXA_SHARPSL \
 		    || MACH_ARMCORE || ARCH_PXA_PALM || TRIZEPS_PCMCIA \
 		    || ARCOM_PCMCIA || ARCH_PXA_ESERIES || MACH_STARGATE2 \
-		    || MACH_VPAC270)
+		    || MACH_VPAC270 || MACH_BALLOON3)
 	select PCMCIA_SOC_COMMON
 	help
 	  Say Y here to include support for the PXA2xx PCMCIA controller
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index d006e8b..6a60773 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -70,6 +70,7 @@ pxa2xx-obj-$(CONFIG_MACH_PALMLD)		+= pxa2xx_palmld.o
 pxa2xx-obj-$(CONFIG_MACH_E740)			+= pxa2xx_e740.o
 pxa2xx-obj-$(CONFIG_MACH_STARGATE2)		+= pxa2xx_stargate2.o
 pxa2xx-obj-$(CONFIG_MACH_VPAC270)		+= pxa2xx_vpac270.o
+pxa2xx-obj-$(CONFIG_MACH_BALLOON3)		+= pxa2xx_balloon3.o
 
 obj-$(CONFIG_PCMCIA_PXA2XX)			+= pxa2xx_base.o $(pxa2xx-obj-y)
 
diff --git a/drivers/pcmcia/pxa2xx_balloon3.c b/drivers/pcmcia/pxa2xx_balloon3.c
new file mode 100644
index 0000000..1f71f0d
--- /dev/null
+++ b/drivers/pcmcia/pxa2xx_balloon3.c
@@ -0,0 +1,199 @@
+/*
+ * linux/drivers/pcmcia/pxa2xx_balloon3.c
+ *
+ * Balloon3 PCMCIA specific routines.
+ *
+ *  Author:	Nick Bane
+ *  Created:	June, 2006
+ *  Copyright:	Toby Churchill Ltd
+ *  Derived from pxa2xx_mainstone.c, by Nico Pitre
+ *
+ * Various modification by Marek Vasut <marek.vasut@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <mach/balloon3.h>
+
+#include "soc_common.h"
+
+/*
+ * FPGA / CPLD register offsets for CF socket
+ */
+#define	BALLOON3_CF_STATUS_REG		(0x10e00008)
+#define	BALLOON3_CF_CONTROL_REG		(0x10e00008)
+#define BALLOON3_FPGA_VER		(0x10e0001c)
+
+/* CF Status Register bits (read-only) bits */
+#define BALLOON3_CF_nIRQ		(1 << 0)
+#define BALLOON3_CF_nSTSCHG_BVD1	(1 << 1)
+
+/* CF Control Set Register bits / CF Control Clear Register bits (write-only) */
+#define BALLOON3_CF_RESET		(1 << 0)
+#define BALLOON3_CF_ENABLE		(1 << 1)
+#define BALLOON3_CF_ADD_ENABLE		(1 << 2)
+
+/* CF Interrupt sources */
+#define BALLOON3_BP_CF_NRDY_IRQ		BALLOON3_IRQ(0)
+#define BALLOON3_BP_NSTSCHG_IRQ		BALLOON3_IRQ(1)
+
+/*
+ * These are a list of interrupt sources that provokes a polled
+ * check of status
+ */
+static struct pcmcia_irqs irqs[] = {
+	{ 0, BALLOON3_S0_CD_IRQ, "PCMCIA0 CD" },
+	{ 0, BALLOON3_BP_NSTSCHG_IRQ, "PCMCIA0 STSCHG" },
+};
+
+static void __iomem *cf_control_reg;
+
+static int balloon3_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
+{
+	uint16_t ver;
+	int ret;
+	static void __iomem *fpga_ver;
+
+	cf_control_reg = ioremap(BALLOON3_CF_CONTROL_REG, 0x4);
+	if (!cf_control_reg) {
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	fpga_ver = ioremap(BALLOON3_FPGA_VER, 0x4);
+	if (!fpga_ver) {
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	ver = readw(fpga_ver);
+	if (ver > 0x0201)
+		pr_warn("The FPGA code, version 0x%04x, is newer than rel-0.3. "
+			"PCMCIA/CF support might be broken in this version!",
+			ver);
+
+	iounmap(fpga_ver);
+
+	skt->socket.pci_irq = BALLOON3_BP_CF_NRDY_IRQ;
+	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
+
+err2:
+	iounmap(cf_control_reg);
+err1:
+	return ret;
+}
+
+static void balloon3_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
+{
+	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
+	iounmap(cf_control_reg);
+}
+
+static unsigned long balloon3_pcmcia_status[2] = {
+	BALLOON3_CF_nSTSCHG_BVD1,
+	BALLOON3_CF_nSTSCHG_BVD1
+};
+
+static void balloon3_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
+				    struct pcmcia_state *state)
+{
+	uint16_t status;
+	int flip;
+
+	/* This actually reads the STATUS register */
+	status = readw(cf_control_reg);
+	flip = (status ^ balloon3_pcmcia_status[skt->nr])
+		& BALLOON3_CF_nSTSCHG_BVD1;
+	/*
+	 * Workaround for STSCHG which can't be deasserted:
+	 * We therefore disable/enable corresponding IRQs
+	 * as needed to avoid IRQ locks.
+	 */
+	if (flip) {
+		balloon3_pcmcia_status[skt->nr] = status;
+		if (status & BALLOON3_CF_nSTSCHG_BVD1)
+			enable_irq(BALLOON3_BP_NSTSCHG_IRQ);
+		else
+			disable_irq(BALLOON3_BP_NSTSCHG_IRQ);
+	}
+
+	state->detect	= !gpio_get_value(BALLOON3_GPIO_S0_CD);
+	state->ready	= !!(status & BALLOON3_CF_nIRQ);
+	state->bvd1	= !!(status & BALLOON3_CF_nSTSCHG_BVD1);
+	state->bvd2	= 0;	/* not available */
+	state->vs_3v	= 1;	/* Always true its a CF card */
+	state->vs_Xv	= 0;	/* not available */
+	state->wrprot	= 0;	/* not available */
+}
+
+static int balloon3_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
+				       const socket_state_t *state)
+{
+	writew((state->flags & SS_RESET) ? BALLOON3_CF_RESET:0, cf_control_reg);
+	return 0;
+}
+
+static void balloon3_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
+{
+}
+
+static void balloon3_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
+{
+}
+
+static struct pcmcia_low_level balloon3_pcmcia_ops = {
+	.owner			= THIS_MODULE,
+	.hw_init		= balloon3_pcmcia_hw_init,
+	.hw_shutdown		= balloon3_pcmcia_hw_shutdown,
+	.socket_state		= balloon3_pcmcia_socket_state,
+	.configure_socket	= balloon3_pcmcia_configure_socket,
+	.socket_init		= balloon3_pcmcia_socket_init,
+	.socket_suspend		= balloon3_pcmcia_socket_suspend,
+	.first			= 0,
+	.nr			= 1,
+};
+
+static struct platform_device *balloon3_pcmcia_device;
+
+static int __init balloon3_pcmcia_init(void)
+{
+	int ret;
+
+	balloon3_pcmcia_device = platform_device_alloc("pxa2xx-pcmcia", -1);
+	if (!balloon3_pcmcia_device)
+		return -ENOMEM;
+
+	ret = platform_device_add_data(balloon3_pcmcia_device,
+			&balloon3_pcmcia_ops, sizeof(balloon3_pcmcia_ops));
+
+	if (!ret)
+		ret = platform_device_add(balloon3_pcmcia_device);
+
+	if (ret)
+		platform_device_put(balloon3_pcmcia_device);
+
+	return ret;
+}
+
+static void __exit balloon3_pcmcia_exit(void)
+{
+	platform_device_unregister(balloon3_pcmcia_device);
+}
+
+module_init(balloon3_pcmcia_init);
+module_exit(balloon3_pcmcia_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nick Bane <nick@cecomputing.co.uk>");
+MODULE_ALIAS("platform:pxa2xx-pcmcia");
+MODULE_DESCRIPTION("Balloon3 board CF/PCMCIA driver");
-- 
1.7.1
