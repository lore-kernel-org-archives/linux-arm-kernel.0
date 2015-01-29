From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 29 Jan 2015 13:39:42 +0100
Subject: [PATCH v2] MediaTek PMIC support
In-Reply-To: <20150126114735.GA3178@pengutronix.de>
References: <1422022202-7526-1-git-send-email-s.hauer@pengutronix.de>
 <20150126114735.GA3178@pengutronix.de>
Message-ID: <CABuKBe+x9o5OiysnMq-gvOBx3nKoaheL2efZGA6YQ7ZT5aqijw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

2015-01-26 12:47 GMT+01:00 Sascha Hauer <s.hauer@pengutronix.de>:
> Olof, Arnd,
>
> OK to put the driver into drivers/soc/mediatek? Can you take these
> patches?

How does this patches fit together with the one James clock framework patches?
Both use the same compatible "mediatek,mt8135-infracfg" and
"mediatek,mt8135-pericfg".

I had a look on other implementations and they attach the reset
controller to the clk driver, if they share the same hw block.
Might we run into problems if we implement the clocks in the mfd, as
we need the clocks early in boot (e.g. for the timer)?

In mt6589 pericfg apart from the clocks and reset controller provides
registers for AXI bus control and USB wakeup and USB clock selection.
The infracfg block provides top AXI bus fabric control signals and
remap registers for the modem.
Mike, Stephen, what do you think. Can we implement the clk in a mfd
driver? Or do you prefer to implement the whole block in the clk
driver?

Cheers,
Matthias

>
> Sascha
>
> On Fri, Jan 23, 2015 at 03:09:55PM +0100, Sascha Hauer wrote:
>> This series adds initial support for the MediaTek MT6397 PMIC and the
>> necessary infrastructure to attach it on the MT8135 / MT8173 SoCs.
>>
>> The infrastructure includes:
>>
>> - pericfg / infracfg controller support
>>   The pericfg / infracfg controllers contain miscellaneous registers for
>>   reset controllers and clocks.
>>
>> - PMIC wrapper support
>>   On MediaTek MT8135, MT8173 and other SoCs the PMIC is connected via
>>   SPI. The SPI master interface is not directly visible to the CPU, but
>>   only through the PMIC wrapper inside the SoC. The communication between
>>   the SoC and the PMIC can optionally be encrypted. Also a non standard
>>   Dual IO SPI mode can be used to increase speed. The MT8135 also supports
>>   a special feature named "IP Pairing". With IP Pairing the pins of some
>>   SoC internal peripherals can be on the PMIC. The signals of these pins
>>   are routed over the SPI bus using the pwrap bridge. Because of these
>>   optional non SPI conform features the PMIC driver is not implemented as
>>   a SPI bus master driver.
>>
>> The MT6397 PMIC itself is implemented as a regular mfd device driver which
>> uses regmap to access the PMIC registers.
>>
>> This series also adds regulator support for the MT6397 PMIC.
>>
>> The first 6 patches can be merged through the ARM SoC tree. The mfd
>> patch is independent of the first 6 patches and can be merged through the
>> mfd maintainer trees.
>>
>> Changes since v1:
>>
>> - document reset bindings for infracfg/pericfg
>> - fix base addresses in infracfg binding example
>> - Remove more Email addresses from Flora Fu (She is not working at
>>   MediaTek anymore, her address is no longer valid)
>> - drop Regulator support patch, it's already in next
>>
>> Sascha
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



-- 
motzblog.wordpress.com
