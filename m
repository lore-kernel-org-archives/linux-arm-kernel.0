From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Aug 2011 16:51:47 +0200
Subject: [[PATCH v2 6/6] ARM: mx5: use generic function for displaying
	silicon revision
In-Reply-To: <1314162277-2840-7-git-send-email-jason.hui@linaro.org>
References: <1314162277-2840-1-git-send-email-jason.hui@linaro.org>
	<1314162277-2840-7-git-send-email-jason.hui@linaro.org>
Message-ID: <20110825145147.GX31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 01:04:37PM +0800, Jason Liu wrote:
> Update to use generic function for displaying silicon revision
> 
> Signed-off-by: Jason Liu <jason.hui@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx5/clock-mx51-mx53.c |    6 +--
>  arch/arm/mach-mx5/cpu.c             |   74 ++++++++---------------------------
>  2 files changed, 19 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index f7bf996..0e23e1d 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1548,9 +1548,8 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
>  	clk_enable(&main_bus_clk);
>  
>  	clk_enable(&iim_clk);
> -	mx51_revision();
> +	imx_print_silicon_rev("i.MX51", mx51_revision());
>  	clk_disable(&iim_clk);
> -	mx51_display_revision();
>  
>  	/* move usb_phy_clk to 24MHz */
>  	clk_set_parent(&usb_phy1_clk, &osc_clk);
> @@ -1592,9 +1591,8 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
>  	clk_enable(&main_bus_clk);
>  
>  	clk_enable(&iim_clk);
> -	mx53_revision();
> +	imx_print_silicon_rev("i.MX53", mx53_revision());
>  	clk_disable(&iim_clk);
> -	mx53_display_revision();
>  
>  	/* Set SDHC parents to be PLL2 */
>  	clk_set_parent(&esdhc1_clk, &pll2_sw_clk);
> diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
> index 86f87da..df46967 100644
> --- a/arch/arm/mach-mx5/cpu.c
> +++ b/arch/arm/mach-mx5/cpu.c
> @@ -18,7 +18,7 @@
>  #include <mach/hardware.h>
>  #include <asm/io.h>
>  
> -static int cpu_silicon_rev = -1;
> +static int mx5_cpu_rev = -1;
>  
>  #define IIM_SREV 0x24
>  #define MX50_HW_ADADIG_DIGPROG	0xB0
> @@ -28,11 +28,14 @@ static int get_mx51_srev(void)
>  	void __iomem *iim_base = MX51_IO_ADDRESS(MX51_IIM_BASE_ADDR);
>  	u32 rev = readl(iim_base + IIM_SREV) & 0xff;
>  
> -	if (rev == 0x0)
> +	switch (rev) {
> +	case 0x0:
>  		return IMX_CHIP_REVISION_2_0;
> -	else if (rev == 0x10)
> +	case 0x2:
>  		return IMX_CHIP_REVISION_3_0;

0x2 != 0x10

My babbage board now shows a unknown cpu revision.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
