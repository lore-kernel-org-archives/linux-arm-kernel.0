From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Sep 2014 18:37:19 +0200
Subject: [GIT PULL] ARM: LPC32xx: Device tree updates
In-Reply-To: <541058F7.8060809@antcom.de>
References: <541058F7.8060809@antcom.de>
Message-ID: <13599998.oE5Dh5uM3r@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 September 2014 15:58:15 Roland Stigge wrote:
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   git://git.antcom.de/linux-2.6 lpc32xx/dt
> 
> for you to fetch changes up to 280f965674dbc5090147724d90b701f2b81f07e3:
> 
>   ARM: LPC32xx: Use DMA for both SSP channels (2014-09-10 15:41:30 +0200)
> 
> ----------------------------------------------------------------
> Roland Stigge (1):
>       ARM: LPC32xx: Use DMA for both SSP channels
> 
>  arch/arm/boot/dts/lpc32xx.dtsi | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

This unfortunately uses a binding for pl08x that hasn't been reviewed
yet, so I can't pull it. See below for an illustration of how I think
the binding should work. There are probably bugs in that code, but
hopefully it's not too far off.

	Arnd

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 3abebb75fc57..72b1923d6ad3 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -40,6 +40,8 @@
 			compatible = "nxp,lpc3220-slc";
 			reg = <0x20020000 0x1000>;
 			status = "disabled";
+			dmas = <&pl080 1 1>
+			dma-names = "data";
 		};
 
 		mlc: flash at 200a8000 {
@@ -47,12 +49,17 @@
 			reg = <0x200a8000 0x11000>;
 			interrupts = <11 0>;
 			status = "disabled";
+			dmas = <&pl080 12 1>;
+			dma-names = "data";
 		};
 
-		dma at 31000000 {
+		pl080: dma at 31000000 {
 			compatible = "arm,pl080", "arm,primecell";
 			reg = <0x31000000 0x1000>;
 			interrupts = <0x1c 0>;
+			#dma-cells = <2>;
+			dma-channels = <10>;
+			dma-requests = <32>;
 		};
 
 		/*
@@ -95,11 +102,15 @@
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x20084000 0x1000>;
 				interrupts = <0x14 0>;
+				dmas = <&pl080 3 1>, <&pl080 11 1>;
+				dma-names = "rx", "tx";
 			};
 
 			spi1: spi at 20088000 {
 				compatible = "nxp,lpc3220-spi";
 				reg = <0x20088000 0x1000>;
+				dmas = <&pl080 14 1>, <&pl080 15 1>;
+				dma-names = "rx", "tx";
 			};
 
 			ssp1: ssp at 2008c000 {
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 7858d5b6f6ce..f8952f8d16aa 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -155,35 +155,8 @@ static struct clcd_board lpc32xx_clcd_data = {
 	.remove		= lpc32xx_clcd_remove,
 };
 
-static struct pl08x_channel_data pl08x_slave_channels[] = {
-	{
-		.bus_id = "nand-slc",
-		.min_signal = 1, /* SLC NAND Flash */
-		.max_signal = 1,
-		.periph_buses = PL08X_AHB1,
-	},
-	{
-		.bus_id = "nand-mlc",
-		.min_signal = 12, /* MLC NAND Flash */
-		.max_signal = 12,
-		.periph_buses = PL08X_AHB1,
-	},
-};
-
-static int pl08x_get_signal(const struct pl08x_channel_data *cd)
-{
-	return cd->min_signal;
-}
-
-static void pl08x_put_signal(const struct pl08x_channel_data *cd, int ch)
-{
-}
-
 static struct pl08x_platform_data pl08x_pd = {
-	.slave_channels = &pl08x_slave_channels[0],
-	.num_slave_channels = ARRAY_SIZE(pl08x_slave_channels),
-	.get_xfer_signal = pl08x_get_signal,
-	.put_xfer_signal = pl08x_put_signal,
+	.num_slave_channels = 0;
 	.lli_buses = PL08X_AHB1,
 	.mem_buses = PL08X_AHB1,
 };
@@ -204,14 +177,6 @@ static struct mmci_platform_data lpc32xx_mmci_data = {
 	.ios_handler	= mmc_handle_ios,
 };
 
-static struct lpc32xx_slc_platform_data lpc32xx_slc_data = {
-	.dma_filter = pl08x_filter_id,
-};
-
-static struct lpc32xx_mlc_platform_data lpc32xx_mlc_data = {
-	.dma_filter = pl08x_filter_id,
-};
-
 static const struct of_dev_auxdata lpc32xx_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("arm,pl022", 0x20084000, "dev:ssp0", NULL),
 	OF_DEV_AUXDATA("arm,pl022", 0x2008C000, "dev:ssp1", NULL),
@@ -219,10 +184,8 @@ static const struct of_dev_auxdata lpc32xx_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("arm,pl080", 0x31000000, "pl08xdmac", &pl08x_pd),
 	OF_DEV_AUXDATA("arm,pl18x", 0x20098000, "20098000.sd",
 		       &lpc32xx_mmci_data),
-	OF_DEV_AUXDATA("nxp,lpc3220-slc", 0x20020000, "20020000.flash",
-		       &lpc32xx_slc_data),
-	OF_DEV_AUXDATA("nxp,lpc3220-mlc", 0x200a8000, "200a8000.flash",
-		       &lpc32xx_mlc_data),
+	OF_DEV_AUXDATA("nxp,lpc3220-slc", 0x20020000, "20020000.flash", NULL)
+	OF_DEV_AUXDATA("nxp,lpc3220-mlc", 0x200a8000, "200a8000.flash", NULL)
 	{ }
 };
 
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index aa3f08683e73..0867c3cccf19 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1925,6 +1925,49 @@ static void pl08x_free_virtual_channels(struct dma_device *dmadev)
 	}
 }
 
+static struct dma_chan *of_dma_pl08x_xlate(struct of_phandle_args *dma_spec,
+						struct of_dma *ofdma)
+{
+	int count = dma_spec->args_count;
+	struct pl08x_driver_data *pl08x = ofdma->of_dma_data;
+	struct pl08x_dma_chan *chan;
+	struct pl08x_channel_data *data;
+
+	unsigned int chan_id;
+
+	if (!pl08x)
+		return NULL;
+
+	if (count < 2 || count > 3)
+		return NULL;
+
+	/* FIXME: memory leak, should first see if we already have this one */
+	chan = devm_kzalloc(pl08x->slave.dev,
+			    sizeof(*chan) + sizeof(struct pl08x_channel_data),
+			    GFP_KERNEL);
+	if (!chan)
+		return NULL;
+
+	data = (void *)&chan[1];
+	data->bus_id = "(none)";
+	data->min_signal = data->max_signal = dma_spec->args[0];
+	data->periph_buses = dma_spec->args[1];
+	if (count == 3)
+		chan->muxval = dma_spec->args[2];
+
+	chan->host = pl08x;
+	chan->slave = true;
+	chan->name = data->bus_id;
+	chan->state = PL08X_CHAN_IDLE;
+	chan->signal = -1;
+	chan->cd = data;
+	chan->vc.desc_free = pl08x_desc_free;
+
+	vchan_init(&chan->vc, dmadev);
+
+	return chan;
+}
+
 #ifdef CONFIG_DEBUG_FS
 static const char *pl08x_state_str(enum pl08x_dma_chan_state state)
 {
@@ -2200,6 +2243,16 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		 amba_part(adev), pl08x->vd->pl080s ? "s" : "", amba_rev(adev),
 		 (unsigned long long)adev->res.start, adev->irq[0]);
 
+	if (adev->dev.of_node) {
+		ret = of_dma_controller_register(adev->dev.of_node,
+					 of_dma_pl08x_xlate, pl08x);
+		if (ret) {
+			dev_err(&adev->dev,
+			"unable to register DMA to the generic DT DMA helpers\n");
+		}
+	}
+
+
 	return 0;
 
 out_no_slave_reg:
