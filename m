From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:12 +0200
Subject: [PATCH 16/61] ARM: imx: get rid of mxc_gpio_init
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-17-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is defined once for each imx family and so is in the way
when compiling a kernel for more than one SoC.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices.c      |   22 ++++++++--------------
 arch/arm/mach-imx/mm-imx21.c     |    3 +++
 arch/arm/mach-imx/mm-imx27.c     |    3 +++
 arch/arm/mach-mx1/devices.c      |    2 +-
 arch/arm/mach-mx1/generic.c      |    3 +++
 arch/arm/mach-mx25/devices.c     |    2 +-
 arch/arm/mach-mx25/mm.c          |    3 +++
 arch/arm/mach-mx3/devices.c      |    2 +-
 arch/arm/mach-mx3/mm.c           |    3 +++
 arch/arm/mach-mx5/devices.c      |    2 +-
 arch/arm/mach-mx5/mm.c           |    3 +++
 arch/arm/mach-mxc91231/devices.c |    2 +-
 arch/arm/mach-mxc91231/mm.c      |    3 +++
 arch/arm/plat-mxc/irq.c          |    3 ---
 arch/arm/plat-mxc/tzic.c         |    2 --
 15 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index a0aeb8a..e708bfd 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -454,26 +454,21 @@ DEFINE_IMX_SSI_DEVICE(1, 2, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 
 #ifdef CONFIG_MACH_MX21
 DEFINE_MXC_GPIO_PORTS(MX21, imx21);
+
+int __init imx21_register_gpios(void)
+{
+	return mxc_gpio_init(imx21_gpio_ports, ARRAY_SIZE(imx21_gpio_ports));
+}
 #endif
 
 #ifdef CONFIG_MACH_MX27
 DEFINE_MXC_GPIO_PORTS(MX27, imx27);
-#endif
 
-int __init mxc_register_gpios(void)
+int __init imx27_register_gpios(void)
 {
-#ifdef CONFIG_MACH_MX21
-	if (cpu_is_mx21())
-		return mxc_gpio_init(imx21_gpio_ports, ARRAY_SIZE(imx21_gpio_ports));
-	else
-#endif
-#ifdef CONFIG_MACH_MX27
-	if (cpu_is_mx27())
-		return mxc_gpio_init(imx27_gpio_ports, ARRAY_SIZE(imx27_gpio_ports));
-	else
-#endif
-		return 0;
+	return mxc_gpio_init(imx27_gpio_ports, ARRAY_SIZE(imx27_gpio_ports));
 }
+#endif
 
 #ifdef CONFIG_MACH_MX21
 static struct resource mx21_usbhc_resources[] = {
@@ -500,4 +495,3 @@ struct platform_device mx21_usbhc_device = {
 	.resource	= mx21_usbhc_resources,
 };
 #endif
-
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index 115c212..68aa5d2 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -77,7 +77,10 @@ void __init mx21_map_io(void)
 	iotable_init(imx21_io_desc, ARRAY_SIZE(imx21_io_desc));
 }
 
+int imx21_register_gpios(void);
+
 void __init mx21_init_irq(void)
 {
+	imx21_register_gpios();
 	mxc_init_irq(MX21_IO_ADDRESS(MX21_AVIC_BASE_ADDR));
 }
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 89b4174..bcedce9 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -77,7 +77,10 @@ void __init mx27_map_io(void)
 	iotable_init(imx27_io_desc, ARRAY_SIZE(imx27_io_desc));
 }
 
+int imx27_register_gpios(void);
+
 void __init mx27_init_irq(void)
 {
+	imx27_register_gpios();
 	mxc_init_irq(MX27_IO_ADDRESS(MX27_AVIC_BASE_ADDR));
 }
diff --git a/arch/arm/mach-mx1/devices.c b/arch/arm/mach-mx1/devices.c
index 8064f2c..860cbb7 100644
--- a/arch/arm/mach-mx1/devices.c
+++ b/arch/arm/mach-mx1/devices.c
@@ -237,7 +237,7 @@ static struct mxc_gpio_port imx_gpio_ports[] = {
 	}
 };
 
-int __init mxc_register_gpios(void)
+int __init imx1_register_gpios(void)
 {
 	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
 }
diff --git a/arch/arm/mach-mx1/generic.c b/arch/arm/mach-mx1/generic.c
index 5a745d9..a9be5f1 100644
--- a/arch/arm/mach-mx1/generic.c
+++ b/arch/arm/mach-mx1/generic.c
@@ -46,7 +46,10 @@ void __init mx1_map_io(void)
 	iotable_init(imx_io_desc, ARRAY_SIZE(imx_io_desc));
 }
 
+int imx1_register_gpios(void);
+
 void __init mx1_init_irq(void)
 {
+	imx1_register_gpios();
 	mxc_init_irq(MX1_IO_ADDRESS(MX1_AVIC_BASE_ADDR));
 }
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 3a405fa..80f3131 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -414,7 +414,7 @@ static struct mxc_gpio_port imx_gpio_ports[] = {
 	}
 };
 
-int __init mxc_register_gpios(void)
+int __init imx25_register_gpios(void)
 {
 	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
 }
diff --git a/arch/arm/mach-mx25/mm.c b/arch/arm/mach-mx25/mm.c
index a7e587f..cf4d76e 100644
--- a/arch/arm/mach-mx25/mm.c
+++ b/arch/arm/mach-mx25/mm.c
@@ -69,8 +69,11 @@ void __init mx25_map_io(void)
 	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
 }
 
+int imx25_register_gpios(void);
+
 void __init mx25_init_irq(void)
 {
+	imx25_register_gpios();
 	mxc_init_irq((void __iomem *)MX25_AVIC_BASE_ADDR_VIRT);
 }
 
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index db7acd6..f6da0ff 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -147,7 +147,7 @@ static struct mxc_gpio_port imx_gpio_ports[] = {
 	}
 };
 
-int __init mxc_register_gpios(void)
+int __init imx3x_register_gpios(void)
 {
 	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
 }
diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
index 6858a4f..595cf09 100644
--- a/arch/arm/mach-mx3/mm.c
+++ b/arch/arm/mach-mx3/mm.c
@@ -97,8 +97,11 @@ void __init mx35_map_io(void)
 }
 #endif
 
+int imx3x_register_gpios(void);
+
 void __init mx31_init_irq(void)
 {
+	imx3x_register_gpios();
 	mxc_init_irq(IO_ADDRESS(AVIC_BASE_ADDR));
 }
 
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 7130449..f40778f 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -195,7 +195,7 @@ static struct mxc_gpio_port mxc_gpio_ports[] = {
 	},
 };
 
-int __init mxc_register_gpios(void)
+int __init imx51_register_gpios(void)
 {
 	return mxc_gpio_init(mxc_gpio_ports, ARRAY_SIZE(mxc_gpio_ports));
 }
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index b7677ef..2f79722 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -65,6 +65,8 @@ void __init mx51_map_io(void)
 	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
 }
 
+int imx51_register_gpios(void);
+
 void __init mx51_init_irq(void)
 {
 	unsigned long tzic_addr;
@@ -79,5 +81,6 @@ void __init mx51_init_irq(void)
 	if (!tzic_virt)
 		panic("unable to map TZIC interrupt controller\n");
 
+	imx51_register_gpios();
 	tzic_init_irq(tzic_virt);
 }
diff --git a/arch/arm/mach-mxc91231/devices.c b/arch/arm/mach-mxc91231/devices.c
index 353bd97..027af4f 100644
--- a/arch/arm/mach-mxc91231/devices.c
+++ b/arch/arm/mach-mxc91231/devices.c
@@ -135,7 +135,7 @@ static struct mxc_gpio_port mxc_gpio_ports[] = {
 	},
 };
 
-int __init mxc_register_gpios(void)
+int __init mxc91231_register_gpios(void)
 {
 	return mxc_gpio_init(mxc_gpio_ports, ARRAY_SIZE(mxc_gpio_ports));
 }
diff --git a/arch/arm/mach-mxc91231/mm.c b/arch/arm/mach-mxc91231/mm.c
index 6becda3..1f23c74 100644
--- a/arch/arm/mach-mxc91231/mm.c
+++ b/arch/arm/mach-mxc91231/mm.c
@@ -88,7 +88,10 @@ void __init mxc91231_map_io(void)
 	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
 }
 
+int mxc91231_register_gpios(void);
+
 void __init mxc91231_init_irq(void)
 {
+	mxc91231_register_gpios();
 	mxc_init_irq(MXC91231_IO_ADDRESS(MXC91231_AVIC_BASE_ADDR));
 }
diff --git a/arch/arm/plat-mxc/irq.c b/arch/arm/plat-mxc/irq.c
index 778ddfe..7331f2a 100644
--- a/arch/arm/plat-mxc/irq.c
+++ b/arch/arm/plat-mxc/irq.c
@@ -142,9 +142,6 @@ void __init mxc_init_irq(void __iomem *irqbase)
 	for (i = 0; i < 8; i++)
 		__raw_writel(0, avic_base + AVIC_NIPRIORITY(i));
 
-	/* init architectures chained interrupt handler */
-	mxc_register_gpios();
-
 #ifdef CONFIG_FIQ
 	/* Initialize FIQ */
 	init_FIQ();
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index 9b86d2a..b3da9aa 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -145,8 +145,6 @@ void __init tzic_init_irq(void __iomem *irqbase)
 		set_irq_handler(i, handle_level_irq);
 		set_irq_flags(i, IRQF_VALID);
 	}
-	mxc_register_gpios();
-
 	pr_info("TrustZone Interrupt Controller (TZIC) initialized\n");
 }
 
-- 
1.7.1
