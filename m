From: philippe.cornu@st.com (Philippe CORNU)
Date: Thu, 18 Jan 2018 16:37:28 +0000
Subject: [PATCH 2/2] clk: stm32: Add DSI clock for STM32F469 Board
In-Reply-To: <1516286980-8603-3-git-send-email-gabriel.fernandez@st.com>
References: <1516286980-8603-1-git-send-email-gabriel.fernandez@st.com>
 <1516286980-8603-3-git-send-email-gabriel.fernandez@st.com>
Message-ID: <69b40967-b334-5e94-0d57-e23944c30b17@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

Tested successfully on f469 disco board.

Tested-by: Philippe Cornu <philippe.cornu@st.com>

Many thanks,
Philippe :-)

On 01/18/2018 03:49 PM, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch adds DSI clock for STM32F469 board
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>   drivers/clk/clk-stm32f4.c                 | 11 ++++++++++-
>   include/dt-bindings/clock/stm32fx-clock.h |  3 ++-
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
> index da44f8d..3c28798 100644
> --- a/drivers/clk/clk-stm32f4.c
> +++ b/drivers/clk/clk-stm32f4.c
> @@ -521,7 +521,7 @@ struct stm32f4_pll_data {
>   };
>   
>   static const struct stm32f4_pll_data stm32f469_pll[MAX_PLL_DIV] = {
> -	{ PLL,	   50, { "pll",	     "pll-q",    NULL	    } },
> +	{ PLL,	   50, { "pll",	     "pll-q",    "pll-r"    } },
>   	{ PLL_I2S, 50, { "plli2s-p", "plli2s-q", "plli2s-r" } },
>   	{ PLL_SAI, 50, { "pllsai-p", "pllsai-q", "pllsai-r" } },
>   };
> @@ -1047,6 +1047,8 @@ static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
>   	"no-clock", "lse", "lsi", "hse-rtc"
>   };
>   
> +static const char *dsi_parent[2] = { NULL, "pll-r" };
> +
>   static const char *lcd_parent[1] = { "pllsai-r-div" };
>   
>   static const char *i2s_parents[2] = { "plli2s-r", NULL };
> @@ -1156,6 +1158,12 @@ struct stm32f4_clk_data {
>   		NO_GATE, 0,
>   		0
>   	},
> +	{
> +		CLK_F469_DSI, "dsi", dsi_parent, ARRAY_SIZE(dsi_parent),
> +		STM32F4_RCC_DCKCFGR, 29, 1,
> +		STM32F4_RCC_APB2ENR, 27,
> +		CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT
> +	},
>   };
>   
>   static const struct stm32_aux_clk stm32f746_aux_clk[] = {
> @@ -1450,6 +1458,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
>   	stm32f4_gate_map = data->gates_map;
>   
>   	hse_clk = of_clk_get_parent_name(np, 0);
> +	dsi_parent[0] = hse_clk;
>   
>   	i2s_in_clk = of_clk_get_parent_name(np, 1);
>   
> diff --git a/include/dt-bindings/clock/stm32fx-clock.h b/include/dt-bindings/clock/stm32fx-clock.h
> index 4d523b0..58d8b51 100644
> --- a/include/dt-bindings/clock/stm32fx-clock.h
> +++ b/include/dt-bindings/clock/stm32fx-clock.h
> @@ -35,8 +35,9 @@
>   #define CLK_SAIQ_PDIV		13
>   #define CLK_HSI			14
>   #define CLK_SYSCLK		15
> +#define CLK_F469_DSI		16
>   
> -#define END_PRIMARY_CLK		16
> +#define END_PRIMARY_CLK		17
>   
>   #define CLK_HDMI_CEC		16
>   #define CLK_SPDIF		17
> 
