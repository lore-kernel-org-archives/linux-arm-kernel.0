From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 23 Mar 2011 11:05:00 +0100
Subject: [PATCH 4/6] mach-ux500: force PrimeCell revisions
Message-ID: <1300874700-14814-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The DB8500v2 and DB5500 has a fifth version of the "PL023" and
PL180 blocks. However the ASIC engineers have forgot to bump the
revision in the PrimeCell peripheral ID registers. Since the
platform is aware of the actual silicon revision we need to
hard-code the periphid from the platform, bumping the subrevision
field to 1.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |   16 ++++++++++++----
 arch/arm/mach-ux500/devices-common.h   |   10 ++++++----
 arch/arm/mach-ux500/devices-db5500.h   |   28 +++++++++++++++++++---------
 arch/arm/mach-ux500/devices-db8500.h   |   32 ++++++++++++++++----------------
 4 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index bf0b024..7c6cb4f 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -99,8 +99,11 @@ static void sdi0_configure(void)
 	gpio_direction_output(sdi0_vsel, 0);
 	gpio_direction_output(sdi0_en, 1);
 
-	/* Add the device */
-	db8500_add_sdi0(&mop500_sdi0_data);
+	/* Add the device, force v2 to subrevision 1 */
+	if (cpu_is_u8500v2())
+		db8500_add_sdi0(&mop500_sdi0_data, 0x10480180);
+	else
+		db8500_add_sdi0(&mop500_sdi0_data, 0);
 }
 
 void mop500_sdi_tc35892_init(void)
@@ -188,13 +191,18 @@ static struct mmci_platform_data mop500_sdi4_data = {
 
 void __init mop500_sdi_init(void)
 {
+	u32 periphid = 0;
+
+	/* v2 has a new version of this block that need to be forced */
+	if (cpu_is_u8500v2())
+		periphid = 0x10480180;
 	/* PoP:ed eMMC on top of DB8500 v1.0 has problems with high speed */
 	if (!cpu_is_u8500v10())
 		mop500_sdi2_data.capabilities |= MMC_CAP_MMC_HIGHSPEED;
-	db8500_add_sdi2(&mop500_sdi2_data);
+	db8500_add_sdi2(&mop500_sdi2_data, periphid);
 
 	/* On-board eMMC */
-	db8500_add_sdi4(&mop500_sdi4_data);
+	db8500_add_sdi4(&mop500_sdi4_data, periphid);
 
 	if (machine_is_hrefv60()) {
 		mop500_sdi0_data.gpio_cd = HREFV60_SDMMC_CD_GPIO;
diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
index c719b5a1..7825705 100644
--- a/arch/arm/mach-ux500/devices-common.h
+++ b/arch/arm/mach-ux500/devices-common.h
@@ -28,18 +28,20 @@ dbx500_add_msp_spi(const char *name, resource_size_t base, int irq,
 
 static inline struct amba_device *
 dbx500_add_spi(const char *name, resource_size_t base, int irq,
-				   struct spi_master_cntlr *pdata)
+	       struct spi_master_cntlr *pdata,
+	       u32 periphid)
 {
-	return dbx500_add_amba_device(name, base, irq, pdata, 0);
+	return dbx500_add_amba_device(name, base, irq, pdata, periphid);
 }
 
 struct mmci_platform_data;
 
 static inline struct amba_device *
 dbx500_add_sdi(const char *name, resource_size_t base, int irq,
-	       struct mmci_platform_data *pdata)
+	       struct mmci_platform_data *pdata,
+	       u32 periphid)
 {
-	return dbx500_add_amba_device(name, base, irq, pdata, 0);
+	return dbx500_add_amba_device(name, base, irq, pdata, periphid);
 }
 
 struct amba_pl011_data;
diff --git a/arch/arm/mach-ux500/devices-db5500.h b/arch/arm/mach-ux500/devices-db5500.h
index 94627f7..0c4bccd 100644
--- a/arch/arm/mach-ux500/devices-db5500.h
+++ b/arch/arm/mach-ux500/devices-db5500.h
@@ -38,24 +38,34 @@
 	ux500_add_usb(U5500_USBOTG_BASE, IRQ_DB5500_USBOTG, rx_cfg, tx_cfg)
 
 #define db5500_add_sdi0(pdata) \
-	dbx500_add_sdi("sdi0", U5500_SDI0_BASE, IRQ_DB5500_SDMMC0, pdata)
+	dbx500_add_sdi("sdi0", U5500_SDI0_BASE, IRQ_DB5500_SDMMC0, pdata, \
+		       0x10480180)
 #define db5500_add_sdi1(pdata) \
-	dbx500_add_sdi("sdi1", U5500_SDI1_BASE, IRQ_DB5500_SDMMC1, pdata)
+	dbx500_add_sdi("sdi1", U5500_SDI1_BASE, IRQ_DB5500_SDMMC1, pdata, \
+		       0x10480180)
 #define db5500_add_sdi2(pdata) \
-	dbx500_add_sdi("sdi2", U5500_SDI2_BASE, IRQ_DB5500_SDMMC2, pdata)
+	dbx500_add_sdi("sdi2", U5500_SDI2_BASE, IRQ_DB5500_SDMMC2, pdata \
+		       0x10480180)
 #define db5500_add_sdi3(pdata) \
-	dbx500_add_sdi("sdi3", U5500_SDI3_BASE, IRQ_DB5500_SDMMC3, pdata)
+	dbx500_add_sdi("sdi3", U5500_SDI3_BASE, IRQ_DB5500_SDMMC3, pdata \
+		       0x10480180)
 #define db5500_add_sdi4(pdata) \
-	dbx500_add_sdi("sdi4", U5500_SDI4_BASE, IRQ_DB5500_SDMMC4, pdata)
+	dbx500_add_sdi("sdi4", U5500_SDI4_BASE, IRQ_DB5500_SDMMC4, pdata \
+		       0x10480180)
 
+/* This one has a bad peripheral ID in the U5500 silicon */
 #define db5500_add_spi0(pdata) \
-	dbx500_add_spi("spi0", U5500_SPI0_BASE, IRQ_DB5500_SPI0, pdata)
+	dbx500_add_spi("spi0", U5500_SPI0_BASE, IRQ_DB5500_SPI0, pdata, \
+		       0x10080023)
 #define db5500_add_spi1(pdata) \
-	dbx500_add_spi("spi1", U5500_SPI1_BASE, IRQ_DB5500_SPI1, pdata)
+	dbx500_add_spi("spi1", U5500_SPI1_BASE, IRQ_DB5500_SPI1, pdata, \
+		       0x10080023)
 #define db5500_add_spi2(pdata) \
-	dbx500_add_spi("spi2", U5500_SPI2_BASE, IRQ_DB5500_SPI2, pdata)
+	dbx500_add_spi("spi2", U5500_SPI2_BASE, IRQ_DB5500_SPI2, pdata \
+		       0x10080023)
 #define db5500_add_spi3(pdata) \
-	dbx500_add_spi("spi3", U5500_SPI3_BASE, IRQ_DB5500_SPI3, pdata)
+	dbx500_add_spi("spi3", U5500_SPI3_BASE, IRQ_DB5500_SPI3, pdata \
+		       0x10080023)
 
 #define db5500_add_uart0(plat) \
 	dbx500_add_uart("uart0", U5500_UART0_BASE, IRQ_DB5500_UART0, plat)
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index e341ad0..cbd4a9a 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -64,18 +64,18 @@ db8500_add_ssp(const char *name, resource_size_t base, int irq,
 #define db8500_add_usb(rx_cfg, tx_cfg) \
 	ux500_add_usb(U8500_USBOTG_BASE, IRQ_DB8500_USBOTG, rx_cfg, tx_cfg)
 
-#define db8500_add_sdi0(pdata) \
-	dbx500_add_sdi("sdi0", U8500_SDI0_BASE, IRQ_DB8500_SDMMC0, pdata)
-#define db8500_add_sdi1(pdata) \
-	dbx500_add_sdi("sdi1", U8500_SDI1_BASE, IRQ_DB8500_SDMMC1, pdata)
-#define db8500_add_sdi2(pdata) \
-	dbx500_add_sdi("sdi2", U8500_SDI2_BASE, IRQ_DB8500_SDMMC2, pdata)
-#define db8500_add_sdi3(pdata) \
-	dbx500_add_sdi("sdi3", U8500_SDI3_BASE, IRQ_DB8500_SDMMC3, pdata)
-#define db8500_add_sdi4(pdata) \
-	dbx500_add_sdi("sdi4", U8500_SDI4_BASE, IRQ_DB8500_SDMMC4, pdata)
-#define db8500_add_sdi5(pdata) \
-	dbx500_add_sdi("sdi5", U8500_SDI5_BASE, IRQ_DB8500_SDMMC5, pdata)
+#define db8500_add_sdi0(pdata, pid) \
+	dbx500_add_sdi("sdi0", U8500_SDI0_BASE, IRQ_DB8500_SDMMC0, pdata, pid)
+#define db8500_add_sdi1(pdata, pid) \
+	dbx500_add_sdi("sdi1", U8500_SDI1_BASE, IRQ_DB8500_SDMMC1, pdata, pid)
+#define db8500_add_sdi2(pdata, pid) \
+	dbx500_add_sdi("sdi2", U8500_SDI2_BASE, IRQ_DB8500_SDMMC2, pdata, pid)
+#define db8500_add_sdi3(pdata, pid) \
+	dbx500_add_sdi("sdi3", U8500_SDI3_BASE, IRQ_DB8500_SDMMC3, pdata, pid)
+#define db8500_add_sdi4(pdata, pid) \
+	dbx500_add_sdi("sdi4", U8500_SDI4_BASE, IRQ_DB8500_SDMMC4, pdata, pid)
+#define db8500_add_sdi5(pdata, pid) \
+	dbx500_add_sdi("sdi5", U8500_SDI5_BASE, IRQ_DB8500_SDMMC5, pdata, pid)
 
 #define db8500_add_ssp0(pdata) \
 	db8500_add_ssp("ssp0", U8500_SSP0_BASE, IRQ_DB8500_SSP0, pdata)
@@ -83,13 +83,13 @@ db8500_add_ssp(const char *name, resource_size_t base, int irq,
 	db8500_add_ssp("ssp1", U8500_SSP1_BASE, IRQ_DB8500_SSP1, pdata)
 
 #define db8500_add_spi0(pdata) \
-	dbx500_add_spi("spi0", U8500_SPI0_BASE, IRQ_DB8500_SPI0, pdata)
+	dbx500_add_spi("spi0", U8500_SPI0_BASE, IRQ_DB8500_SPI0, pdata, 0)
 #define db8500_add_spi1(pdata) \
-	dbx500_add_spi("spi1", U8500_SPI1_BASE, IRQ_DB8500_SPI1, pdata)
+	dbx500_add_spi("spi1", U8500_SPI1_BASE, IRQ_DB8500_SPI1, pdata, 0)
 #define db8500_add_spi2(pdata) \
-	dbx500_add_spi("spi2", U8500_SPI2_BASE, IRQ_DB8500_SPI2, pdata)
+	dbx500_add_spi("spi2", U8500_SPI2_BASE, IRQ_DB8500_SPI2, pdata, 0)
 #define db8500_add_spi3(pdata) \
-	dbx500_add_spi("spi3", U8500_SPI3_BASE, IRQ_DB8500_SPI3, pdata)
+	dbx500_add_spi("spi3", U8500_SPI3_BASE, IRQ_DB8500_SPI3, pdata, 0)
 
 #define db8500_add_uart0(pdata) \
 	dbx500_add_uart("uart0", U8500_UART0_BASE, IRQ_DB8500_UART0, pdata)
-- 
1.7.3.2
