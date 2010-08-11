From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 11 Aug 2010 16:03:04 -0700
Subject: [PATCH 2/2] video: amba_clcd: Seperate controller and register clock
	enables
In-Reply-To: <1281567784-12684-1-git-send-email-wellsk40@gmail.com>
References: <1281567784-12684-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1281567784-12684-3-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

To optimize power for architectures that disable the clock to the
clcd primecell, clock enable logic for the controller (maintaining
the LCD) and accessing the registers (AMBA bus clock) has been
seperated.

When accessing registers, the register clock is enabled prior to
access and then disabled when accesses are complete. The clcd probe
function will disable the clock enabled by the AMBA bus driver prior
to exiting probe. The clock is re-enabled prior to exiting remove.
amba_pclk_enable() and amba_pclk_disable() functions macros are used
for register clock enable/disable. All calls to the macros are
balanced and un-nested.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 drivers/video/amba-clcd.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 1c2c683..a67b33a 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -65,6 +65,8 @@ static void clcdfb_disable(struct clcd_fb *fb)
 	if (fb->board->disable)
 		fb->board->disable(fb);
 
+	amba_pclk_enable(fb->dev);
+
 	val = readl(fb->regs + fb->off_cntl);
 	if (val & CNTL_LCDPWR) {
 		val &= ~CNTL_LCDPWR;
@@ -77,6 +79,8 @@ static void clcdfb_disable(struct clcd_fb *fb)
 		writel(val, fb->regs + fb->off_cntl);
 	}
 
+	amba_pclk_disable(fb->dev);
+
 	/*
 	 * Disable CLCD clock source.
 	 */
@@ -96,6 +100,8 @@ static void clcdfb_enable(struct clcd_fb *fb, u32 cntl)
 		clk_enable(fb->clk);
 	}
 
+	amba_pclk_enable(fb->dev);
+
 	/*
 	 * Bring up by first enabling..
 	 */
@@ -110,6 +116,8 @@ static void clcdfb_enable(struct clcd_fb *fb, u32 cntl)
 	cntl |= CNTL_LCDPWR;
 	writel(cntl, fb->regs + fb->off_cntl);
 
+	amba_pclk_disable(fb->dev);
+
 	/*
 	 * finally, enable the interface.
 	 */
@@ -217,6 +225,7 @@ static int clcdfb_set_par(struct fb_info *info)
 	fb->board->decode(fb, &regs);
 
 	clcdfb_disable(fb);
+	amba_pclk_enable(fb->dev);
 
 	writel(regs.tim0, fb->regs + CLCD_TIM0);
 	writel(regs.tim1, fb->regs + CLCD_TIM1);
@@ -229,9 +238,11 @@ static int clcdfb_set_par(struct fb_info *info)
 
 	fb->clcd_cntl = regs.cntl;
 
+	amba_pclk_disable(fb->dev);
 	clcdfb_enable(fb, regs.cntl);
 
 #ifdef DEBUG
+	amba_pclk_enable(fb->dev);
 	printk(KERN_INFO
 	       "CLCD: Registers set to\n"
 	       "  %08x %08x %08x %08x\n"
@@ -240,6 +251,7 @@ static int clcdfb_set_par(struct fb_info *info)
 		readl(fb->regs + CLCD_TIM2), readl(fb->regs + CLCD_TIM3),
 		readl(fb->regs + CLCD_UBAS), readl(fb->regs + CLCD_LBAS),
 		readl(fb->regs + fb->off_ienb), readl(fb->regs + fb->off_cntl));
+	amba_pclk_disable(fb->dev);
 #endif
 
 	return 0;
@@ -290,8 +302,10 @@ clcdfb_setcolreg(unsigned int regno, unsigned int red, unsigned int green,
 			mask = 0xffff0000;
 		}
 
+		amba_pclk_enable(fb->dev);
 		val = readl(fb->regs + hw_reg) & mask;
 		writel(val | newval, fb->regs + hw_reg);
+		amba_pclk_disable(fb->dev);
 	}
 
 	return regno > 255;
@@ -492,6 +506,9 @@ static int clcdfb_probe(struct amba_device *dev, struct amba_id *id)
 
 	ret = clcdfb_register(fb); 
 	if (ret == 0) {
+		/* Disable AMBA PCLK */
+		amba_pclk_disable(dev);
+
 		amba_set_drvdata(dev, fb);
 		goto out;
 	}
@@ -524,6 +541,9 @@ static int clcdfb_remove(struct amba_device *dev)
 
 	amba_release_regions(dev);
 
+	/* Restore AMBA PCLK */
+	amba_pclk_enable(dev);
+
 	return 0;
 }
 
-- 
1.7.1.1
