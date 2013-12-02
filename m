From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Dec 2013 13:14:48 +0100
Subject: [PATCH] clk: tegra: Correct clock number for UARTE
In-Reply-To: <1385984847.4086.3.camel@weser.hi.pengutronix.de>
References: <1385983825-20317-1-git-send-email-treding@nvidia.com>
 <1385984847.4086.3.camel@weser.hi.pengutronix.de>
Message-ID: <20131202121447.GB12793@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 12:47:27PM +0100, Lucas Stach wrote:
> Am Montag, den 02.12.2013, 12:30 +0100 schrieb Thierry Reding:
> > UARTE has clock number 66. Number 65 is the right one for UARTD.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/clk/tegra/clk-tegra-periph.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
> > index 5c35885f4a7c..3744a6fe589e 100644
> > --- a/drivers/clk/tegra/clk-tegra-periph.c
> > +++ b/drivers/clk/tegra/clk-tegra-periph.c
> > @@ -492,7 +492,7 @@ static struct tegra_periph_init_data periph_clks[] = {
> >  	UART("uartb", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTB, 7, tegra_clk_uartb),
> >  	UART("uartc", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTC, 55, tegra_clk_uartc),
> >  	UART("uartd", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTD, 65, tegra_clk_uartd),
> > -	UART("uarte", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTE, 65, tegra_clk_uarte),
> > +	UART("uarte", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTE, 66, tegra_clk_uarte),
> >  	XUSB("xusb_host_src", mux_clkm_pllp_pllc_pllre, CLK_SOURCE_XUSB_HOST_SRC, 143, TEGRA_PERIPH_ON_APB | TEGRA_PERIPH_NO_RESET, tegra_clk_xusb_host_src),
> >  	XUSB("xusb_falcon_src", mux_clkm_pllp_pllc_pllre, CLK_SOURCE_XUSB_FALCON_SRC, 143, TEGRA_PERIPH_NO_RESET, tegra_clk_xusb_falcon_src),
> >  	XUSB("xusb_fs_src", mux_clkm_48M_pllp_480M, CLK_SOURCE_XUSB_FS_SRC, 143, TEGRA_PERIPH_NO_RESET, tegra_clk_xusb_fs_src),
> 
> Is this a stable patch or why are those magic numbers even necessary? I
> have to admit I didn't follow the Tegra clk stuff closely, but with all
> the churn going on there I would have suspected that those numbers would
> have been replaced by the DT include defines by now.

There is no 1:1 mapping between the DT include defines and the hardware
clock numbers. For instance, UARTB has DT define 192, but the enable bit
is at offset 7.

I think the main reason for doing was because of the Tegra-specific
reset API. Now that that's being converted to the generic API, there may
be some room to refactor this. Until then I think we're stuck with
having these numbers in this table.

But perhaps there were other reasons to do this as well. Peter or
Stephen may know the details better than I do.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/cfee0d39/attachment-0001.sig>
