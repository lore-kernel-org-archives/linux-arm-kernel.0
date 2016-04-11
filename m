From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 11 Apr 2016 14:25:15 +0530
Subject: [PATCH v3 03/16] ARM: davinici: da8xx: move usb code to new file
In-Reply-To: <1458863503-31121-4-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-4-git-send-email-david@lechnology.com>
Message-ID: <570B6673.80108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 March 2016 05:21 AM, David Lechner wrote:
> We will be adding more da8xx-specific code for phy and clocks, so it will
> be better to have this in a separate file. This way we don't have a bunch
> of #ifdefs for all of the da8xx stuff.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied this patch with a couple of local changes.

1) The subject line has a typo: s/davinici/davinci
2) There are checkpatch warnings in new code that are coming from old 
code. Even though this is just code movement, I prefer new code is free 
of checkpatch warnings.

Here is the updated patch.

Thanks,
Sekhar

---8<---
From: David Lechner <david@lechnology.com>
Date: Thu, 24 Mar 2016 18:51:28 -0500
Subject: [PATCH] ARM: davinci: da8xx: move usb code to new file

We will be adding more da8xx-specific code for phy and clocks, so it will
be better to have this in a separate file. This way we don't have a bunch
of #ifdefs for all of the da8xx stuff.

While at it, fix some checkpatch warnings coming from existing code.

Signed-off-by: David Lechner <david@lechnology.com>
[nsekhar at ti.com: typo and checkpatch fixes]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/Makefile    |   4 +-
 arch/arm/mach-davinci/usb-da8xx.c | 124 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/usb.c       |  74 +----------------------
 3 files changed, 127 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm/mach-davinci/usb-da8xx.c

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 2e3464b8bab4..da4c336b4637 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -14,8 +14,8 @@ obj-$(CONFIG_ARCH_DAVINCI_DM644x)       += dm644x.o devices.o
 obj-$(CONFIG_ARCH_DAVINCI_DM355)        += dm355.o devices.o
 obj-$(CONFIG_ARCH_DAVINCI_DM646x)       += dm646x.o devices.o
 obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= dm365.o devices.o
-obj-$(CONFIG_ARCH_DAVINCI_DA830)        += da830.o devices-da8xx.o
-obj-$(CONFIG_ARCH_DAVINCI_DA850)        += da850.o devices-da8xx.o
+obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= da830.o devices-da8xx.o usb-da8xx.o
+obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= da850.o devices-da8xx.o usb-da8xx.o
 
 obj-$(CONFIG_AINTC)			+= irq.o
 obj-$(CONFIG_CP_INTC)			+= cp_intc.o
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
new file mode 100644
index 000000000000..0cab01f79825
--- /dev/null
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -0,0 +1,124 @@
+/*
+ * DA8xx USB
+ */
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/usb/musb.h>
+
+#include <mach/common.h>
+#include <mach/irqs.h>
+#include <mach/cputype.h>
+#include <mach/da8xx.h>
+#include <linux/platform_data/usb-davinci.h>
+
+#define DA8XX_USB0_BASE		0x01e00000
+#define DA8XX_USB1_BASE		0x01e25000
+
+#if IS_ENABLED(CONFIG_USB_MUSB_HDRC)
+
+static struct musb_hdrc_eps_bits musb_eps[] = {
+	{ "ep1_tx", 8, },
+	{ "ep1_rx", 8, },
+	{ "ep2_tx", 8, },
+	{ "ep2_rx", 8, },
+	{ "ep3_tx", 5, },
+	{ "ep3_rx", 5, },
+	{ "ep4_tx", 5, },
+	{ "ep4_rx", 5, },
+};
+
+static struct musb_hdrc_config musb_config = {
+	.multipoint	= true,
+	.dyn_fifo	= true,
+	.soft_con	= true,
+	.dma		= true,
+
+	.num_eps	= 5,
+	.dma_channels	= 8,
+	.ram_bits	= 10,
+	.eps_bits	= musb_eps,
+};
+
+static struct musb_hdrc_platform_data usb_data = {
+	/* OTG requires a Mini-AB connector */
+	.mode           = MUSB_OTG,
+	.clock		= "usb20",
+	.config		= &musb_config,
+};
+
+static struct resource da8xx_usb20_resources[] = {
+	{
+		.start		= DA8XX_USB0_BASE,
+		.end		= DA8XX_USB0_BASE + SZ_64K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= IRQ_DA8XX_USB_INT,
+		.flags		= IORESOURCE_IRQ,
+		.name		= "mc",
+	},
+};
+
+static u64 usb_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device usb_dev = {
+	.name		= "musb-da8xx",
+	.id             = -1,
+	.dev = {
+		.platform_data		= &usb_data,
+		.dma_mask		= &usb_dmamask,
+		.coherent_dma_mask      = DMA_BIT_MASK(32),
+	},
+	.resource	= da8xx_usb20_resources,
+	.num_resources	= ARRAY_SIZE(da8xx_usb20_resources),
+};
+
+int __init da8xx_register_usb20(unsigned int mA, unsigned int potpgt)
+{
+	usb_data.power	= mA > 510 ? 255 : mA / 2;
+	usb_data.potpgt = (potpgt + 1) / 2;
+
+	return platform_device_register(&usb_dev);
+}
+
+#else
+
+int __init da8xx_register_usb20(unsigned int mA, unsigned int potpgt)
+{
+	return 0;
+}
+
+#endif  /* CONFIG_USB_MUSB_HDRC */
+
+static struct resource da8xx_usb11_resources[] = {
+	[0] = {
+		.start	= DA8XX_USB1_BASE,
+		.end	= DA8XX_USB1_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_DA8XX_IRQN,
+		.end	= IRQ_DA8XX_IRQN,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 da8xx_usb11_dma_mask = DMA_BIT_MASK(32);
+
+static struct platform_device da8xx_usb11_device = {
+	.name		= "ohci",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &da8xx_usb11_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(da8xx_usb11_resources),
+	.resource	= da8xx_usb11_resources,
+};
+
+int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
+{
+	da8xx_usb11_device.dev.platform_data = pdata;
+	return platform_device_register(&da8xx_usb11_device);
+}
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index b0a6b522575f..9980ddb7ae83 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -10,15 +10,12 @@
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/cputype.h>
-#include <mach/da8xx.h>
 #include <linux/platform_data/usb-davinci.h>
 
 #define DAVINCI_USB_OTG_BASE	0x01c64000
 
-#define DA8XX_USB0_BASE 	0x01e00000
-#define DA8XX_USB1_BASE 	0x01e25000
-
 #if IS_ENABLED(CONFIG_USB_MUSB_HDRC)
+
 static struct musb_hdrc_eps_bits musb_eps[] = {
 	{ "ep1_tx", 8, },
 	{ "ep1_rx", 8, },
@@ -97,79 +94,10 @@ void __init davinci_setup_usb(unsigned mA, unsigned potpgt_ms)
 	platform_device_register(&usb_dev);
 }
 
-#ifdef CONFIG_ARCH_DAVINCI_DA8XX
-static struct resource da8xx_usb20_resources[] = {
-	{
-		.start		= DA8XX_USB0_BASE,
-		.end		= DA8XX_USB0_BASE + SZ_64K - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= IRQ_DA8XX_USB_INT,
-		.flags		= IORESOURCE_IRQ,
-		.name		= "mc",
-	},
-};
-
-int __init da8xx_register_usb20(unsigned mA, unsigned potpgt)
-{
-	usb_data.clock  = "usb20";
-	usb_data.power	= mA > 510 ? 255 : mA / 2;
-	usb_data.potpgt = (potpgt + 1) / 2;
-
-	usb_dev.resource = da8xx_usb20_resources;
-	usb_dev.num_resources = ARRAY_SIZE(da8xx_usb20_resources);
-	usb_dev.name = "musb-da8xx";
-
-	return platform_device_register(&usb_dev);
-}
-#endif	/* CONFIG_DAVINCI_DA8XX */
-
 #else
 
 void __init davinci_setup_usb(unsigned mA, unsigned potpgt_ms)
 {
 }
 
-#ifdef CONFIG_ARCH_DAVINCI_DA8XX
-int __init da8xx_register_usb20(unsigned mA, unsigned potpgt)
-{
-	return 0;
-}
-#endif
-
 #endif  /* CONFIG_USB_MUSB_HDRC */
-
-#ifdef	CONFIG_ARCH_DAVINCI_DA8XX
-static struct resource da8xx_usb11_resources[] = {
-	[0] = {
-		.start	= DA8XX_USB1_BASE,
-		.end	= DA8XX_USB1_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_DA8XX_IRQN,
-		.end	= IRQ_DA8XX_IRQN,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 da8xx_usb11_dma_mask = DMA_BIT_MASK(32);
-
-static struct platform_device da8xx_usb11_device = {
-	.name		= "ohci",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &da8xx_usb11_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(da8xx_usb11_resources),
-	.resource	= da8xx_usb11_resources,
-};
-
-int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
-{
-	da8xx_usb11_device.dev.platform_data = pdata;
-	return platform_device_register(&da8xx_usb11_device);
-}
-#endif	/* CONFIG_DAVINCI_DA8XX */
-- 
2.6.3
