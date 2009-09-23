From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Thu, 24 Sep 2009 01:19:13 +0530
Subject: [PATCH 6/8] [ARM] U8500: adds stw4500 as pl022 device
Message-ID: <1253735353.21542.176.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

This adds STw4500 device as pl022. STw4500
is a mixed signal power management chip
connects to U8500 on the SSP/SPI bus.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c |   67 ++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index bca2e84..55f8fa8 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -14,6 +14,8 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/amba/bus.h>
+#include <linux/amba/pl022.h>
+#include <linux/spi/spi.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -43,10 +45,72 @@ static struct amba_device uart2_device = {
 	.irq = {IRQ_UART2, NO_IRQ},
 };
 
+static void stw4500_spi_cs_control(u32 command)
+{
+	/* set the FRM signal, which is CS  - TODO */
+}
+
+struct pl022_config_chip stw4500_chip_info = {
+	.lbm = LOOPBACK_DISABLED,
+	.com_mode = INTERRUPT_TRANSFER,
+	.iface = SSP_INTERFACE_MOTOROLA_SPI,
+	/* we can act as master only */
+	.hierarchy = SSP_MASTER,
+	.slave_tx_disable = 0,
+	.endian_rx = SSP_RX_MSB,
+	.endian_tx = SSP_TX_MSB,
+	.data_size = SSP_DATA_BITS_24,
+	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
+	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
+	.clk_phase = SSP_CLK_FALLING_EDGE,
+	.clk_pol = SSP_CLK_POL_IDLE_HIGH,
+	.cs_control = stw4500_spi_cs_control,
+};
+
+static struct spi_board_info u8500_spi_devices[] = {
+	{
+	.modalias = "stw4500",
+	.platform_data = NULL,
+	.controller_data = &stw4500_chip_info,
+	.max_speed_hz = 12000000,
+	.bus_num = 0,
+	.chip_select = 0,
+	.mode = SPI_MODE_0,
+	.irq = STW4500_IRQ,
+	},
+};
+
+static struct pl022_ssp_controller ssp0_platform_data = {
+	.bus_id = 0,
+	/* pl022 not yet supports dma */
+	.enable_dma = 0,
+	/* on this platform, gpio 31,142,144,214 &
+	 * 224 are connected as chip selects
+	 */
+	.num_chipselect = 5,
+};
+
+static struct amba_device pl022_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.init_name = "pl022",
+		.platform_data = &ssp0_platform_data,
+	},
+	.res = {
+		.start = U8500_SSP0_BASE,
+		.end   = U8500_SSP0_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_SSP0, NO_IRQ },
+	/* ST-Ericsson modified id */
+	.periphid = 0x01080022,
+};
+
 static struct amba_device *amba_devs[] __initdata = {
 	&uart0_device,
 	&uart1_device,
 	&uart2_device,
+	&pl022_device,
 };
 
 /* add any platform devices here - TODO */
@@ -64,6 +128,9 @@ static void __init u8500_init_machine(void)
 	/* Register the platform devices */
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 
+	spi_register_board_info(u8500_spi_devices,
+			ARRAY_SIZE(u8500_spi_devices));
+
 	u8500_init_devices();
 }
 
-- 
1.6.3.GIT
