From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Sat, 27 Feb 2010 17:30:11 +0100
Subject: [RFC] mx3fb: introduce waveform configuration for Pixel Clock signal.
Message-ID: <1267288211.2723.102.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of static assignments for Pixel Clock waveform timings
make it machine configurable.
This address an old problem posted here:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/58185/focus=58285

In particular, the Armadillo 500 developing board is provided
with a digital to analogue converter chip that need a different than
default Pixel Clock waveform to perform the pixel conversion correctly.
(Te DAC is low CS enabled and need more time than a half pixelclock
period to perform the conversion)

This RFC address the problem modelling the pixelclock signal as a
square waveform where can be chosen the start and width for the high
part of the signal. 
These parameters are expressed in sixteenths of the pixelclock period.
Why the number 16? Because I think it is the better trade off between
the maths offered by the hardware (DISP3_IF_CLK_[UP:DOWN]_WR are number
with 2 fractional digits so the unity can be divided at least by 4 and
the normal configurations achieved with a 640x480 resolution is 
div = circa 4 with 400Mhz MCU clock) and the configuration needs (think
that today this timings cannot be configurable).

The code is developed to prevent regressions: if not configured
pix_clk_start and pix_clk_width, the driver probe function provide
to choose a configuration very similar (on my board equal) to the 
previous one.

Reviews are welcomes!

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 arch/arm/plat-mxc/include/mach/mx3fb.h |   16 ++++++++++++++
 drivers/video/mx3fb.c                  |   35 ++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx3fb.h b/arch/arm/plat-mxc/include/mach/mx3fb.h
index ac24c5c..6ca870e 100644
--- a/arch/arm/plat-mxc/include/mach/mx3fb.h
+++ b/arch/arm/plat-mxc/include/mach/mx3fb.h
@@ -33,6 +33,22 @@ struct mx3fb_platform_data {
 	const char			*name;
 	const struct fb_videomode	*mode;
 	int				num_modes;
+
+	/*
+	 * Timings configuration for the Pixel clock waveform:
+	 *          ___________
+	 *  _______|           |_____ Pixel clock
+	 * ^       ^           ^     ^
+	 * |<--ts->|<---tw---->|     |
+	 * |<-----------Tc---------->|
+	 *
+	 * ts = (Tc * pix_clk_start) / 16
+	 * tw = (Tc * pix_clk_width) / 16
+	 *
+	 * Constraint: ((pix_clk_start + pix_clk_width) / 16) <= 1
+	 */
+	__u8 pix_clk_start;
+	__u8 pix_clk_width;
 };
 
 #endif
diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 054ef29..8dd7c22 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -241,6 +241,7 @@ struct mx3fb_data {
 	void __iomem		*reg_base;
 	spinlock_t		lock;
 	struct device		*dev;
+	struct mx3fb_platform_data	*pdata;
 
 	uint32_t		h_start_width;
 	uint32_t		v_start_width;
@@ -440,6 +441,7 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
 			  uint16_t v_sync_width, uint16_t v_end_width,
 			  struct ipu_di_signal_cfg sig)
 {
+	struct mx3fb_platform_data *mx3fb_pdata = mx3fb->pdata;
 	unsigned long lock_flags;
 	uint32_t reg;
 	uint32_t old_conf;
@@ -503,6 +505,10 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
 		dev_dbg(mx3fb->dev,
 			"InitPanel() - Pixel clock divider less than 4\n");
 		div = 0x40;
+	} else if (div > 0xFFF) {
+		dev_dbg(mx3fb->dev,
+			"InitPanel() - Pixel clock divider greater than max\n");
+		div = 0xFFFF;
 	}
 
 	dev_dbg(mx3fb->dev, "pixel clk = %u, divider %u.%u\n",
@@ -511,11 +517,18 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
 	spin_lock_irqsave(&mx3fb->lock, lock_flags);
 
 	/*
-	 * DISP3_IF_CLK_DOWN_WR is half the divider value and 2 fraction bits
-	 * fewer. Subtract 1 extra from DISP3_IF_CLK_DOWN_WR based on timing
-	 * debug. DISP3_IF_CLK_UP_WR is 0
+	 * Building DI_DISP3_TIME_CONF:
+	 * DISP3_IF_CLK_PER_WR  = div; (4 fractional digits)
+	 * DISP3_IF_CLK_UP_WR   [0:(DOWN_WR - 0.5)]  (2 fractional digits)
+	 * DISP3_IF_CLK_DOWN_WR [(UP_WR + 0.5):PER_WR] (2 fractional digits)
+	 * using old_conf as buffer.
 	 */
-	mx3fb_write_reg(mx3fb, (((div / 8) - 1) << 22) | div, DI_DISP3_TIME_CONF);
+	old_conf = div;
+	old_conf |= (((div * mx3fb_pdata->pix_clk_start) / 16) >> 2) << 12;
+	old_conf |= (((div * (mx3fb_pdata->pix_clk_start +
+		              mx3fb_pdata->pix_clk_width)) / 16) >> 2) << 22;
+
+	mx3fb_write_reg(mx3fb, old_conf , DI_DISP3_TIME_CONF);
 
 	/* DI settings */
 	old_conf = mx3fb_read_reg(mx3fb, DI_DISP_IF_CONF) & 0x78FFFFFF;
@@ -1444,6 +1457,7 @@ static int mx3fb_probe(struct platform_device *pdev)
 	dma_cap_mask_t mask;
 	struct dma_chan *chan;
 	struct dma_chan_request rq;
+	struct mx3fb_platform_data *pdata = pdev->dev.platform_data;
 
 	/*
 	 * Display Interface (DI) and Synchronous Display Controller (SDC)
@@ -1459,6 +1473,19 @@ static int mx3fb_probe(struct platform_device *pdev)
 
 	spin_lock_init(&mx3fb->lock);
 
+	/*
+	 * If pixel clock configuration is not defined or misconfigured, fall
+	 * through the default: rising edge at the beginning of the period and
+	 * falling edge a bit before the half.
+	 */
+	if ((!pdata->pix_clk_start && !pdata->pix_clk_width) ||
+	    ((pdata->pix_clk_start + pdata->pix_clk_width) > 16) {
+		pr_debug("mx3fb: Default waveform for Pixel clock signal.\n");
+		pdata->pix_clk_start = 0;
+		pdata->pix_clk_width = 7;
+	}
+	mx3fb->pdata = pdata;
+
 	mx3fb->reg_base = ioremap(sdc_reg->start, resource_size(sdc_reg));
 	if (!mx3fb->reg_base) {
 		ret = -ENOMEM;
-- 
1.6.3.3
