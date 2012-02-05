From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  5 Feb 2012 19:29:36 +0100
Subject: [PATCH 2/2] ARM: at91: make gpbr soc independent
In-Reply-To: <1328466576-29384-1-git-send-email-plagnioj@jcrosoft.com>
References: <1328466576-29384-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1328466576-29384-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use genalloc to manage the pool of backup register

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: rtc-linux at googlegroups.com
---
Hi,

	if you don't mind I'll apply this via at91 tree as it's needed to
	finish a cleanup on at91 to allow multiple soc in the same kernel

Best Regards,
J.

 arch/arm/Kconfig                              |    1 +
 arch/arm/mach-at91/at91sam9260_devices.c      |    1 +
 arch/arm/mach-at91/at91sam9261_devices.c      |    1 +
 arch/arm/mach-at91/at91sam9263_devices.c      |    1 +
 arch/arm/mach-at91/at91sam9g45_devices.c      |    1 +
 arch/arm/mach-at91/at91sam9rl_devices.c       |    1 +
 arch/arm/mach-at91/generic.h                  |    1 +
 arch/arm/mach-at91/include/mach/at91sam9260.h |    5 +--
 arch/arm/mach-at91/include/mach/at91sam9261.h |    5 +--
 arch/arm/mach-at91/include/mach/at91sam9263.h |    5 +--
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    5 +--
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    2 +-
 arch/arm/mach-at91/setup.c                    |   29 +++++++++++++++++++++++++
 drivers/rtc/rtc-at91sam9.c                    |   18 +++++++++++++--
 14 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 92c9c79..dd49374 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -322,6 +322,7 @@ config ARCH_AT91
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
+	select GENERIC_ALLOCATOR
 	help
 	  This enables support for systems based on the Atmel AT91RM9200,
 	  AT91SAM9 processors.
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 2760146..d86319f 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -1333,6 +1333,7 @@ void __init at91_add_device_cf(struct at91_cf_data * data) {}
  */
 static int __init at91_add_standard_devices(void)
 {
+	at91_init_gpbr(AT91SAM9260_BASE_GPBR, 16);
 	at91_add_device_rtt();
 	at91_add_device_watchdog();
 	at91_add_device_tc();
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 52c1f1a..64e194d 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -1061,6 +1061,7 @@ void __init at91_add_device_serial(void) {}
  */
 static int __init at91_add_standard_devices(void)
 {
+	at91_init_gpbr(AT91SAM9261_BASE_GPBR, 16);
 	at91_add_device_rtt();
 	at91_add_device_watchdog();
 	at91_add_device_tc();
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 1de4c4f..4ba3e18 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1447,6 +1447,7 @@ void __init at91_add_device_serial(void) {}
  */
 static int __init at91_add_standard_devices(void)
 {
+	at91_init_gpbr(AT91SAM9263_BASE_GPBR, 80);
 	at91_add_device_rtt();
 	at91_add_device_watchdog();
 	at91_add_device_tc();
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 8c036ff..33c7f44 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1732,6 +1732,7 @@ void __init at91_add_device_serial(void) {}
  */
 static int __init at91_add_standard_devices(void)
 {
+	at91_init_gpbr(AT91SAM9G45_BASE_GPBR, 80);
 	at91_add_device_hdmac();
 	at91_add_device_rtc();
 	at91_add_device_rtt();
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 936cf20..df9224d 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -1202,6 +1202,7 @@ void __init at91_add_device_serial(void) {}
  */
 static int __init at91_add_standard_devices(void)
 {
+	at91_init_gpbr(AT91SAM9G45_BASE_GPBR, 16);
 	at91_add_device_hdmac();
 	at91_add_device_rtc();
 	at91_add_device_rtt();
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 7a5e23a..cbf43b1 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -14,6 +14,7 @@
 extern void __init at91_map_io(void);
 extern void __init at91_init_sram(int bank, unsigned long base,
 				  unsigned int length);
+extern void __init at91_init_gpbr(unsigned long base, unsigned int length);
 
  /* Processors */
 extern void __init at91rm9200_set_type(int type);
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 5cfc9dc..08ae9af 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -78,10 +78,8 @@
 #define AT91SAM9260_BASE_ADC		0xfffe0000
 
 /*
- * System Peripherals (offset from AT91_BASE_SYS)
+ * System Peripherals
  */
-#define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
-
 #define AT91SAM9260_BASE_ECC	0xffffe800
 #define AT91SAM9260_BASE_SDRAMC	0xffffea00
 #define AT91SAM9260_BASE_SMC	0xffffec00
@@ -95,6 +93,7 @@
 #define AT91SAM9260_BASE_RTT	0xfffffd20
 #define AT91SAM9260_BASE_PIT	0xfffffd30
 #define AT91SAM9260_BASE_WDT	0xfffffd40
+#define AT91SAM9260_BASE_GPBR	0xfffffd50
 
 #define AT91_USART0	AT91SAM9260_BASE_US0
 #define AT91_USART1	AT91SAM9260_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index e4c936c..1124bd2 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -63,10 +63,8 @@
 
 
 /*
- * System Peripherals (offset from AT91_BASE_SYS)
+ * System Peripherals
  */
-#define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
-
 #define AT91SAM9261_BASE_SMC	0xffffec00
 #define AT91SAM9261_BASE_SDRAMC	0xffffea00
 #define AT91SAM9261_BASE_MATRIX	0xffffee00
@@ -79,6 +77,7 @@
 #define AT91SAM9261_BASE_RTT	0xfffffd20
 #define AT91SAM9261_BASE_PIT	0xfffffd30
 #define AT91SAM9261_BASE_WDT	0xfffffd40
+#define AT91SAM9261_BASE_GPBR	0xfffffd50
 
 #define AT91_USART0	AT91SAM9261_BASE_US0
 #define AT91_USART1	AT91SAM9261_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index dda083d..d96cbb2 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -72,10 +72,8 @@
 #define AT91SAM9263_BASE_2DGE		0xfffc8000
 
 /*
- * System Peripherals (offset from AT91_BASE_SYS)
+ * System Peripherals
  */
-#define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
-
 #define AT91SAM9263_BASE_ECC0	0xffffe000
 #define AT91SAM9263_BASE_SDRAMC0 0xffffe200
 #define AT91SAM9263_BASE_SMC0	0xffffe400
@@ -95,6 +93,7 @@
 #define AT91SAM9263_BASE_PIT	0xfffffd30
 #define AT91SAM9263_BASE_WDT	0xfffffd40
 #define AT91SAM9263_BASE_RTT1	0xfffffd50
+#define AT91SAM9263_BASE_GPBR	0xfffffd60
 
 #define AT91_USART0	AT91SAM9263_BASE_US0
 #define AT91_USART1	AT91SAM9263_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index a824e15..8851a4b 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -84,10 +84,8 @@
 #define AT91SAM9G45_BASE_TC5		0xfffd4080
 
 /*
- * System Peripherals (offset from AT91_BASE_SYS)
+ * System Peripherals
  */
-#define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
-
 #define AT91SAM9G45_BASE_ECC	0xffffe200
 #define AT91SAM9G45_BASE_DDRSDRC1 0xffffe400
 #define AT91SAM9G45_BASE_DDRSDRC0 0xffffe600
@@ -105,6 +103,7 @@
 #define AT91SAM9G45_BASE_RTT	0xfffffd20
 #define AT91SAM9G45_BASE_PIT	0xfffffd30
 #define AT91SAM9G45_BASE_WDT	0xfffffd40
+#define AT91SAM9G45_BASE_GPBR	0xfffffd60
 #define AT91SAM9G45_BASE_RTC	0xfffffdb0
 
 #define AT91_USART0	AT91SAM9G45_BASE_US0
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index 2d7176a..e0073eb 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -70,7 +70,6 @@
  * System Peripherals (offset from AT91_BASE_SYS)
  */
 #define AT91_SCKCR	(0xfffffd50 - AT91_BASE_SYS)
-#define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 
 #define AT91SAM9RL_BASE_DMA	0xffffe600
 #define AT91SAM9RL_BASE_ECC	0xffffe800
@@ -87,6 +86,7 @@
 #define AT91SAM9RL_BASE_RTT	0xfffffd20
 #define AT91SAM9RL_BASE_PIT	0xfffffd30
 #define AT91SAM9RL_BASE_WDT	0xfffffd40
+#define AT91SAM9RL_BASE_GPBR	0xfffffd60
 #define AT91SAM9RL_BASE_RTC	0xfffffe00
 
 #define AT91_USART0	AT91SAM9RL_BASE_US0
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 79ec878..a2c577e 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/pm.h>
+#include <linux/genalloc.h>
 
 #include <asm/mach/map.h>
 
@@ -51,6 +52,34 @@ void __init at91_init_interrupts(unsigned int *priority)
 	at91_gpio_irq_setup();
 }
 
+void __init at91_init_gpbr(unsigned long base, unsigned int length)
+{
+	struct gen_pool *pool;
+	void __iomem *virt;
+
+	pool = gen_pool_create_byname("gpbr", 2, -1);
+
+	if (!pool)
+		goto err_create;
+
+	virt = ioremap(base, length);
+	if (!virt)
+		goto err_ioremap;
+	if (gen_pool_add_virt(pool, (unsigned long)virt, base, length, -1))
+		goto fail_add_virt;
+
+	pr_info("AT91: create GPBR pool of 0x%x at 0x%lx (mapped at 0x%p)\n",
+		length, base, virt);
+	return;
+
+fail_add_virt:
+	iounmap(virt);
+err_ioremap:
+	gen_pool_destroy(pool);
+err_create:
+	pr_err("gpbr: genalloc pool failed to create\n");
+}
+
 static struct map_desc sram_desc[2] __initdata;
 
 void __init at91_init_sram(int bank, unsigned long base, unsigned int length)
diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index ee3c122..7df6cb4 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioctl.h>
 #include <linux/slab.h>
+#include <linux/genalloc.h>
 
 #include <mach/board.h>
 #include <mach/at91_rtt.h>
@@ -57,6 +58,7 @@ struct sam9_rtc {
 	void __iomem		*rtt;
 	struct rtc_device	*rtcdev;
 	u32			imr;
+	void __iomem		*gpbr;
 };
 
 #define rtt_readl(rtc, field) \
@@ -65,9 +67,9 @@ struct sam9_rtc {
 	__raw_writel((val), (rtc)->rtt + AT91_RTT_ ## field)
 
 #define gpbr_readl(rtc) \
-	at91_sys_read(AT91_GPBR + 4 * CONFIG_RTC_DRV_AT91SAM9_GPBR)
+	__raw_readl((rtc)->gpbr)
 #define gpbr_writel(rtc, val) \
-	at91_sys_write(AT91_GPBR + 4 * CONFIG_RTC_DRV_AT91SAM9_GPBR, (val))
+	__raw_writel((val), (rtc)->gpbr)
 
 /*
  * Read current time and date in RTC
@@ -302,6 +304,13 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 	if (!rtc)
 		return -ENOMEM;
 
+	rtc->gpbr = (void __iomem*)gen_pool_alloc_byname("gpbr", 4);
+	if (!rtc->gpbr) {
+		dev_err(&pdev->dev, "failed to alloc gpbr, aborting.\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
+
 	/* platform setup code should have handled this; sigh */
 	if (!device_can_wakeup(&pdev->dev))
 		device_init_wakeup(&pdev->dev, 1);
@@ -311,7 +320,7 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 	if (!rtc->rtt) {
 		dev_err(&pdev->dev, "failed to map registers, aborting.\n");
 		ret = -ENOMEM;
-		goto fail;
+		goto fail_ioremap;
 	}
 
 	mr = rtt_readl(rtc, MR);
@@ -357,6 +366,8 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 
 fail_register:
 	iounmap(rtc->rtt);
+fail_ioremap:
+	gen_pool_free_byname("gpbr", (unsigned long)rtc->gpbr, 4);
 fail:
 	platform_set_drvdata(pdev, NULL);
 	kfree(rtc);
@@ -378,6 +389,7 @@ static int __exit at91_rtc_remove(struct platform_device *pdev)
 	rtc_device_unregister(rtc->rtcdev);
 
 	iounmap(rtc->rtt);
+	gen_pool_free_byname("gpbr", (unsigned long)rtc->gpbr, 4);
 	platform_set_drvdata(pdev, NULL);
 	kfree(rtc);
 	return 0;
-- 
1.7.7
