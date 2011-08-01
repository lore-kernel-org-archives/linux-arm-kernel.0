From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  1 Aug 2011 11:38:24 +0200
Subject: [PATCH 3/8] ARM: mx5: dynamically allocate mxc-ehci devices
In-Reply-To: <1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110801093759.GD9250@pengutronix.de>
	<1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1312191509-21895-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Additionally make the usb related defines consistent with the other imx
SoCs.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig                     |    6 ++-
 arch/arm/mach-mx5/board-cpuimx51.c            |   12 +++---
 arch/arm/mach-mx5/board-cpuimx51sd.c          |   12 +++---
 arch/arm/mach-mx5/board-mx51_babbage.c        |   12 +++---
 arch/arm/mach-mx5/board-mx51_efikasb.c        |    5 +-
 arch/arm/mach-mx5/devices-imx51.h             |    7 +++
 arch/arm/mach-mx5/devices.c                   |   61 +------------------------
 arch/arm/mach-mx5/devices.h                   |    3 -
 arch/arm/mach-mx5/ehci.c                      |    2 +-
 arch/arm/mach-mx5/mx51_efika.c                |   14 +++---
 arch/arm/plat-mxc/devices/platform-mxc-ehci.c |    9 ++++
 arch/arm/plat-mxc/include/mach/mx51.h         |   11 +++--
 12 files changed, 57 insertions(+), 97 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index b4e7c58..2905110 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -68,6 +68,7 @@ config MACH_MX51_BABBAGE
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
@@ -93,6 +94,7 @@ config MACH_EUKREA_CPUIMX51
 	select SOC_IMX51
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
@@ -120,9 +122,10 @@ config MACH_EUKREA_CPUIMX51SD
 	bool "Support Eukrea CPUIMX51SD module"
 	select SOC_IMX51
 	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_SPI_IMX
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  Include support for Eukrea CPUIMX51SD platform. This includes
 	  specific configurations for the module and its peripherals.
@@ -147,6 +150,7 @@ config MX51_EFIKA_COMMON
 	bool
 	select SOC_IMX51
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 7c893fa..aa1ff79 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -167,7 +167,7 @@ static int initialize_otg_port(struct platform_device *pdev)
 	void __iomem *usb_base;
 	void __iomem *usbother_base;
 
-	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	usb_base = ioremap(MX51_USB_OTG_BASE_ADDR, SZ_4K);
 	if (!usb_base)
 		return -ENOMEM;
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
@@ -190,7 +190,7 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 	void __iomem *usb_base;
 	void __iomem *usbother_base;
 
-	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	usb_base = ioremap(MX51_USB_OTG_BASE_ADDR, SZ_4K);
 	if (!usb_base)
 		return -ENOMEM;
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
@@ -206,7 +206,7 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 			MXC_EHCI_ITC_NO_THRESHOLD);
 }
 
-static struct mxc_usbh_platform_data dr_utmi_config = {
+static const struct mxc_usbh_platform_data dr_utmi_config __initconst = {
 	.init		= initialize_otg_port,
 	.portsc	= MXC_EHCI_UTMI_16BIT,
 };
@@ -216,7 +216,7 @@ static struct fsl_usb2_platform_data usb_pdata = {
 	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
 };
 
-static struct mxc_usbh_platform_data usbh1_config = {
+static const struct mxc_usbh_platform_data usbh1_config __initconst = {
 	.init		= initialize_usbh1_port,
 	.portsc	= MXC_EHCI_MODE_ULPI,
 };
@@ -270,12 +270,12 @@ static void __init eukrea_cpuimx51_init(void)
 				ARRAY_SIZE(eukrea_cpuimx51_i2c_devices));
 
 	if (otg_mode_host)
-		mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
+		imx51_add_mxc_ehci_otg(&dr_utmi_config);
 	else {
 		initialize_otg_port(NULL);
 		mxc_register_device(&mxc_usbdr_udc_device, &usb_pdata);
 	}
-	mxc_register_device(&mxc_usbh1_device, &usbh1_config);
+	imx51_add_mxc_ehci_hs(1, &usbh1_config);
 
 #ifdef CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD
 	eukrea_mbimx51_baseboard_init();
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index ff096d5..bca3719 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -149,7 +149,7 @@ static int initialize_otg_port(struct platform_device *pdev)
 	void __iomem *usb_base;
 	void __iomem *usbother_base;
 
-	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	usb_base = ioremap(MX51_USB_OTG_BASE_ADDR, SZ_4K);
 	if (!usb_base)
 		return -ENOMEM;
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
@@ -172,7 +172,7 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 	void __iomem *usb_base;
 	void __iomem *usbother_base;
 
-	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	usb_base = ioremap(MX51_USB_OTG_BASE_ADDR, SZ_4K);
 	if (!usb_base)
 		return -ENOMEM;
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
@@ -189,7 +189,7 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 			MXC_EHCI_ITC_NO_THRESHOLD);
 }
 
-static struct mxc_usbh_platform_data dr_utmi_config = {
+static const struct mxc_usbh_platform_data dr_utmi_config __initconst = {
 	.init		= initialize_otg_port,
 	.portsc	= MXC_EHCI_UTMI_16BIT,
 };
@@ -199,7 +199,7 @@ static struct fsl_usb2_platform_data usb_pdata = {
 	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
 };
 
-static struct mxc_usbh_platform_data usbh1_config = {
+static const struct mxc_usbh_platform_data usbh1_config __initconst = {
 	.init		= initialize_usbh1_port,
 	.portsc	= MXC_EHCI_MODE_ULPI,
 };
@@ -303,7 +303,7 @@ static void __init eukrea_cpuimx51sd_init(void)
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 
 	if (otg_mode_host)
-		mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
+		imx51_add_mxc_ehci_otg(&dr_utmi_config);
 	else {
 		initialize_otg_port(NULL);
 		mxc_register_device(&mxc_usbdr_udc_device, &usb_pdata);
@@ -313,7 +313,7 @@ static void __init eukrea_cpuimx51sd_init(void)
 	gpio_direction_output(USBH1_RST, 0);
 	msleep(20);
 	gpio_set_value(USBH1_RST, 1);
-	mxc_register_device(&mxc_usbh1_device, &usbh1_config);
+	imx51_add_mxc_ehci_hs(1, &usbh1_config);
 
 #ifdef CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD
 	eukrea_mbimxsd51_baseboard_init();
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index e400b09..1d15297 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -249,7 +249,7 @@ static int initialize_otg_port(struct platform_device *pdev)
 	void __iomem *usb_base;
 	void __iomem *usbother_base;
 
-	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	usb_base = ioremap(MX51_USB_OTG_BASE_ADDR, SZ_4K);
 	if (!usb_base)
 		return -ENOMEM;
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
@@ -272,7 +272,7 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 	void __iomem *usb_base;
 	void __iomem *usbother_base;
 
-	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	usb_base = ioremap(MX51_USB_OTG_BASE_ADDR, SZ_4K);
 	if (!usb_base)
 		return -ENOMEM;
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
@@ -288,7 +288,7 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 			MXC_EHCI_ITC_NO_THRESHOLD);
 }
 
-static struct mxc_usbh_platform_data dr_utmi_config = {
+static const struct mxc_usbh_platform_data dr_utmi_config __initconst = {
 	.init		= initialize_otg_port,
 	.portsc	= MXC_EHCI_UTMI_16BIT,
 };
@@ -298,7 +298,7 @@ static struct fsl_usb2_platform_data usb_pdata = {
 	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
 };
 
-static struct mxc_usbh_platform_data usbh1_config = {
+static const struct mxc_usbh_platform_data usbh1_config __initconst = {
 	.init		= initialize_usbh1_port,
 	.portsc	= MXC_EHCI_MODE_ULPI,
 };
@@ -384,14 +384,14 @@ static void __init mx51_babbage_init(void)
 	mxc_register_device(&mxc_hsi2c_device, &babbage_hsi2c_data);
 
 	if (otg_mode_host)
-		mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
+		imx51_add_mxc_ehci_otg(&dr_utmi_config);
 	else {
 		initialize_otg_port(NULL);
 		mxc_register_device(&mxc_usbdr_udc_device, &usb_pdata);
 	}
 
 	gpio_usbh1_active();
-	mxc_register_device(&mxc_usbh1_device, &usbh1_config);
+	imx51_add_mxc_ehci_hs(1, &usbh1_config);
 	/* setback USBH1_STP to be function */
 	mxc_iomux_v3_setup_pad(usbh1stp);
 	babbage_usbhub_reset();
diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
index 2e4d9d3..10f0562 100644
--- a/arch/arm/mach-mx5/board-mx51_efikasb.c
+++ b/arch/arm/mach-mx5/board-mx51_efikasb.c
@@ -42,7 +42,6 @@
 #include <asm/mach/time.h>
 
 #include "devices-imx51.h"
-#include "devices.h"
 #include "efika.h"
 
 #define EFIKASB_USBH2_STP	IMX_GPIO_NR(2, 20)
@@ -119,7 +118,7 @@ static int initialize_usbh2_port(struct platform_device *pdev)
 	return mx51_initialize_usb_hw(pdev->id, MXC_EHCI_ITC_NO_THRESHOLD);
 }
 
-static struct mxc_usbh_platform_data usbh2_config = {
+static struct mxc_usbh_platform_data usbh2_config __initdata = {
 	.init   = initialize_usbh2_port,
 	.portsc = MXC_EHCI_MODE_ULPI,
 };
@@ -129,7 +128,7 @@ static void __init mx51_efikasb_usb(void)
 	usbh2_config.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
 			ULPI_OTG_DRVVBUS_EXT | ULPI_OTG_EXTVBUSIND);
 	if (usbh2_config.otg)
-		mxc_register_device(&mxc_usbh2_device, &usbh2_config);
+		imx51_add_mxc_ehci_hs(2, &usbh2_config);
 }
 
 static const struct gpio_led mx51_efikasb_leds[] __initconst = {
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index e11bc0e..f42acf5 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -25,6 +25,13 @@ extern const struct imx_imx_uart_1irq_data imx51_imx_uart_data[];
 #define imx51_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx51_imx_uart_data[id], pdata)
 
+extern const struct imx_mxc_ehci_data imx51_mxc_ehci_otg_data;
+#define imx51_add_mxc_ehci_otg(pdata)	\
+	imx_add_mxc_ehci(&imx51_mxc_ehci_otg_data, pdata)
+extern const struct imx_mxc_ehci_data imx51_mxc_ehci_hs_data[];
+#define imx51_add_mxc_ehci_hs(id, pdata)	\
+	imx_add_mxc_ehci(&imx51_mxc_ehci_hs_data[id - 1], pdata)
+
 extern const struct imx_mxc_nand_data imx51_mxc_nand_data;
 #define imx51_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx51_mxc_nand_data, pdata)
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 5fd8f0c..88edf26 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -40,8 +40,8 @@ static u64 usb_dma_mask = DMA_BIT_MASK(32);
 
 static struct resource usbotg_resources[] = {
 	{
-		.start = MX51_OTG_BASE_ADDR,
-		.end = MX51_OTG_BASE_ADDR + 0x1ff,
+		.start = MX51_USB_OTG_BASE_ADDR,
+		.end = MX51_USB_OTG_BASE_ADDR + 0x1ff,
 		.flags = IORESOURCE_MEM,
 	},
 	{
@@ -61,60 +61,3 @@ struct platform_device mxc_usbdr_udc_device = {
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
-
-struct platform_device mxc_usbdr_host_device = {
-	.name = "mxc-ehci",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(usbotg_resources),
-	.resource = usbotg_resources,
-	.dev = {
-		.dma_mask = &usb_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-};
-
-static struct resource usbh1_resources[] = {
-	{
-		.start = MX51_OTG_BASE_ADDR + 0x200,
-		.end = MX51_OTG_BASE_ADDR + 0x200 + 0x1ff,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = MX51_INT_USB_H1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_usbh1_device = {
-	.name = "mxc-ehci",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(usbh1_resources),
-	.resource = usbh1_resources,
-	.dev = {
-		.dma_mask = &usb_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-};
-
-static struct resource usbh2_resources[] = {
-	{
-		.start = MX51_OTG_BASE_ADDR + 0x400,
-		.end = MX51_OTG_BASE_ADDR + 0x400 + 0x1ff,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = MX51_INT_USB_H2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_usbh2_device = {
-	.name = "mxc-ehci",
-	.id = 2,
-	.num_resources = ARRAY_SIZE(usbh2_resources),
-	.resource = usbh2_resources,
-	.dev = {
-		.dma_mask = &usb_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-};
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index 55a5129..0f30a6e 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -1,5 +1,2 @@
-extern struct platform_device mxc_usbdr_host_device;
-extern struct platform_device mxc_usbh1_device;
-extern struct platform_device mxc_usbh2_device;
 extern struct platform_device mxc_usbdr_udc_device;
 extern struct platform_device mxc_hsi2c_device;
diff --git a/arch/arm/mach-mx5/ehci.c b/arch/arm/mach-mx5/ehci.c
index 7ce12c8..c17fa13 100644
--- a/arch/arm/mach-mx5/ehci.c
+++ b/arch/arm/mach-mx5/ehci.c
@@ -52,7 +52,7 @@ int mx51_initialize_usb_hw(int port, unsigned int flags)
 	void __iomem *usbother_base;
 	int ret = 0;
 
-	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	usb_base = ioremap(MX51_USB_OTG_BASE_ADDR, SZ_4K);
 	if (!usb_base) {
 		printk(KERN_ERR "%s(): ioremap failed\n", __func__);
 		return -ENOMEM;
diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_efika.c
index 4435e03..e99dead 100644
--- a/arch/arm/mach-mx5/mx51_efika.c
+++ b/arch/arm/mach-mx5/mx51_efika.c
@@ -41,7 +41,6 @@
 #include <asm/mach/time.h>
 
 #include "devices-imx51.h"
-#include "devices.h"
 #include "efika.h"
 #include "cpu_op-mx51.h"
 
@@ -133,7 +132,7 @@ static int initialize_otg_port(struct platform_device *pdev)
 	u32 v;
 	void __iomem *usb_base;
 	void __iomem *usbother_base;
-	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	usb_base = ioremap(MX51_USB_OTG_BASE_ADDR, SZ_4K);
 	if (!usb_base)
 		return -ENOMEM;
 	usbother_base = (void __iomem *)(usb_base + MX5_USBOTHER_REGS_OFFSET);
@@ -150,7 +149,7 @@ static int initialize_otg_port(struct platform_device *pdev)
 	return mx51_initialize_usb_hw(pdev->id, MXC_EHCI_INTERNAL_PHY);
 }
 
-static struct mxc_usbh_platform_data dr_utmi_config = {
+static const struct mxc_usbh_platform_data dr_utmi_config __initconst = {
 	.init   = initialize_otg_port,
 	.portsc = MXC_EHCI_UTMI_16BIT,
 };
@@ -170,7 +169,7 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 	gpio_set_value(EFIKAMX_USBH1_STP, 1);
 	msleep(1);
 
-	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	usb_base = ioremap(MX51_USB_OTG_BASE_ADDR, SZ_4K);
 	socregs_base = (void __iomem *)(usb_base + MX5_USBOTHER_REGS_OFFSET);
 
 	/* The clock for the USBH1 ULPI port will come externally */
@@ -189,7 +188,7 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 	return mx51_initialize_usb_hw(0, MXC_EHCI_ITC_NO_THRESHOLD);
 }
 
-static struct mxc_usbh_platform_data usbh1_config = {
+static struct mxc_usbh_platform_data usbh1_config __initdata = {
 	.init   = initialize_usbh1_port,
 	.portsc = MXC_EHCI_MODE_ULPI,
 };
@@ -217,9 +216,9 @@ static void __init mx51_efika_usb(void)
 	usbh1_config.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
 			ULPI_OTG_DRVVBUS_EXT | ULPI_OTG_EXTVBUSIND);
 
-	mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
+	imx51_add_mxc_ehci_otg(&dr_utmi_config);
 	if (usbh1_config.otg)
-		mxc_register_device(&mxc_usbh1_device, &usbh1_config);
+		imx51_add_mxc_ehci_hs(1, &usbh1_config);
 }
 
 static struct mtd_partition mx51_efika_spi_nor_partitions[] = {
@@ -631,4 +630,3 @@ void __init efika_board_common_init(void)
 	get_cpu_op = mx51_get_cpu_op;
 #endif
 }
-
diff --git a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c b/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
index e1763e0..35851d8 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
@@ -49,6 +49,15 @@ const struct imx_mxc_ehci_data imx35_mxc_ehci_hs_data __initconst =
 	imx_mxc_ehci_data_entry_single(MX35, 1, HS);
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
+#ifdef CONFIG_SOC_IMX51
+const struct imx_mxc_ehci_data imx51_mxc_ehci_otg_data __initconst =
+	imx_mxc_ehci_data_entry_single(MX51, 0, OTG);
+const struct imx_mxc_ehci_data imx51_mxc_ehci_hs_data[] __initconst = {
+	imx_mxc_ehci_data_entry_single(MX51, 1, HS1),
+	imx_mxc_ehci_data_entry_single(MX51, 2, HS2),
+};
+#endif /* ifdef CONFIG_SOC_IMX51 */
+
 struct platform_device *__init imx_add_mxc_ehci(
 		const struct imx_mxc_ehci_data *data,
 		const struct mxc_usbh_platform_data *pdata)
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index d240b6f..9666e31 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -55,7 +55,10 @@
 #define MX51_AIPS1_BASE_ADDR		0x73f00000
 #define MX51_AIPS1_SIZE			SZ_1M
 
-#define MX51_OTG_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0x80000)
+#define MX51_USB_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0x80000)
+#define MX51_USB_OTG_BASE_ADDR		(MX51_USB_BASE_ADDR + 0x0000)
+#define MX51_USB_HS1_BASE_ADDR		(MX51_USB_BASE_ADDR + 0x0200)
+#define MX51_USB_HS2_BASE_ADDR		(MX51_USB_BASE_ADDR + 0x0400)
 #define MX51_GPIO1_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0x84000)
 #define MX51_GPIO2_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0x88000)
 #define MX51_GPIO3_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0x8c000)
@@ -255,10 +258,10 @@
 #define MX51_INT_IPU_SYN		11
 #define MX51_INT_GPU			12
 #define MX51_INT_RESV13			13
-#define MX51_INT_USB_H1			14
+#define MX51_INT_USB_HS1		14
 #define MX51_INT_EMI			15
-#define MX51_INT_USB_H2			16
-#define MX51_INT_USB_H3			17
+#define MX51_INT_USB_HS2		16
+#define MX51_INT_USB_HS3		17
 #define MX51_INT_USB_OTG		18
 #define MX51_INT_SAHARA_H0		19
 #define MX51_INT_SAHARA_H1		20
-- 
1.7.5.4
