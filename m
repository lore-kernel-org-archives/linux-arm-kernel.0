From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Oct 2013 19:01:23 +0000
Subject: imx-drm: Add HDMI support
In-Reply-To: <CAHCPf3viBN5RwxPYGN_gMhbgbJbwJAQDJKHHYFyLUFBqvsFztg@mail.gmail.com>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
 <1382039535.976669051@f130.i.mail.ru>
 <CAHCPf3viBN5RwxPYGN_gMhbgbJbwJAQDJKHHYFyLUFBqvsFztg@mail.gmail.com>
Message-ID: <20131030190123.GM16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 01:01:15PM -0500, Matt Sealey wrote:
> I seem to
> remember it needs to be within 2% - 1 bit extra on the fraction and
> you're 3 times that over the range of accectable clocks monitors MUST
> accept by specification.

I think 2% may be too generous - that's what I originally tried when
fiddling around with this and it wasn't good enough in some
circumstances for my TV to produce a picture.

> On i.MX51, too, the IPU HSC can't go above 133MHz without making the
> system unstable, so any mode that needs 148MHz (most high HDMI modes)
> won't work.

That's where validating the modes you're prepared to support becomes
important, and there's hooks in DRM for doing that.  If you can't
support those with 148.5MHz dotclocks, then you have to return
MODE_CLOCK_HIGH from the connector's mode_valid callback.  That will
result in DRM pruning the modes reported by the connector to those
which the display hardware can support.

> There's no good reason to use the DI internal clock from IPU HSC,
> unless you can guarantee an EXACT rate coming out (i.e. if you need
> 64MHz, then you can get that with 128MHz/2.0 - which is fine.)

This is exactly what I'm doing on my Carrier-1 board.  If the output
can use the the internal clock (iow, if IPU_DI_CLKMODE_EXT is clear)
and the IPU clock can generate the dotclock within 1% of the requested
rate, then we set the DI to use the IPU clock and set the divisor
appropriately.

If the IPU clock can't satisfy the dot clock within 1%, I try to set
the external DI clock to the required rate, read it back and calculate
the required DI integer divisor.  Yes, I could allow some fractional
divisors here, but at the moment it's easier not to.

Each of the four cases I handle separately - and I've gotten rid of
the horrid CCF stuff in ipu-di.c: there's really no need for that
additional complication here, we're not sharing this mux and divisor
which are both internal to the DI with anything else.

Consequently, my ipu-di.c (relative to v3.12-rc7) looks like this,
and works pretty well with HDMI, providing a stable picture with
almost all mode configurations reported by my TV.

It's also fewer lines too. :)

 drivers/staging/imx-drm/ipu-v3/ipu-di.c |  328 ++++++++++---------------------
 1 files changed, 105 insertions(+), 223 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
index d766e18bfca0..82a9ebad697c 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
@@ -19,9 +19,6 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/clkdev.h>
 
 #include "imx-ipu-v3.h"
 #include "ipu-prv.h"
@@ -33,10 +30,7 @@ struct ipu_di {
 	struct clk *clk_di;	/* display input clock */
 	struct clk *clk_ipu;	/* IPU bus clock */
 	struct clk *clk_di_pixel; /* resulting pixel clock */
-	struct clk_hw clk_hw_out;
-	char *clk_name;
 	bool inuse;
-	unsigned long clkflags;
 	struct ipu_soc *ipu;
 };
 
@@ -141,130 +135,6 @@ static inline void ipu_di_write(struct ipu_di *di, u32 value, unsigned offset)
 	writel(value, di->base + offset);
 }
 
-static int ipu_di_clk_calc_div(unsigned long inrate, unsigned long outrate)
-{
-	u64 tmp = inrate;
-	int div;
-
-	tmp *= 16;
-
-	do_div(tmp, outrate);
-
-	div = tmp;
-
-	if (div < 0x10)
-		div = 0x10;
-
-#ifdef WTF_IS_THIS
-	/*
-	 * Freescale has this in their Kernel. It is neither clear what
-	 * it does nor why it does it
-	 */
-	if (div & 0x10)
-		div &= ~0x7;
-	else {
-		/* Round up divider if it gets us closer to desired pix clk */
-		if ((div & 0xC) == 0xC) {
-			div += 0x10;
-			div &= ~0xF;
-		}
-	}
-#endif
-	return div;
-}
-
-static unsigned long clk_di_recalc_rate(struct clk_hw *hw,
-		unsigned long parent_rate)
-{
-	struct ipu_di *di = container_of(hw, struct ipu_di, clk_hw_out);
-	unsigned long outrate;
-	u32 div = ipu_di_read(di, DI_BS_CLKGEN0);
-
-	if (div < 0x10)
-		div = 0x10;
-
-	outrate = (parent_rate / div) * 16;
-
-	return outrate;
-}
-
-static long clk_di_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *prate)
-{
-	struct ipu_di *di = container_of(hw, struct ipu_di, clk_hw_out);
-	unsigned long outrate;
-	int div;
-	u32 val;
-
-	div = ipu_di_clk_calc_div(*prate, rate);
-
-	outrate = (*prate / div) * 16;
-
-	val = ipu_di_read(di, DI_GENERAL);
-
-	if (!(val & DI_GEN_DI_CLK_EXT) && outrate > *prate / 2)
-		outrate = *prate / 2;
-
-	dev_dbg(di->ipu->dev,
-		"%s: inrate: %ld div: 0x%08x outrate: %ld wanted: %ld\n",
-			__func__, *prate, div, outrate, rate);
-
-	return outrate;
-}
-
-static int clk_di_set_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long parent_rate)
-{
-	struct ipu_di *di = container_of(hw, struct ipu_di, clk_hw_out);
-	int div;
-	u32 clkgen0;
-
-	clkgen0 = ipu_di_read(di, DI_BS_CLKGEN0) & ~0xfff;
-
-	div = ipu_di_clk_calc_div(parent_rate, rate);
-
-	ipu_di_write(di, clkgen0 | div, DI_BS_CLKGEN0);
-
-	dev_dbg(di->ipu->dev, "%s: inrate: %ld desired: %ld div: 0x%08x\n",
-			__func__, parent_rate, rate, div);
-	return 0;
-}
-
-static u8 clk_di_get_parent(struct clk_hw *hw)
-{
-	struct ipu_di *di = container_of(hw, struct ipu_di, clk_hw_out);
-	u32 val;
-
-	val = ipu_di_read(di, DI_GENERAL);
-
-	return val & DI_GEN_DI_CLK_EXT ? 1 : 0;
-}
-
-static int clk_di_set_parent(struct clk_hw *hw, u8 index)
-{
-	struct ipu_di *di = container_of(hw, struct ipu_di, clk_hw_out);
-	u32 val;
-
-	val = ipu_di_read(di, DI_GENERAL);
-
-	if (index)
-		val |= DI_GEN_DI_CLK_EXT;
-	else
-		val &= ~DI_GEN_DI_CLK_EXT;
-
-	ipu_di_write(di, val, DI_GENERAL);
-
-	return 0;
-}
-
-static struct clk_ops clk_di_ops = {
-	.round_rate = clk_di_round_rate,
-	.set_rate = clk_di_set_rate,
-	.recalc_rate = clk_di_recalc_rate,
-	.set_parent = clk_di_set_parent,
-	.get_parent = clk_di_get_parent,
-};
-
 static void ipu_di_data_wave_config(struct ipu_di *di,
 				     int wave_gen,
 				     int access_size, int component_size)
@@ -528,42 +398,58 @@ static void ipu_di_sync_config_noninterlaced(struct ipu_di *di,
 		ipu_di_sync_config(di, cfg_vga, 0, ARRAY_SIZE(cfg_vga));
 }
 
-int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
+static void ipu_di_config_clock(struct ipu_di *di,
+	const struct ipu_di_signal_cfg *sig)
 {
-	u32 reg;
-	u32 di_gen, vsync_cnt;
-	u32 div;
-	u32 h_total, v_total;
-	int ret;
-	unsigned long round;
-	struct clk *parent;
+	struct clk *clk;
+	unsigned clkgen0;
+	uint32_t val;
 
-	dev_dbg(di->ipu->dev, "disp %d: panel size = %d x %d\n",
-		di->id, sig->width, sig->height);
+	if (sig->clkflags & IPU_DI_CLKMODE_EXT) {
+		/*
+		 * CLKMODE_EXT means we must use the DI clock: this is
+		 * needed for things like LVDS which needs to feed the
+		 * DI and LDB with the same pixel clock.
+		 */
+		clk = di->clk_di;
+
+		if (sig->clkflags & IPU_DI_CLKMODE_SYNC) {
+			/*
+			 * CLKMODE_SYNC means that we want the DI to be
+			 * clocked at the same rate as the parent clock.
+			 * This is needed (eg) for LDB which needs to be
+			 * fed with the same pixel clock.  We assume that
+			 * the LDB clock has already been set correctly.
+			 */
+			clkgen0 = 1 << 4;
+		} else {
+			/*
+			 * We can use the divider.  We should really have
+			 * a flag here indicating whether the bridge can
+			 * cope with a fractional divider or not.  For the
+			 * time being, let's go for simplicitly and
+			 * reliability.
+			 */
+			unsigned long in_rate;
+			unsigned div;
 
-	if ((sig->v_sync_width == 0) || (sig->h_sync_width == 0))
-		return -EINVAL;
+			clk_set_rate(clk, sig->pixelclock);
 
-	dev_dbg(di->ipu->dev, "Clocks: IPU %luHz DI %luHz Needed %luHz\n",
-		clk_get_rate(di->clk_ipu),
-		clk_get_rate(di->clk_di),
-		sig->pixelclock);
+			in_rate = clk_get_rate(clk);
+			div = (in_rate + sig->pixelclock / 2) / sig->pixelclock;
+			if (div == 0)
+				div = 1;
 
-	/*
-	 * CLKMODE_EXT means we must use the DI clock: this is needed
-	 * for things like LVDS which needs to feed the DI and LDB with
-	 * the same pixel clock.
-	 *
-	 * For other interfaces, we can arbitarily select between the DI
-	 * specific clock and the internal IPU clock.  See DI_GENERAL
-	 * bit 20.  We select the IPU clock if it can give us a clock
-	 * rate within 1% of the requested frequency, otherwise we use
-	 * the DI clock.
-	 */
-	round = sig->pixelclock;
-	if (sig->clkflags & IPU_DI_CLKMODE_EXT) {
-		parent = di->clk_di;
+			clkgen0 = div << 4;
+		}
 	} else {
+		/*
+		 * For other interfaces, we can arbitarily select between
+		 * the DI specific clock and the internal IPU clock.  See
+		 * DI_GENERAL bit 20.  We select the IPU clock if it can
+		 * give us a clock rate within 1% of the requested frequency,
+		 * otherwise we use the DI clock.
+		 */
 		unsigned long rate, clkrate;
 		unsigned div, error;
 
@@ -578,54 +464,80 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 
 		/* Allow a 1% error */
 		if (error < 1010 && error >= 990) {
-			parent = di->clk_ipu;
+			clk = di->clk_ipu;
+
+			clkgen0 = div << 4;
 		} else {
-			parent = di->clk_di;
+			unsigned long in_rate;
+			unsigned div;
+
+			clk = di->clk_di;
 
-			ret = clk_set_rate(parent, sig->pixelclock);
-			if (ret)
-				dev_err(di->ipu->dev, "Setting of DI clock failed: %d\n", ret);
+			clk_set_rate(clk, sig->pixelclock);
 
-			/* Use the integer divisor rate - avoid fractional dividers */
-			round = rate;
+			in_rate = clk_get_rate(clk);
+			div = (in_rate + sig->pixelclock / 2) / sig->pixelclock;
+			if (div == 0)
+				div = 1;
+
+			clkgen0 = div << 4;
 		}
 	}
 
-	ret = clk_set_parent(di->clk_di_pixel, parent);
-	if (ret) {
-		dev_err(di->ipu->dev,
-			"setting pixel clock to parent %s failed with %d\n",
-				__clk_get_name(parent), ret);
-		return ret;
-	}
+	di->clk_di_pixel = clk;
+
+	/* Set the divider */
+	ipu_di_write(di, clkgen0, DI_BS_CLKGEN0);
 
 	/*
-	 * CLKMODE_SYNC means that we want the DI to be clocked at the
-	 * same rate as the parent clock.  This is needed (eg) for LDB
-	 * which needs to be fed with the same pixel clock.
-	 *
-	 * Note: clk_set_rate(clk, clk_round_rate(clk, rate)) is the
-	 * same as clk_set_rate(clk, rate);
+	 * Set the high/low periods.  Bits 24:16 give us the falling edge,
+	 * and bits 8:0 give the rising edge.  LSB is fraction, and is
+	 * based on the divider above.  We want a 50% duty cycle, so set
+	 * the falling edge to be half the divider.
 	 */
-	if (sig->clkflags & IPU_DI_CLKMODE_SYNC)
-		round = clk_get_rate(parent);
+	ipu_di_write(di, (clkgen0 >> 4) << 16, DI_BS_CLKGEN1);
 
-	ret = clk_set_rate(di->clk_di_pixel, round);
+	/* Finally select the input clock */
+	val = ipu_di_read(di, DI_GENERAL) & ~DI_GEN_DI_CLK_EXT;
+	if (clk == di->clk_di)
+		val |= DI_GEN_DI_CLK_EXT;
+	ipu_di_write(di, val, DI_GENERAL);
 
-	dev_dbg(di->ipu->dev, "Want %luHz IPU %luHz DI %luHz using %s, got %luHz\n",
+	dev_dbg(di->ipu->dev, "Want %luHz IPU %luHz DI %luHz using %s, %luHz\n",
 		sig->pixelclock,
 		clk_get_rate(di->clk_ipu),
 		clk_get_rate(di->clk_di),
-		parent == di->clk_di ? "DI" : "IPU",
-		clk_get_rate(di->clk_di_pixel));
+		clk == di->clk_di ? "DI" : "IPU",
+		clk_get_rate(di->clk_di_pixel) / (clkgen0 >> 4));
+}
+
+int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
+{
+	u32 reg;
+	u32 di_gen, vsync_cnt;
+	u32 div;
+	u32 h_total, v_total;
+
+	dev_dbg(di->ipu->dev, "disp %d: panel size = %d x %d\n",
+		di->id, sig->width, sig->height);
+
+	if ((sig->v_sync_width == 0) || (sig->h_sync_width == 0))
+		return -EINVAL;
 
 	h_total = sig->width + sig->h_sync_width + sig->h_start_width +
 		sig->h_end_width;
 	v_total = sig->height + sig->v_sync_width + sig->v_start_width +
 		sig->v_end_width;
 
+	dev_dbg(di->ipu->dev, "Clocks: IPU %luHz DI %luHz Needed %luHz\n",
+		clk_get_rate(di->clk_ipu),
+		clk_get_rate(di->clk_di),
+		sig->pixelclock);
+
 	mutex_lock(&di_mutex);
 
+	ipu_di_config_clock(di, sig);
+
 	div = ipu_di_read(di, DI_BS_CLKGEN0) & 0xfff;
 	div = div / 16;		/* Now divider is integer portion */
 
@@ -709,7 +621,11 @@ EXPORT_SYMBOL_GPL(ipu_di_init_sync_panel);
 
 int ipu_di_enable(struct ipu_di *di)
 {
-	int ret = clk_prepare_enable(di->clk_di_pixel);
+	int ret;
+
+	WARN_ON(IS_ERR(di->clk_di_pixel));
+
+	ret = clk_prepare_enable(di->clk_di_pixel);
 	if (ret)
 		return ret;
 
@@ -721,6 +637,8 @@ EXPORT_SYMBOL_GPL(ipu_di_enable);
 
 int ipu_di_disable(struct ipu_di *di)
 {
+	WARN_ON(IS_ERR(di->clk_di_pixel));
+
 	ipu_module_disable(di->ipu, di->module);
 
 	clk_disable_unprepare(di->clk_di_pixel);
@@ -776,13 +694,6 @@ int ipu_di_init(struct ipu_soc *ipu, struct device *dev, int id,
 		u32 module, struct clk *clk_ipu)
 {
 	struct ipu_di *di;
-	int ret;
-	const char *di_parent[2];
-	struct clk_init_data init = {
-		.ops = &clk_di_ops,
-		.num_parents = 2,
-		.flags = 0,
-	};
 
 	if (id > 1)
 		return -ENODEV;
@@ -804,45 +715,16 @@ int ipu_di_init(struct ipu_soc *ipu, struct device *dev, int id,
 	if (!di->base)
 		return -ENOMEM;
 
-	di_parent[0] = __clk_get_name(di->clk_ipu);
-	di_parent[1] = __clk_get_name(di->clk_di);
-
 	ipu_di_write(di, 0x10, DI_BS_CLKGEN0);
 
-	init.parent_names = (const char **)&di_parent;
-	di->clk_name = kasprintf(GFP_KERNEL, "%s_di%d_pixel",
-			dev_name(dev), id);
-	if (!di->clk_name)
-		return -ENOMEM;
-
-	init.name = di->clk_name;
-
-	di->clk_hw_out.init = &init;
-	di->clk_di_pixel = clk_register(dev, &di->clk_hw_out);
-
-	if (IS_ERR(di->clk_di_pixel)) {
-		ret = PTR_ERR(di->clk_di_pixel);
-		goto failed_clk_register;
-	}
-
 	dev_dbg(dev, "DI%d base: 0x%08lx remapped to %p\n",
 			id, base, di->base);
 	di->inuse = false;
 	di->ipu = ipu;
 
 	return 0;
-
-failed_clk_register:
-
-	kfree(di->clk_name);
-
-	return ret;
 }
 
 void ipu_di_exit(struct ipu_soc *ipu, int id)
 {
-	struct ipu_di *di = ipu->di_priv[id];
-
-	clk_unregister(di->clk_di_pixel);
-	kfree(di->clk_name);
 }
