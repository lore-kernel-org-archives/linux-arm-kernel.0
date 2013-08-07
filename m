From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:34:07 +0200
Subject: [PATCH 18/20] ARM: pxa: register static mmp_pdma device
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <1375889649-14638-19-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop the init call to the properietary dma subsystem and register the
mmp_pdma device.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/devices.c | 26 ++++++++++++++++++++++++++
 arch/arm/mach-pxa/devices.h |  1 +
 arch/arm/mach-pxa/pxa25x.c  |  9 ++++++---
 arch/arm/mach-pxa/pxa27x.c  |  9 ++++++---
 arch/arm/mach-pxa/pxa3xx.c  | 11 +++++++----
 5 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index eb7afe6..78b7181 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -46,6 +46,32 @@ struct platform_device pxa_device_pmu = {
 	.num_resources	= 1,
 };
 
+static struct resource pxadma_resources[] = {
+	[0] = {
+		.start	= 0x40000000,
+		.end	= 0x40001fff,
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
+struct platform_device pxa_device_dma = {
+	.name		= "mmp-pdma",
+	.id		= 0,
+	.dev		= {
+		.dma_mask = &pxadma_dmamask,
+		.coherent_dma_mask = 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(pxadma_resources),
+	.resource	= pxadma_resources,
+};
+
 static struct resource pxamci_resources[] = {
 	[0] = {
 		.start	= 0x41100000,
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 0f3fd0d..19906c9 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -1,4 +1,5 @@
 extern struct platform_device pxa_device_pmu;
+extern struct platform_device pxa_device_dma;
 extern struct platform_device pxa_device_mci;
 extern struct platform_device pxa3xx_device_mci2;
 extern struct platform_device pxa3xx_device_mci3;
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index f2c2897..f9b76f7 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -25,6 +25,7 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/irq.h>
+#include <linux/platform_data/mmp_dma.h>
 
 #include <asm/mach/map.h>
 #include <asm/suspend.h>
@@ -33,7 +34,6 @@
 #include <mach/pxa25x.h>
 #include <mach/reset.h>
 #include <mach/pm.h>
-#include <mach/dma.h>
 #include <mach/smemc.h>
 
 #include "generic.h"
@@ -348,6 +348,10 @@ static struct pxa_gpio_platform_data pxa25x_gpio_info __initdata = {
 	.gpio_set_wake	= gpio_set_wake,
 };
 
+static struct mmp_dma_platdata pxa25x_dma_data __initdata = {
+	.dma_channels	= 16,
+};
+
 static struct platform_device *pxa25x_devices[] __initdata = {
 	&pxa25x_device_udc,
 	&pxa_device_pmu,
@@ -371,8 +375,7 @@ static int __init pxa25x_init(void)
 
 		clkdev_add_table(pxa25x_clkregs, ARRAY_SIZE(pxa25x_clkregs));
 
-		if ((ret = pxa_init_dma(IRQ_DMA, 16)))
-			return ret;
+		pxa_register_device(&pxa_device_dma, &pxa25x_dma_data);
 
 		pxa25x_init_pm();
 
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 301471a..0cb17f1 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <linux/platform_data/mmp_dma.h>
 
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
@@ -32,7 +33,6 @@
 #include <mach/reset.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/pm.h>
-#include <mach/dma.h>
 #include <mach/smemc.h>
 
 #include "generic.h"
@@ -435,6 +435,10 @@ static struct pxa_gpio_platform_data pxa27x_gpio_info __initdata = {
 	.gpio_set_wake	= gpio_set_wake,
 };
 
+static struct mmp_dma_platdata pxa27x_dma_data __initdata = {
+	.dma_channels = 32,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&pxa27x_device_udc,
 	&pxa_device_pmu,
@@ -462,8 +466,7 @@ static int __init pxa27x_init(void)
 
 		clkdev_add_table(pxa27x_clkregs, ARRAY_SIZE(pxa27x_clkregs));
 
-		if ((ret = pxa_init_dma(IRQ_DMA, 32)))
-			return ret;
+		pxa_register_device(&pxa_device_dma, &pxa27x_dma_data);
 
 		pxa27x_init_pm();
 
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 87011f3..7675a5d 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/syscore_ops.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <linux/platform_data/mmp_dma.h>
 
 #include <asm/mach/map.h>
 #include <asm/suspend.h>
@@ -31,7 +32,6 @@
 #include <mach/reset.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/pm.h>
-#include <mach/dma.h>
 #include <mach/smemc.h>
 #include <mach/irqs.h>
 
@@ -441,6 +441,10 @@ static struct pxa_gpio_platform_data pxa3xx_gpio_pdata = {
 	.irq_base	= PXA_GPIO_TO_IRQ(0),
 };
 
+static struct mmp_dma_platdata pxa3xx_dma_data __initdata = {
+	.dma_channels = 32,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&pxa27x_device_udc,
 	&pxa_device_pmu,
@@ -478,9 +482,6 @@ static int __init pxa3xx_init(void)
 
 		clkdev_add_table(pxa3xx_clkregs, ARRAY_SIZE(pxa3xx_clkregs));
 
-		if ((ret = pxa_init_dma(IRQ_DMA, 32)))
-			return ret;
-
 		pxa3xx_init_pm();
 
 		register_syscore_ops(&pxa_irq_syscore_ops);
@@ -490,6 +491,8 @@ static int __init pxa3xx_init(void)
 		if (of_have_populated_dt())
 			return 0;
 
+		pxa_register_device(&pxa_device_dma, &pxa3xx_dma_data);
+
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 		if (ret)
 			return ret;
-- 
1.8.3.1
