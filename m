From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 26 Sep 2013 10:20:59 +0200
Subject: [RFC, PATCH] clocksource: provide timekeeping for efm32 SoCs
In-Reply-To: <524376A0.7020405@linaro.org>
References: <1379324644-20934-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5242F434.7060702@linaro.org>
 <20130925153207.GG16106@pengutronix.de>
 <524376A0.7020405@linaro.org>
Message-ID: <20130926082059.GI16106@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Daniel,

On Thu, Sep 26, 2013 at 01:49:52AM +0200, Daniel Lezcano wrote:
> On 09/25/2013 05:32 PM, Uwe Kleine-K?nig wrote:
> >>> +static void __init efm32_timer_init(struct device_node *np)
> >>> +{
> >>> +	static int has_clocksource, has_clockevent;
> >>> +	int ret;
> >>> +
> >>> +	if (!has_clocksource) {
> >>> +		ret = efm32_clocksource_init(np);
> >>> +		if (!ret) {
> >>> +			has_clocksource = 1;
> >>> +			return;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	if (!has_clockevent) {
> >>> +		ret = efm32_clockevent_init(np);
> >>> +		if (!ret) {
> >>> +			has_clockevent = 1;
> >>> +			return;
> >>> +		}
> >>> +	}
> >>> +}
> >>
> >> I don't get the purpose of this initialization, can you explain ?
> > An efm32 SoC has four timer blocks. A single block can only be used for
> > one of clocksource or clockevent device and having more than one
> > clocksource or clockevent device doesn't make sense. So this routine
> > asserts that the first timer is used as clocksource and the second as
> > clockevent device. The others are unused.
> 
> Shouldn't be up to the dt to give the timers you want ?
The dt looks as follows:

                timer0: timer at 40010000 {
                        compatible = "efm32,timer";
                        reg = <0x40010000 0x400>;
                        interrupts = <2>;
                        clocks = <&cmu clk_HFPERCLKTIMER0>;
                };

                timer1: timer at 40010400 {
                        compatible = "efm32,timer";
                        reg = <0x40010400 0x400>;
                        interrupts = <12>;
                        clocks = <&cmu clk_HFPERCLKTIMER1>;
                };

                timer2: timer at 40010800 {
                        compatible = "efm32,timer";
                        reg = <0x40010800 0x400>;
                        interrupts = <13>;
                        clocks = <&cmu clk_HFPERCLKTIMER2>;
                };

                timer3: timer at 40010c00 {
                        compatible = "efm32,timer";
                        reg = <0x40010c00 0x400>;
                        interrupts = <14>;
                        clocks = <&cmu clk_HFPERCLKTIMER3>;
                };

What is your suggestion now? Add a property that specifies if the block
should be used as clocksource or clockevent_device? That isn't a
hardware description and so shouldn't go into the device tree.
Provide two drivers that match on "efm32,timer", one for clocksource and
another for clockevent_device? That wouldn't work, too, as the first
driver to be loaded would grab all four timers and the second would get
none.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
