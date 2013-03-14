From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 23:14:31 +0100
Subject: [PATCH 5/5] ARM: cns3xxx: initial DT support
In-Reply-To: <1363299271-8283-1-git-send-email-arnd@arndb.de>
References: <1363299271-8283-1-git-send-email-arnd@arndb.de>
Message-ID: <1363299271-8283-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds very minimal support for booting cns3xxx using a device
tree. It should support the same devices that cns3420vb provides
but gets them from the DT. All devices that don't have their own
binding are probed through auxdata. This is completely untested
and likely incomplete.

Booting through ATAGS is made optional, so it can be turned off
by anybody who has a DTB file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-cns3xxx/Kconfig  |   1 +
 arch/arm/mach-cns3xxx/Makefile |   8 +--
 arch/arm/mach-cns3xxx/core.c   | 119 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index 5720f3d..dbf0df8 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -14,6 +14,7 @@ menu "CNS3XXX platform type"
 
 config MACH_CNS3420VB
 	bool "Support for CNS3420 Validation Board"
+	depends on ATAGS
 	help
 	  Include support for the Cavium Networks CNS3420 MPCore Platform
 	  Baseboard.
diff --git a/arch/arm/mach-cns3xxx/Makefile b/arch/arm/mach-cns3xxx/Makefile
index 11033f1..a1ff108 100644
--- a/arch/arm/mach-cns3xxx/Makefile
+++ b/arch/arm/mach-cns3xxx/Makefile
@@ -1,3 +1,5 @@
-obj-$(CONFIG_ARCH_CNS3XXX)		+= core.o pm.o devices.o
-obj-$(CONFIG_PCI)			+= pcie.o
-obj-$(CONFIG_MACH_CNS3420VB)		+= cns3420vb.o
+obj-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx.o
+cns3xxx-y				+= core.o pm.o
+cns3xxx-$(CONFIG_ATAGS)			+= devices.o
+cns3xxx-$(CONFIG_PCI)			+= pcie.o
+cns3xxx-$(CONFIG_MACH_CNS3420VB)	+= cns3420vb.o
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 012ffdb..49e657c 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -13,12 +13,18 @@
 #include <linux/clockchips.h>
 #include <linux/io.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
+#include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 #include <asm/hardware/cache-l2x0.h>
 #include "cns3xxx.h"
 #include "core.h"
+#include "pm.h"
 
 static struct map_desc cns3xxx_io_desc[] __initdata = {
 	{
@@ -276,3 +282,116 @@ void __init cns3xxx_l2x0_init(void)
 }
 
 #endif /* CONFIG_CACHE_L2X0 */
+
+static int csn3xxx_usb_power_on(struct platform_device *pdev)
+{
+	/*
+	 * EHCI and OHCI share the same clock and power,
+	 * resetting twice would cause the 1st controller been reset.
+	 * Therefore only do power up  at the first up device, and
+	 * power down at the last down device.
+	 *
+	 * Set USB AHB INCR length to 16
+	 */
+	if (atomic_inc_return(&usb_pwr_ref) == 1) {
+		cns3xxx_pwr_power_up(1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_PLL_USB);
+		cns3xxx_pwr_clk_en(1 << PM_CLK_GATE_REG_OFFSET_USB_HOST);
+		cns3xxx_pwr_soft_rst(1 << PM_SOFT_RST_REG_OFFST_USB_HOST);
+		__raw_writel((__raw_readl(MISC_CHIP_CONFIG_REG) | (0X2 << 24)),
+			MISC_CHIP_CONFIG_REG);
+	}
+
+	return 0;
+}
+
+static void csn3xxx_usb_power_off(struct platform_device *pdev)
+{
+	/*
+	 * EHCI and OHCI share the same clock and power,
+	 * resetting twice would cause the 1st controller been reset.
+	 * Therefore only do power up  at the first up device, and
+	 * power down@the last down device.
+	 */
+	if (atomic_dec_return(&usb_pwr_ref) == 0)
+		cns3xxx_pwr_clk_dis(1 << PM_CLK_GATE_REG_OFFSET_USB_HOST);
+}
+
+static struct usb_ehci_pdata cns3xxx_usb_ehci_pdata = {
+	.power_on	= csn3xxx_usb_power_on,
+	.power_off	= csn3xxx_usb_power_off,
+};
+
+static struct usb_ohci_pdata cns3xxx_usb_ohci_pdata = {
+	.num_ports	= 1,
+	.power_on	= csn3xxx_usb_power_on,
+	.power_off	= csn3xxx_usb_power_off,
+};
+
+static struct of_dev_auxdata cns3xxx_auxdata[] __initconst = {
+	{ "intel,usb-ehci", CNS3XXX_USB_BASE, "ehci-platform", &cns3xxx_usb_ehci_pdata },
+	{ "intel,usb-ohci", CNS3XXX_USB_OHCI_BASE, "ohci-platform", &cns3xxx_usb_ohci_pdata },
+	{ "cavium,cns3420-ahci", CNS3XXX_SATA2_BASE, "ahci", NULL },
+	{ "cavium,cns3420-sdhci", CNS3XXX_SDIO_BASE, "ahci", NULL },
+	{},
+};
+
+static void __init cns3xxx_init(void)
+{
+	struct device_node *dn;
+
+	cns3xxx_l2x0_init();
+
+	dn = of_find_compatible_node(NULL, NULL, "cavium,cns3420-ahci");
+	if (of_device_is_available(dn)) {
+		u32 tmp;
+	
+		tmp = __raw_readl(MISC_SATA_POWER_MODE);
+		tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
+		tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
+		__raw_writel(tmp, MISC_SATA_POWER_MODE);
+	
+		/* Enable SATA PHY */
+		cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0);
+		cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1);
+	
+		/* Enable SATA Clock */
+		cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
+	
+		/* De-Asscer SATA Reset */
+		cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
+	}
+
+	dn = of_find_compatible_node(NULL, NULL, "cavium,cns3420-sdhci");
+	if (of_device_is_available(dn)) {
+		u32 __iomem *gpioa = IOMEM(CNS3XXX_MISC_BASE_VIRT + 0x0014);
+		u32 gpioa_pins = __raw_readl(gpioa);
+	
+		/* MMC/SD pins share with GPIOA */
+		gpioa_pins |= 0x1fff0004;
+		__raw_writel(gpioa_pins, gpioa);
+	
+		cns3xxx_pwr_clk_en(CNS3XXX_PWR_CLK_EN(SDIO));
+		cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SDIO));
+	}
+
+	pm_power_off = cns3xxx_power_off;
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+                        cns3xxx_auxdata, NULL);
+}
+
+static const char *cns3xxx_dt_compat[] __initdata = {
+	"cavium,cns3410",
+	"cavium,cns3420",
+	NULL,
+};
+
+DT_MACHINE_START(CNS3XXX_DT, "Cavium Networks CNS3xxx")
+	.dt_compat	= cns3xxx_dt_compat,
+	.nr_irqs	= NR_IRQS_CNS3XXX,
+	.map_io		= cns3xxx_map_io,
+	.init_irq	= cns3xxx_init_irq,
+	.init_time	= cns3xxx_timer_init,
+	.init_machine	= cns3xxx_init,
+	.restart	= cns3xxx_restart,
+MACHINE_END
-- 
1.8.1.2
