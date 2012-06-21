From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Jun 2012 21:11:41 +0800
Subject: [PATCH] ARM:MXS: Initial support for the Crystalfontz CFA-10036
In-Reply-To: <1340268415-5022-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1340268415-5022-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120621131138.GA21418@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 10:46:52AM +0200, Maxime Ripard wrote:
> On the MMC part though, Something odd is going on.  On the first
> patches I made against 3.4, everything was working fine. With 3.5-rc2
> though, the MMC never replies to the first CMD52 command sent to
> it. The pin muxing hasn't changed and has been checked, the card is
> well detected through the card detect pin, the power enable pin is
> correctly set to a low level, and so the SD card is correctly
> powered. The MMC works fine with the exact same kernel on the
> imx28-evk though.
> 
> What seems odd to me, is that when booting the board with the 3.4
> kernel, at boot, the mxs-mmc driver reports a SSP clock of 288MHz,
> while on 3.5, it reports a 480MHz SSP clock. By looking at the clk
> driver for the iMX28, there is a comment saying that the 480MHz clock
> seems to high for SD controlers, and that it should be 288MHz
> instead. Given that the clock part has changed quite a lot from 3.4 to
> 3.5, I think it might be a good lead, but hardcoding the SSP clock to
> 288MHz in the mxs-mmc driver instead of using the clk_get_rate
> function does not resolve the problem.
> 
> Also, this problem is seen with both DT-probing and traditionnal
> probing.
> 
> Do someone have an idea on what could possibly happen here ?
> 
Can you try the change below to see if it fixes the problem?

Regards,
Shawn

--8<---

diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index 003b0f3..1a41d4e 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -245,8 +245,8 @@ int __init mx28_clocks_init(void)
        clks[pll2] = mxs_clk_pll("pll2", "ref_xtal", PLL2CTRL0, 23, 50000000);
        clks[ref_cpu] = mxs_clk_ref("ref_cpu", "pll0", FRAC0, 0);
        clks[ref_emi] = mxs_clk_ref("ref_emi", "pll0", FRAC0, 1);
-       clks[ref_io0] = mxs_clk_ref("ref_io0", "pll0", FRAC0, 2);
-       clks[ref_io1] = mxs_clk_ref("ref_io1", "pll0", FRAC0, 3);
+       clks[ref_io1] = mxs_clk_ref("ref_io1", "pll0", FRAC0, 2);
+       clks[ref_io0] = mxs_clk_ref("ref_io0", "pll0", FRAC0, 3);
        clks[ref_pix] = mxs_clk_ref("ref_pix", "pll0", FRAC1, 0);
        clks[ref_hsadc] = mxs_clk_ref("ref_hsadc", "pll0", FRAC1, 1);
        clks[ref_gpmi] = mxs_clk_ref("ref_gpmi", "pll0", FRAC1, 2);
