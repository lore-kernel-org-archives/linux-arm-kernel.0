From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:12:18 +0530
Subject: [PATCH 17/74] ST SPEAr: Adding USB Host support
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <16ef7fe197c3333deccdc6ff41d34ffeb0a8b71e.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Deepak Sikri <deepak.sikri@st.com>

Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/clock.c                |    4 +-
 arch/arm/mach-spear13xx/include/mach/generic.h |    4 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |    4 +
 arch/arm/mach-spear13xx/spear13xx.c            |  106 +++++++++++
 arch/arm/mach-spear3xx/clock.c                 |    2 +-
 arch/arm/mach-spear3xx/include/mach/generic.h  |    3 +
 arch/arm/mach-spear3xx/spear300_evb.c          |    3 +
 arch/arm/mach-spear3xx/spear310_evb.c          |    3 +
 arch/arm/mach-spear3xx/spear320_evb.c          |    3 +
 arch/arm/mach-spear3xx/spear3xx.c              |   80 ++++++++
 arch/arm/mach-spear6xx/clock.c                 |    4 +-
 arch/arm/mach-spear6xx/include/mach/generic.h  |    4 +
 arch/arm/mach-spear6xx/spear600_evb.c          |    4 +
 arch/arm/mach-spear6xx/spear6xx.c              |  108 +++++++++++
 drivers/usb/Kconfig                            |    2 +
 drivers/usb/host/ehci-hcd.c                    |    5 +
 drivers/usb/host/ehci-spear.c                  |  210 +++++++++++++++++++++
 drivers/usb/host/ohci-hcd.c                    |    5 +
 drivers/usb/host/ohci-spear.c                  |  240 ++++++++++++++++++++++++
 19 files changed, 789 insertions(+), 5 deletions(-)
 create mode 100644 drivers/usb/host/ehci-spear.c
 create mode 100644 drivers/usb/host/ohci-spear.c

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 7f7330c..9d97c69 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -774,8 +774,8 @@ static struct clk_lookup spear_clk_lookups[] = {
 
 	/* clock derived from ahb clk */
 	{.dev_id = "smi",		.clk = &smi_clk},
-	{.dev_id = "uhci0",		.clk = &uhci0_clk},
-	{.dev_id = "uhci1",		.clk = &uhci1_clk},
+	{.con_id = "usbh.0_clk",	.clk = &uhci0_clk},
+	{.con_id = "usbh.1_clk",	.clk = &uhci1_clk},
 	{.dev_id = "usbd",		.clk = &usbd_clk},
 	{.dev_id = "i2c_designware.0",	.clk = &i2c_clk},
 	{.dev_id = "dma0",		.clk = &dma0_clk},
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 0ba99de..7e5d7e1 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -30,7 +30,11 @@
 
 /* Add spear13xx family device structure declarations here */
 extern struct amba_device uart_device;
+extern struct platform_device ehci0_device;
+extern struct platform_device ehci1_device;
 extern struct platform_device i2c_device;
+extern struct platform_device ohci0_device;
+extern struct platform_device ohci1_device;
 extern struct platform_device rtc_device;
 extern struct sys_timer spear13xx_timer;
 
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 4bf908f..0a6d26f 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -22,7 +22,11 @@ static struct amba_device *amba_devs[] __initdata = {
 };
 
 static struct platform_device *plat_devs[] __initdata = {
+	&ehci0_device,
+	&ehci1_device,
 	&i2c_device,
+	&ohci0_device,
+	&ohci1_device,
 	&rtc_device,
 };
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 5abdae8..c8f1aff 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -60,6 +60,112 @@ struct platform_device i2c_device = {
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
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index ae6c244..5eb6ff6 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -495,7 +495,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "gpt1",		.clk = &gpt1_clk},
 	{ .dev_id = "gpt2",		.clk = &gpt2_clk},
 	/* clock derived from pll3 clk */
-	{ .dev_id = "usbh",		.clk = &usbh_clk},
+	{ .con_id = "usbh_clk",		.clk = &usbh_clk},
 	{ .dev_id = "usbd",		.clk = &usbd_clk},
 	{ .dev_id = "clcd",		.clk = &clcd_clk},
 	/* clock derived from ahb clk */
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
index 34d22a5..780d83e 100644
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
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index 0972b8f..3caf91a 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -591,8 +591,8 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "gpt2",		.clk = &gpt2_clk},
 	{ .dev_id = "gpt3",		.clk = &gpt3_clk},
 	/* clock derived from pll3 clk */
-	{ .dev_id = "usbh0",		.clk = &usbh0_clk},
-	{ .dev_id = "usbh1",		.clk = &usbh1_clk},
+	{ .con_id = "usbh.0_clk",	.clk = &usbh0_clk},
+	{ .con_id = "usbh.1_clk",	.clk = &usbh1_clk},
 	{ .dev_id = "usbd",		.clk = &usbd_clk},
 	/* clock derived from ahb clk */
 	{ .con_id = "apb_clk",		.clk = &apb_clk},
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
index 787de46..5a5195b 100644
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
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 4aa00e6..108f69d 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -41,6 +41,7 @@ config USB_ARCH_HAS_OHCI
 	default y if MFD_TC6393XB
 	default y if ARCH_W90X900
 	default y if ARCH_DAVINCI_DA8XX
+	default y if PLAT_SPEAR
 	# PPC:
 	default y if STB03xxx
 	default y if PPC_MPC52xx
@@ -65,6 +66,7 @@ config USB_ARCH_HAS_EHCI
 	default y if ARCH_AT91SAM9G45
 	default y if ARCH_MXC
 	default y if ARCH_OMAP3
+	default y if PLAT_SPEAR
 	default PCI
 
 # ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host interface.
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 34a928d..2101725 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1197,6 +1197,11 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		ehci_atmel_driver
 #endif
 
+#ifdef CONFIG_PLAT_SPEAR
+#include "ehci-spear.c"
+#define PLATFORM_DRIVER		spear_ehci_hcd_driver
+#endif
+
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER) && \
     !defined(PS3_SYSTEM_BUS_DRIVER) && !defined(OF_PLATFORM_DRIVER) && \
     !defined(XILINX_OF_PLATFORM_DRIVER)
diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
new file mode 100644
index 0000000..caac843
--- /dev/null
+++ b/drivers/usb/host/ehci-spear.c
@@ -0,0 +1,210 @@
+/*
+* Driver for EHCI HCD on SPEAR SOC
+*
+* Copyright (C) 2010 ST Micro Electronics,
+* Deepak Sikri <deepak.sikri@st.com>
+*
+* Based on various ehci-*.c drivers
+*
+* This file is subject to the terms and conditions of the GNU General Public
+* License. See the file COPYING in the main directory of this archive for
+* more details.
+*/
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+struct spear_ehci {
+	struct ehci_hcd ehci;
+	struct clk *clk;
+};
+
+#define to_spear_ehci(hcd)	(struct spear_ehci *)hcd_to_ehci(hcd)
+
+static void spear_start_ehci(struct spear_ehci *ehci)
+{
+	clk_enable(ehci->clk);
+}
+
+static void spear_stop_ehci(struct spear_ehci *ehci)
+{
+	clk_disable(ehci->clk);
+}
+
+static int ehci_spear_setup(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	int retval = 0;
+
+	/* registers start at offset 0x0 */
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs + HC_LENGTH(ehci_readl(ehci,
+				&ehci->caps->hc_capbase));
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+	retval = ehci_halt(ehci);
+	if (retval)
+		return retval;
+
+	retval = ehci_init(hcd);
+	if (retval)
+		return retval;
+
+	ehci_reset(ehci);
+	ehci_port_power(ehci, 0);
+
+	return retval;
+}
+
+static const struct hc_driver ehci_spear_hc_driver = {
+	.description		= hcd_name,
+	.product_desc		= "SPEAr EHCI",
+	.hcd_priv_size		= sizeof(struct spear_ehci),
+
+	/* generic hardware linkage */
+	.irq			= ehci_irq,
+	.flags			= HCD_MEMORY | HCD_USB2,
+
+	/* basic lifecycle operations */
+	.reset			= ehci_spear_setup,
+	.start			= ehci_run,
+	.stop			= ehci_stop,
+	.shutdown		= ehci_shutdown,
+
+	/* managing i/o requests and associated device resources */
+	.urb_enqueue		= ehci_urb_enqueue,
+	.urb_dequeue		= ehci_urb_dequeue,
+	.endpoint_disable	= ehci_endpoint_disable,
+
+	/* scheduling support */
+	.get_frame_number	= ehci_get_frame,
+
+	/* root hub support */
+	.hub_status_data	= ehci_hub_status_data,
+	.hub_control		= ehci_hub_control,
+	.bus_suspend		= ehci_bus_suspend,
+	.bus_resume		= ehci_bus_resume,
+	.relinquish_port	= ehci_relinquish_port,
+	.port_handed_over	= ehci_port_handed_over,
+};
+
+static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd ;
+	struct spear_ehci *ehci;
+	struct resource *res;
+	struct clk *usbh_clk;
+	const struct hc_driver *driver = &ehci_spear_hc_driver;
+	int *pdata = pdev->dev.platform_data;
+	int irq, retval;
+	char clk_name[20] = "usbh_clk";
+
+	if (pdata == NULL)
+		return -EFAULT;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		retval = irq;
+		goto fail_irq_get;
+	}
+
+	if (*pdata >= 0)
+		sprintf(clk_name, "usbh.%01d_clk", *pdata);
+
+	usbh_clk = clk_get(NULL, clk_name);
+	if (IS_ERR(usbh_clk)) {
+		dev_err(&pdev->dev, "Error getting interface clock\n");
+		retval = PTR_ERR(usbh_clk);
+		goto fail_get_usbh_clk;
+	}
+
+	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
+	if (!hcd) {
+		retval = -ENOMEM;
+		goto fail_create_hcd;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		retval = -ENODEV;
+		goto fail_request_resource;
+	}
+
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = resource_size(res);
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len,
+				driver->description)) {
+		retval = -EBUSY;
+		goto fail_request_resource;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (hcd->regs == NULL) {
+		dev_dbg(&pdev->dev, "error mapping memory\n");
+		retval = -ENOMEM;
+		goto fail_ioremap;
+	}
+
+	ehci = (struct spear_ehci *)hcd_to_ehci(hcd);
+	ehci->clk = usbh_clk;
+
+	spear_start_ehci(ehci);
+	retval = usb_add_hcd(hcd, irq, IRQF_SHARED | IRQF_DISABLED);
+	if (retval)
+		goto fail_add_hcd;
+
+	return retval;
+
+fail_add_hcd:
+	spear_stop_ehci(ehci);
+	iounmap(hcd->regs);
+fail_ioremap:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+fail_request_resource:
+	usb_put_hcd(hcd);
+fail_create_hcd:
+	clk_put(usbh_clk);
+fail_get_usbh_clk:
+fail_irq_get:
+	dev_err(&pdev->dev, "init fail, %d\n", retval);
+
+	return retval ;
+}
+
+static int spear_ehci_hcd_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct spear_ehci *ehci_p = to_spear_ehci(hcd);
+
+	if (!hcd)
+		return 0;
+	if (in_interrupt())
+		BUG();
+	usb_remove_hcd(hcd);
+
+	if (ehci_p->clk)
+		spear_stop_ehci(ehci_p);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+
+	if (ehci_p->clk)
+		clk_put(ehci_p->clk);
+
+	return 0;
+}
+
+static struct platform_driver spear_ehci_hcd_driver = {
+	.probe		= spear_ehci_hcd_drv_probe,
+	.remove		= spear_ehci_hcd_drv_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver		= {
+		.name = "spear-ehci",
+		.bus = &platform_bus_type
+	}
+};
+
+MODULE_ALIAS("platform:spear-ehci");
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index c3b4ccc..8104fd3 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1075,6 +1075,11 @@ MODULE_LICENSE ("GPL");
 #define OF_PLATFORM_DRIVER	ohci_hcd_ppc_of_driver
 #endif
 
+#ifdef CONFIG_PLAT_SPEAR
+#include "ohci-spear.c"
+#define PLATFORM_DRIVER		spear_ohci_hcd_driver
+#endif
+
 #ifdef CONFIG_PPC_PS3
 #include "ohci-ps3.c"
 #define PS3_SYSTEM_BUS_DRIVER	ps3_ohci_driver
diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
new file mode 100644
index 0000000..4fd4bea
--- /dev/null
+++ b/drivers/usb/host/ohci-spear.c
@@ -0,0 +1,240 @@
+/*
+* OHCI HCD (Host Controller Driver) for USB.
+*
+* Copyright (C) 2010 ST Microelectronics.
+* Deepak Sikri<deepak.sikri@st.com>
+*
+* Based on various ohci-*.c drivers
+*
+* This file is licensed under the terms of the GNU General Public
+* License version 2. This program is licensed "as is" without any
+* warranty of any kind, whether express or implied.
+*/
+
+#include <linux/signal.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+struct spear_ohci {
+	struct ohci_hcd ohci;
+	struct clk *clk;
+};
+
+#define to_spear_ohci(hcd)	(struct spear_ohci *)hcd_to_ohci(hcd)
+
+static void spear_start_ohci(struct spear_ohci *ohci)
+{
+	clk_enable(ohci->clk);
+}
+
+static void spear_stop_ohci(struct spear_ohci *ohci)
+{
+	clk_disable(ohci->clk);
+}
+
+static int __devinit ohci_spear_start(struct usb_hcd *hcd)
+{
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	int ret;
+
+	ret = ohci_init(ohci);
+	if (ret < 0)
+		return ret;
+	ohci->regs = hcd->regs;
+
+	ret = ohci_run(ohci);
+	if (ret < 0) {
+		dev_err(hcd->self.controller, "can't start\n");
+		ohci_stop(hcd);
+		return ret;
+	}
+
+	create_debug_files(ohci);
+
+#ifdef DEBUG
+	ohci_dump(ohci, 1);
+#endif
+	return 0;
+}
+
+static const struct hc_driver ohci_spear_hc_driver = {
+	.description		= hcd_name,
+	.product_desc		= "SPEAr OHCI",
+	.hcd_priv_size		= sizeof(struct spear_ohci),
+
+	/* generic hardware linkage */
+	.irq			= ohci_irq,
+	.flags			= HCD_USB11 | HCD_MEMORY,
+
+	/* basic lifecycle operations */
+	.start			= ohci_spear_start,
+	.stop			= ohci_stop,
+	.shutdown		= ohci_shutdown,
+#ifdef	CONFIG_PM
+	.bus_suspend		= ohci_bus_suspend,
+	.bus_resume		= ohci_bus_resume,
+#endif
+
+	/* managing i/o requests and associated device resources */
+	.urb_enqueue		= ohci_urb_enqueue,
+	.urb_dequeue		= ohci_urb_dequeue,
+	.endpoint_disable	= ohci_endpoint_disable,
+
+	/* scheduling support */
+	.get_frame_number	= ohci_get_frame,
+
+	/* root hub support */
+	.hub_status_data	= ohci_hub_status_data,
+	.hub_control		= ohci_hub_control,
+
+	.start_port_reset	= ohci_start_port_reset,
+};
+
+static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
+{
+	const struct hc_driver *driver = &ohci_spear_hc_driver;
+	struct usb_hcd *hcd = NULL;
+	struct clk *usbh_clk;
+	struct spear_ohci *ohci_p;
+	struct resource *res;
+	int retval, irq;
+	int *pdata = pdev->dev.platform_data;
+	char clk_name[20] = "usbh_clk";
+
+	if (pdata == NULL)
+		return -EFAULT;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		retval = irq;
+		goto fail_irq_get;
+	}
+
+	if (*pdata >= 0)
+		sprintf(clk_name, "usbh.%01d_clk", *pdata);
+
+	usbh_clk = clk_get(NULL, clk_name);
+	if (IS_ERR(usbh_clk)) {
+		dev_err(&pdev->dev, "Error getting interface clock\n");
+		retval = PTR_ERR(usbh_clk);
+		goto fail_get_usbh_clk;
+	}
+
+	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
+	if (!hcd) {
+		retval = -ENOMEM;
+		goto fail_create_hcd;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		retval = -ENODEV;
+		goto fail_request_resource;
+	}
+
+	hcd->rsrc_start = pdev->resource[0].start;
+	hcd->rsrc_len = resource_size(res);
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		dev_dbg(&pdev->dev, "request_mem_region failed\n");
+		retval = -EBUSY;
+		goto fail_request_resource;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		dev_dbg(&pdev->dev, "ioremap failed\n");
+		retval = -ENOMEM;
+		goto fail_ioremap;
+	}
+
+	ohci_p = (struct spear_ohci *)hcd_to_ohci(hcd);
+	ohci_p->clk = usbh_clk;
+	spear_start_ohci(ohci_p);
+	ohci_hcd_init(hcd_to_ohci(hcd));
+
+	retval = usb_add_hcd(hcd, platform_get_irq(pdev, 0), IRQF_DISABLED);
+	if (retval == 0)
+		return retval;
+
+	spear_stop_ohci(ohci_p);
+	iounmap(hcd->regs);
+fail_ioremap:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+fail_request_resource:
+	usb_put_hcd(hcd);
+fail_create_hcd:
+	clk_put(usbh_clk);
+fail_get_usbh_clk:
+fail_irq_get:
+	dev_err(&pdev->dev, "init fail, %d\n", retval);
+
+	return retval;
+}
+
+static int spear_ohci_hcd_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct spear_ohci *ohci_p = to_spear_ohci(hcd);
+
+	usb_remove_hcd(hcd);
+	if (ohci_p->clk)
+		spear_stop_ohci(ohci_p);
+
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+
+	if (ohci_p->clk)
+		clk_put(ohci_p->clk);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+#if defined(CONFIG_PM)
+static int spear_ohci_hcd_drv_suspend(struct platform_device *dev,
+		pm_message_t message)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	struct spear_ohci *ohci_p = to_spear_ohci(hcd);
+
+	if (time_before(jiffies, ohci->next_statechange))
+		msleep(5);
+	ohci->next_statechange = jiffies;
+
+	spear_stop_ohci(ohci_p);
+	ohci_to_hcd(ohci)->state = HC_STATE_SUSPENDED;
+	return 0;
+}
+
+static int spear_ohci_hcd_drv_resume(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	struct spear_ohci *ohci_p = to_spear_ohci(hcd);
+
+	if (time_before(jiffies, ohci->next_statechange))
+		msleep(5);
+	ohci->next_statechange = jiffies;
+
+	spear_start_ohci(ohci_p);
+	ohci_finish_controller_resume(hcd);
+	return 0;
+}
+#endif
+
+/* Driver definition to register with the platform bus */
+static struct platform_driver spear_ohci_hcd_driver = {
+	.probe =	spear_ohci_hcd_drv_probe,
+	.remove =	spear_ohci_hcd_drv_remove,
+#ifdef CONFIG_PM
+	.suspend =	spear_ohci_hcd_drv_suspend,
+	.resume =	spear_ohci_hcd_drv_resume,
+#endif
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "spear-ohci",
+	},
+};
+
+MODULE_ALIAS("platform:spear-ohci");
-- 
1.7.2.2
