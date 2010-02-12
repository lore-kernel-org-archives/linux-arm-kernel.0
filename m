From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Feb 2010 16:41:24 +0000
Subject: [PATCH 12/14] AMBA: CLCD: LPC32XX register swap in the clcd
	header file
In-Reply-To: <083DF309106F364B939360100EC290F805C8D3D7DD@eu1rdcrdc1wx030.exi.nxp.com>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-13-git-send-email-wellsk40@gmail.com>
	<20100212143136.GA18595@n2100.arm.linux.org.uk>
	<083DF309106F364B939360100EC290F805C8D3D7DD@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20100212164124.GE18595@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2010 at 05:32:58PM +0100, Kevin Wells wrote:
> > 
> > On Mon, Feb 08, 2010 at 04:11:33PM -0800, wellsk40 at gmail.com wrote:
> > > The CTRL and IENB registers need to be swapped for the LPC32XX
> > > arch.
> > 
> > Is your peripheral a PL110 or PL111 ?
> > 
> 
> This part uses an unmodified PL111.

In which case, could you test this patch please:

    Video: ARM CLCD: Better fix for swapped IENB and CNTL registers
    
    On PL111, as found on Realview and other platforms, these registers are
    always arranged as CNTL then IENB.  On PL110, these registers are IENB
    then CNTL, except on Versatile platforms.
    
    Re-arrange the handling of these register swaps so that PL111 always
    gets it right without resorting to ifdefs, leaving the only case needing
    special handling being PL110 on Versatile.
    
    Fill out amba/clcd.h with the PL110/PL111 register definition
    differences in case someone tries to use the PL110 specific definitions
    on PL111.
    
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

 drivers/video/amba-clcd.c |   31 ++++++++++++++++++++++++-------
 include/linux/amba/clcd.h |   33 +++++++++++++++++----------------
 2 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index a21efcd..afe21e6 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -65,16 +65,16 @@ static void clcdfb_disable(struct clcd_fb *fb)
 	if (fb->board->disable)
 		fb->board->disable(fb);
 
-	val = readl(fb->regs + CLCD_CNTL);
+	val = readl(fb->regs + fb->off_cntl);
 	if (val & CNTL_LCDPWR) {
 		val &= ~CNTL_LCDPWR;
-		writel(val, fb->regs + CLCD_CNTL);
+		writel(val, fb->regs + fb->off_cntl);
 
 		clcdfb_sleep(20);
 	}
 	if (val & CNTL_LCDEN) {
 		val &= ~CNTL_LCDEN;
-		writel(val, fb->regs + CLCD_CNTL);
+		writel(val, fb->regs + fb->off_cntl);
 	}
 
 	/*
@@ -94,7 +94,7 @@ static void clcdfb_enable(struct clcd_fb *fb, u32 cntl)
 	 * Bring up by first enabling..
 	 */
 	cntl |= CNTL_LCDEN;
-	writel(cntl, fb->regs + CLCD_CNTL);
+	writel(cntl, fb->regs + fb->off_cntl);
 
 	clcdfb_sleep(20);
 
@@ -102,7 +102,7 @@ static void clcdfb_enable(struct clcd_fb *fb, u32 cntl)
 	 * and now apply power.
 	 */
 	cntl |= CNTL_LCDPWR;
-	writel(cntl, fb->regs + CLCD_CNTL);
+	writel(cntl, fb->regs + fb->off_cntl);
 
 	/*
 	 * finally, enable the interface.
@@ -233,7 +233,7 @@ static int clcdfb_set_par(struct fb_info *info)
 		readl(fb->regs + CLCD_TIM0), readl(fb->regs + CLCD_TIM1),
 		readl(fb->regs + CLCD_TIM2), readl(fb->regs + CLCD_TIM3),
 		readl(fb->regs + CLCD_UBAS), readl(fb->regs + CLCD_LBAS),
-		readl(fb->regs + CLCD_IENB), readl(fb->regs + CLCD_CNTL));
+		readl(fb->regs + fb->off_ienb), readl(fb->regs + fb->off_cntl));
 #endif
 
 	return 0;
@@ -345,6 +345,23 @@ static int clcdfb_register(struct clcd_fb *fb)
 {
 	int ret;
 
+	/*
+	 * ARM PL111 always has IENB at 0x1c; it's only PL110
+	 * which is reversed on some platforms.
+	 */
+	if (amba_manf(fb->dev) == 0x41 && amba_part(fb->dev) == 0x111) {
+		fb->off_ienb = CLCD_PL111_IENB;
+		fb->off_cntl = CLCD_PL111_CNTL;
+	} else {
+#ifdef CONFIG_ARCH_VERSATILE
+		fb->off_ienb = CLCD_PL111_IENB;
+		fb->off_cntl = CLCD_PL111_CNTL;
+#else
+		fb->off_ienb = CLCD_PL110_IENB;
+		fb->off_cntl = CLCD_PL110_CNTL;
+#endif
+	}
+
 	fb->clk = clk_get(&fb->dev->dev, NULL);
 	if (IS_ERR(fb->clk)) {
 		ret = PTR_ERR(fb->clk);
@@ -416,7 +433,7 @@ static int clcdfb_register(struct clcd_fb *fb)
 	/*
 	 * Ensure interrupts are disabled.
 	 */
-	writel(0, fb->regs + CLCD_IENB);
+	writel(0, fb->regs + fb->off_ienb);
 
 	fb_set_var(&fb->fb, &fb->fb.var);
 
diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index 29c0448..ca16c38 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -21,22 +21,21 @@
 #define CLCD_UBAS 		0x00000010
 #define CLCD_LBAS 		0x00000014
 
-#if !defined(CONFIG_ARCH_VERSATILE) && !defined(CONFIG_ARCH_REALVIEW)
-#define CLCD_IENB 		0x00000018
-#define CLCD_CNTL 		0x0000001c
-#else
-/*
- * Someone rearranged these two registers on the Versatile
- * platform...
- */
-#define CLCD_IENB 		0x0000001c
-#define CLCD_CNTL 		0x00000018
-#endif
-
-#define CLCD_STAT 		0x00000020
-#define CLCD_INTR 		0x00000024
-#define CLCD_UCUR 		0x00000028
-#define CLCD_LCUR 		0x0000002C
+#define CLCD_PL110_IENB		0x00000018
+#define CLCD_PL110_CNTL		0x0000001c
+#define CLCD_PL110_STAT		0x00000020
+#define CLCD_PL110_INTR 	0x00000024
+#define CLCD_PL110_UCUR		0x00000028
+#define CLCD_PL110_LCUR		0x0000002C
+
+#define CLCD_PL111_CNTL		0x00000018
+#define CLCD_PL111_IENB		0x0000001c
+#define CLCD_PL111_RIS		0x00000020
+#define CLCD_PL111_MIS		0x00000024
+#define CLCD_PL111_ICR		0x00000028
+#define CLCD_PL111_UCUR		0x0000002c
+#define CLCD_PL111_LCUR		0x00000030
+
 #define CLCD_PALL 		0x00000200
 #define CLCD_PALETTE		0x00000200
 
@@ -147,6 +146,8 @@ struct clcd_fb {
 	struct clcd_board	*board;
 	void			*board_data;
 	void __iomem		*regs;
+	u16			off_ienb;
+	u16			off_cntl;
 	u32			clcd_cntl;
 	u32			cmap[16];
 };
