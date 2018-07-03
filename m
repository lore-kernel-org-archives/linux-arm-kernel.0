From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 03 Jul 2018 12:01:15 +0200
Subject: [PATCH 2/3] clk: meson: add sub EMMC clock dt-bindings IDs
In-Reply-To: <1aedbb15-1373-adde-f5bb-bce3701d50b0@amlogic.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
 <20180703145716.31860-3-yixun.lan@amlogic.com>
 <20180703092107.51497a8f@bbrezillon>
 <4b88c509-27ea-2605-023b-de208921e157@amlogic.com>
 <1530605373.2900.158.camel@baylibre.com>
 <1aedbb15-1373-adde-f5bb-bce3701d50b0@amlogic.com>
Message-ID: <1530612075.2900.204.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-03 at 17:56 +0800, Yixun Lan wrote:
> > > Yes, It's true, the mux is parent of the div clock.
> > > 
> > > while testing for the NAND driver, I find it's kind of loose about the
> > > parent of the clock, so selecting the div (and let CCF decide freely) is
> > > actually works fine
> > > 
> > > but for the EMMC driver, especially when running at high clock, it's
> > > kind of picky about the parent of the clock, 
> > 
> > It would be nice to get an explanation about this behavior.
> > it seems that even of the rate provided by CLKID_SD_EMMC_X_CLK0 (main clock
> > controller) is correct, the eMMC cannot reliably tune with it.
> > 
> > Could you elaborate on this ?
> > 
> 
> It's during my own test in AXG platform, I found clock path
> a) fclk_div2 -> sd_emmc_c_clk0_sel -> sd_emmc_c_clk0_div ->
> sd_emmc_c_clk0 -> sd_emmc_c_mux -> sd_emmc_c_div
> 
> b) fclk_div2 -> sd_emmc_c_mux -> sd_emmc_c_div
> 
> path a) doesn't work in EMMC driver, even both clock parent of them from
> the same fclk_div2 source.
> 
>  sd_emmc_c_mux -> sd_emmc_c_div is the clock from the EMMC register base.
> I believe it's ASIC design issue

yes Yixun, I did the same test. What I meant with this question is: could you
confirm there a problem with this clock, and what it is exactly so we can adjust
the clock as necessary.

If FDIV2 entry to this clock is broken, maybe it should be removed.
