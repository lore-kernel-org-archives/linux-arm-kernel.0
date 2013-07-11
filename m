From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 11 Jul 2013 12:56:26 +0200
Subject: [PATCH 2/6] ARM: mxs: look up timrot clock from device tree
In-Reply-To: <1364224652-28332-3-git-send-email-shawn.guo@linaro.org>
References: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
 <1364224652-28332-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130711105625.GB12139@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Mon, Mar 25, 2013 at 11:17:28PM +0800, Shawn Guo wrote:
> Change call clk_get_sys() to of_clk_get() to look up timrot clock from
> device tree, so that the clk_register_clkdev() call for timrot can be
> saved in clock driver.

I'm currently using an i.MX28 with 3.8-rt13 and patched the clocksource
and clockevent to use the 24 MHz clock source
(BV_TIMROTv2_TIMCTRLn_SELECT__ALWAYS instead of
BV_TIMROTv2_TIMCTRLn_SELECT__32KHZ_XTAL). Currently my patch is a hack
because I hard code the 24 MHz. I wonder how to do it properly?

Add another item to the "clocks = <...>" entry and use the first entry
for enable and the 2nd for clk_get_rate?

Something like:

	always_clk = of_clk_get(np, 1);
	if (always_clk)
		register timers using always clk (24 MHz, SELECT__ALWAYS)
	else
		fall back to timer_clk (32 kHz, 32KHZ_XTAL)

and then

	timrot at 80068000 {
		compatible = "fsl,imx28-timrot", "fsl,timrot";
		reg = <0x80068000 0x2000>;
		interrupts = <48 49 50 51>;
		clocks = <&clks 26 &clks 0>;
	};

If you like it, too, I can prepare a patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
