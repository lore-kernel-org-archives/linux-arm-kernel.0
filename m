From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 1 May 2013 02:45:54 +0400
Subject: [PATCH v7 1/9] ARM: shmobile: Marzen: move USB EHCI, OHCI,
 and PHY devices to R8A7779 code
In-Reply-To: <201305010242.37483.sergei.shtylyov@cogentembedded.com>
References: <201305010242.37483.sergei.shtylyov@cogentembedded.com>
Message-ID: <201305010245.55413.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB EHCI, OHCI, and common PHY are the SoC devices but are wrongly defined and
registered in the Marzen board file.  Move the data and code to their proper
place in setup-r8a7779.c; while at it, we have to rename r8a7779_late_devices[]
to r8a7779_standard_devices[] -- this seems legitimate since they are registered
from r8a7779_add_standard_devices() anyway.

Note that I'm deliberately changing the USB PHY platform device's 'id' field
from (previously just omitted) 0 to -1 as the device is a single of its kind.

Note also that the board and SoC code have to be in one patch to keep the code
bisectable...

The patch has been tested on the Marzen board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes since version 5:
- fixed typos in the changelog.

Changes since version 4:
- resolved reject in the 'board-marzen.c' file, refreshed the patch.

Changes since version 3:
- refreshed the 'board-marzen.c' file.

Changes since version 2:
- added a note about testing to the changelog;
- added ACKs from Simon Horman and Kuninori Morimoto.

Changes since the original posting:
- added a note about bisectability to the changelog.

 arch/arm/mach-shmobile/board-marzen.c         |  178 -------------------------
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    1 
 arch/arm/mach-shmobile/setup-r8a7779.c        |  185 +++++++++++++++++++++++++-
 3 files changed, 184 insertions(+), 180 deletions(-)

Index: renesas/arch/arm/mach-shmobile/board-marzen.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-marzen.c
+++ renesas/arch/arm/mach-shmobile/board-marzen.c
@@ -37,10 +37,6 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
-#include <linux/usb/otg.h>
-#include <linux/usb/ehci_pdriver.h>
-#include <linux/usb/ohci_pdriver.h>
-#include <linux/pm_runtime.h>
 #include <mach/hardware.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
@@ -150,26 +146,6 @@ static struct platform_device hspi_devic
 	.num_resources	= ARRAY_SIZE(hspi_resources),
 };
 
-/* USB PHY */
-static struct resource usb_phy_resources[] = {
-	[0] = {
-		.start		= 0xffe70000,
-		.end		= 0xffe70900 - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= 0xfff70000,
-		.end		= 0xfff70900 - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device usb_phy_device = {
-	.name		= "rcar_usb_phy",
-	.resource	= usb_phy_resources,
-	.num_resources	= ARRAY_SIZE(usb_phy_resources),
-};
-
 /* LEDS */
 static struct gpio_led marzen_leds[] = {
 	{
@@ -205,161 +181,9 @@ static struct platform_device *marzen_de
 	&sdhi0_device,
 	&thermal_device,
 	&hspi_device,
-	&usb_phy_device,
 	&leds_device,
 };
 
-/* USB */
-static struct usb_phy *phy;
-static int usb_power_on(struct platform_device *pdev)
-{
-	if (!phy)
-		return -EIO;
-
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
-
-	usb_phy_init(phy);
-
-	return 0;
-}
-
-static void usb_power_off(struct platform_device *pdev)
-{
-	if (!phy)
-		return;
-
-	usb_phy_shutdown(phy);
-
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-}
-
-static struct usb_ehci_pdata ehcix_pdata = {
-	.power_on	= usb_power_on,
-	.power_off	= usb_power_off,
-	.power_suspend	= usb_power_off,
-};
-
-static struct resource ehci0_resources[] = {
-	[0] = {
-		.start	= 0xffe70000,
-		.end	= 0xffe70400 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= gic_iid(0x4c),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device ehci0_device = {
-	.name	= "ehci-platform",
-	.id	= 0,
-	.dev	= {
-		.dma_mask		= &ehci0_device.dev.coherent_dma_mask,
-		.coherent_dma_mask	= 0xffffffff,
-		.platform_data		= &ehcix_pdata,
-	},
-	.num_resources	= ARRAY_SIZE(ehci0_resources),
-	.resource	= ehci0_resources,
-};
-
-static struct resource ehci1_resources[] = {
-	[0] = {
-		.start	= 0xfff70000,
-		.end	= 0xfff70400 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= gic_iid(0x4d),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device ehci1_device = {
-	.name	= "ehci-platform",
-	.id	= 1,
-	.dev	= {
-		.dma_mask		= &ehci1_device.dev.coherent_dma_mask,
-		.coherent_dma_mask	= 0xffffffff,
-		.platform_data		= &ehcix_pdata,
-	},
-	.num_resources	= ARRAY_SIZE(ehci1_resources),
-	.resource	= ehci1_resources,
-};
-
-static struct usb_ohci_pdata ohcix_pdata = {
-	.power_on	= usb_power_on,
-	.power_off	= usb_power_off,
-	.power_suspend	= usb_power_off,
-};
-
-static struct resource ohci0_resources[] = {
-	[0] = {
-		.start	= 0xffe70400,
-		.end	= 0xffe70800 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= gic_iid(0x4c),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device ohci0_device = {
-	.name	= "ohci-platform",
-	.id	= 0,
-	.dev	= {
-		.dma_mask		= &ohci0_device.dev.coherent_dma_mask,
-		.coherent_dma_mask	= 0xffffffff,
-		.platform_data		= &ohcix_pdata,
-	},
-	.num_resources	= ARRAY_SIZE(ohci0_resources),
-	.resource	= ohci0_resources,
-};
-
-static struct resource ohci1_resources[] = {
-	[0] = {
-		.start	= 0xfff70400,
-		.end	= 0xfff70800 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= gic_iid(0x4d),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device ohci1_device = {
-	.name	= "ohci-platform",
-	.id	= 1,
-	.dev	= {
-		.dma_mask		= &ohci1_device.dev.coherent_dma_mask,
-		.coherent_dma_mask	= 0xffffffff,
-		.platform_data		= &ohcix_pdata,
-	},
-	.num_resources	= ARRAY_SIZE(ohci1_resources),
-	.resource	= ohci1_resources,
-};
-
-static struct platform_device *marzen_late_devices[] __initdata = {
-	&ehci0_device,
-	&ehci1_device,
-	&ohci0_device,
-	&ohci1_device,
-};
-
-static void __init marzen_init_late(void)
-{
-	/* get usb phy */
-	phy = usb_get_phy(USB_PHY_TYPE_USB2);
-
-	shmobile_init_late();
-	platform_add_devices(marzen_late_devices,
-			     ARRAY_SIZE(marzen_late_devices));
-}
-
 static const struct pinctrl_map marzen_pinctrl_map[] = {
 	/* HSPI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-hspi.0", "pfc-r8a7779",
@@ -418,6 +242,6 @@ MACHINE_START(MARZEN, "marzen")
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq,
 	.init_machine	= marzen_init,
-	.init_late	= marzen_init_late,
+	.init_late	= r8a7779_init_late,
 	.init_time	= r8a7779_earlytimer_init,
 MACHINE_END
Index: renesas/arch/arm/mach-shmobile/include/mach/r8a7779.h
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ renesas/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -33,6 +33,7 @@ extern void r8a7779_add_early_devices(vo
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_add_standard_devices_dt(void);
 extern void r8a7779_add_ether_device(struct sh_eth_plat_data *pdata);
+extern void r8a7779_init_late(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -32,6 +32,10 @@
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
 #include <linux/dma-mapping.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
+#include <linux/pm_runtime.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/r8a7779.h>
@@ -383,6 +387,162 @@ static struct platform_device sata_devic
 	},
 };
 
+/* USB PHY */
+static struct resource usb_phy_resources[] = {
+	[0] = {
+		.start		= 0xffe70000,
+		.end		= 0xffe70900 - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= 0xfff70000,
+		.end		= 0xfff70900 - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device usb_phy_device = {
+	.name		= "rcar_usb_phy",
+	.id		= -1,
+	.resource	= usb_phy_resources,
+	.num_resources	= ARRAY_SIZE(usb_phy_resources),
+};
+
+/* USB */
+static struct usb_phy *phy;
+
+static int usb_power_on(struct platform_device *pdev)
+{
+	if (!phy)
+		return -EIO;
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
+	usb_phy_init(phy);
+
+	return 0;
+}
+
+static void usb_power_off(struct platform_device *pdev)
+{
+	if (!phy)
+		return;
+
+	usb_phy_shutdown(phy);
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+}
+
+static struct usb_ehci_pdata ehcix_pdata = {
+	.power_on	= usb_power_on,
+	.power_off	= usb_power_off,
+	.power_suspend	= usb_power_off,
+};
+
+static struct resource ehci0_resources[] = {
+	[0] = {
+		.start	= 0xffe70000,
+		.end	= 0xffe70400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_iid(0x4c),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ehci0_device = {
+	.name	= "ehci-platform",
+	.id	= 0,
+	.dev	= {
+		.dma_mask		= &ehci0_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &ehcix_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(ehci0_resources),
+	.resource	= ehci0_resources,
+};
+
+static struct resource ehci1_resources[] = {
+	[0] = {
+		.start	= 0xfff70000,
+		.end	= 0xfff70400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_iid(0x4d),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ehci1_device = {
+	.name	= "ehci-platform",
+	.id	= 1,
+	.dev	= {
+		.dma_mask		= &ehci1_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &ehcix_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(ehci1_resources),
+	.resource	= ehci1_resources,
+};
+
+static struct usb_ohci_pdata ohcix_pdata = {
+	.power_on	= usb_power_on,
+	.power_off	= usb_power_off,
+	.power_suspend	= usb_power_off,
+};
+
+static struct resource ohci0_resources[] = {
+	[0] = {
+		.start	= 0xffe70400,
+		.end	= 0xffe70800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_iid(0x4c),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ohci0_device = {
+	.name	= "ohci-platform",
+	.id	= 0,
+	.dev	= {
+		.dma_mask		= &ohci0_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &ohcix_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(ohci0_resources),
+	.resource	= ohci0_resources,
+};
+
+static struct resource ohci1_resources[] = {
+	[0] = {
+		.start	= 0xfff70400,
+		.end	= 0xfff70800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_iid(0x4d),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ohci1_device = {
+	.name	= "ohci-platform",
+	.id	= 1,
+	.dev	= {
+		.dma_mask		= &ohci1_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &ohcix_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(ohci1_resources),
+	.resource	= ohci1_resources,
+};
+
 /* Ether */
 static struct resource ether_resources[] = {
 	{
@@ -404,9 +564,10 @@ static struct platform_device *r8a7779_d
 	&scif5_device,
 	&tmu00_device,
 	&tmu01_device,
+	&usb_phy_device,
 };
 
-static struct platform_device *r8a7779_late_devices[] __initdata = {
+static struct platform_device *r8a7779_standard_devices[] __initdata = {
 	&i2c0_device,
 	&i2c1_device,
 	&i2c2_device,
@@ -426,8 +587,8 @@ void __init r8a7779_add_standard_devices
 
 	platform_add_devices(r8a7779_devices_dt,
 			    ARRAY_SIZE(r8a7779_devices_dt));
-	platform_add_devices(r8a7779_late_devices,
-			    ARRAY_SIZE(r8a7779_late_devices));
+	platform_add_devices(r8a7779_standard_devices,
+			    ARRAY_SIZE(r8a7779_standard_devices));
 }
 
 void __init r8a7779_add_ether_device(struct sh_eth_plat_data *pdata)
@@ -470,6 +631,23 @@ void __init r8a7779_add_early_devices(vo
 	 */
 }
 
+static struct platform_device *r8a7779_late_devices[] __initdata = {
+	&ehci0_device,
+	&ehci1_device,
+	&ohci0_device,
+	&ohci1_device,
+};
+
+void __init r8a7779_init_late(void)
+{
+	/* get USB PHY */
+	phy = usb_get_phy(USB_PHY_TYPE_USB2);
+
+	shmobile_init_late();
+	platform_add_devices(r8a7779_late_devices,
+			     ARRAY_SIZE(r8a7779_late_devices));
+}
+
 #ifdef CONFIG_USE_OF
 void __init r8a7779_init_delay(void)
 {
@@ -503,6 +681,7 @@ DT_MACHINE_START(R8A7779_DT, "Generic R8
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= r8a7779_add_standard_devices_dt,
 	.init_time	= shmobile_timer_init,
+	.init_late	= r8a7779_init_late,
 	.dt_compat	= r8a7779_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
