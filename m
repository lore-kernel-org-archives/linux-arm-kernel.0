From: hechtb@gmail.com (Bastian Hecht)
Date: Mon, 25 Mar 2013 14:51:43 +0100
Subject: [PATCH v2 2/2] ARM: shmobile: r8a7740: Migrate from INTC to GIC
In-Reply-To: <1364219503-7738-1-git-send-email-hechtb+renesas@gmail.com>
References: <1364219503-7738-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <1364219503-7738-2-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the added capabilty of the intc_irqpin driver to handle shared
external IRQs, all prerequisites are fulfilled and we are ready to
migrate completely to GIC. This includes the following steps:

- Kconfig:	select ARM_GIC and RENESAS_INTC_IRQPIN
- intc-r8a7740: Throw out all legacy INTC code and init the GIC. We need
  		to mask out all shared IRQs as it is needed by the
		shared intc_irqpin driver.
- setup-r8a7740: Add 4 irqpin devices to handle external IRQs and update
		all IRQ numbers to point to the GIC SPI.
- board-armadillo: Update all IRQ numbers to point to the GIC SPI.
- pfc-r8a7740:	Update all IRQ numbers of the GPIOs to point to the GIC
		SPI.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2:

New patch added to the series.

 arch/arm/mach-shmobile/Kconfig                 |    2 +
 arch/arm/mach-shmobile/board-armadillo800eva.c |   35 +-
 arch/arm/mach-shmobile/intc-r8a7740.c          |  636 +-----------------------
 arch/arm/mach-shmobile/setup-r8a7740.c         |  192 +++++--
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c           |   64 +--
 5 files changed, 235 insertions(+), 694 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index eb3a7ff..ad01bed 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -21,8 +21,10 @@ config ARCH_SH73A0
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
+	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 8004433..ac3de5e 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -148,7 +148,7 @@
  * see
  *	usbhsf_power_ctrl()
  */
-#define IRQ7		evt2irq(0x02e0)
+#define IRQ7		irq_pin(7)
 #define USBCR1		IOMEM(0xe605810a)
 #define USBH		0xC6700000
 #define USBH_USBCTR	0x10834
@@ -333,7 +333,7 @@ static struct resource usbhsf_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= evt2irq(0x0A20),
+		.start	= gic_spi(51),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -366,7 +366,7 @@ static struct resource sh_eth_resources[] = {
 		.end	= 0xe9a02000 - 1,
 		.flags	= IORESOURCE_MEM,
 	}, {
-		.start	= evt2irq(0x0500),
+		.start	= gic_spi(110),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -420,7 +420,7 @@ static struct resource lcdc0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= intcs_evt2irq(0x580),
+		.start	= gic_spi(177),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -455,7 +455,7 @@ static struct resource hdmi_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= evt2irq(0x1700),
+		.start	= gic_spi(131),
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
@@ -517,7 +517,7 @@ static struct resource hdmi_lcdc_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= intcs_evt2irq(0x1780),
+		.start	= gic_spi(178),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -654,7 +654,7 @@ static struct platform_device vccq_sdhi0 = {
  * We can use IRQ31 as card detect irq,
  * but it needs chattering removal operation
  */
-#define IRQ31	evt2irq(0x33E0)
+#define IRQ31	irq_pin(31)
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
@@ -675,12 +675,12 @@ static struct resource sdhi0_resources[] = {
 	 */
 	{
 		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
-		.start	= evt2irq(0x0E20),
+		.start	= gic_spi(118),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
-		.start	= evt2irq(0x0E40),
+		.start	= gic_spi(119),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -713,15 +713,15 @@ static struct resource sdhi1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= evt2irq(0x0E80),
+		.start	= gic_spi(121),
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
-		.start	= evt2irq(0x0EA0),
+		.start	= gic_spi(122),
 		.flags	= IORESOURCE_IRQ,
 	},
 	[3] = {
-		.start	= evt2irq(0x0EC0),
+		.start	= gic_spi(123),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -753,12 +753,12 @@ static struct resource sh_mmcif_resources[] = {
 	},
 	[1] = {
 		/* MMC ERR */
-		.start	= evt2irq(0x1AC0),
+		.start	= gic_spi(56),
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
 		/* MMC NOR */
-		.start	= evt2irq(0x1AE0),
+		.start	= gic_spi(57),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -835,7 +835,7 @@ static struct resource ceu0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = intcs_evt2irq(0x0500),
+		.start  = gic_spi(160),
 		.flags  = IORESOURCE_IRQ,
 	},
 	[2] = {
@@ -877,7 +877,7 @@ static struct resource fsi_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = evt2irq(0x1840),
+		.start  = gic_spi(9),
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -960,7 +960,7 @@ static struct platform_device i2c_gpio_device = {
 static struct i2c_board_info i2c0_devices[] = {
 	{
 		I2C_BOARD_INFO("st1232-ts", 0x55),
-		.irq = evt2irq(0x0340),
+		.irq = irq_pin(10),
 	},
 	{
 		I2C_BOARD_INFO("wm8978", 0x1a),
@@ -1264,7 +1264,6 @@ DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva")
 	.map_io		= r8a7740_map_io,
 	.init_early	= eva_add_early_devices,
 	.init_irq	= r8a7740_init_irq,
-	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= eva_init,
 	.init_late	= shmobile_init_late,
 	.init_time	= eva_earlytimer_init,
diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c b/arch/arm/mach-shmobile/intc-r8a7740.c
index 9a69a31..1ceafc1 100644
--- a/arch/arm/mach-shmobile/intc-r8a7740.c
+++ b/arch/arm/mach-shmobile/intc-r8a7740.c
@@ -18,620 +18,36 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/io.h>
-#include <linux/sh_intc.h>
-#include <mach/intc.h>
-#include <mach/irqs.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
+#include <linux/irqchip/arm-gic.h>
 
-/*
- *		INTCA
- */
-enum {
-	UNUSED_INTCA = 0,
-
-	/* interrupt sources INTCA */
-	DIRC,
-	ATAPI,
-	IIC1_ALI, IIC1_TACKI, IIC1_WAITI, IIC1_DTEI,
-	AP_ARM_COMMTX, AP_ARM_COMMRX,
-	MFI, MFIS,
-	BBIF1, BBIF2,
-	USBHSDMAC,
-	USBF_OUL_SOF, USBF_IXL_INT,
-	SGX540,
-	CMT1_0, CMT1_1, CMT1_2, CMT1_3,
-	CMT2,
-	CMT3,
-	KEYSC,
-	SCIFA0, SCIFA1, SCIFA2, SCIFA3,
-	MSIOF2, MSIOF1,
-	SCIFA4, SCIFA5, SCIFB,
-	FLCTL_FLSTEI, FLCTL_FLTENDI, FLCTL_FLTREQ0I, FLCTL_FLTREQ1I,
-	SDHI0_0, SDHI0_1, SDHI0_2, SDHI0_3,
-	SDHI1_0, SDHI1_1, SDHI1_2, SDHI1_3,
-	AP_ARM_L2CINT,
-	IRDA,
-	TPU0,
-	SCIFA6, SCIFA7,
-	GbEther,
-	ICBS0,
-	DDM,
-	SDHI2_0, SDHI2_1, SDHI2_2, SDHI2_3,
-	RWDT0,
-	DMAC1_1_DEI0, DMAC1_1_DEI1, DMAC1_1_DEI2, DMAC1_1_DEI3,
-	DMAC1_2_DEI4, DMAC1_2_DEI5, DMAC1_2_DADERR,
-	DMAC2_1_DEI0, DMAC2_1_DEI1, DMAC2_1_DEI2, DMAC2_1_DEI3,
-	DMAC2_2_DEI4, DMAC2_2_DEI5, DMAC2_2_DADERR,
-	DMAC3_1_DEI0, DMAC3_1_DEI1, DMAC3_1_DEI2, DMAC3_1_DEI3,
-	DMAC3_2_DEI4, DMAC3_2_DEI5, DMAC3_2_DADERR,
-	SHWYSTAT_RT, SHWYSTAT_HS, SHWYSTAT_COM,
-	HDMI,
-	USBH_INT, USBH_OHCI, USBH_EHCI, USBH_PME, USBH_BIND,
-	RSPI_OVRF, RSPI_SPTEF, RSPI_SPRF,
-	SPU2_0, SPU2_1,
-	FSI, FMSI,
-	HDMI_SSS, HDMI_KEY,
-	IPMMU,
-	AP_ARM_CTIIRQ, AP_ARM_PMURQ,
-	MFIS2,
-	CPORTR2S,
-	CMT14, CMT15,
-	MMCIF_0, MMCIF_1, MMCIF_2,
-	SIM_ERI, SIM_RXI, SIM_TXI, SIM_TEI,
-	STPRO_0, STPRO_1, STPRO_2, STPRO_3, STPRO_4,
-
-	/* interrupt groups INTCA */
-	DMAC1_1, DMAC1_2,
-	DMAC2_1, DMAC2_2,
-	DMAC3_1, DMAC3_2,
-	AP_ARM1, AP_ARM2,
-	SDHI0, SDHI1, SDHI2,
-	SHWYSTAT,
-	USBF, USBH1, USBH2,
-	RSPI, SPU2, FLCTL, IIC1,
-};
-
-static struct intc_vect intca_vectors[] __initdata = {
-	INTC_VECT(DIRC,			0x0560),
-	INTC_VECT(ATAPI,		0x05E0),
-	INTC_VECT(IIC1_ALI,		0x0780),
-	INTC_VECT(IIC1_TACKI,		0x07A0),
-	INTC_VECT(IIC1_WAITI,		0x07C0),
-	INTC_VECT(IIC1_DTEI,		0x07E0),
-	INTC_VECT(AP_ARM_COMMTX,	0x0840),
-	INTC_VECT(AP_ARM_COMMRX,	0x0860),
-	INTC_VECT(MFI,			0x0900),
-	INTC_VECT(MFIS,			0x0920),
-	INTC_VECT(BBIF1,		0x0940),
-	INTC_VECT(BBIF2,		0x0960),
-	INTC_VECT(USBHSDMAC,		0x0A00),
-	INTC_VECT(USBF_OUL_SOF,		0x0A20),
-	INTC_VECT(USBF_IXL_INT,		0x0A40),
-	INTC_VECT(SGX540,		0x0A60),
-	INTC_VECT(CMT1_0,		0x0B00),
-	INTC_VECT(CMT1_1,		0x0B20),
-	INTC_VECT(CMT1_2,		0x0B40),
-	INTC_VECT(CMT1_3,		0x0B60),
-	INTC_VECT(CMT2,			0x0B80),
-	INTC_VECT(CMT3,			0x0BA0),
-	INTC_VECT(KEYSC,		0x0BE0),
-	INTC_VECT(SCIFA0,		0x0C00),
-	INTC_VECT(SCIFA1,		0x0C20),
-	INTC_VECT(SCIFA2,		0x0C40),
-	INTC_VECT(SCIFA3,		0x0C60),
-	INTC_VECT(MSIOF2,		0x0C80),
-	INTC_VECT(MSIOF1,		0x0D00),
-	INTC_VECT(SCIFA4,		0x0D20),
-	INTC_VECT(SCIFA5,		0x0D40),
-	INTC_VECT(SCIFB,		0x0D60),
-	INTC_VECT(FLCTL_FLSTEI,		0x0D80),
-	INTC_VECT(FLCTL_FLTENDI,	0x0DA0),
-	INTC_VECT(FLCTL_FLTREQ0I,	0x0DC0),
-	INTC_VECT(FLCTL_FLTREQ1I,	0x0DE0),
-	INTC_VECT(SDHI0_0,		0x0E00),
-	INTC_VECT(SDHI0_1,		0x0E20),
-	INTC_VECT(SDHI0_2,		0x0E40),
-	INTC_VECT(SDHI0_3,		0x0E60),
-	INTC_VECT(SDHI1_0,		0x0E80),
-	INTC_VECT(SDHI1_1,		0x0EA0),
-	INTC_VECT(SDHI1_2,		0x0EC0),
-	INTC_VECT(SDHI1_3,		0x0EE0),
-	INTC_VECT(AP_ARM_L2CINT,	0x0FA0),
-	INTC_VECT(IRDA,			0x0480),
-	INTC_VECT(TPU0,			0x04A0),
-	INTC_VECT(SCIFA6,		0x04C0),
-	INTC_VECT(SCIFA7,		0x04E0),
-	INTC_VECT(GbEther,		0x0500),
-	INTC_VECT(ICBS0,		0x0540),
-	INTC_VECT(DDM,			0x1140),
-	INTC_VECT(SDHI2_0,		0x1200),
-	INTC_VECT(SDHI2_1,		0x1220),
-	INTC_VECT(SDHI2_2,		0x1240),
-	INTC_VECT(SDHI2_3,		0x1260),
-	INTC_VECT(RWDT0,		0x1280),
-	INTC_VECT(DMAC1_1_DEI0,		0x2000),
-	INTC_VECT(DMAC1_1_DEI1,		0x2020),
-	INTC_VECT(DMAC1_1_DEI2,		0x2040),
-	INTC_VECT(DMAC1_1_DEI3,		0x2060),
-	INTC_VECT(DMAC1_2_DEI4,		0x2080),
-	INTC_VECT(DMAC1_2_DEI5,		0x20A0),
-	INTC_VECT(DMAC1_2_DADERR,	0x20C0),
-	INTC_VECT(DMAC2_1_DEI0,		0x2100),
-	INTC_VECT(DMAC2_1_DEI1,		0x2120),
-	INTC_VECT(DMAC2_1_DEI2,		0x2140),
-	INTC_VECT(DMAC2_1_DEI3,		0x2160),
-	INTC_VECT(DMAC2_2_DEI4,		0x2180),
-	INTC_VECT(DMAC2_2_DEI5,		0x21A0),
-	INTC_VECT(DMAC2_2_DADERR,	0x21C0),
-	INTC_VECT(DMAC3_1_DEI0,		0x2200),
-	INTC_VECT(DMAC3_1_DEI1,		0x2220),
-	INTC_VECT(DMAC3_1_DEI2,		0x2240),
-	INTC_VECT(DMAC3_1_DEI3,		0x2260),
-	INTC_VECT(DMAC3_2_DEI4,		0x2280),
-	INTC_VECT(DMAC3_2_DEI5,		0x22A0),
-	INTC_VECT(DMAC3_2_DADERR,	0x22C0),
-	INTC_VECT(SHWYSTAT_RT,		0x1300),
-	INTC_VECT(SHWYSTAT_HS,		0x1320),
-	INTC_VECT(SHWYSTAT_COM,		0x1340),
-	INTC_VECT(USBH_INT,		0x1540),
-	INTC_VECT(USBH_OHCI,		0x1560),
-	INTC_VECT(USBH_EHCI,		0x1580),
-	INTC_VECT(USBH_PME,		0x15A0),
-	INTC_VECT(USBH_BIND,		0x15C0),
-	INTC_VECT(HDMI,			0x1700),
-	INTC_VECT(RSPI_OVRF,		0x1780),
-	INTC_VECT(RSPI_SPTEF,		0x17A0),
-	INTC_VECT(RSPI_SPRF,		0x17C0),
-	INTC_VECT(SPU2_0,		0x1800),
-	INTC_VECT(SPU2_1,		0x1820),
-	INTC_VECT(FSI,			0x1840),
-	INTC_VECT(FMSI,			0x1860),
-	INTC_VECT(HDMI_SSS,		0x18A0),
-	INTC_VECT(HDMI_KEY,		0x18C0),
-	INTC_VECT(IPMMU,		0x1920),
-	INTC_VECT(AP_ARM_CTIIRQ,	0x1980),
-	INTC_VECT(AP_ARM_PMURQ,		0x19A0),
-	INTC_VECT(MFIS2,		0x1A00),
-	INTC_VECT(CPORTR2S,		0x1A20),
-	INTC_VECT(CMT14,		0x1A40),
-	INTC_VECT(CMT15,		0x1A60),
-	INTC_VECT(MMCIF_0,		0x1AA0),
-	INTC_VECT(MMCIF_1,		0x1AC0),
-	INTC_VECT(MMCIF_2,		0x1AE0),
-	INTC_VECT(SIM_ERI,		0x1C00),
-	INTC_VECT(SIM_RXI,		0x1C20),
-	INTC_VECT(SIM_TXI,		0x1C40),
-	INTC_VECT(SIM_TEI,		0x1C60),
-	INTC_VECT(STPRO_0,		0x1C80),
-	INTC_VECT(STPRO_1,		0x1CA0),
-	INTC_VECT(STPRO_2,		0x1CC0),
-	INTC_VECT(STPRO_3,		0x1CE0),
-	INTC_VECT(STPRO_4,		0x1D00),
-};
-
-static struct intc_group intca_groups[] __initdata = {
-	INTC_GROUP(DMAC1_1,
-		   DMAC1_1_DEI0, DMAC1_1_DEI1, DMAC1_1_DEI2, DMAC1_1_DEI3),
-	INTC_GROUP(DMAC1_2,
-		   DMAC1_2_DEI4, DMAC1_2_DEI5, DMAC1_2_DADERR),
-	INTC_GROUP(DMAC2_1,
-		   DMAC2_1_DEI0, DMAC2_1_DEI1, DMAC2_1_DEI2, DMAC2_1_DEI3),
-	INTC_GROUP(DMAC2_2,
-		   DMAC2_2_DEI4, DMAC2_2_DEI5, DMAC2_2_DADERR),
-	INTC_GROUP(DMAC3_1,
-		   DMAC3_1_DEI0, DMAC3_1_DEI1, DMAC3_1_DEI2, DMAC3_1_DEI3),
-	INTC_GROUP(DMAC3_2,
-		   DMAC3_2_DEI4, DMAC3_2_DEI5, DMAC3_2_DADERR),
-	INTC_GROUP(AP_ARM1,
-		   AP_ARM_COMMTX, AP_ARM_COMMRX),
-	INTC_GROUP(AP_ARM2,
-		   AP_ARM_CTIIRQ, AP_ARM_PMURQ),
-	INTC_GROUP(USBF,
-		   USBF_OUL_SOF, USBF_IXL_INT),
-	INTC_GROUP(SDHI0,
-		   SDHI0_0, SDHI0_1, SDHI0_2, SDHI0_3),
-	INTC_GROUP(SDHI1,
-		   SDHI1_0, SDHI1_1, SDHI1_2, SDHI1_3),
-	INTC_GROUP(SDHI2,
-		   SDHI2_0, SDHI2_1, SDHI2_2, SDHI2_3),
-	INTC_GROUP(SHWYSTAT,
-		   SHWYSTAT_RT, SHWYSTAT_HS, SHWYSTAT_COM),
-	INTC_GROUP(USBH1, /* FIXME */
-		   USBH_INT, USBH_OHCI),
-	INTC_GROUP(USBH2, /* FIXME */
-		   USBH_EHCI,
-		   USBH_PME, USBH_BIND),
-	INTC_GROUP(RSPI,
-		   RSPI_OVRF, RSPI_SPTEF, RSPI_SPRF),
-	INTC_GROUP(SPU2,
-		   SPU2_0, SPU2_1),
-	INTC_GROUP(FLCTL,
-		   FLCTL_FLSTEI, FLCTL_FLTENDI, FLCTL_FLTREQ0I, FLCTL_FLTREQ1I),
-	INTC_GROUP(IIC1,
-		   IIC1_ALI, IIC1_TACKI, IIC1_WAITI, IIC1_DTEI),
-};
-
-static struct intc_mask_reg intca_mask_registers[] __initdata = {
-	{ /* IMR0A / IMCR0A */ 0xe6940080, 0xe69400c0, 8,
-	  { DMAC2_1_DEI3, DMAC2_1_DEI2, DMAC2_1_DEI1, DMAC2_1_DEI0,
-	    0, 0, AP_ARM_COMMTX, AP_ARM_COMMRX } },
-	{ /* IMR1A / IMCR1A */ 0xe6940084, 0xe69400c4, 8,
-	  { ATAPI, 0, DIRC, 0,
-	    DMAC1_1_DEI3, DMAC1_1_DEI2, DMAC1_1_DEI1, DMAC1_1_DEI0 } },
-	{ /* IMR2A / IMCR2A */ 0xe6940088, 0xe69400c8, 8,
-	  { 0, 0, 0, 0,
-	    BBIF1, BBIF2, MFIS, MFI } },
-	{ /* IMR3A / IMCR3A */ 0xe694008c, 0xe69400cc, 8,
-	  { DMAC3_1_DEI3, DMAC3_1_DEI2, DMAC3_1_DEI1, DMAC3_1_DEI0,
-	    DMAC3_2_DADERR, DMAC3_2_DEI5, DMAC3_2_DEI4, IRDA } },
-	{ /* IMR4A / IMCR4A */ 0xe6940090, 0xe69400d0, 8,
-	  { DDM, 0, 0, 0,
-	    0, 0, 0, 0 } },
-	{ /* IMR5A / IMCR5A */ 0xe6940094, 0xe69400d4, 8,
-	  { KEYSC, DMAC1_2_DADERR, DMAC1_2_DEI5, DMAC1_2_DEI4,
-	    SCIFA3, SCIFA2, SCIFA1, SCIFA0 } },
-	{ /* IMR6A / IMCR6A */ 0xe6940098, 0xe69400d8, 8,
-	  { SCIFB, SCIFA5, SCIFA4, MSIOF1,
-	    0, 0, MSIOF2, 0 } },
-	{ /* IMR7A / IMCR7A */ 0xe694009c, 0xe69400dc, 8,
-	  { SDHI0_3, SDHI0_2, SDHI0_1, SDHI0_0,
-	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLTENDI, FLCTL_FLSTEI } },
-	{ /* IMR8A / IMCR8A */ 0xe69400a0, 0xe69400e0, 8,
-	  { SDHI1_3, SDHI1_2, SDHI1_1, SDHI1_0,
-	    0, USBHSDMAC, 0, AP_ARM_L2CINT } },
-	{ /* IMR9A / IMCR9A */ 0xe69400a4, 0xe69400e4, 8,
-	  { CMT1_3, CMT1_2, CMT1_1, CMT1_0,
-	    CMT2, USBF_IXL_INT, USBF_OUL_SOF, SGX540 } },
-	{ /* IMR10A / IMCR10A */ 0xe69400a8, 0xe69400e8, 8,
-	  { 0, DMAC2_2_DADERR, DMAC2_2_DEI5, DMAC2_2_DEI4,
-	    0, 0, 0, 0 } },
-	{ /* IMR11A / IMCR11A */ 0xe69400ac, 0xe69400ec, 8,
-	  { IIC1_DTEI, IIC1_WAITI, IIC1_TACKI, IIC1_ALI,
-	    ICBS0, 0, 0, 0 } },
-	{ /* IMR12A / IMCR12A */ 0xe69400b0, 0xe69400f0, 8,
-	  { 0, 0, TPU0, SCIFA6,
-	    SCIFA7, GbEther, 0, 0 } },
-	{ /* IMR13A / IMCR13A */ 0xe69400b4, 0xe69400f4, 8,
-	  { SDHI2_3, SDHI2_2, SDHI2_1, SDHI2_0,
-	    0, CMT3, 0, RWDT0 } },
-	{ /* IMR0A3 / IMCR0A3 */ 0xe6950080, 0xe69500c0, 8,
-	  { SHWYSTAT_RT, SHWYSTAT_HS, SHWYSTAT_COM, 0,
-	    0, 0, 0, 0 } },
-	  /* IMR1A3 / IMCR1A3 */
-	{ /* IMR2A3 / IMCR2A3 */ 0xe6950088, 0xe69500c8, 8,
-	  { 0, 0, USBH_INT, USBH_OHCI,
-	    USBH_EHCI, USBH_PME, USBH_BIND, 0 } },
-	  /* IMR3A3 / IMCR3A3 */
-	{ /* IMR4A3 / IMCR4A3 */ 0xe6950090, 0xe69500d0, 8,
-	  { HDMI, 0, 0, 0,
-	    RSPI_OVRF, RSPI_SPTEF, RSPI_SPRF, 0 } },
-	{ /* IMR5A3 / IMCR5A3 */ 0xe6950094, 0xe69500d4, 8,
-	  { SPU2_0, SPU2_1, FSI, FMSI,
-	    0, HDMI_SSS, HDMI_KEY, 0 } },
-	{ /* IMR6A3 / IMCR6A3 */ 0xe6950098, 0xe69500d8, 8,
-	  { 0, IPMMU, 0, 0,
-	    AP_ARM_CTIIRQ, AP_ARM_PMURQ, 0, 0 } },
-	{ /* IMR7A3 / IMCR7A3 */ 0xe695009c, 0xe69500dc, 8,
-	  { MFIS2, CPORTR2S, CMT14, CMT15,
-	    0, MMCIF_0, MMCIF_1, MMCIF_2 } },
-	  /* IMR8A3 / IMCR8A3 */
-	{ /* IMR9A3 / IMCR9A3 */ 0xe69500a4, 0xe69500e4, 8,
-	  { SIM_ERI, SIM_RXI, SIM_TXI, SIM_TEI,
-	    STPRO_0, STPRO_1, STPRO_2, STPRO_3 } },
-	{ /* IMR10A3 / IMCR10A3 */ 0xe69500a8, 0xe69500e8, 8,
-	  { STPRO_4, 0, 0, 0,
-	    0, 0, 0, 0 } },
-};
-
-static struct intc_prio_reg intca_prio_registers[] __initdata = {
-	{ 0xe6940000, 0, 16, 4, /* IPRAA */ { DMAC3_1, DMAC3_2, CMT2, ICBS0 } },
-	{ 0xe6940004, 0, 16, 4, /* IPRBA */ { IRDA, 0, BBIF1, BBIF2 } },
-	{ 0xe6940008, 0, 16, 4, /* IPRCA */ { ATAPI, 0, CMT1_1, AP_ARM1 } },
-	{ 0xe694000c, 0, 16, 4, /* IPRDA */ { 0, 0, CMT1_2, 0 } },
-	{ 0xe6940010, 0, 16, 4, /* IPREA */ { DMAC1_1, MFIS, MFI, USBF } },
-	{ 0xe6940014, 0, 16, 4, /* IPRFA */ { KEYSC, DMAC1_2,
-					      SGX540, CMT1_0 } },
-	{ 0xe6940018, 0, 16, 4, /* IPRGA */ { SCIFA0, SCIFA1,
-					      SCIFA2, SCIFA3 } },
-	{ 0xe694001c, 0, 16, 4, /* IPRGH */ { MSIOF2, USBHSDMAC,
-					      FLCTL, SDHI0 } },
-	{ 0xe6940020, 0, 16, 4, /* IPRIA */ { MSIOF1, SCIFA4, 0, IIC1 } },
-	{ 0xe6940024, 0, 16, 4, /* IPRJA */ { DMAC2_1, DMAC2_2,
-					      AP_ARM_L2CINT, 0 } },
-	{ 0xe6940028, 0, 16, 4, /* IPRKA */ { 0, CMT1_3, 0, SDHI1 } },
-	{ 0xe694002c, 0, 16, 4, /* IPRLA */ { TPU0, SCIFA6,
-					      SCIFA7, GbEther } },
-	{ 0xe6940030, 0, 16, 4, /* IPRMA */ { 0, CMT3, 0, RWDT0 } },
-	{ 0xe6940034, 0, 16, 4, /* IPRNA */ { SCIFB, SCIFA5, 0, DDM } },
-	{ 0xe6940038, 0, 16, 4, /* IPROA */ { 0, 0, DIRC, SDHI2 } },
-	{ 0xe6950000, 0, 16, 4, /* IPRAA3 */ { SHWYSTAT, 0, 0, 0 } },
-				/* IPRBA3 */
-				/* IPRCA3 */
-				/* IPRDA3 */
-	{ 0xe6950010, 0, 16, 4, /* IPREA3 */ { USBH1, 0, 0, 0 } },
-	{ 0xe6950014, 0, 16, 4, /* IPRFA3 */ { USBH2, 0, 0, 0 } },
-				/* IPRGA3 */
-				/* IPRHA3 */
-	{ 0xe6950020, 0, 16, 4, /* IPRIA3 */ { HDMI, 0, 0, 0 } },
-	{ 0xe6950024, 0, 16, 4, /* IPRJA3 */ { RSPI, 0, 0, 0 } },
-	{ 0xe6950028, 0, 16, 4, /* IPRKA3 */ { SPU2, 0, FSI, FMSI } },
-	{ 0xe695002c, 0, 16, 4, /* IPRLA3 */ { 0, HDMI_SSS, HDMI_KEY, 0 } },
-	{ 0xe6950030, 0, 16, 4, /* IPRMA3 */ { IPMMU, 0, 0, 0 } },
-	{ 0xe6950034, 0, 16, 4, /* IPRNA3 */ { AP_ARM2, 0, 0, 0 } },
-	{ 0xe6950038, 0, 16, 4, /* IPROA3 */ { MFIS2, CPORTR2S,
-					       CMT14, CMT15 } },
-	{ 0xe695003c, 0, 16, 4, /* IPRPA3 */ { 0, MMCIF_0, MMCIF_1, MMCIF_2 } },
-				/* IPRQA3 */
-				/* IPRRA3 */
-	{ 0xe6950048, 0, 16, 4, /* IPRSA3 */ { SIM_ERI, SIM_RXI,
-					       SIM_TXI, SIM_TEI } },
-	{ 0xe695004c, 0, 16, 4, /* IPRTA3 */ { STPRO_0, STPRO_1,
-					       STPRO_2, STPRO_3 } },
-	{ 0xe6950050, 0, 16, 4, /* IPRUA3 */ { STPRO_4, 0, 0, 0 } },
-};
-
-static DECLARE_INTC_DESC(intca_desc, "r8a7740-intca",
-			 intca_vectors, intca_groups,
-			 intca_mask_registers, intca_prio_registers,
-			 NULL);
-
-INTC_IRQ_PINS_32(intca_irq_pins, 0xe6900000,
-		 INTC_VECT, "r8a7740-intca-irq-pins");
-
-
-/*
- *		INTCS
- */
-enum {
-	UNUSED_INTCS = 0,
-
-	INTCS,
-
-	/* interrupt sources INTCS */
-
-	/* HUDI */
-	/* STPRO */
-	/* RTDMAC(1) */
-	VPU5HA2,
-	_2DG_TRAP, _2DG_GPM_INT, _2DG_CER_INT,
-	/* MFI */
-	/* BBIF2 */
-	VPU5F,
-	_2DG_BRK_INT,
-	/* SGX540 */
-	/* 2DDMAC */
-	/* IPMMU */
-	/* RTDMAC 2 */
-	/* KEYSC */
-	/* MSIOF */
-	IIC0_ALI, IIC0_TACKI, IIC0_WAITI, IIC0_DTEI,
-	TMU0_0, TMU0_1, TMU0_2,
-	CMT0,
-	/* CMT2 */
-	LMB,
-	CTI,
-	VOU,
-	/* RWDT0 */
-	ICB,
-	VIO6C,
-	CEU20, CEU21,
-	JPU,
-	LCDC0,
-	LCRC,
-	/* RTDMAC2(1) */
-	/* RTDMAC2(2) */
-	LCDC1,
-	/* SPU2 */
-	/* FSI */
-	/* FMSI */
-	TMU1_0, TMU1_1, TMU1_2,
-	CMT4,
-	DISP,
-	DSRV,
-	/* MFIS2 */
-	CPORTS2R,
-
-	/* interrupt groups INTCS */
-	_2DG1,
-	IIC0, TMU1,
-};
-
-static struct intc_vect intcs_vectors[] = {
-	/* HUDI */
-	/* STPRO */
-	/* RTDMAC(1) */
-	INTCS_VECT(VPU5HA2,		0x0880),
-	INTCS_VECT(_2DG_TRAP,		0x08A0),
-	INTCS_VECT(_2DG_GPM_INT,	0x08C0),
-	INTCS_VECT(_2DG_CER_INT,	0x08E0),
-	/* MFI */
-	/* BBIF2 */
-	INTCS_VECT(VPU5F,		0x0980),
-	INTCS_VECT(_2DG_BRK_INT,	0x09A0),
-	/* SGX540 */
-	/* 2DDMAC */
-	/* IPMMU */
-	/* RTDMAC(2) */
-	/* KEYSC */
-	/* MSIOF */
-	INTCS_VECT(IIC0_ALI,		0x0E00),
-	INTCS_VECT(IIC0_TACKI,		0x0E20),
-	INTCS_VECT(IIC0_WAITI,		0x0E40),
-	INTCS_VECT(IIC0_DTEI,		0x0E60),
-	INTCS_VECT(TMU0_0,		0x0E80),
-	INTCS_VECT(TMU0_1,		0x0EA0),
-	INTCS_VECT(TMU0_2,		0x0EC0),
-	INTCS_VECT(CMT0,		0x0F00),
-	/* CMT2 */
-	INTCS_VECT(LMB,			0x0F60),
-	INTCS_VECT(CTI,			0x0400),
-	INTCS_VECT(VOU,			0x0420),
-	/* RWDT0 */
-	INTCS_VECT(ICB,			0x0480),
-	INTCS_VECT(VIO6C,		0x04E0),
-	INTCS_VECT(CEU20,		0x0500),
-	INTCS_VECT(CEU21,		0x0520),
-	INTCS_VECT(JPU,			0x0560),
-	INTCS_VECT(LCDC0,		0x0580),
-	INTCS_VECT(LCRC,		0x05A0),
-	/* RTDMAC2(1) */
-	/* RTDMAC2(2) */
-	INTCS_VECT(LCDC1,		0x1780),
-	/* SPU2 */
-	/* FSI */
-	/* FMSI */
-	INTCS_VECT(TMU1_0,		0x1900),
-	INTCS_VECT(TMU1_1,		0x1920),
-	INTCS_VECT(TMU1_2,		0x1940),
-	INTCS_VECT(CMT4,		0x1980),
-	INTCS_VECT(DISP,		0x19A0),
-	INTCS_VECT(DSRV,		0x19C0),
-	/* MFIS2 */
-	INTCS_VECT(CPORTS2R,		0x1A20),
-
-	INTC_VECT(INTCS,		0xf80),
-};
-
-static struct intc_group intcs_groups[] __initdata = {
-	INTC_GROUP(_2DG1, /*FIXME*/
-		   _2DG_CER_INT, _2DG_GPM_INT, _2DG_TRAP),
-	INTC_GROUP(IIC0,
-		   IIC0_DTEI, IIC0_WAITI, IIC0_TACKI, IIC0_ALI),
-	INTC_GROUP(TMU1,
-		   TMU1_0, TMU1_1, TMU1_2),
-};
-
-static struct intc_mask_reg intcs_mask_registers[] = {
-	  /* IMR0SA / IMCR0SA */ /* all 0 */
-	{ /* IMR1SA / IMCR1SA */ 0xffd20184, 0xffd201c4, 8,
-	  { _2DG_CER_INT, _2DG_GPM_INT, _2DG_TRAP, VPU5HA2,
-	    0, 0, 0, 0 /*STPRO*/ } },
-	{ /* IMR2SA / IMCR2SA */ 0xffd20188, 0xffd201c8, 8,
-	  { 0/*STPRO*/, 0, CEU21, VPU5F,
-	    0/*BBIF2*/, 0, 0, 0/*MFI*/ } },
-	{ /* IMR3SA / IMCR3SA */ 0xffd2018c, 0xffd201cc, 8,
-	  { 0, 0, 0, 0, /*2DDMAC*/
-	    VIO6C, 0, 0, ICB } },
-	{ /* IMR4SA / IMCR4SA */ 0xffd20190, 0xffd201d0, 8,
-	  { 0, 0, VOU, CTI,
-	    JPU, 0, LCRC, LCDC0 } },
-	  /* IMR5SA / IMCR5SA */ /*KEYSC/RTDMAC2/RTDMAC1*/
-	  /* IMR6SA / IMCR6SA */ /*MSIOF/SGX540*/
-	{ /* IMR7SA / IMCR7SA */ 0xffd2019c, 0xffd201dc, 8,
-	  { 0, TMU0_2, TMU0_1, TMU0_0,
-	    0, 0, 0, 0 } },
-	{ /* IMR8SA / IMCR8SA */ 0xffd201a0, 0xffd201e0, 8,
-	  { 0, 0, 0, 0,
-	    CEU20, 0, 0, 0 } },
-	{ /* IMR9SA / IMCR9SA */ 0xffd201a4, 0xffd201e4, 8,
-	  { 0, 0/*RWDT0*/, 0/*CMT2*/, CMT0,
-	    0, 0, 0, 0 } },
-	  /* IMR10SA / IMCR10SA */ /*IPMMU*/
-	{ /* IMR11SA / IMCR11SA */ 0xffd201ac, 0xffd201ec, 8,
-	  { IIC0_DTEI, IIC0_WAITI, IIC0_TACKI, IIC0_ALI,
-	    0, _2DG_BRK_INT, LMB, 0 } },
-	  /* IMR12SA / IMCR12SA */
-	  /* IMR13SA / IMCR13SA */
-	  /* IMR0SA3 / IMCR0SA3 */ /*RTDMAC2(1)/RTDMAC2(2)*/
-	  /* IMR1SA3 / IMCR1SA3 */
-	  /* IMR2SA3 / IMCR2SA3 */
-	  /* IMR3SA3 / IMCR3SA3 */
-	{ /* IMR4SA3 / IMCR4SA3 */ 0xffd50190, 0xffd501d0, 8,
-	  { 0, 0, 0, 0,
-	    LCDC1, 0, 0, 0 } },
-	  /* IMR5SA3 / IMCR5SA3 */ /* SPU2/FSI/FMSI */
-	{ /* IMR6SA3 / IMCR6SA3 */ 0xffd50198, 0xffd501d8, 8,
-	  { TMU1_0, TMU1_1, TMU1_2, 0,
-	    CMT4, DISP, DSRV, 0 } },
-	{ /* IMR7SA3 / IMCR7SA3 */ 0xffd5019c, 0xffd501dc, 8,
-	  { 0/*MFIS2*/, CPORTS2R, 0, 0,
-	    0, 0, 0, 0 } },
-	{ /* INTAMASK */ 0xffd20104, 0, 16,
-	  { 0, 0, 0, 0, 0, 0, 0, 0,
-	    0, 0, 0, 0, 0, 0, 0, INTCS } },
-};
-
-/* Priority is needed for INTCA to receive the INTCS interrupt */
-static struct intc_prio_reg intcs_prio_registers[] = {
-	{ 0xffd20000, 0, 16, 4, /* IPRAS */ { CTI, VOU, 0/*2DDMAC*/, ICB } },
-	{ 0xffd20004, 0, 16, 4, /* IPRBS */ { JPU, LCDC0, 0, LCRC } },
-				/* IPRCS */ /*BBIF2*/
-				/* IPRDS */
-	{ 0xffd20010, 0, 16, 4, /* IPRES */ { 0/*RTDMAC(1)*/, VPU5HA2,
-					      0/*MFI*/, VPU5F } },
-	{ 0xffd20014, 0, 16, 4, /* IPRFS */ { 0/*KEYSC*/, 0/*RTDMAC(2)*/,
-					      0/*CMT2*/, CMT0 } },
-	{ 0xffd20018, 0, 16, 4, /* IPRGS */ { TMU0_0, TMU0_1,
-					      TMU0_2, _2DG1 } },
-	{ 0xffd2001c, 0, 16, 4, /* IPRHS */ { 0, 0/*STPRO*/, 0/*STPRO*/,
-					      _2DG_BRK_INT/*FIXME*/ } },
-	{ 0xffd20020, 0, 16, 4, /* IPRIS */ { 0, 0/*MSIOF*/, 0, IIC0 } },
-	{ 0xffd20024, 0, 16, 4, /* IPRJS */ { CEU20, 0/*SGX540*/, 0, 0 } },
-	{ 0xffd20028, 0, 16, 4, /* IPRKS */ { VIO6C, 0, LMB, 0 } },
-	{ 0xffd2002c, 0, 16, 4, /* IPRLS */ { 0/*IPMMU*/, 0, CEU21, 0 } },
-				/* IPRMS */ /*RWDT0*/
-				/* IPRAS3 */ /*RTDMAC2(1)*/
-				/* IPRBS3 */ /*RTDMAC2(2)*/
-				/* IPRCS3 */
-				/* IPRDS3 */
-				/* IPRES3 */
-				/* IPRFS3 */
-				/* IPRGS3 */
-				/* IPRHS3 */
-				/* IPRIS3 */
-	{ 0xffd50024, 0, 16, 4, /* IPRJS3 */ { LCDC1, 0, 0, 0 } },
-				/* IPRKS3 */ /*SPU2/FSI/FMSi*/
-				/* IPRLS3 */
-	{ 0xffd50030, 0, 16, 4, /* IPRMS3 */ { TMU1, 0, 0, 0 } },
-	{ 0xffd50034, 0, 16, 4, /* IPRNS3 */ { CMT4, DISP, DSRV, 0 } },
-	{ 0xffd50038, 0, 16, 4, /* IPROS3 */ { 0/*MFIS2*/, CPORTS2R, 0, 0 } },
-				/* IPRPS3 */
-};
-
-static struct resource intcs_resources[] __initdata = {
-	[0] = {
-		.start	= 0xffd20000,
-		.end	= 0xffd201ff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= 0xffd50000,
-		.end	= 0xffd501ff,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct intc_desc intcs_desc __initdata = {
-	.name = "r8a7740-intcs",
-	.resource = intcs_resources,
-	.num_resources = ARRAY_SIZE(intcs_resources),
-	.hw = INTC_HW_DESC(intcs_vectors, intcs_groups, intcs_mask_registers,
-			   intcs_prio_registers, NULL, NULL),
-};
-
-static void intcs_demux(unsigned int irq, struct irq_desc *desc)
-{
-	void __iomem *reg = (void *)irq_get_handler_data(irq);
-	unsigned int evtcodeas = ioread32(reg);
-
-	generic_handle_irq(intcs_evt2irq(evtcodeas));
-}
+#define INTA_CTRL	IOMEM(0xe605807c)
+#define INTPRIO_BASE	IOMEM(0xe6900010)
+#define INTMSK_BASE	IOMEM(0xe6900040)
 
 void __init r8a7740_init_irq(void)
 {
-	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
-
-	register_intc_controller(&intca_desc);
-	register_intc_controller(&intca_irq_pins_desc);
-	register_intc_controller(&intcs_desc);
-
-	/* demux using INTEVTSA */
-	irq_set_handler_data(evt2irq(0xf80), (void *)intevtsa);
-	irq_set_chained_handler(evt2irq(0xf80), intcs_demux);
+	void *gic_dist_base = ioremap_nocache(0xc2800000, 0x1000);
+	void *gic_cpu_base = ioremap_nocache(0xc2000000, 0x1000);
+
+	/* initialize the Generic Interrupt Controller PL390 r0p0 */
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+
+	/* route signals to GIC */
+	__raw_writel(0x0, INTA_CTRL);
+
+	/*
+	 * To mask the shared interrupt to SPI 149 we must ensure to set
+	 * PRIO *and* MASK. Else we run into IRQ floods when registering
+	 * the intc_irqpin devices
+	 */
+	__raw_writeb(0x0, INTPRIO_BASE + 0x0);
+	__raw_writeb(0x0, INTPRIO_BASE + 0x4);
+	__raw_writeb(0x0, INTPRIO_BASE + 0x8);
+	__raw_writeb(0x0, INTPRIO_BASE + 0xc);
+	__raw_writeb(0xff, INTMSK_BASE + 0x0);
+	__raw_writeb(0xff, INTMSK_BASE + 0x4);
+	__raw_writeb(0xff, INTMSK_BASE + 0x8);
+	__raw_writeb(0xff, INTMSK_BASE + 0xc);
 }
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 30ac79c..f98304e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/serial_sci.h>
@@ -93,6 +94,126 @@ void __init r8a7740_pinmux_init(void)
 	platform_device_register(&r8a7740_pfc_device);
 }
 
+static struct renesas_intc_irqpin_config irqpin0_platform_data = {
+	.irq_base = irq_pin(0), /* IRQ0 -> IRQ7 */
+};
+
+static struct resource irqpin0_resources[] = {
+	DEFINE_RES_MEM(0xe6900000, 4), /* ICR1A */
+	DEFINE_RES_MEM(0xe6900010, 4), /* INTPRI00A */
+	DEFINE_RES_MEM(0xe6900020, 1), /* INTREQ00A */
+	DEFINE_RES_MEM(0xe6900040, 1), /* INTMSK00A */
+	DEFINE_RES_MEM(0xe6900060, 1), /* INTMSKCLR00A */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ0 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ1 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ2 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ3 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ4 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ5 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ6 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ7 */
+};
+
+static struct platform_device irqpin0_device = {
+	.name		= "renesas_intc_irqpin",
+	.id		= 0,
+	.resource	= irqpin0_resources,
+	.num_resources	= ARRAY_SIZE(irqpin0_resources),
+	.dev		= {
+		.platform_data  = &irqpin0_platform_data,
+	},
+};
+
+static struct renesas_intc_irqpin_config irqpin1_platform_data = {
+	.irq_base = irq_pin(8), /* IRQ8 -> IRQ15 */
+};
+
+static struct resource irqpin1_resources[] = {
+	DEFINE_RES_MEM(0xe6900004, 4), /* ICR2A */
+	DEFINE_RES_MEM(0xe6900014, 4), /* INTPRI10A */
+	DEFINE_RES_MEM(0xe6900024, 1), /* INTREQ10A */
+	DEFINE_RES_MEM(0xe6900044, 1), /* INTMSK10A */
+	DEFINE_RES_MEM(0xe6900064, 1), /* INTMSKCLR10A */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ8 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ9 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ10 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ11 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ12 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ13 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ14 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ15 */
+};
+
+static struct platform_device irqpin1_device = {
+	.name		= "renesas_intc_irqpin",
+	.id		= 1,
+	.resource	= irqpin1_resources,
+	.num_resources	= ARRAY_SIZE(irqpin1_resources),
+	.dev		= {
+		.platform_data  = &irqpin1_platform_data,
+	},
+};
+
+static struct renesas_intc_irqpin_config irqpin2_platform_data = {
+	.irq_base = irq_pin(16), /* IRQ16 -> IRQ23 */
+};
+
+static struct resource irqpin2_resources[] = {
+	DEFINE_RES_MEM(0xe6900008, 4), /* ICR3A */
+	DEFINE_RES_MEM(0xe6900018, 4), /* INTPRI30A */
+	DEFINE_RES_MEM(0xe6900028, 1), /* INTREQ30A */
+	DEFINE_RES_MEM(0xe6900048, 1), /* INTMSK30A */
+	DEFINE_RES_MEM(0xe6900068, 1), /* INTMSKCLR30A */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ16 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ17 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ18 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ19 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ20 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ21 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ22 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ23 */
+};
+
+static struct platform_device irqpin2_device = {
+	.name		= "renesas_intc_irqpin",
+	.id		= 2,
+	.resource	= irqpin2_resources,
+	.num_resources	= ARRAY_SIZE(irqpin2_resources),
+	.dev		= {
+		.platform_data  = &irqpin2_platform_data,
+	},
+};
+
+static struct renesas_intc_irqpin_config irqpin3_platform_data = {
+	.irq_base = irq_pin(24), /* IRQ24 -> IRQ31 */
+};
+
+static struct resource irqpin3_resources[] = {
+	DEFINE_RES_MEM(0xe690000c, 4), /* ICR3A */
+	DEFINE_RES_MEM(0xe690001c, 4), /* INTPRI30A */
+	DEFINE_RES_MEM(0xe690002c, 1), /* INTREQ30A */
+	DEFINE_RES_MEM(0xe690004c, 1), /* INTMSK30A */
+	DEFINE_RES_MEM(0xe690006c, 1), /* INTMSKCLR30A */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ24 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ25 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ26 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ27 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ28 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ29 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ30 */
+	DEFINE_RES_IRQ(gic_spi(149)), /* IRQ31 */
+};
+
+static struct platform_device irqpin3_device = {
+	.name		= "renesas_intc_irqpin",
+	.id		= 3,
+	.resource	= irqpin3_resources,
+	.num_resources	= ARRAY_SIZE(irqpin3_resources),
+	.dev		= {
+		.platform_data  = &irqpin3_platform_data,
+	},
+};
+
 /* SCIFA0 */
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xe6c40000,
@@ -100,7 +221,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
 	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0c00)),
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(100)),
 };
 
 static struct platform_device scif0_device = {
@@ -118,7 +239,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
 	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0c20)),
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(101)),
 };
 
 static struct platform_device scif1_device = {
@@ -136,7 +257,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
 	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0c40)),
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(102)),
 };
 
 static struct platform_device scif2_device = {
@@ -154,7 +275,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
 	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0c60)),
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(103)),
 };
 
 static struct platform_device scif3_device = {
@@ -172,7 +293,7 @@ static struct plat_sci_port scif4_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
 	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0d20)),
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(104)),
 };
 
 static struct platform_device scif4_device = {
@@ -190,7 +311,7 @@ static struct plat_sci_port scif5_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
 	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0d40)),
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(105)),
 };
 
 static struct platform_device scif5_device = {
@@ -208,7 +329,7 @@ static struct plat_sci_port scif6_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
 	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x04c0)),
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(106)),
 };
 
 static struct platform_device scif6_device = {
@@ -226,7 +347,7 @@ static struct plat_sci_port scif7_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
 	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x04e0)),
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(107)),
 };
 
 static struct platform_device scif7_device = {
@@ -244,7 +365,7 @@ static struct plat_sci_port scifb_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
 	.type		= PORT_SCIFB,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0d60)),
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(108)),
 };
 
 static struct platform_device scifb_device = {
@@ -272,7 +393,7 @@ static struct resource cmt10_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= evt2irq(0x0b00),
+		.start	= gic_spi(58),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -303,7 +424,7 @@ static struct resource tmu00_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= intcs_evt2irq(0xe80),
+		.start	= gic_spi(198),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -333,7 +454,7 @@ static struct resource tmu01_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= intcs_evt2irq(0xea0),
+		.start	= gic_spi(199),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -363,7 +484,7 @@ static struct resource tmu02_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= intcs_evt2irq(0xec0),
+		.start	= gic_spi(200),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -379,6 +500,10 @@ static struct platform_device tmu02_device = {
 };
 
 static struct platform_device *r8a7740_early_devices[] __initdata = {
+	&irqpin0_device,
+	&irqpin1_device,
+	&irqpin2_device,
+	&irqpin3_device,
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
@@ -492,14 +617,14 @@ static struct resource r8a7740_dmae0_resources[] = {
 	},
 	{
 		.name	= "error_irq",
-		.start	= evt2irq(0x20c0),
-		.end	= evt2irq(0x20c0),
+		.start	= gic_spi(34),
+		.end	= gic_spi(34),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 0-5 */
-		.start	= evt2irq(0x2000),
-		.end	= evt2irq(0x20a0),
+		.start	= gic_spi(28),
+		.end	= gic_spi(33),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -520,14 +645,14 @@ static struct resource r8a7740_dmae1_resources[] = {
 	},
 	{
 		.name	= "error_irq",
-		.start	= evt2irq(0x21c0),
-		.end	= evt2irq(0x21c0),
+		.start	= gic_spi(41),
+		.end	= gic_spi(41),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 0-5 */
-		.start	= evt2irq(0x2100),
-		.end	= evt2irq(0x21a0),
+		.start	= gic_spi(35),
+		.end	= gic_spi(40),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -548,14 +673,14 @@ static struct resource r8a7740_dmae2_resources[] = {
 	},
 	{
 		.name	= "error_irq",
-		.start	= evt2irq(0x22c0),
-		.end	= evt2irq(0x22c0),
+		.start	= gic_spi(42),
+		.end	= gic_spi(47),
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
 		/* IRQ for channels 0-5 */
-		.start	= evt2irq(0x2200),
-		.end	= evt2irq(0x22a0),
+		.start	= gic_spi(48),
+		.end	= gic_spi(48),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -644,8 +769,8 @@ static struct resource r8a7740_usb_dma_resources[] = {
 	},
 	{
 		/* IRQ for channels */
-		.start	= evt2irq(0x0a00),
-		.end	= evt2irq(0x0a00),
+		.start	= gic_spi(49),
+		.end	= gic_spi(49),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -669,8 +794,8 @@ static struct resource i2c0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= intcs_evt2irq(0xe00),
-		.end	= intcs_evt2irq(0xe60),
+		.start	= gic_spi(201),
+		.end	= gic_spi(204),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -683,8 +808,8 @@ static struct resource i2c1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = evt2irq(0x780), /* IIC1_ALI1 */
-		.end    = evt2irq(0x7e0), /* IIC1_DTEI1 */
+		.start  = gic_spi(70), /* IIC1_ALI1 */
+		.end    = gic_spi(73), /* IIC1_DTEI1 */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -705,8 +830,8 @@ static struct platform_device i2c1_device = {
 
 static struct resource pmu_resources[] = {
 	[0] = {
-		.start	= evt2irq(0x19a0),
-		.end	= evt2irq(0x19a0),
+		.start	= gic_spi(83),
+		.end	= gic_spi(83),
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -871,7 +996,6 @@ DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.map_io		= r8a7740_map_io,
 	.init_early	= r8a7740_add_early_devices_dt,
 	.init_irq	= r8a7740_init_irq,
-	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= r8a7740_add_standard_devices_dt,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a7740_boards_compat_dt,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index d0b7165..22a97f1 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -2780,38 +2780,38 @@ static struct pinmux_data_reg pinmux_data_regs[] = {
 };
 
 static struct pinmux_irq pinmux_irqs[] = {
-	PINMUX_IRQ(evt2irq(0x0200), GPIO_PORT2,   GPIO_PORT13),	/* IRQ0A */
-	PINMUX_IRQ(evt2irq(0x0220), GPIO_PORT20),		/* IRQ1A */
-	PINMUX_IRQ(evt2irq(0x0240), GPIO_PORT11,  GPIO_PORT12),	/* IRQ2A */
-	PINMUX_IRQ(evt2irq(0x0260), GPIO_PORT10,  GPIO_PORT14),	/* IRQ3A */
-	PINMUX_IRQ(evt2irq(0x0280), GPIO_PORT15,  GPIO_PORT172),/* IRQ4A */
-	PINMUX_IRQ(evt2irq(0x02A0), GPIO_PORT0,   GPIO_PORT1),	/* IRQ5A */
-	PINMUX_IRQ(evt2irq(0x02C0), GPIO_PORT121, GPIO_PORT173),/* IRQ6A */
-	PINMUX_IRQ(evt2irq(0x02E0), GPIO_PORT120, GPIO_PORT209),/* IRQ7A */
-	PINMUX_IRQ(evt2irq(0x0300), GPIO_PORT119),		/* IRQ8A */
-	PINMUX_IRQ(evt2irq(0x0320), GPIO_PORT118, GPIO_PORT210),/* IRQ9A */
-	PINMUX_IRQ(evt2irq(0x0340), GPIO_PORT19),		/* IRQ10A */
-	PINMUX_IRQ(evt2irq(0x0360), GPIO_PORT104),		/* IRQ11A */
-	PINMUX_IRQ(evt2irq(0x0380), GPIO_PORT42,  GPIO_PORT97),	/* IRQ12A */
-	PINMUX_IRQ(evt2irq(0x03A0), GPIO_PORT64,  GPIO_PORT98),	/* IRQ13A */
-	PINMUX_IRQ(evt2irq(0x03C0), GPIO_PORT63,  GPIO_PORT99),	/* IRQ14A */
-	PINMUX_IRQ(evt2irq(0x03E0), GPIO_PORT62,  GPIO_PORT100),/* IRQ15A */
-	PINMUX_IRQ(evt2irq(0x3200), GPIO_PORT68,  GPIO_PORT211),/* IRQ16A */
-	PINMUX_IRQ(evt2irq(0x3220), GPIO_PORT69),		/* IRQ17A */
-	PINMUX_IRQ(evt2irq(0x3240), GPIO_PORT70),		/* IRQ18A */
-	PINMUX_IRQ(evt2irq(0x3260), GPIO_PORT71),		/* IRQ19A */
-	PINMUX_IRQ(evt2irq(0x3280), GPIO_PORT67),		/* IRQ20A */
-	PINMUX_IRQ(evt2irq(0x32A0), GPIO_PORT202),		/* IRQ21A */
-	PINMUX_IRQ(evt2irq(0x32C0), GPIO_PORT95),		/* IRQ22A */
-	PINMUX_IRQ(evt2irq(0x32E0), GPIO_PORT96),		/* IRQ23A */
-	PINMUX_IRQ(evt2irq(0x3300), GPIO_PORT180),		/* IRQ24A */
-	PINMUX_IRQ(evt2irq(0x3320), GPIO_PORT38),		/* IRQ25A */
-	PINMUX_IRQ(evt2irq(0x3340), GPIO_PORT58,  GPIO_PORT81),	/* IRQ26A */
-	PINMUX_IRQ(evt2irq(0x3360), GPIO_PORT57,  GPIO_PORT168),/* IRQ27A */
-	PINMUX_IRQ(evt2irq(0x3380), GPIO_PORT56,  GPIO_PORT169),/* IRQ28A */
-	PINMUX_IRQ(evt2irq(0x33A0), GPIO_PORT50,  GPIO_PORT170),/* IRQ29A */
-	PINMUX_IRQ(evt2irq(0x33C0), GPIO_PORT49,  GPIO_PORT171),/* IRQ30A */
-	PINMUX_IRQ(evt2irq(0x33E0), GPIO_PORT41,  GPIO_PORT167),/* IRQ31A */
+	PINMUX_IRQ(irq_pin(0), GPIO_PORT2,   GPIO_PORT13),	/* IRQ0A */
+	PINMUX_IRQ(irq_pin(1), GPIO_PORT20),		/* IRQ1A */
+	PINMUX_IRQ(irq_pin(2), GPIO_PORT11,  GPIO_PORT12),	/* IRQ2A */
+	PINMUX_IRQ(irq_pin(3), GPIO_PORT10,  GPIO_PORT14),	/* IRQ3A */
+	PINMUX_IRQ(irq_pin(4), GPIO_PORT15,  GPIO_PORT172),/* IRQ4A */
+	PINMUX_IRQ(irq_pin(5), GPIO_PORT0,   GPIO_PORT1),	/* IRQ5A */
+	PINMUX_IRQ(irq_pin(6), GPIO_PORT121, GPIO_PORT173),/* IRQ6A */
+	PINMUX_IRQ(irq_pin(7), GPIO_PORT120, GPIO_PORT209),/* IRQ7A */
+	PINMUX_IRQ(irq_pin(8), GPIO_PORT119),		/* IRQ8A */
+	PINMUX_IRQ(irq_pin(9), GPIO_PORT118, GPIO_PORT210),/* IRQ9A */
+	PINMUX_IRQ(irq_pin(10), GPIO_PORT19),		/* IRQ10A */
+	PINMUX_IRQ(irq_pin(11), GPIO_PORT104),		/* IRQ11A */
+	PINMUX_IRQ(irq_pin(12), GPIO_PORT42,  GPIO_PORT97),	/* IRQ12A */
+	PINMUX_IRQ(irq_pin(13), GPIO_PORT64,  GPIO_PORT98),	/* IRQ13A */
+	PINMUX_IRQ(irq_pin(14), GPIO_PORT63,  GPIO_PORT99),	/* IRQ14A */
+	PINMUX_IRQ(irq_pin(15), GPIO_PORT62,  GPIO_PORT100),/* IRQ15A */
+	PINMUX_IRQ(irq_pin(16), GPIO_PORT68,  GPIO_PORT211),/* IRQ16A */
+	PINMUX_IRQ(irq_pin(17), GPIO_PORT69),		/* IRQ17A */
+	PINMUX_IRQ(irq_pin(18), GPIO_PORT70),		/* IRQ18A */
+	PINMUX_IRQ(irq_pin(19), GPIO_PORT71),		/* IRQ19A */
+	PINMUX_IRQ(irq_pin(20), GPIO_PORT67),		/* IRQ20A */
+	PINMUX_IRQ(irq_pin(21), GPIO_PORT202),		/* IRQ21A */
+	PINMUX_IRQ(irq_pin(22), GPIO_PORT95),		/* IRQ22A */
+	PINMUX_IRQ(irq_pin(23), GPIO_PORT96),		/* IRQ23A */
+	PINMUX_IRQ(irq_pin(24), GPIO_PORT180),		/* IRQ24A */
+	PINMUX_IRQ(irq_pin(25), GPIO_PORT38),		/* IRQ25A */
+	PINMUX_IRQ(irq_pin(26), GPIO_PORT58,  GPIO_PORT81),	/* IRQ26A */
+	PINMUX_IRQ(irq_pin(27), GPIO_PORT57,  GPIO_PORT168),/* IRQ27A */
+	PINMUX_IRQ(irq_pin(28), GPIO_PORT56,  GPIO_PORT169),/* IRQ28A */
+	PINMUX_IRQ(irq_pin(29), GPIO_PORT50,  GPIO_PORT170),/* IRQ29A */
+	PINMUX_IRQ(irq_pin(30), GPIO_PORT49,  GPIO_PORT171),/* IRQ30A */
+	PINMUX_IRQ(irq_pin(31), GPIO_PORT41,  GPIO_PORT167),/* IRQ31A */
 };
 
 struct sh_pfc_soc_info r8a7740_pinmux_info = {
-- 
1.7.9.5
