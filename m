From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 12 Aug 2015 12:00:14 -0700
Subject: [PATCH v4 2/8] clk: Add a Raspberry Pi-specific clock driver.
In-Reply-To: <87wpx04c4q.fsf@eliezer.anholt.net>
References: <1437420787-32137-1-git-send-email-eric@anholt.net>
 <1437420787-32137-3-git-send-email-eric@anholt.net>
 <20150811211733.31346.11122@quantum> <87wpx04c4q.fsf@eliezer.anholt.net>
Message-ID: <20150812190014.31346.89987@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Eric Anholt (2015-08-12 11:04:05)
> Michael Turquette <mturquette@linaro.org> writes:
> 
> > Hi Eric,
> >
> > Quoting Eric Anholt (2015-07-20 12:33:01)
> >> +void __init rpi_firmware_init_clock_provider(struct device_node *node)
> >> +{
> >> +       /* We delay construction of our struct clks until get time,
> >> +        * because we need to be able to return -EPROBE_DEFER if the
> >> +        * firmware driver isn't up yet.  clk core doesn't support
> >> +        * re-probing on -EPROBE_DEFER, but callers of clk_get can.
> >> +        */
> >> +       of_clk_add_provider(node, rpi_firmware_delayed_get_clk, node);
> >> +}
> >> +
> >> +CLK_OF_DECLARE(rpi_firmware_clocks, "raspberrypi,bcm2835-firmware-clocks",
> >> +              rpi_firmware_init_clock_provider);
> >
> > Do you require CLK_OF_DECLARE here? Could this be a platform driver
> > instead?
> 
> I'm not actually sure.  The common pattern seemed to be using
> CLK_OF_DECLARE (130 files using it versus declaring a struct
> platform_driver), and it seems to avoid a whole lot of boilerplate.
> What would the advantage be?

Correctly using the Linux driver model, having a nice struct device and
things like supsend and resume handlers, etc.

There is a lot of CLK_OF_DECLARE going on in drivers/clk, but I am
hoping we can fix that. The main reason for CLK_OF_DECLARE is when you
need to register clocks very early (e.g. timers). This is often not the
case.

Regards,
Mike
