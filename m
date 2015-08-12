From: eric@anholt.net (Eric Anholt)
Date: Wed, 12 Aug 2015 11:04:05 -0700
Subject: [PATCH v4 2/8] clk: Add a Raspberry Pi-specific clock driver.
In-Reply-To: <20150811211733.31346.11122@quantum>
References: <1437420787-32137-1-git-send-email-eric@anholt.net>
 <1437420787-32137-3-git-send-email-eric@anholt.net>
 <20150811211733.31346.11122@quantum>
Message-ID: <87wpx04c4q.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Turquette <mturquette@linaro.org> writes:

> Hi Eric,
>
> Quoting Eric Anholt (2015-07-20 12:33:01)
>> +void __init rpi_firmware_init_clock_provider(struct device_node *node)
>> +{
>> +       /* We delay construction of our struct clks until get time,
>> +        * because we need to be able to return -EPROBE_DEFER if the
>> +        * firmware driver isn't up yet.  clk core doesn't support
>> +        * re-probing on -EPROBE_DEFER, but callers of clk_get can.
>> +        */
>> +       of_clk_add_provider(node, rpi_firmware_delayed_get_clk, node);
>> +}
>> +
>> +CLK_OF_DECLARE(rpi_firmware_clocks, "raspberrypi,bcm2835-firmware-clocks",
>> +              rpi_firmware_init_clock_provider);
>
> Do you require CLK_OF_DECLARE here? Could this be a platform driver
> instead?

I'm not actually sure.  The common pattern seemed to be using
CLK_OF_DECLARE (130 files using it versus declaring a struct
platform_driver), and it seems to avoid a whole lot of boilerplate.
What would the advantage be?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/82521ee8/attachment.sig>
