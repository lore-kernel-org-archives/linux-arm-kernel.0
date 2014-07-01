From: Guangyu.Chen@freescale.com (Nicolin Chen)
Date: Tue, 1 Jul 2014 14:23:57 +0800
Subject: [PATCH 3/5] ARM: imx: clk-imx6sx: Remove SSI IPG clocks
In-Reply-To: <1404194129-25543-3-git-send-email-festevam@gmail.com>
References: <1404194129-25543-1-git-send-email-festevam@gmail.com>
 <1404194129-25543-3-git-send-email-festevam@gmail.com>
Message-ID: <20140701062355.GA10926@MrMyself>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,
   
On Tue, Jul 01, 2014 at 02:55:27AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Looking at the CCGR5 register we see that that each SSI has its corresponding
> clock gate field.
> 
> There are no SSI IPG clock gate field, so remove these SSI IPG variants as
> they point to the same SSI clock fields and have no use in the kernel.

I was just abort to say that actually each SSI has an IPG clock as CCM shows:

SSIn      ssi_clk      ssin_clk_root      CCGR5[CG11:CG9] (ssi[3:1]_clk_enable)
          ipg_clk      ipg_clk_root       CCGR5[CG11:CG9] (ssi[3:1]_clk_enable)
          ipg_clk_s    ipg_clk_root       CCGR5[CG11:CG9] (ssi[3:1]_clk_enable)

So we don't have to remove the IPG one. Instead we shall protect IPG and baud
clocks with imx_clk_gate2_shared().

Thank you,
Nicolin

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx6sx.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6sx.c b/arch/arm/mach-imx/clk-imx6sx.c
> index 2e96103..1b198ea 100644
> --- a/arch/arm/mach-imx/clk-imx6sx.c
> +++ b/arch/arm/mach-imx/clk-imx6sx.c
> @@ -409,9 +409,6 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
>  	clks[IMX6SX_CLK_SPBA]         = imx_clk_gate2("spba",          "ipg",               base + 0x7c, 12);
>  	clks[IMX6SX_CLK_AUDIO]        = imx_clk_gate2_shared("audio",  "audio_podf",        base + 0x7c, 14, &share_count_audio);
>  	clks[IMX6SX_CLK_SPDIF]        = imx_clk_gate2_shared("spdif",  "spdif_podf",        base + 0x7c, 14, &share_count_audio);
> -	clks[IMX6SX_CLK_SSI1_IPG]     = imx_clk_gate2("ssi1_ipg",      "ipg",               base + 0x7c, 18);
> -	clks[IMX6SX_CLK_SSI2_IPG]     = imx_clk_gate2("ssi2_ipg",      "ipg",               base + 0x7c, 20);
> -	clks[IMX6SX_CLK_SSI3_IPG]     = imx_clk_gate2("ssi3_ipg",      "ipg",               base + 0x7c, 22);
>  	clks[IMX6SX_CLK_SSI1]         = imx_clk_gate2("ssi1",          "ssi1_podf",         base + 0x7c, 18);
>  	clks[IMX6SX_CLK_SSI2]         = imx_clk_gate2("ssi2",          "ssi2_podf",         base + 0x7c, 20);
>  	clks[IMX6SX_CLK_SSI3]         = imx_clk_gate2("ssi3",          "ssi3_podf",         base + 0x7c, 22);
> -- 
> 1.8.3.2
> 
