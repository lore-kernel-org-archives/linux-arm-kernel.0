From: david@lechnology.com (David Lechner)
Date: Fri, 8 Dec 2017 19:51:54 -0600
Subject: [PATCH v2 2/5] ARM: davinci: don't use static clk_lookup
In-Reply-To: <1512783831-19487-3-git-send-email-david@lechnology.com>
References: <1512783831-19487-1-git-send-email-david@lechnology.com>
 <1512783831-19487-3-git-send-email-david@lechnology.com>
Message-ID: <20860edf-a8f9-82d1-e3ad-2444bd8eeb07@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2017 07:43 PM, David Lechner wrote:
> In preparation of moving to the common clock framework, usage of static
> struct clk_lookup is removed. The common clock framework uses an opaque
> struct clk, so we won't be able to use static tables as was previously
> done.
> 
> davinci_clk_init() is changed to init a single clock instead of a table.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v2 changes:
> * No longer introduces init_time functions since those are now in the previous
>    patch.
> 
> 
>   arch/arm/mach-davinci/clock.c               |  75 +++++++---------
>   arch/arm/mach-davinci/clock.h               |   9 +-
>   arch/arm/mach-davinci/da830.c               | 111 ++++++++++++-----------
>   arch/arm/mach-davinci/da850.c               | 133 ++++++++++++++--------------
>   arch/arm/mach-davinci/devices-da8xx.c       |   5 +-
>   arch/arm/mach-davinci/dm355.c               |  93 ++++++++++---------
>   arch/arm/mach-davinci/dm365.c               | 123 +++++++++++++------------
>   arch/arm/mach-davinci/dm644x.c              |  85 +++++++++---------
>   arch/arm/mach-davinci/dm646x.c              |  94 ++++++++++----------
>   arch/arm/mach-davinci/include/mach/common.h |   1 -
>   arch/arm/mach-davinci/usb-da8xx.c           |  15 +---
>   11 files changed, 356 insertions(+), 388 deletions(-)
> 

...

> diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
> index 6136d35..56c0bdb 100644
> --- a/arch/arm/mach-davinci/dm646x.c
> +++ b/arch/arm/mach-davinci/dm646x.c
> @@ -320,49 +320,54 @@ static struct clk vpif1_clk = {
>   	.flags = ALWAYS_ENABLED,
>   };
>   
> -static struct clk_lookup dm646x_clks[] = {
> -	CLK(NULL, "ref", &ref_clk),
> -	CLK(NULL, "aux", &aux_clkin),
> -	CLK(NULL, "pll1", &pll1_clk),
> -	CLK(NULL, "pll1_sysclk", &pll1_sysclk1),
> -	CLK(NULL, "pll1_sysclk", &pll1_sysclk2),
> -	CLK(NULL, "pll1_sysclk", &pll1_sysclk3),
> -	CLK(NULL, "pll1_sysclk", &pll1_sysclk4),
> -	CLK(NULL, "pll1_sysclk", &pll1_sysclk5),
> -	CLK(NULL, "pll1_sysclk", &pll1_sysclk6),
> -	CLK(NULL, "pll1_sysclk", &pll1_sysclk8),
> -	CLK(NULL, "pll1_sysclk", &pll1_sysclk9),
> -	CLK(NULL, "pll1_sysclk", &pll1_sysclkbp),
> -	CLK(NULL, "pll1_aux", &pll1_aux_clk),
> -	CLK(NULL, "pll2", &pll2_clk),
> -	CLK(NULL, "pll2_sysclk1", &pll2_sysclk1),
> -	CLK(NULL, "dsp", &dsp_clk),
> -	CLK(NULL, "arm", &arm_clk),
> -	CLK(NULL, "edma_cc", &edma_cc_clk),
> -	CLK(NULL, "edma_tc0", &edma_tc0_clk),
> -	CLK(NULL, "edma_tc1", &edma_tc1_clk),
> -	CLK(NULL, "edma_tc2", &edma_tc2_clk),
> -	CLK(NULL, "edma_tc3", &edma_tc3_clk),
> -	CLK("serial8250.0", NULL, &uart0_clk),
> -	CLK("serial8250.1", NULL, &uart1_clk),
> -	CLK("serial8250.2", NULL, &uart2_clk),
> -	CLK("i2c_davinci.1", NULL, &i2c_clk),
> -	CLK(NULL, "gpio", &gpio_clk),
> -	CLK("davinci-mcasp.0", NULL, &mcasp0_clk),
> -	CLK("davinci-mcasp.1", NULL, &mcasp1_clk),
> -	CLK(NULL, "aemif", &aemif_clk),
> -	CLK("davinci_emac.1", NULL, &emac_clk),
> -	CLK("davinci_mdio.0", "fck", &emac_clk),
> -	CLK(NULL, "pwm0", &pwm0_clk),
> -	CLK(NULL, "pwm1", &pwm1_clk),
> -	CLK(NULL, "timer0", &timer0_clk),
> -	CLK(NULL, "timer1", &timer1_clk),
> -	CLK("davinci-wdt", NULL, &timer2_clk),
> -	CLK("palm_bk3710", NULL, &ide_clk),
> -	CLK(NULL, "vpif0", &vpif0_clk),
> -	CLK(NULL, "vpif1", &vpif1_clk),
> -	CLK(NULL, NULL, NULL),
> -};
> +#define DM6467T_EVM_REF_FREQ		33000000
> +
> +static __init void dm646x_clk_init(void)
> +{
> +	davinci_clk_init(&ref_clk, "ref", NULL);
> +	davinci_clk_init(&aux_clkin, "aux", NULL);
> +	davinci_clk_init(&pll1_clk, "pll1", NULL);
> +	davinci_clk_init(&pll1_sysclk1, "pll1_sysclk", NULL);
> +	davinci_clk_init(&pll1_sysclk2, "pll1_sysclk", NULL);
> +	davinci_clk_init(&pll1_sysclk3, "pll1_sysclk", NULL);
> +	davinci_clk_init(&pll1_sysclk4, "pll1_sysclk", NULL);
> +	davinci_clk_init(&pll1_sysclk5, "pll1_sysclk", NULL);
> +	davinci_clk_init(&pll1_sysclk6, "pll1_sysclk", NULL);
> +	davinci_clk_init(&pll1_sysclk8, "pll1_sysclk", NULL);
> +	davinci_clk_init(&pll1_sysclk9, "pll1_sysclk", NULL);
> +	davinci_clk_init(&pll1_sysclkbp, "pll1_sysclk", NULL);
> +	davinci_clk_init(&pll1_aux_clk, "pll1_aux", NULL);
> +	davinci_clk_init(&pll2_clk, "pll2", NULL);
> +	davinci_clk_init(&pll2_sysclk1, "pll2_sysclk1", NULL);
> +	davinci_clk_init(&dsp_clk, "dsp", NULL);
> +	davinci_clk_init(&arm_clk, "arm", NULL);
> +	davinci_clk_init(&edma_cc_clk, "edma_cc", NULL);
> +	davinci_clk_init(&edma_tc0_clk, "edma_tc0", NULL);
> +	davinci_clk_init(&edma_tc1_clk, "edma_tc1", NULL);
> +	davinci_clk_init(&edma_tc2_clk, "edma_tc2", NULL);
> +	davinci_clk_init(&edma_tc3_clk, "edma_tc3", NULL);
> +	davinci_clk_init(&uart0_clk, NULL, "serial8250.0");
> +	davinci_clk_init(&uart1_clk, NULL, "serial8250.1");
> +	davinci_clk_init(&uart2_clk, NULL, "serial8250.2");
> +	davinci_clk_init(&i2c_clk, NULL, "i2c_davinci.1");
> +	davinci_clk_init(&gpio_clk, "gpio", NULL);
> +	davinci_clk_init(&mcasp0_clk, NULL, "davinci-mcasp.0");
> +	davinci_clk_init(&mcasp1_clk, NULL, "davinci-mcasp.1");
> +	davinci_clk_init(&aemif_clk, "aemif", NULL);
> +	davinci_clk_init(&emac_clk, NULL, "davinci_emac.1");
> +	davinci_clk_init(&emac_clk, "fck", "davinci_mdio.0");
> +	davinci_clk_init(&pwm0_clk, "pwm0", NULL);
> +	davinci_clk_init(&pwm1_clk, "pwm1", NULL);
> +	davinci_clk_init(&timer0_clk, "timer0", NULL);
> +	davinci_clk_init(&timer1_clk, "timer1", NULL);
> +	davinci_clk_init(&timer2_clk, NULL, "davinci-wdt");
> +	davinci_clk_init(&ide_clk, NULL, "palm_bk3710");
> +	davinci_clk_init(&vpif0_clk, "vpif0", NULL);
> +	davinci_clk_init(&vpif1_clk, "vpif1", NULL);
> +
> +	if (machine_is_davinci_dm6467tevm())
> +		davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);


These two lines (three counting the blank line) are not supposed to be 
here. It will cause a compile error. Missed it while rebasing. Sorry 
about that.
