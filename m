From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 20 Jan 2011 12:55:58 +0530
Subject: [PATCH V5 20/63] ST SPEAr: Adding machine support for USB host
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <75b8eec2cfdc8c6c8a94d58a8fc2634bc101b831.1295499394.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Deepak Sikri <deepak.sikri@st.com>

Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    4 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |    4 +
 arch/arm/mach-spear13xx/spear13xx.c            |  106 +++++++++++++++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    3 +
 arch/arm/mach-spear3xx/spear300_evb.c          |    3 +
 arch/arm/mach-spear3xx/spear310_evb.c          |    3 +
 arch/arm/mach-spear3xx/spear320_evb.c          |    3 +
 arch/arm/mach-spear3xx/spear3xx.c              |   80 +++++++++++++++++
 arch/arm/mach-spear6xx/include/mach/generic.h  |    4 +
 arch/arm/mach-spear6xx/spear600_evb.c          |    4 +
 arch/arm/mach-spear6xx/spear6xx.c              |  108 ++++++++++++++++++++++++
 11 files changed, 322 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index c8db271..6473316 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -30,7 +30,11 @@
 
 /* Add spear13xx family device structure declarations here */
 extern struct amba_device spear13xx_uart_device;
+extern struct platform_device spear13xx_ehci0_device;
+extern struct platform_device spear13xx_ehci1_device;
 extern struct platform_device spear13xx_i2c_device;
+extern struct platform_device spear13xx_ohci0_device;
+extern struct platform_device spear13xx_ohci1_device;
 extern struct platform_device spear13xx_rtc_device;
 extern struct sys_timer spear13xx_timer;
 
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 8df2a6c..1518044 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -22,7 +22,11 @@ static struct amba_device *amba_devs[] __initdata = {
 };
 
 static struct platform_device *plat_devs[] __initdata = {
+	&spear13xx_ehci0_device,
+	&spear13xx_ehci1_device,
 	&spear13xx_i2c_device,
+	&spear13xx_ohci0_device,
+	&spear13xx_ohci1_device,
 	&spear13xx_rtc_device,
 };
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 4b04a20..2ebe8db 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -60,6 +60,112 @@ struct platform_device spear13xx_i2c_device = {
 	.resource = i2c_resources,
 };
 
+/* usb host device registeration */
+static struct resource ehci0_resources[] = {
+	[0] = {
+		.start = SPEAR13XX_UHC0_EHCI_BASE,
+		.end = SPEAR13XX_UHC0_EHCI_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_USBH_EHCI0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct resource ehci1_resources[] = {
+	[0] = {
+		.start = SPEAR13XX_UHC1_EHCI_BASE,
+		.end = SPEAR13XX_UHC1_EHCI_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_USBH_EHCI1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct resource ohci0_resources[] = {
+	[0] = {
+		.start = SPEAR13XX_UHC0_OHCI_BASE,
+		.end = SPEAR13XX_UHC0_OHCI_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_USBH_OHCI0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+static struct resource ohci1_resources[] = {
+	[0] = {
+		.start = SPEAR13XX_UHC1_OHCI_BASE,
+		.end = SPEAR13XX_UHC1_OHCI_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_USBH_OHCI1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+/* usbh0_id defaults to 0, being static variable */
+static int usbh0_id;
+static int usbh1_id = 1;
+static u64 ehci0_dmamask = ~0;
+
+struct platform_device spear13xx_ehci0_device = {
+	.name = "spear-ehci",
+	.id = 0,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &ehci0_dmamask,
+		.platform_data = &usbh0_id,
+	},
+	.num_resources = ARRAY_SIZE(ehci0_resources),
+	.resource = ehci0_resources,
+};
+
+static u64 ehci1_dmamask = ~0;
+
+struct platform_device spear13xx_ehci1_device = {
+	.name = "spear-ehci",
+	.id = 1,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &ehci1_dmamask,
+		.platform_data = &usbh1_id,
+	},
+	.num_resources = ARRAY_SIZE(ehci1_resources),
+	.resource = ehci1_resources,
+};
+
+static u64 ohci0_dmamask = ~0;
+
+struct platform_device spear13xx_ohci0_device = {
+	.name = "spear-ohci",
+	.id = 0,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &ohci0_dmamask,
+		.platform_data = &usbh0_id,
+	},
+	.num_resources = ARRAY_SIZE(ohci0_resources),
+	.resource = ohci0_resources,
+};
+
+static u64 ohci1_dmamask = ~0;
+struct platform_device spear13xx_ohci1_device = {
+	.name = "spear-ohci",
+	.id = 1,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &ohci1_dmamask,
+		.platform_data = &usbh1_id,
+	},
+	.num_resources = ARRAY_SIZE(ohci1_resources),
+	.resource = ohci1_resources,
+};
+
 /* rtc device registration */
 static struct resource rtc_resources[] = {
 	{
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 2933b39..b65a884 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -33,7 +33,10 @@
 /* Add spear3xx family device structure declarations here */
 extern struct amba_device gpio_device;
 extern struct amba_device uart_device;
+extern struct platform_device ehci_device;
 extern struct platform_device i2c_device;
+extern struct platform_device ohci0_device;
+extern struct platform_device ohci1_device;
 extern struct platform_device rtc_device;
 extern struct sys_timer spear3xx_timer;
 
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 7c079ae..caa7000 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -44,7 +44,10 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&ehci_device,
 	&i2c_device,
+	&ohci0_device,
+	&ohci1_device,
 	&rtc_device,
 
 	/* spear300 specific devices */
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index cbe6f42..7b7a236 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -50,7 +50,10 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&ehci_device,
 	&i2c_device,
+	&ohci0_device,
+	&ohci1_device,
 	&rtc_device,
 
 	/* spear310 specific devices */
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 2c8d32c..7bfe609 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -48,7 +48,10 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&ehci_device,
 	&i2c_device,
+	&ohci0_device,
+	&ohci1_device,
 	&rtc_device,
 
 	/* spear320 specific devices */
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 168b9fb..6a096f4 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -76,6 +76,86 @@ struct platform_device i2c_device = {
 	.resource = i2c_resources,
 };
 
+/* usb host device registeration */
+static struct resource ehci_resources[] = {
+	[0] = {
+		.start = SPEAR3XX_ICM4_USB_EHCI0_1_BASE,
+		.end = SPEAR3XX_ICM4_USB_EHCI0_1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_USB_H_EHCI_0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct resource ohci0_resources[] = {
+	[0] = {
+		.start = SPEAR3XX_ICM4_USB_OHCI0_BASE,
+		.end = SPEAR3XX_ICM4_USB_OHCI0_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_USB_H_OHCI_0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct resource ohci1_resources[] = {
+	[0] = {
+		.start = SPEAR3XX_ICM4_USB_OHCI1_BASE,
+		.end = SPEAR3XX_ICM4_USB_OHCI1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_USB_H_OHCI_1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static u64 ehci_dmamask = ~0;
+static int usbh_id = -1;
+
+struct platform_device ehci_device = {
+	.name = "spear-ehci",
+	.id = -1,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &ehci_dmamask,
+		.platform_data = &usbh_id,
+	},
+	.num_resources = ARRAY_SIZE(ehci_resources),
+	.resource = ehci_resources,
+};
+
+static u64 ohci0_dmamask = ~0;
+
+struct platform_device ohci0_device = {
+	.name = "spear-ohci",
+	.id = 0,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &ohci0_dmamask,
+		.platform_data = &usbh_id,
+	},
+	.num_resources = ARRAY_SIZE(ohci0_resources),
+	.resource = ohci0_resources,
+};
+
+static u64 ohci1_dmamask = ~0;
+
+struct platform_device ohci1_device = {
+	.name = "spear-ohci",
+	.id = 1,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &ohci1_dmamask,
+		.platform_data = &usbh_id,
+	},
+	.num_resources = ARRAY_SIZE(ohci1_resources),
+	.resource = ohci1_resources,
+};
+
 /* rtc device registration */
 static struct resource rtc_resources[] = {
 	{
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 3c04487..ed1dbfc 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -32,7 +32,11 @@
 extern struct amba_device clcd_device;
 extern struct amba_device gpio_device[];
 extern struct amba_device uart_device[];
+extern struct platform_device ehci0_device;
+extern struct platform_device ehci1_device;
 extern struct platform_device i2c_device;
+extern struct platform_device ohci0_device;
+extern struct platform_device ohci1_device;
 extern struct platform_device rtc_device;
 extern struct sys_timer spear6xx_timer;
 
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index 59abb31..4297c3a 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -26,7 +26,11 @@ static struct amba_device *amba_devs[] __initdata = {
 };
 
 static struct platform_device *plat_devs[] __initdata = {
+	&ehci0_device,
+	&ehci1_device,
 	&i2c_device,
+	&ohci0_device,
+	&ohci1_device,
 	&rtc_device,
 };
 
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index a421ae3..ec42549 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -143,6 +143,114 @@ struct platform_device i2c_device = {
 	.resource = i2c_resources,
 };
 
+/* usb host device registeration */
+static struct resource ehci0_resources[] = {
+	[0] = {
+		.start = SPEAR6XX_ICM4_USB_EHCI0_BASE,
+		.end = SPEAR6XX_ICM4_USB_EHCI0_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_USB_H_EHCI_0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct resource ehci1_resources[] = {
+	[0] = {
+		.start = SPEAR6XX_ICM4_USB_EHCI1_BASE,
+		.end = SPEAR6XX_ICM4_USB_EHCI1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_USB_H_EHCI_1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct resource ohci0_resources[] = {
+	[0] = {
+		.start = SPEAR6XX_ICM4_USB_OHCI0_BASE,
+		.end = SPEAR6XX_ICM4_USB_OHCI0_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_USB_H_OHCI_0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct resource ohci1_resources[] = {
+	[0] = {
+		.start = SPEAR6XX_ICM4_USB_OHCI1_BASE,
+		.end = SPEAR6XX_ICM4_USB_OHCI1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_USB_H_OHCI_1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+/* usbh0_id defaults to 0, being static variable */
+static int usbh0_id;
+static int usbh1_id = 1;
+static u64 ehci0_dmamask = ~0;
+
+struct platform_device ehci0_device = {
+	.name = "spear-ehci",
+	.id = 0,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &ehci0_dmamask,
+		.platform_data = &usbh0_id,
+	},
+	.num_resources = ARRAY_SIZE(ehci0_resources),
+	.resource = ehci0_resources,
+};
+
+static u64 ehci1_dmamask = ~0;
+
+struct platform_device ehci1_device = {
+	.name = "spear-ehci",
+	.id = 1,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &ehci1_dmamask,
+		.platform_data = &usbh1_id,
+	},
+	.num_resources = ARRAY_SIZE(ehci1_resources),
+	.resource = ehci1_resources,
+};
+
+static u64 ohci0_dmamask = ~0;
+
+struct platform_device ohci0_device = {
+	.name = "spear-ohci",
+	.id = 0,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &ohci0_dmamask,
+		.platform_data = &usbh0_id,
+	},
+	.num_resources = ARRAY_SIZE(ohci0_resources),
+	.resource = ohci0_resources,
+};
+
+static u64 ohci1_dmamask = ~0;
+
+struct platform_device ohci1_device = {
+	.name = "spear-ohci",
+	.id = 1,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &ohci1_dmamask,
+		.platform_data = &usbh1_id,
+	},
+	.num_resources = ARRAY_SIZE(ohci1_resources),
+	.resource = ohci1_resources,
+};
+
 /* rtc device registration */
 static struct resource rtc_resources[] = {
 	{
-- 
1.7.3.4
