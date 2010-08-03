From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  3 Aug 2010 09:03:59 -0700
Subject: [PATCH 2/2] amba_pl022: Add support for amba peripheral clocking
In-Reply-To: <1280851439-25468-1-git-send-email-wellsk40@gmail.com>
References: <1280851439-25468-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1280851439-25468-3-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

For register based accesses, enable the AMBA peripheral clock
prior to a register access and disable it after a register access.
The AMBA PCLK is disabled on probe and restored on remove.
---
 drivers/video/amba-clcd.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 1c2c683..1d2fe32 100644
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
+	amba_pclk_disable(fb->dev);
 
 	writel(regs.tim0, fb->regs + CLCD_TIM0);
 	writel(regs.tim1, fb->regs + CLCD_TIM1);
@@ -242,6 +251,8 @@ static int clcdfb_set_par(struct fb_info *info)
 		readl(fb->regs + fb->off_ienb), readl(fb->regs + fb->off_cntl));
 #endif
 
+	amba_pclk_disable(fb->dev);
+
 	return 0;
 }
 
@@ -290,8 +301,10 @@ clcdfb_setcolreg(unsigned int regno, unsigned int red, unsigned int green,
 			mask = 0xffff0000;
 		}
 
+		amba_pclk_enable(fb->dev);
 		val = readl(fb->regs + hw_reg) & mask;
 		writel(val | newval, fb->regs + hw_reg);
+		amba_pclk_disable(fb->dev);
 	}
 
 	return regno > 255;
@@ -492,6 +505,9 @@ static int clcdfb_probe(struct amba_device *dev, struct amba_id *id)
 
 	ret = clcdfb_register(fb); 
 	if (ret == 0) {
+		/* Disable AMBA PCLK */
+		amba_pclk_disable(dev);
+
 		amba_set_drvdata(dev, fb);
 		goto out;
 	}
@@ -524,6 +540,9 @@ static int clcdfb_remove(struct amba_device *dev)
 
 	amba_release_regions(dev);
 
+	/* Restore AMBA PCLK */
+	amba_pclk_enable(dev);
+
 	return 0;
 }
 
-- 
1.7.1.1
