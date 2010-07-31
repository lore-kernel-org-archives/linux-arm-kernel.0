From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jul 2010 14:26:30 +0100
Subject: RFC ARM LPC32xx AMBA apb_pclk changes
In-Reply-To: <20100731094442.GF23886@n2100.arm.linux.org.uk>
References: <AANLkTi=eqwRMYLAUoXkuBgTrPWHsj_XbfQF4FgNOxiXd@mail.gmail.com>
	<20100731094442.GF23886@n2100.arm.linux.org.uk>
Message-ID: <20100731132630.GB27064@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 31, 2010 at 10:44:42AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 29, 2010 at 05:24:47PM -0700, Kevin Wells wrote:
> > This is a first cut at adding apb_pclk support for the AMBA bus driver.
> > 
> > The temporary clock enable/disable wrappers around the amba_register
> > function will no longer be needed. A "apb_pclk" con_id wasn't added,
> > using only the matching device IDs used by the AMBA drivers. Because
> > the AMBA driver attempts to turn off the LCD clock prior to exist, the
> > workaround for the LCD clock enable needs to be handled with
> > clk_enable so it will stay on after the AMBA driver disables it's clock.
> 
> I think the clcd driver should be fixed not to do the first disable,
> rather than work-around the problem like this.

Something like this:

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index afe21e6..1c2c683 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -80,7 +80,10 @@ static void clcdfb_disable(struct clcd_fb *fb)
 	/*
 	 * Disable CLCD clock source.
 	 */
-	clk_disable(fb->clk);
+	if (fb->clk_enabled) {
+		fb->clk_enabled = false;
+		clk_disable(fb->clk);
+	}
 }
 
 static void clcdfb_enable(struct clcd_fb *fb, u32 cntl)
@@ -88,7 +91,10 @@ static void clcdfb_enable(struct clcd_fb *fb, u32 cntl)
 	/*
 	 * Enable the CLCD clock source.
 	 */
-	clk_enable(fb->clk);
+	if (!fb->clk_enabled) {
+		fb->clk_enabled = true;
+		clk_enable(fb->clk);
+	}
 
 	/*
 	 * Bring up by first enabling..
diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index ca16c38..be33b3a 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -150,6 +150,7 @@ struct clcd_fb {
 	u16			off_cntl;
 	u32			clcd_cntl;
 	u32			cmap[16];
+	bool			clk_enabled;
 };
 
 static inline void clcdfb_decode(struct clcd_fb *fb, struct clcd_regs *regs)
