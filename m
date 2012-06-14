From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 18:50:54 +0200
Subject: [PATCH v2 04/23] ARM: LPC32xx: Add DMA configuration to platform data
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <1339692673-7848-5-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMA channel configuration to the LPC32xx platform file.  The
configured DMA signalling is generic for LPC32xx SoC and is not board specific.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
Changes since v1:
* Don't use pointers to functions in struct init

 arch/arm/mach-lpc32xx/phy3250.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/phy3250.c
+++ linux-2.6/arch/arm/mach-lpc32xx/phy3250.c
@@ -226,7 +226,38 @@ static int __init phy3250_spi_board_regi
 }
 arch_initcall(phy3250_spi_board_register);
 
+static struct pl08x_channel_data pl08x_slave_channels[] = {
+	{
+		.bus_id = "nand-slc",
+		.min_signal = 1, /* SLC NAND Flash */
+		.max_signal = 1,
+		.periph_buses = PL08X_AHB1,
+	},
+	{
+		.bus_id = "nand-mlc",
+		.min_signal = 12, /* MLC NAND Flash */
+		.max_signal = 12,
+		.periph_buses = PL08X_AHB1,
+	},
+};
+
+/* NOTE: These will change, according to RMK */
+static int pl08x_get_signal(struct pl08x_dma_chan *ch)
+{
+	return ch->cd->min_signal;
+}
+
+static void pl08x_put_signal(struct pl08x_dma_chan *ch)
+{
+}
+
 static struct pl08x_platform_data pl08x_pd = {
+	.slave_channels = &pl08x_slave_channels[0],
+	.num_slave_channels = ARRAY_SIZE(pl08x_slave_channels),
+	.get_signal = pl08x_get_signal,
+	.put_signal = pl08x_put_signal,
+	.lli_buses = PL08X_AHB1,
+	.mem_buses = PL08X_AHB1,
 };
 
 static const struct of_dev_auxdata lpc32xx_auxdata_lookup[] __initconst = {
