From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 19 Aug 2015 14:40:47 -0400 (EDT)
Subject: [PATCH] drivers/clk: appropriate __init annotation for const data
In-Reply-To: <20150811231416.31346.83289@quantum>
References: <alpine.LFD.2.20.1507281430130.26147@knanqh.ubzr>
 <20150811231416.31346.83289@quantum>
Message-ID: <alpine.LFD.2.20.1508191437410.25645@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Aug 2015, Michael Turquette wrote:

> Quoting Nicolas Pitre (2015-07-28 16:43:20)
> > 
> > Init data marked const should be annotated with __initconst for
> > correctness and not __initdata.  This also fixes LTO builds that
> > otherwise fail with section mismatch errors.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> Thanks for the patch Nico. Applied.


Is it possible for you to amend that patch with the following?

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 5404a001c3..3f6f7ad394 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -293,7 +293,7 @@ stm32f4_rcc_lookup_clk(struct of_phandle_args *clkspec, void *data)
 	return clks[i];
 }
 
-static const char *const sys_parents[] __initconst =   { "hsi", NULL, "pll" };
+static const char *sys_parents[] __initdata =   { "hsi", NULL, "pll" };
 
 static const struct clk_div_table ahb_div_table[] = {
 	{ 0x0,   1 }, { 0x1,   1 }, { 0x2,   1 }, { 0x3,   1 },

Turns out that sys_parents[] is actually written to.


Nicolas
