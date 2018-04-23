From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Mon, 23 Apr 2018 22:05:44 +0000
Subject: [PATCH] ARM: tegra: fix ulpi regression on tegra20
In-Reply-To: <4f2ac009-8618-4b4d-e137-a5fd4907a56f@gmail.com>
References: <20180219151252.29289-1-marcel@ziswiler.com>
 <6600596.BijQW1iq1K@ax5200p>
 <4f2ac009-8618-4b4d-e137-a5fd4907a56f@gmail.com>
Message-ID: <1524521136.4493.70.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry

On Fri, 2018-04-20 at 13:50 +0300, Dmitry Osipenko wrote:
> ...
> I managed to find CDEV clocks in TRM this time.

And where exactly in which TRM? In all my attempts at finding anything
CDEV2 is just a pad group which includes the DAP_MCLK2 pad in question.

> Seems assigning CDEV2 clock to
> "ulpi-link" was correct

Sorry, but I do really not see how you can get to any such conclusion.

Whatever that CDEV2 clock exactly is. Its offset 93 points towards the
CLK_RST_CONTROLLER_CLK_OUT_ENB_U_0 register which has CLK_ENB_DEV2_OUT
at bit position 29 reading "Enable clock to DEV2 pad". While the TRM
misses further documenting what exactly that DEV2 pad should be I guess
it may point towards our suspected DAP_MCLK2. So for some reason
besides PLL_P_OUT4 which is what that pad is actually muxed to also
some additional DEV2 pad clock needs enabling. In addition there would
be a CLK_RST_CONTROLLER_MISC_CLK_ENB_0 register where one could also
specify a DEV2_OSC_DIV_SEL but I would assume that one only applies if
the pad in question being muxed to OSC which is not the case at least
in all device trees I have looked at.

> and both CDEV2 and PLL_P_OUT4 should be enabled,

Agreed, basically the DAP_MCLK2 pad seems gated by an additional enable
called CLK_ENB_DEV2_OUT.

> CDEV2
> should gate the PLL_P_OUT4 that feeds USB HW and PLL_P_OUT4 should be
> always-enabled because it is enabled by init_table, but apparently it
> is getting
> disabled erroneously.

At least that was the case back when I had trouble getting ULPI to work
on T20. Strangely latest -next right now does no longer seem to suffer
from that same issue even if my patch is reverted but as mentioned
before nobody stops the required PLL_P_OUT4 which is what is actually
driving DAP_MCLK2 to not be changed behind the scenes breaking the
whole thing again.

> Marcel, could you please revert your patch, add
> "trace_event=clk_enable,clk_disable,clk_set_parent tp_printk" to
> kernels cmdline
> and post the log?

Yes, the only difference in those traces is whether or not that non-
existent CDEV2 clock is enabled or not:

[    1.897521] clk_enable: cdev2_fixed
[    1.901008] clk_enable: cdev2

I also do have an explanation why it kept working in my case. Probably
the boot ROM or U-Boot is already setting that bit.

> It looks like there is some clk framework bug,

My conclusion is that there should be a DAP_MCLK2 clock which is gated
by that CLK_ENB_DEV2_OUT but really outputs a T20 internal clock
according to its pin muxing which if set to OSC may be further divided
down by DEV2_OSC_DIV_SEL.

> but just in case please also try
> to apply this patch:
> 
> diff --git a/drivers/clk/tegra/clk-tegra-periph.c
> b/drivers/clk/tegra/clk-tegra-periph.c
> index 2acba2986bc6..407bd0c0ac2f 100644
> --- a/drivers/clk/tegra/clk-tegra-periph.c
> +++ b/drivers/clk/tegra/clk-tegra-periph.c
> @@ -1024,7 +1024,7 @@ static void __init init_pllp(void __iomem
> *clk_base, void
> __iomem *pmc_base,
>                 if (dt_clk) {
>                         clk =
> tegra_clk_register_pll_out("pll_p_out4",
>                                         "pll_p_out4_div", clk_base +
> PLLP_OUTB,
> -                                       17, 16, CLK_IGNORE_UNUSED |
> +                                       17, 16, CLK_IS_CRITICAL |
>                                         CLK_SET_RATE_PARENT, 0,
>                                         &PLLP_OUTB_lock);
>                         *dt_clk = clk;

I did not have to do any such but maybe that would at least prevent any
further issues on PLL_P_OUT4. However I still believe this is kind of
wrong as PLL_P_OUT4 is what drives DAP_MCLK2 in its current muxing
which is connected to the ULPI transceivers REFCLK pin.

BTW: That pin is usually to be driven at 24 MHz and not 26 MHz which
CDEV2 claims to be at.

What do you think?

Cheers

Marcel
