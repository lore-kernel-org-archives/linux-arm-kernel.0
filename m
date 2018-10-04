From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 4 Oct 2018 18:20:04 +0200
Subject: [PATCH] clk: sunxi-ng: enable so-said LDOs for A64 SoC's
 pll-mipi clock
In-Reply-To: <20181002122911.22094-1-icenowy@aosc.io>
References: <20181002122911.22094-1-icenowy@aosc.io>
Message-ID: <20181004162004.dstnrzyaqryenfj3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Tue, Oct 02, 2018 at 08:29:11PM +0800, Icenowy Zheng wrote:
> In the user manual of A64 SoC, the bit 22 and 23 of pll-mipi control
> register is called "LDO{1,2}_EN", and according to the BSP source code
> from Allwinner , the LDOs are enabled during the clock's enabling
> process.
> 
> The clock failed to generate output if the two LDOs are not enabled.
> 
> Add the two bits to the clock's gate bits, so that the LDOs are enabled
> when the PLL is enabled.
> 
> Fixes: c6a0637460c2 ("clk: sunxi-ng: Add A64 clocks")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> As PLL-MIPI is not used before 4.20~5.0, I decide not to target this patch
> on stable/mainline kernels.
> 
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> index 5f80eb018014..f7d297368eb2 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -162,7 +162,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
>  #define SUN50I_A64_PLL_MIPI_REG		0x040
>  
>  static struct ccu_nkm pll_mipi_clk = {
> -	.enable		= BIT(31),
> +	.enable		= BIT(31) | BIT(23) | BIT(22),

Adding a comment on why those are needed in addition to the enable bit
would be great :)

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
