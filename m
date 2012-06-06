From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  6 Jun 2012 23:34:51 +0200
Subject: [PATCH 2/7] ARM: nomadik: register AMBA devices dynamically
Message-ID: <1339018491-29025-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes AMBA devices on the Nomadik main CPU die register
dynamically, and refactor the registration of the RNG to use
this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/board-nhk8815.c |   17 ++---------------
 arch/arm/mach-nomadik/cpu-8815.c      |   13 ++++---------
 2 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 2e8d3e1..43b844e 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -185,17 +185,6 @@ static void __init nhk8815_onenand_init(void)
 #endif
 }
 
-static AMBA_APB_DEVICE(uart0, "uart0", 0, NOMADIK_UART0_BASE,
-	{ IRQ_UART0 }, NULL);
-
-static AMBA_APB_DEVICE(uart1, "uart1", 0, NOMADIK_UART1_BASE,
-	{ IRQ_UART1 }, NULL);
-
-static struct amba_device *amba_devs[] __initdata = {
-	&uart0_device,
-	&uart1_device,
-};
-
 static struct resource nhk8815_eth_resources[] = {
 	{
 		.name = "smc91x-regs",
@@ -255,15 +244,13 @@ static struct sys_timer nomadik_timer = {
 
 static void __init nhk8815_platform_init(void)
 {
-	int i;
-
 	cpu8815_platform_init();
 	nhk8815_onenand_init();
 	platform_add_devices(nhk8815_platform_devices,
 			     ARRAY_SIZE(nhk8815_platform_devices));
 
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
-		amba_device_register(amba_devs[i], &iomem_resource);
+	amba_apb_device_add(NULL, "uart0", NOMADIK_UART0_BASE, SZ_4K, IRQ_UART0, 0, NULL, 0);
+	amba_apb_device_add(NULL, "uart1", NOMADIK_UART1_BASE, SZ_4K, IRQ_UART1, 0, NULL, 0);
 }
 
 MACHINE_START(NOMADIK, "NHK8815")
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index b79b384..c0f28a6 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -22,6 +22,9 @@
 #include <linux/amba/bus.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/dma-mapping.h>
 
 #include <plat/gpio-nomadik.h>
 #include <mach/hardware.h>
@@ -35,12 +38,6 @@
 #include "clock.h"
 #include "cpu-8815.h"
 
-static AMBA_APB_DEVICE(cpu8815_amba_rng, "rng", 0, NOMADIK_RNG_BASE, { }, NULL);
-
-static struct amba_device *amba_devs[] __initdata = {
-	&cpu8815_amba_rng_device
-};
-
 /* The 8815 has 4 GPIO blocks, let's register them immediately */
 static resource_size_t __initdata cpu8815_gpio_base[] = {
 	NOMADIK_GPIO0_BASE,
@@ -88,15 +85,13 @@ void cpu8815_add_gpios(resource_size_t *base, int num, int irq,
 
 static int __init cpu8815_init(void)
 {
-	int i;
 	struct nmk_gpio_platform_data pdata = {
 		/* No custom data yet */
 	};
 
 	cpu8815_add_gpios(cpu8815_gpio_base, ARRAY_SIZE(cpu8815_gpio_base),
 			  IRQ_GPIO0, &pdata);
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
-		amba_device_register(amba_devs[i], &iomem_resource);
+	amba_apb_device_add(NULL, "rng", NOMADIK_RNG_BASE, SZ_4K, 0, 0, NULL, 0);
 	return 0;
 }
 arch_initcall(cpu8815_init);
-- 
1.7.7.6
