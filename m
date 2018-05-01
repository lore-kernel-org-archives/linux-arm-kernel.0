From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 10:02:36 -0500
Subject: [PATCH] clk:aspeed: Fix reset bits for PCI/VGA and PECI
In-Reply-To: <20180426172232.12535-1-jae.hyun.yoo@linux.intel.com>
References: <20180426172232.12535-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180501150236.GA15330@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 10:22:32AM -0700, Jae Hyun Yoo wrote:
> This commit fixes incorrect setting of reset bits for PCI/VGA and
> PECI modules.
> 
> 1. Reset bit for PCI/VGA is 8.
> 2. PECI reset bit is missing so added bit 10 as its reset bit.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")
> Cc: stable <stable@vger.kernel.org>
> ---
>  drivers/clk/clk-aspeed.c                 | 4 ++--
>  include/dt-bindings/clock/aspeed-clock.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 5eb50c31e455..2c23e7d7ba28 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -88,7 +88,7 @@ static const struct aspeed_gate_data aspeed_gates[] = {
>  	[ASPEED_CLK_GATE_GCLK] =	{  1,  7, "gclk-gate",		NULL,	0 }, /* 2D engine */
>  	[ASPEED_CLK_GATE_MCLK] =	{  2, -1, "mclk-gate",		"mpll",	CLK_IS_CRITICAL }, /* SDRAM */
>  	[ASPEED_CLK_GATE_VCLK] =	{  3,  6, "vclk-gate",		NULL,	0 }, /* Video Capture */
> -	[ASPEED_CLK_GATE_BCLK] =	{  4, 10, "bclk-gate",		"bclk",	0 }, /* PCIe/PCI */
> +	[ASPEED_CLK_GATE_BCLK] =	{  4,  8, "bclk-gate",		"bclk",	0 }, /* PCIe/PCI */
>  	[ASPEED_CLK_GATE_DCLK] =	{  5, -1, "dclk-gate",		NULL,	0 }, /* DAC */
>  	[ASPEED_CLK_GATE_REFCLK] =	{  6, -1, "refclk-gate",	"clkin", CLK_IS_CRITICAL },
>  	[ASPEED_CLK_GATE_USBPORT2CLK] =	{  7,  3, "usb-port2-gate",	NULL,	0 }, /* USB2.0 Host port 2 */
> @@ -297,7 +297,7 @@ static const u8 aspeed_resets[] = {
>  	[ASPEED_RESET_JTAG_MASTER] = 22,
>  	[ASPEED_RESET_MIC]	= 18,
>  	[ASPEED_RESET_PWM]	=  9,
> -	[ASPEED_RESET_PCIVGA]	=  8,
> +	[ASPEED_RESET_PECI]	= 10,
>  	[ASPEED_RESET_I2C]	=  2,
>  	[ASPEED_RESET_AHB]	=  1,
>  };
> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
> index d3558d897a4d..8d69b9134bef 100644
> --- a/include/dt-bindings/clock/aspeed-clock.h
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -45,7 +45,7 @@
>  #define ASPEED_RESET_JTAG_MASTER	3
>  #define ASPEED_RESET_MIC		4
>  #define ASPEED_RESET_PWM		5
> -#define ASPEED_RESET_PCIVGA		6
> +#define ASPEED_RESET_PECI		6

You can't really be changing these as they represent an ABI.

Is there no PCIVGA reset?

>  #define ASPEED_RESET_I2C		7
>  #define ASPEED_RESET_AHB		8
>  
> -- 
> 2.17.0
> 
