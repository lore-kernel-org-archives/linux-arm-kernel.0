From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 30 May 2015 11:15:58 +0200
Subject: [PATCH v2 3/4] clk: stm32: Add clock driver for STM32F4[23]xxx
 devices
In-Reply-To: <1432972448-10332-4-git-send-email-daniel.thompson@linaro.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
 <1432972448-10332-1-git-send-email-daniel.thompson@linaro.org>
 <1432972448-10332-4-git-send-email-daniel.thompson@linaro.org>
Message-ID: <55697FCE.9040003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

     Nice driver, please find my comments below.

     Once fixed, you can add:
Reviewed-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>


On 05/30/2015 09:54 AM, Daniel Thompson wrote:
> The driver supports decoding and statically modelling PLL state (i.e.
> we inherit state from bootloader) and provides support for all
> peripherals that support simple one-bit gated clocks. The covers all
> peripherals whose clocks come from the AHB, APB1 or APB2 buses.
>
> It has been tested (for non-regression only) on an STM32F429I-Discovery
> boards. The clock counts for TIM2, USART1 and SYSTICK are all set correctly
> and time and the wall clock looks OK when checked with a stopwatch.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>   drivers/clk/Makefile      |   1 +
>   drivers/clk/clk-stm32f4.c | 364 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 365 insertions(+)
>   create mode 100644 drivers/clk/clk-stm32f4.c
...
> diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
> new file mode 100644
> index 0000000..68f9962
> --- /dev/null
> +++ b/drivers/clk/clk-stm32f4.c
> @@ -0,0 +1,364 @@
...
> +/*
> + * Converts the primary and secondary indices (as they appear in DT) to an
> + * offset into our struct clock array.
> + */
> +static unsigned int stm32f4_rcc_lookup_clk_idx(u8 primary, u8 secondary)
> +{
> +	u64 table[ARRAY_SIZE(stm32f42xx_gate_map)];
> +
> +	if (primary == 1) {
> +		BUG_ON(secondary > FCLK);
Maybe the function could return a signed int, an propagate errors 
instead of using BUG_ON?
> +		return secondary;
> +	}
> +
> +	memcpy(table, stm32f42xx_gate_map, sizeof(table));
> +
> +	/* only bits set in table can be used as indices */
> +	BUG_ON(secondary > 8 * sizeof(table) ||
> +	       0 == (table[BIT_ULL_WORD(secondary)] & BIT_ULL_MASK(secondary)));
Ditto.
> +
> +	/* mask out bits above our current index */
> +	table[BIT_ULL_WORD(secondary)] &=
> +	    GENMASK_ULL(secondary % BITS_PER_LONG_LONG, 0);
> +
> +	return FCLK + hweight64(table[0]) +
> +	       (BIT_ULL_WORD(secondary) >= 1 ? hweight64(table[1]) : 0) +
> +	       (BIT_ULL_WORD(secondary) >= 2 ? hweight64(table[2]) : 0);
> +}
> +
> +struct clk *stm32f4_rcc_lookup_clk(struct of_phandle_args *clkspec, void *data)
> +{
> +	return clks[stm32f4_rcc_lookup_clk_idx(clkspec->args[0],
> +					       clkspec->args[1])];
If stm32f4_rcc_lookup_clk_idx() returns an error, you could propagate it 
using ERR_PTR().
> +}
> +
> +static const char __initdata *sys_parents[] =   { "hsi", NULL, "pll" };
> +
> +static struct clk_div_table ahb_div_table[] = {
Should be const.
> +	{ 0x0,   1 }, { 0x1,   1 }, { 0x2,   1 }, { 0x3,   1 },
> +	{ 0x4,   1 }, { 0x5,   1 }, { 0x6,   1 }, { 0x7,   1 },
> +	{ 0x8,   2 }, { 0x9,   4 }, { 0xa,   8 }, { 0xb,  16 },
> +	{ 0xc,  64 }, { 0xd, 128 }, { 0xe, 256 }, { 0xf, 512 },
> +	{ 0 },
> +};
> +
> +static struct clk_div_table apb_div_table[] = {
Ditto.
> +	{ 0,  1 }, { 0,  1 }, { 0,  1 }, { 0,  1 },
> +	{ 4,  2 }, { 5,  4 }, { 6,  8 }, { 7, 16 },
> +	{ 0 },
> +};
>

Thanks!
Maxime
