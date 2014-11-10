From: horms@verge.net.au (Simon Horman)
Date: Mon, 10 Nov 2014 09:48:10 +0900
Subject: [PATCH v2] ARM: shmobile: r8a7740 legacy: Add missing INTCA
 clock for irqpin module
In-Reply-To: <1415221174-29097-1-git-send-email-geert+renesas@glider.be>
References: <1415221174-29097-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20141110004809.GB16836@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 09:59:34PM +0100, Geert Uytterhoeven wrote:
> This clock drives the irqpin controller modules.
> Before, it was assumed enabled by the bootloader or reset state.
> By making it available to the driver, we make sure it gets enabled when
> needed, and allow it to be managed by system or runtime PM.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert,

I have queued this up after dropping the previous version.

> ---
> v2:
>   - Index div4_clks[] instead of div6_clks[] (i.e. squashed in "ARM:
>     shmobile: r8a7740 legacy: Fix INTCA clock parent"),
>   - Extend commit message.
> ---
>  arch/arm/mach-shmobile/clock-r8a7740.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
> index 969e85dad09b3588..dbb0ab283e2fe91f 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> @@ -451,7 +451,7 @@ enum {
>  	MSTP128, MSTP127, MSTP125,
>  	MSTP116, MSTP111, MSTP100, MSTP117,
>  
> -	MSTP230,
> +	MSTP230, MSTP229,
>  	MSTP222,
>  	MSTP218, MSTP217, MSTP216, MSTP214,
>  	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
> @@ -475,6 +475,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP100] = SH_CLK_MSTP32(&div4_clks[DIV4_B],	SMSTPCR1,  0, 0), /* LCDC0 */
>  
>  	[MSTP230] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2, 30, 0), /* SCIFA6 */
> +	[MSTP229] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR2, 29, 0), /* INTCA */
>  	[MSTP222] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2, 22, 0), /* SCIFA7 */
>  	[MSTP218] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],  SMSTPCR2, 18, 0), /* DMAC1 */
>  	[MSTP217] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],  SMSTPCR2, 17, 0), /* DMAC2 */
> @@ -571,6 +572,10 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh-dma-engine.0",	&mstp_clks[MSTP218]),
>  	CLKDEV_DEV_ID("sh-sci.7",		&mstp_clks[MSTP222]),
>  	CLKDEV_DEV_ID("e6cd0000.serial",	&mstp_clks[MSTP222]),
> +	CLKDEV_DEV_ID("renesas_intc_irqpin.0",	&mstp_clks[MSTP229]),
> +	CLKDEV_DEV_ID("renesas_intc_irqpin.1",	&mstp_clks[MSTP229]),
> +	CLKDEV_DEV_ID("renesas_intc_irqpin.2",	&mstp_clks[MSTP229]),
> +	CLKDEV_DEV_ID("renesas_intc_irqpin.3",	&mstp_clks[MSTP229]),
>  	CLKDEV_DEV_ID("sh-sci.6",		&mstp_clks[MSTP230]),
>  	CLKDEV_DEV_ID("e6cc0000.serial",	&mstp_clks[MSTP230]),
>  
> -- 
> 1.9.1
> 
