From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 18 Apr 2012 20:46:34 +0800
Subject: [PATCH 2/5] dma: mxs-dma: make platform_device_id more generic
In-Reply-To: <1334753197-12032-1-git-send-email-b29396@freescale.com>
References: <1334753197-12032-1-git-send-email-b29396@freescale.com>
Message-ID: <1334753197-12032-3-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Rewrite mxs_dma_is_apbh and mxs_dma_is_apbx in order to support
other SoCs like imx6q and reform the platform_device_id for the
better further dt support.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Huang Shijie <b32955@freescale.com>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/mach-mxs/clock-mx23.c           |    4 +-
 arch/arm/mach-mxs/clock-mx28.c           |    4 +-
 arch/arm/mach-mxs/devices/platform-dma.c |   14 ++--
 drivers/dma/mxs-dma.c                    |  111 +++++++++++++++++++++++-------
 include/linux/fsl/mxs-dma.h              |   12 +---
 5 files changed, 101 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index e3ac52c..1e67b85 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -427,8 +427,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("duart", NULL, uart_clk)
 	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
 	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
-	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
-	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
+	_REGISTER_CLOCK("imx23-dma-apbh", NULL, hbus_clk)
+	_REGISTER_CLOCK("imx23-dma-apbx", NULL, xbus_clk)
 	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp_clk)
 	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp_clk)
 	_REGISTER_CLOCK(NULL, "usb", usb_clk)
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 1867a17..cca2cf7 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -625,8 +625,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxs-auart.4", NULL, uart_clk)
 	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
 	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
-	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
-	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
+	_REGISTER_CLOCK("imx28-dma-apbh", NULL, hbus_clk)
+	_REGISTER_CLOCK("imx28-dma-apbx", NULL, xbus_clk)
 	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp0_clk)
 	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp1_clk)
 	_REGISTER_CLOCK("mxs-mmc.2", NULL, ssp2_clk)
diff --git a/arch/arm/mach-mxs/devices/platform-dma.c b/arch/arm/mach-mxs/devices/platform-dma.c
index 6a0202b..aff4813 100644
--- a/arch/arm/mach-mxs/devices/platform-dma.c
+++ b/arch/arm/mach-mxs/devices/platform-dma.c
@@ -32,17 +32,19 @@ static struct platform_device *__init mxs_add_dma(const char *devid,
 
 static int __init mxs_add_mxs_dma(void)
 {
-	char *apbh = "mxs-dma-apbh";
-	char *apbx = "mxs-dma-apbx";
+	char *mx23_apbh = "imx23-dma-apbh";
+	char *mx23_apbx = "imx23-dma-apbx";
+	char *mx28_apbh = "imx28-dma-apbh";
+	char *mx28_apbx = "imx28-dma-apbx";
 
 	if (cpu_is_mx23()) {
-		mxs_add_dma(apbh, MX23_APBH_DMA_BASE_ADDR);
-		mxs_add_dma(apbx, MX23_APBX_DMA_BASE_ADDR);
+		mxs_add_dma(mx23_apbh, MX23_APBH_DMA_BASE_ADDR);
+		mxs_add_dma(mx23_apbx, MX23_APBX_DMA_BASE_ADDR);
 	}
 
 	if (cpu_is_mx28()) {
-		mxs_add_dma(apbh, MX28_APBH_DMA_BASE_ADDR);
-		mxs_add_dma(apbx, MX28_APBX_DMA_BASE_ADDR);
+		mxs_add_dma(mx28_apbh, MX28_APBH_DMA_BASE_ADDR);
+		mxs_add_dma(mx28_apbx, MX28_APBX_DMA_BASE_ADDR);
 	}
 
 	return 0;
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index b0051a8..51a29f9 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -50,7 +50,8 @@
 #define HW_APBHX_CTRL2				0x020
 #define HW_APBHX_CHANNEL_CTRL			0x030
 #define BP_APBHX_CHANNEL_CTRL_RESET_CHANNEL	16
-#define HW_APBH_VERSION				(cpu_is_mx23() ? 0x3f0 : 0x800)
+#define HW_APBH_VERSION_IMX23			0x3f0
+#define HW_APBH_VERSION_IMX28			0x800
 #define HW_APBX_VERSION				0x800
 #define BP_APBHX_VERSION_MAJOR			24
 #define HW_APBHX_CHn_NXTCMDAR(n) \
@@ -121,7 +122,8 @@ struct mxs_dma_chan {
 #define MXS_DMA_CHANNELS_MASK		0xffff
 
 struct mxs_dma_engine {
-	int				dev_id;
+	unsigned int			type;
+	unsigned int			dev_id;
 	unsigned int			version;
 	void __iomem			*base;
 	struct clk			*clk;
@@ -130,6 +132,74 @@ struct mxs_dma_engine {
 	struct mxs_dma_chan		mxs_chans[MXS_DMA_CHANNELS];
 };
 
+enum mxs_dma_devtype {
+	IMX23_DMA,
+	IMX28_DMA,
+};
+
+struct mxs_dma_type {
+	unsigned int type;
+	unsigned int id;
+};
+
+static struct mxs_dma_type mxs_dma_types[] = {
+	{
+		.type = IMX23_DMA,
+		.id = MXS_DMA_APBH,
+	}, {
+		.type = IMX23_DMA,
+		.id = MXS_DMA_APBX,
+	}, {
+		.type = IMX28_DMA,
+		.id = MXS_DMA_APBH,
+	}, {
+		.type = IMX28_DMA,
+		.id = MXS_DMA_APBX,
+	}, {
+		/* end of list */
+	}
+};
+
+static struct platform_device_id mxs_dma_idt[] = {
+	{
+		.name = "imx23-dma-apbh",
+		.driver_data = (kernel_ulong_t) &mxs_dma_types[0],
+	}, {
+		.name = "imx23-dma-apbx",
+		.driver_data = (kernel_ulong_t) &mxs_dma_types[1],
+	}, {
+		.name = "imx28-dma-apbh",
+		.driver_data = (kernel_ulong_t) &mxs_dma_types[2],
+	}, {
+		.name = "imx28-dma-apbx",
+		.driver_data = (kernel_ulong_t) &mxs_dma_types[3],
+	}, {
+		/* end of list */
+	}
+};
+
+static struct mxs_dma_chan *to_mxs_dma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct mxs_dma_chan, chan);
+}
+
+int mxs_dma_is_apbh(struct dma_chan *chan)
+{
+	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+
+	return dma_is_apbh();
+}
+
+int mxs_dma_is_apbx(struct dma_chan *chan)
+{
+	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
+	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
+
+	return !dma_is_apbh();
+}
+
+
 static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
 {
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
@@ -193,11 +263,6 @@ static void mxs_dma_resume_chan(struct mxs_dma_chan *mxs_chan)
 	mxs_chan->status = DMA_IN_PROGRESS;
 }
 
-static struct mxs_dma_chan *to_mxs_dma_chan(struct dma_chan *chan)
-{
-	return container_of(chan, struct mxs_dma_chan, chan);
-}
-
 static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(tx->chan);
@@ -574,11 +639,18 @@ static int __init mxs_dma_init(struct mxs_dma_engine *mxs_dma)
 	if (ret)
 		goto err_out;
 
-	/* only major version matters */
-	mxs_dma->version = readl(mxs_dma->base +
+	if (mxs_dma->type == IMX23_DMA) {
+		/* only major version matters */
+		mxs_dma->version = readl(mxs_dma->base +
 				((mxs_dma->dev_id == MXS_DMA_APBX) ?
-				HW_APBX_VERSION : HW_APBH_VERSION)) >>
+				HW_APBX_VERSION : HW_APBH_VERSION_IMX23)) >>
 				BP_APBHX_VERSION_MAJOR;
+	} else if (mxs_dma->type == IMX28_DMA) {
+		mxs_dma->version = readl(mxs_dma->base +
+				((mxs_dma->dev_id == MXS_DMA_APBX) ?
+				HW_APBX_VERSION : HW_APBH_VERSION_IMX28)) >>
+				BP_APBHX_VERSION_MAJOR;
+	}
 
 	/* enable apbh burst */
 	if (dma_is_apbh()) {
@@ -601,6 +673,8 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id_entry =
 				platform_get_device_id(pdev);
+	const struct mxs_dma_type *mtype =
+			(struct mxs_dma_type *)id_entry->driver_data;
 	struct mxs_dma_engine *mxs_dma;
 	struct resource *iores;
 	int ret, i;
@@ -609,7 +683,8 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	if (!mxs_dma)
 		return -ENOMEM;
 
-	mxs_dma->dev_id = id_entry->driver_data;
+	mxs_dma->type = mtype->type;
+	mxs_dma->dev_id = mtype->id;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
@@ -692,23 +767,11 @@ err_request_region:
 	return ret;
 }
 
-static struct platform_device_id mxs_dma_type[] = {
-	{
-		.name = "mxs-dma-apbh",
-		.driver_data = MXS_DMA_APBH,
-	}, {
-		.name = "mxs-dma-apbx",
-		.driver_data = MXS_DMA_APBX,
-	}, {
-		/* end of list */
-	}
-};
-
 static struct platform_driver mxs_dma_driver = {
 	.driver		= {
 		.name	= "mxs-dma",
 	},
-	.id_table	= mxs_dma_type,
+	.id_table	= mxs_dma_idt,
 };
 
 static int __init mxs_dma_module_init(void)
diff --git a/include/linux/fsl/mxs-dma.h b/include/linux/fsl/mxs-dma.h
index 203d7c4..55d8702 100644
--- a/include/linux/fsl/mxs-dma.h
+++ b/include/linux/fsl/mxs-dma.h
@@ -15,14 +15,6 @@ struct mxs_dma_data {
 	int chan_irq;
 };
 
-static inline int mxs_dma_is_apbh(struct dma_chan *chan)
-{
-	return !strcmp(dev_name(chan->device->dev), "mxs-dma-apbh");
-}
-
-static inline int mxs_dma_is_apbx(struct dma_chan *chan)
-{
-	return !strcmp(dev_name(chan->device->dev), "mxs-dma-apbx");
-}
-
+extern int mxs_dma_is_apbh(struct dma_chan *chan);
+extern int mxs_dma_is_apbx(struct dma_chan *chan);
 #endif /* __MACH_MXS_DMA_H__ */
-- 
1.7.0.4
