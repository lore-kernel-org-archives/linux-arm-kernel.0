From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 11 Jul 2013 21:57:43 +0800
Subject: [PATCH 2/6] ARM: mxs: look up timrot clock from device tree
In-Reply-To: <20130711105625.GB12139@pengutronix.de>
References: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
 <1364224652-28332-3-git-send-email-shawn.guo@linaro.org>
 <20130711105625.GB12139@pengutronix.de>
Message-ID: <20130711135741.GA3043@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, Jul 11, 2013 at 12:56:26PM +0200, Uwe Kleine-K?nig wrote:
> I'm currently using an i.MX28 with 3.8-rt13 and patched the clocksource
> and clockevent to use the 24 MHz clock source
> (BV_TIMROTv2_TIMCTRLn_SELECT__ALWAYS instead of
> BV_TIMROTv2_TIMCTRLn_SELECT__32KHZ_XTAL). Currently my patch is a hack
> because I hard code the 24 MHz. I wonder how to do it properly?
> 

You may want to take a look at commit 2fb318f (ARM: mxs: use apbx bus
clock to drive the timers on timrotv2), which hit mainline in v3.9.

Shawn

> Add another item to the "clocks = <...>" entry and use the first entry
> for enable and the 2nd for clk_get_rate?
> 
> Something like:
> 
> 	always_clk = of_clk_get(np, 1);
> 	if (always_clk)
> 		register timers using always clk (24 MHz, SELECT__ALWAYS)
> 	else
> 		fall back to timer_clk (32 kHz, 32KHZ_XTAL)
> 
> and then
> 
> 	timrot at 80068000 {
> 		compatible = "fsl,imx28-timrot", "fsl,timrot";
> 		reg = <0x80068000 0x2000>;
> 		interrupts = <48 49 50 51>;
> 		clocks = <&clks 26 &clks 0>;
> 	};
> 
> If you like it, too, I can prepare a patch.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
