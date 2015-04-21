From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 21 Apr 2015 17:42:53 +0200
Subject: Question about checking rate_spi in pwrap_init_reg_clock
In-Reply-To: <20150421125223.GB6325@pengutronix.de>
References: <1429581487.5994.1.camel@ingics.com>
 <20150421103155.GX6325@pengutronix.de>
 <CABuKBeJqgWHWNYaFXS-BwEayHEtiYGt+56LLXs3QaO3MHUk0bQ@mail.gmail.com>
 <20150421125223.GB6325@pengutronix.de>
Message-ID: <CABuKBeJMKpmkVZQvjZOuEtZmVaby6wxhr-i7w6eoHLjqTNNRig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-21 14:52 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> On Tue, Apr 21, 2015 at 01:43:19PM +0200, Matthias Brugger wrote:
>> 2015-04-21 12:31 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
>> > On Tue, Apr 21, 2015 at 09:58:07AM +0800, Axel Lin wrote:
>> >> hi,
>> >> The implementation in pwrap_init_reg_clock seems has off-by-one bug.
>> >> If rate_spi is 26000000, current code set ck_mhz to 18 rather than 26.
>> >>
>> >> I guess it needs below fix, but I'm not 100% sure as I don't have the datasheet.
>> >> Can someone confirm if this is a bug or not?
>> >
>> > Yes, seems to be a bug. Thanks for noting. Will you send a formal patch
>> > or should I do it?
>>
>> Did you have a look on both datasheets/reference kernels, mt8135 and mt8173?
>> Reading the datasheet and reference kernel code for mt6589 this SPI
>> waveform configuration looks like magic.
>>
>> But reading the clock frequency which can have clk_spi in mt8135, they
>> are 0 MHz, 26 MHz and bigger then 26 MHz, which leads me to the
>> conclusion that the code is correct. Otherwise the check for bigger
>> then 18 MHz is useless and should be deleted, if we have a similar
>> clock distribution in mt8173.
>
> The CSHEXT and CSLEXT registers extend the time the chipselect stays
> high after a SPI transfer or low before a new transfer by the given
> number of spi clk cycles.
> Looking at the code maybe the real question is not whether the border is
> at 25999999Hz or at 26000000Hz, but why the transfers are throttled with
> slower clock frequencies. I would assume the other way round makes
> sense.

After re-reading the data sheet and the reference kernel
implementation, it seems as if three clocks exist. clk_wrap and
clk_spi and "pmic reg_clk". And some how depending on the three clocks
you have to calculate the values for CSHEXT, CSLEXT etc.

I think we need some clarification here from Mediatek to really
understand what is going on.
