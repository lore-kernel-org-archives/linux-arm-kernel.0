From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 14 Apr 2016 17:34:07 +0530
Subject: [PATCH] ARM: davinci: da8xx-usb: remove deprecated properties
 from MUSB config
In-Reply-To: <1460585952-31301-1-git-send-email-david@lechnology.com>
References: <1460585952-31301-1-git-send-email-david@lechnology.com>
Message-ID: <570F8737.3040305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 April 2016 03:49 AM, David Lechner wrote:
> This is the same as commit c1b3b058469e ("ARM: DaVinci USB: removed
> deprecated properties from MUSB config") applied to usb-da8xx.c.
> 
> The following properties of the musb_hdrc_config structure
> are deprecated and no longer required/used by the MUSB driver:
> 
> .dyn_fifo
> .soft_con
> .dma
> .dma_channels
> .eps_bits
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Thanks for pointing this out. I folded this into your patch "ARM: 
davinci: da8xx: move usb code to new file"[1] and in turn based it on 
Petr's patch cleaning up the deprecated properties from the usb.c file.

I have pushed all my v4.7/* branches to my tree and the master branch 
merges all of these in. I should be sending the first pull request to 
ARM-SoC by tomorrow. Any testing feedback on master branch appreciated.

Regards,
Sekhar

[1]
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
 arch/arm/mach-davinci/usb-da8xx.c | 107 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/usb.c       |  73 --------------------------
 3 files changed, 109 insertions(+), 75 deletions(-)
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
index 000000000000..f141f5171906
--- /dev/null
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -0,0 +1,107 @@
+/*
+ * DA8xx USB
+ */
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/platform_data/usb-davinci.h>
+#include <linux/platform_device.h>
+#include <linux/usb/musb.h>
+
+#include <mach/common.h>
+#include <mach/cputype.h>
+#include <mach/da8xx.h>
+#include <mach/irqs.h>
+
+#define DA8XX_USB0_BASE		0x01e00000
+#define DA8XX_USB1_BASE		0x01e25000
+
+#if IS_ENABLED(CONFIG_USB_MUSB_HDRC)
+
+static struct musb_hdrc_config musb_config = {
+	.multipoint	= true,
+	.num_eps	= 5,
+	.ram_bits	= 10,
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
index 6ed5a54ae74d..0e7e89c1f331 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -10,14 +10,10 @@
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
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= true,
@@ -81,79 +77,10 @@ void __init davinci_setup_usb(unsigned mA, unsigned potpgt_ms)
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
