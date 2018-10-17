From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 17 Oct 2018 19:27:19 +0200
Subject: [PATCH v2 00/22] clk: at91: Rework DT bindings
In-Reply-To: <153979502020.5275.12406468543355327223@swboyd.mtv.corp.google.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
 <153979502020.5275.12406468543355327223@swboyd.mtv.corp.google.com>
Message-ID: <20181017172719.GV17341@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/2018 09:50:20-0700, Stephen Boyd wrote:
> Quoting Alexandre Belloni (2018-10-16 07:21:38)
> > This is the promised rework of the at91 PMC clocks driver. It is mainly
> > necessary to remove the DTC warnings but it also complies with the CCF
> > rule that there should be one node per controller instead of one node
> > per clock.
> > 
> > This only handles the PMC, I'm planning to also rework the SCKC bindings
> > later (without breaking the DT ABI).
> > 
> > The series is based on top of v4.19-rc1.
> > 
> > The first two patches are actually fixes and may be considered for this
> > cycle.
> > 
> > I'll take the device tree changes through the at91 tree as DT backward
> > compatibility is working.
> > 
> 
> I get the following warnings and errors from my auto checker script:
> 
> ERROR: need consistent spacing around '+' (ctx:WxV)
> #167: FILE: drivers/clk/at91/sama5d4.c:137:
> +       sama5d4_pmc = pmc_data_allocate(PMC_MCK2 +1,
>                                                  ^
> 
> drivers/clk/at91/clk-i2s-mux.c:49:15: warning: symbol 'at91_clk_i2s_mux_register' was not declared. Should it be static?
> drivers/clk/at91/clk-audio-pll.c:447:15: warning: symbol 'at91_clk_register_audio_pll_frac' was not declared. Should it be static?
> drivers/clk/at91/clk-audio-pll.c:477:15: warning: symbol 'at91_clk_register_audio_pll_pad' was not declared. Should it be static?
> drivers/clk/at91/clk-audio-pll.c:508:15: warning: symbol 'at91_clk_register_audio_pll_pmc' was not declared. Should it be static?
> drivers/clk/at91/sama5d4.c:123 sama5d4_pmc_setup() warn: unsigned 'i' is never less than zero.
> drivers/clk/at91/sama5d4.c:129 sama5d4_pmc_setup() warn: unsigned 'i' is never less than zero.
> drivers/clk/at91/sama5d2.c:140 sama5d2_pmc_setup() warn: unsigned 'i' is never less than zero.
> drivers/clk/at91/sama5d2.c:146 sama5d2_pmc_setup() warn: unsigned 'i' is never less than zero.
> drivers/clk/at91/at91sam9x5.c:132 at91sam9x5_pmc_setup() warn: unsigned 'i' is never less than zero.
> drivers/clk/at91/at91sam9x5.c:138 at91sam9x5_pmc_setup() warn: unsigned 'i' is never less than zero.
> drivers/clk/at91/at91sam9rl.c:76 at91sam9rl_pmc_setup() warn: unsigned 'i' is never less than zero.
> drivers/clk/at91/at91sam9rl.c:82 at91sam9rl_pmc_setup() warn: unsigned 'i' is never less than zero.
> drivers/clk/at91/at91sam9260.c:341 at91sam926x_pmc_setup() warn: unsigned 'i' is never less than zero.
> drivers/clk/at91/at91sam9260.c:347 at91sam926x_pmc_setup() warn: unsigned 'i' is never less than zero.
> 
> I fixed them with the below patch, that I'll squash into the right
> place. Things look good!
> 

The patch seems good to me.

> diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
> index 49aeee6c31a6..b1af5a395423 100644
> --- a/drivers/clk/at91/at91sam9260.c
> +++ b/drivers/clk/at91/at91sam9260.c
> @@ -334,7 +334,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
>  	const char *slck_name;
>  	struct regmap *regmap;
>  	struct clk_hw *hw;
> -	unsigned int i;
> +	int i;
>  	bool bypass;
>  
>  	i = of_property_match_string(np, "clock-names", "slow_xtal");
> diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
> index 5532fba5825b..5aeef68b4bdd 100644
> --- a/drivers/clk/at91/at91sam9rl.c
> +++ b/drivers/clk/at91/at91sam9rl.c
> @@ -70,7 +70,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
>  	const char *parent_names[6];
>  	struct regmap *regmap;
>  	struct clk_hw *hw;
> -	unsigned int i;
> +	int i;
>  
>  	i = of_property_match_string(np, "clock-names", "slow_clk");
>  	if (i < 0)
> diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
> index 3cdf227ce159..2fe225a697df 100644
> --- a/drivers/clk/at91/at91sam9x5.c
> +++ b/drivers/clk/at91/at91sam9x5.c
> @@ -125,7 +125,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>  	const char *parent_names[6];
>  	struct regmap *regmap;
>  	struct clk_hw *hw;
> -	unsigned int i;
> +	int i;
>  	bool bypass;
>  
>  	i = of_property_match_string(np, "clock-names", "slow_clk");
> diff --git a/drivers/clk/at91/clk-audio-pll.c b/drivers/clk/at91/clk-audio-pll.c
> index 96e3c6405351..36d77146a3bd 100644
> --- a/drivers/clk/at91/clk-audio-pll.c
> +++ b/drivers/clk/at91/clk-audio-pll.c
> @@ -43,6 +43,8 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> +#include "pmc.h"
> +
>  #define AUDIO_PLL_DIV_FRAC	BIT(22)
>  #define AUDIO_PLL_ND_MAX	(AT91_PMC_AUDIO_PLL_ND_MASK >> \
>  					AT91_PMC_AUDIO_PLL_ND_OFFSET)
> diff --git a/drivers/clk/at91/clk-i2s-mux.c b/drivers/clk/at91/clk-i2s-mux.c
> index dfdffa5409e6..fe6ce172b8b0 100644
> --- a/drivers/clk/at91/clk-i2s-mux.c
> +++ b/drivers/clk/at91/clk-i2s-mux.c
> @@ -14,6 +14,8 @@
>  
>  #include <soc/at91/atmel-sfr.h>
>  
> +#include "pmc.h"
> +
>  struct clk_i2s_mux {
>  	struct clk_hw hw;
>  	struct regmap *regmap;
> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> index 07f1f1d613ff..d69ad96fe988 100644
> --- a/drivers/clk/at91/sama5d2.c
> +++ b/drivers/clk/at91/sama5d2.c
> @@ -133,7 +133,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>  	const char *parent_names[6];
>  	struct regmap *regmap, *regmap_sfr;
>  	struct clk_hw *hw;
> -	unsigned int i;
> +	int i;
>  	bool bypass;
>  
>  	i = of_property_match_string(np, "clock-names", "slow_clk");
> diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
> index 64b9f438f73b..e358be7f6c8d 100644
> --- a/drivers/clk/at91/sama5d4.c
> +++ b/drivers/clk/at91/sama5d4.c
> @@ -116,7 +116,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
>  	const char *parent_names[5];
>  	struct regmap *regmap;
>  	struct clk_hw *hw;
> -	unsigned int i;
> +	int i;
>  	bool bypass;
>  
>  	i = of_property_match_string(np, "clock-names", "slow_clk");
> @@ -134,7 +134,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
>  	if (IS_ERR(regmap))
>  		return;
>  
> -	sama5d4_pmc = pmc_data_allocate(PMC_MCK2 +1,
> +	sama5d4_pmc = pmc_data_allocate(PMC_MCK2 + 1,
>  					nck(sama5d4_systemck),
>  					nck(sama5d4_periph32ck), 0);
>  	if (!sama5d4_pmc)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
