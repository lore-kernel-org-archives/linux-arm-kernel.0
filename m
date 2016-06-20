From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 20 Jun 2016 18:00:56 +0900
Subject: [PATCH] clk: samsung: exynos5433: use clock_ignore_unused flag
 for SPI3 related clocks
In-Reply-To: <20160620054157.GA6498@samsunx.samsung>
References: <1466151362-2881-1-git-send-email-andi.shyti@samsung.com>
 <CA+Ln22F9eskcpnFkrnVFc3dJqCJcJ5O-STfXC-8Om5MK-THwNg@mail.gmail.com>
 <20160619055921.GA424@jack.zhora.eu>
 <CGME20160619134424epcas1p31493dfce45a8c817bc353702a07fa4bb@epcas1p3.samsung.com>
 <CA+Ln22HHNnPuEq1WVs+iiEEbAhdvkADhVkj99pqgR0qJODFUXw@mail.gmail.com>
 <20160620054157.GA6498@samsunx.samsung>
Message-ID: <CA+Ln22FcKQTq4XhHQPd=Y-B_cUMzFd51ZPkgwrtP_KsqUVxnJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-06-20 14:41 GMT+09:00 Andi Shyti <andi.shyti@samsung.com>:
> Hi Tomasz,
>
>> >> > The SPI 3 bus uses two clocks, a bus clock and an input clock.
>> >> > Do not disable the clocks when unused in order to allow access to
>> >> > the SPI 3 device.
>> >>
>> >> If unused, why would access to SPI 3 device needed?
>> >
>> > because next I will submit a small driver which uses the SPI3.
>> > Actually in the exynos5433 boards all the SPI are used but not all
>> > the drivers are ported to mainline.
>>
>> Then shouldn't the driver request the clocks and enable them? Or I'm
>> missing something obvious? :)
>
> the reason is that...
>
> [ from the patch ]
>
>>         GATE(CLK_SCLK_IOCLK_SPI3, "sclk_ioclk_spi3", "ioclk_spi3_clk_in",
>> -                       ENABLE_SCLK_PERIC, 20, CLK_SET_RATE_PARENT, 0),
>> +                       ENABLE_SCLK_PERIC, 20,
>> +                       CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
>
> ... the sclk_ioclk_spi3 is new in exynos5433 and there is no
> implementation for enabling/disabling that particular clock...

I'm not convinced that it's a good reason to make boards on which SPI3
is unused not gate the clock by default, then. The correct solution
would be to make the SPI driver request this clock and enable it.

>
>>         GATE(CLK_SCLK_SPI3, "sclk_spi3", "sclk_spi3_peric", ENABLE_SCLK_PERIC,
>> -                       18, CLK_SET_RATE_PARENT, 0),
>> +                       18, CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
>
> ... while in this case your question makes sense, but it depends
> on which clock the device (s3c64xx) is requesting (from the DTS).
> In any case, I kept it consistent with the SPI1, which falls in
> the same case, as in mainline we don't have any DTS for
> exynos5433 (yet!).

Same here.

In general CLK_IGNORE_UNUSED should be avoided, because the semantics
of CLK_IGNORE_UNUSED are really weak and protect only from
clk_disable_unused(). It doesn't cause the clock to be enabled if it
was disabled at boot-up and it doesn't cause its parents to be enabled
(not even stay enabled if they don't have CLK_IGNORE_UNUSED, but have
gating capability). The only reasonable use case for it that I can
think of now is a display controller that needs certain clocks to
remain running to keep showing something on the screen until the
proper driver is loaded and takes over.

Unfortunately I have to NAK this patch. Please add proper support for
them to the SPI driver.

Best regards,
Tomasz
