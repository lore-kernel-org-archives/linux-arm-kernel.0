From: lukma@denx.de (Lukasz Majewski)
Date: Fri,  1 Dec 2017 00:51:40 +0100
Subject: [PATCH v4 5/5] ARM: ep93xx: ts72xx: Add support for BK3 board -
 ts72xx derivative
In-Reply-To: <20171130235140.12243-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130235140.12243-1-lukma@denx.de>
Message-ID: <20171130235140.12243-6-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BK3 board is a derivative of the ts72xx reference design.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Place bk3 support code to the ts72xx.c file
Changes for v3:
- Add SD card support (via SPI) for BK3
- Remove definition of apb:i2s bus
- Remove board registration of CPLD WDT device
- Add I2S platform device to BK3
- Add MAINTAINERS entry for BK3 maintainer
Changes for v4:
- Adjust the code to be applicable on top of linux-next/master
---
 MAINTAINERS                   |   6 ++
 arch/arm/mach-ep93xx/Kconfig  |   7 ++
 arch/arm/mach-ep93xx/ts72xx.c | 146 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-ep93xx/ts72xx.h |   5 ++
 arch/arm/tools/mach-types     |   1 +
 5 files changed, 165 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4149cd992825..2fc98b40268d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1254,6 +1254,12 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/net/ethernet/cavium/thunder/
 
+ARM/CIRRUS LOGIC BK3 MACHINE SUPPORT
+M:	Lukasz Majewski <lukma@denx.de>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-ep93xx/ts72xx.c
+
 ARM/CIRRUS LOGIC CLPS711X ARM ARCHITECTURE
 M:	Alexander Shiyan <shc_work@mail.ru>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 61a75ca3684e..c095236d7ff8 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -21,6 +21,13 @@ config MACH_ADSSPHERE
 	  Say 'Y' here if you want your kernel to support the ADS
 	  Sphere board.
 
+config MACH_BK3
+	bool "Support Liebherr BK3.1"
+	select MACH_TS72XX
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Liebherr controller BK3.1.
+
 config MACH_EDB93XX
 	bool
 
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index cf269b5397e5..de3be5e3bee7 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -19,10 +19,15 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/mmc_spi.h>
+#include <linux/mmc/host.h>
 #include <linux/platform_data/spi-ep93xx.h>
 
 #include <mach/gpio-ep93xx.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
+#include <mach/gpio-ep93xx.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -221,6 +226,69 @@ static struct ep93xx_eth_data __initdata ts72xx_eth_data = {
 };
 
 /*************************************************************************
+ * SPI SD/MMC host
+ *************************************************************************/
+#define BK3_EN_SDCARD_PHYS_BASE         0x12400000
+#define BK3_EN_SDCARD_PWR 0x0
+#define BK3_DIS_SDCARD_PWR 0x0C
+static void bk3_mmc_spi_setpower(struct device *dev, unsigned int vdd)
+{
+	void __iomem *pwr_sd = ioremap(BK3_EN_SDCARD_PHYS_BASE, SZ_4K);
+
+	if (!pwr_sd) {
+		pr_err("Failed to enable SD card power!");
+		return;
+	}
+
+	pr_debug("%s: SD card pwr %s VDD:0x%x\n", __func__,
+		 !!vdd ? "ON" : "OFF", vdd);
+
+	if (!!vdd)
+		__raw_writeb(BK3_EN_SDCARD_PWR, pwr_sd);
+	else
+		__raw_writeb(BK3_DIS_SDCARD_PWR, pwr_sd);
+
+	iounmap(pwr_sd);
+}
+
+static struct mmc_spi_platform_data bk3_spi_mmc_data = {
+	.detect_delay	= 500,
+	.powerup_msecs	= 100,
+	.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.caps		= MMC_CAP_NONREMOVABLE,
+	.setpower       = bk3_mmc_spi_setpower,
+};
+
+/*************************************************************************
+ * SPI Bus - SD card access
+ *************************************************************************/
+static struct spi_board_info bk3_spi_board_info[] __initdata = {
+	{
+		.modalias		= "mmc_spi",
+		.platform_data		= &bk3_spi_mmc_data,
+		.max_speed_hz		= 7.4E6,
+		.bus_num		= 0,
+		.chip_select		= 0,
+		.mode			= SPI_MODE_0,
+	},
+};
+
+/*
+ * This is a stub -> the FGPIO[3] pin is not connected on the schematic
+ * The all work is performed automatically by !SPI_FRAME (SFRM1) and
+ * goes through CPLD
+ */
+static int bk3_spi_chipselects[] __initdata = {
+	EP93XX_GPIO_LINE_F(3),
+};
+
+static struct ep93xx_spi_info bk3_spi_master __initdata = {
+	.chipselect	= bk3_spi_chipselects,
+	.num_chipselect = ARRAY_SIZE(bk3_spi_chipselects),
+	.use_dma	= 1,
+};
+
+/*************************************************************************
  * TS72XX support code
  *************************************************************************/
 #if IS_ENABLED(CONFIG_FPGA_MGR_TS73XX)
@@ -294,3 +362,81 @@ MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
 	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
+
+/*************************************************************************
+ * EP93xx I2S audio peripheral handling
+ *************************************************************************/
+static struct resource ep93xx_i2s_resource[] = {
+	DEFINE_RES_MEM(EP93XX_I2S_PHYS_BASE, 0x100),
+	DEFINE_RES_IRQ_NAMED(IRQ_EP93XX_SAI, "spilink i2s slave"),
+};
+
+static struct platform_device ep93xx_i2s_device = {
+	.name		= "ep93xx-spilink-i2s",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ep93xx_i2s_resource),
+	.resource	= ep93xx_i2s_resource,
+};
+
+/*************************************************************************
+ * BK3 support code
+ *************************************************************************/
+static struct mtd_partition bk3_nand_parts[] = {
+	{
+		.name		= "System",
+		.offset	= 0x00000000,
+		.size		= 0x01e00000,
+	}, {
+		.name		= "Data",
+		.offset	= 0x01e00000,
+		.size		= 0x05f20000
+	}, {
+		.name		= "RedBoot",
+		.offset	= 0x07d20000,
+		.size		= 0x002e0000,
+		.mask_flags	= MTD_WRITEABLE,	/* force RO */
+	},
+};
+
+static struct map_desc bk3_io_desc[] __initdata = {
+	{
+		.virtual	= BK3_CPLDVER_VIRT_BASE,
+		.pfn		= __phys_to_pfn(BK3_CPLDVER_PHYS_BASE),
+		.length	= BK3_CPLDVER_SIZE,
+		.type		= MT_DEVICE,
+	}
+};
+
+static void __init bk3_map_io(void)
+{
+	ts72xx_common_map_io();
+	iotable_init(bk3_io_desc, ARRAY_SIZE(bk3_io_desc));
+}
+
+static void __init bk3_init_machine(void)
+{
+	ep93xx_init_devices();
+
+	ts72xx_register_flash(bk3_nand_parts, ARRAY_SIZE(bk3_nand_parts),
+			      EP93XX_CS6_PHYS_BASE);
+
+	ep93xx_register_eth(&ts72xx_eth_data, 1);
+
+	ep93xx_register_spi(&bk3_spi_master, bk3_spi_board_info,
+			    ARRAY_SIZE(bk3_spi_board_info));
+
+	/* Configure ep93xx's I2S to use AC97 pins */
+	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_I2SONAC97);
+	platform_device_register(&ep93xx_i2s_device);
+}
+
+MACHINE_START(BK3, "Liebherr controller BK3.1")
+	/* Maintainer: Lukasz Majewski <lukma@denx.de> */
+	.atag_offset	= 0x100,
+	.map_io	= bk3_map_io,
+	.init_irq	= ep93xx_init_irq,
+	.init_time	= ep93xx_timer_init,
+	.init_machine	= bk3_init_machine,
+	.init_late	= ep93xx_init_late,
+	.restart	= ep93xx_restart,
+MACHINE_END
diff --git a/arch/arm/mach-ep93xx/ts72xx.h b/arch/arm/mach-ep93xx/ts72xx.h
index 7b7490f10fa9..61410faa3785 100644
--- a/arch/arm/mach-ep93xx/ts72xx.h
+++ b/arch/arm/mach-ep93xx/ts72xx.h
@@ -42,6 +42,11 @@
 #define TS72XX_OPTIONS2_TS9420		0x04
 #define TS72XX_OPTIONS2_TS9420_BOOT	0x02
 
+/* BK3 specific defines */
+#define BK3_CPLDVER_PHYS_BASE		0x23400000
+#define BK3_CPLDVER_VIRT_BASE		0xfebfd000
+#define BK3_CPLDVER_SIZE		0x00001000
+
 #ifndef __ASSEMBLY__
 
 static inline int ts72xx_model(void)
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index a9313b66f770..4eac94c1eb6f 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -345,6 +345,7 @@ mxlads			MACH_MXLADS		MXLADS			1851
 linkstation_mini	MACH_LINKSTATION_MINI	LINKSTATION_MINI	1858
 afeb9260		MACH_AFEB9260		AFEB9260		1859
 imx27ipcam		MACH_IMX27IPCAM		IMX27IPCAM		1871
+bk3			MACH_BK3		BK3			1880
 rd88f6183ap_ge		MACH_RD88F6183AP_GE	RD88F6183AP_GE		1894
 realview_pba8		MACH_REALVIEW_PBA8	REALVIEW_PBA8		1897
 realview_pbx		MACH_REALVIEW_PBX	REALVIEW_PBX		1901
-- 
2.11.0
