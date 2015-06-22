From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 22 Jun 2015 16:21:14 -0700
Subject: [PATCH v3 2/3] clk: stm32: Add clock driver for STM32F4[23]xxx
 devices
In-Reply-To: <1433966978-24422-3-git-send-email-daniel.thompson@linaro.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
 <1433966978-24422-1-git-send-email-daniel.thompson@linaro.org>
 <1433966978-24422-3-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150622232114.GK22132@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10, Daniel Thompson wrote:
> The driver supports decoding and statically modelling PLL state (i.e.
> we inherit state from bootloader) and provides support for all
> peripherals that support simple one-bit gated clocks. The covers all
> peripherals whose clocks come from the AHB, APB1 or APB2 buses.
> 
> It has been tested on an STM32F429I-Discovery board. The clock counts
> for TIM2, USART1 and SYSTICK are all set correctly and the wall clock
> looks OK when checked with a stopwatch. I have also tested a prototype
> driver for the RNG hardware. The RNG clock is correctly enabled by the
> framework (also did inverse test and proved that by changing DT to
> configure the wrong clock bit then we observe the RNG driver to fail).
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

I also squashed in some sparse fixes. Please check.

drivers/clk/clk-stm32f4.c:135:44:
warning: constant 0x000000f17ef417ff is so big it is long
drivers/clk/clk-stm32f4.c:137:44:
warning: constant 0x04777f33f6fec9ff is so big it is long
drivers/clk/clk-stm32f4.c:206:12:
warning: symbol 'clk_register_apb_mul' was not declared. Should
it be static?
drivers/clk/clk-stm32f4.c:285:12:
warning: symbol 'stm32f4_rcc_lookup_clk' was not declared. Should
it be static?

---8<----
diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index c825bbd4335f..b9b12a742970 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -132,9 +132,9 @@ enum { SYSTICK, FCLK };
  * This bitmask tells us which bit offsets (0..192) on STM32F4[23]xxx
  * have gate bits associated with them. Its combined hweight is 71.
  */
-static const u64 stm32f42xx_gate_map[] = { 0x000000f17ef417ff,
-					   0x0000000000000001,
-					   0x04777f33f6fec9ff };
+static const u64 stm32f42xx_gate_map[] = { 0x000000f17ef417ffull,
+					   0x0000000000000001ull,
+					   0x04777f33f6fec9ffull };
 
 static struct clk *clks[MAX_CLKS];
 static DEFINE_SPINLOCK(stm32f4_clk_lock);
@@ -186,7 +186,7 @@ static long clk_apb_mul_round_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 static int clk_apb_mul_set_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long parent_rate)
+				unsigned long parent_rate)
 {
 	/*
 	 * We must report success but we can do so unconditionally because
@@ -203,9 +203,9 @@ static const struct clk_ops clk_apb_mul_factor_ops = {
 	.recalc_rate = clk_apb_mul_recalc_rate,
 };
 
-struct clk *clk_register_apb_mul(struct device *dev, const char *name,
-				 const char *parent_name, unsigned long flags,
-				 u8 bit_idx)
+static struct clk *clk_register_apb_mul(struct device *dev, const char *name,
+					const char *parent_name,
+					unsigned long flags, u8 bit_idx)
 {
 	struct clk_apb_mul *am;
 	struct clk_init_data init;
@@ -282,7 +282,8 @@ static int stm32f4_rcc_lookup_clk_idx(u8 primary, u8 secondary)
 	       (BIT_ULL_WORD(secondary) >= 2 ? hweight64(table[2]) : 0);
 }
 
-struct clk *stm32f4_rcc_lookup_clk(struct of_phandle_args *clkspec, void *data)
+static struct clk *
+stm32f4_rcc_lookup_clk(struct of_phandle_args *clkspec, void *data)
 {
 	int i = stm32f4_rcc_lookup_clk_idx(clkspec->args[0], clkspec->args[1]);
 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
