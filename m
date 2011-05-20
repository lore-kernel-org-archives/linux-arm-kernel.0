From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 20 May 2011 19:11:58 +0400
Subject: [PATCH 3/4] davinci: dm646x: remove the macros from the header
	to move to c file
In-Reply-To: <1305900721-3890-1-git-send-email-manjunath.hadli@ti.com>
References: <1305900721-3890-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <4DD684BE.7010600@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Manjunath Hadli wrote:

> move the register base addresses and offsets used only by dm646x
> platform file from platform header dm646x.h to dm646x.c as they
> are used only in the c file.

> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> ---
>  arch/arm/mach-davinci/dm646x.c              |   34 +++++++++++++++-----------
>  arch/arm/mach-davinci/include/mach/dm646x.h |    7 -----
>  2 files changed, 20 insertions(+), 21 deletions(-)

> diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
> index 1e0f809..9efa380 100644
> --- a/arch/arm/mach-davinci/dm646x.c
> +++ b/arch/arm/mach-davinci/dm646x.c
> @@ -30,20 +30,6 @@
>  #include "clock.h"
>  #include "mux.h"
>  
> -#define DAVINCI_VPIF_BASE       (0x01C12000)
> -#define VDD3P3V_PWDN_OFFSET	(0x48)
> -#define VSCLKDIS_OFFSET		(0x6C)
> -
> -#define VDD3P3V_VID_MASK	(BIT_MASK(3) | BIT_MASK(2) | BIT_MASK(1) |\
> -					BIT_MASK(0))
> -#define VSCLKDIS_MASK		(BIT_MASK(11) | BIT_MASK(10) | BIT_MASK(9) |\
> -					BIT_MASK(8))
> -
> -/*
> - * Device specific clocks
> - */
> -#define DM646X_AUX_FREQ		24000000
> -
>  static struct pll_data pll1_data = {
>  	.num       = 1,
>  	.phys_base = DAVINCI_PLL1_BASE,
> @@ -58,6 +44,8 @@ static struct clk ref_clk = {
>  	.name = "ref_clk",
>  };
>  
> +#define DM646X_AUX_FREQ		24000000
> +

    Why move it (and delete the comment)?

>  static struct clk aux_clkin = {
>  	.name = "aux_clkin",
>  	.rate = DM646X_AUX_FREQ,
> @@ -354,6 +342,11 @@ static struct clk_lookup dm646x_clks[] = {
>  	CLK(NULL, NULL, NULL),
>  };
>  
> +#define DM646X_EMAC_CNTRL_OFFSET	0x0000
> +#define DM646X_EMAC_CNTRL_MOD_OFFSET	0x1000
> +#define DM646X_EMAC_CNTRL_RAM_OFFSET	0x2000
> +#define DM646X_EMAC_CNTRL_RAM_SIZE	0x2000
> +
>  static struct emac_platform_data dm646x_emac_pdata = {
>  	.ctrl_reg_offset	= DM646X_EMAC_CNTRL_OFFSET,
>  	.ctrl_mod_reg_offset	= DM646X_EMAC_CNTRL_MOD_OFFSET,
> @@ -362,6 +355,8 @@ static struct emac_platform_data dm646x_emac_pdata = {
>  	.version		= EMAC_VERSION_2,
>  };
>  
> +#define DM646X_EMAC_BASE	0x01C80000
> +
>  static struct resource dm646x_emac_resources[] = {
>  	{
>  		.start	= DM646X_EMAC_BASE,
> @@ -400,6 +395,8 @@ static struct platform_device dm646x_emac_device = {
>  	.resource	= dm646x_emac_resources,
>  };
>  
> +#define DM646X_EMAC_MDIO_BASE	(DM646X_EMAC_BASE + 0x4000)
> +
>  static struct resource dm646x_mdio_resources[] = {
>  	{
>  		.start	= DM646X_EMAC_MDIO_BASE,
> @@ -671,6 +668,8 @@ static struct platform_device dm646x_dit_device = {
>  
>  static u64 vpif_dma_mask = DMA_BIT_MASK(32);
>  
> +#define DAVINCI_VPIF_BASE	0x01C12000
> +
>  static struct resource vpif_resource[] = {
>  	{
>  		.start	= DAVINCI_VPIF_BASE,

    I'd prefer that these macros are still grouped together at the start of file...

> @@ -866,6 +865,13 @@ void __init dm646x_init_mcasp1(struct snd_platform_data *pdata)
>  	platform_device_register(&dm646x_dit_device);
>  }
>  
> +#define VDD3P3V_PWDN_OFFSET	0x48
> +#define VSCLKDIS_OFFSET		0x6C
> +#define VDD3P3V_VID_MASK	(BIT_MASK(3) | BIT_MASK(2) | BIT_MASK(1) |\
> +					BIT_MASK(0))
> +#define VSCLKDIS_MASK		(BIT_MASK(11) | BIT_MASK(10) | BIT_MASK(9) |\
> +					BIT_MASK(8))

    I'd prefer that these remain on their places too. Let's wait for Sekhar's 
word though...

> +
>  void dm646x_setup_vpif(struct vpif_display_config *display_config,
>  		       struct vpif_capture_config *capture_config)
>  {

WBR, Sergei
