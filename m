From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:40 +0530
Subject: [PATCH V2 20/69] ST SPEAr: Adding machine support for USB host
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <c706faccdaddc69e14d4cc9dcc95db6cd500b8bf.1285933331.git.viresh.kumar@st.com>
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
index b0e25be..a75ed3a 100644
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
index 4c72b7a..9f53361 100644
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
index 8acf9df..c201e31 100644
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
index 162f33b..3eb2737 100644
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
index 083f65c..3b3c6ce 100644
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
index 208a68ce1..d523040 100644
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
index 90d685e..f90a9b8 100644
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
index 22d172b..588004f 100644
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
index 44a2f99..3b15289 100644
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
index 6b0cf23..b4dfd25 100644
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
index 646098f..94bbcdf 100644
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
1.7.2.2
