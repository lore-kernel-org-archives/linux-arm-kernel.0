From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 07 Sep 2014 08:50:19 +0800
Subject: [PATCH 2/8] spi: sirf: request and free cs gpio in setup and
 cleanup callbacks
In-Reply-To: <20140906135735.GE2601@sirena.org.uk>
Message-ID: <D031CA8D.21605%21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14-9-6 ??9:57, "Mark Brown" <broonie@kernel.org> wrote:

>On Fri, Sep 05, 2014 at 11:34:57AM +0800, swingboard wrote:
>> 2014-09-05 3:19 GMT+08:00 Mark Brown <broonie@kernel.org>:
>
>> > I'm not quite sure I understand the rationale here - as far as I can
>> > tell this is making the GPIO request happen later not earlier so it's
>> > not clear to me what the problem this is fixing in the existing code.
>> > If the goal is to move the request around in the probe function why
>>not
>> > just move the existing code earlier in probe()?
>
>> As GPIO cs can be high or low validate and the used GPIO pin with
>> default value may high or low,
>> it is need do spi device's chipselect invalidation work in spi_setup,
>> the patch purpose for it.
>> master->cs_gpios only assigned after spi_bitbang_start and the
>> function call spi_setup,
>> if keep the existing code there will result gpio usage before gpio
>>request.
>> just move gpio request code in spi_sirfsoc_setup before gpio use.
>
>I'm still having a hard time understanding why pulling the code earlier
>in probe isn't a better fix here.

Gpio is unknown before spi_bitbang_start(). Everything is done in the big
routine spi_bitbang_start(). It includes:
Get cs_gpios, extend spi devices, and setup cs to de-active.

-barry
