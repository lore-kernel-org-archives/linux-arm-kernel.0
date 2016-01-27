From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 27 Jan 2016 17:55:10 +0100
Subject: [PATCH v3 1/3] spi: atmel: add support for the internal
 chip-select of the spi controller
In-Reply-To: <yw1xk2mvj9xp.fsf@unicorn.mansr.com>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
 <c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen@atmel.com>
 <yw1xvb771yrl.fsf@unicorn.mansr.com> <56A8E66B.208@atmel.com>
 <yw1xk2mvj9xp.fsf@unicorn.mansr.com>
Message-ID: <56A8F66E.6070105@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/01/2016 16:53, M?ns Rullg?rd a ?crit :
> Nicolas Ferre <nicolas.ferre@atmel.com> writes:
> 
>> Le 05/01/2016 22:50, M?ns Rullg?rd a ?crit :
>>> Cyrille Pitchen <cyrille.pitchen@atmel.com> writes:
>>>
>>>> This patch relies on the CSAAT (Chip Select Active After Transfer) feature
>>>> introduced by the version 2 of the spi controller. This new mode allows to
>>>> use properly the internal chip-select output pin of the spi controller
>>>> instead of using external gpios. Consequently, the "cs-gpios" device-tree
>>>> property becomes optional.
>>>>
>>>> When the new CSAAT bit is set into the Chip Select Register, the internal
>>>> chip-select output pin remains asserted till both the following conditions
>>>> become true:
>>>> - the LASTXFER bit is set into the Control Register (or the Transmit Data
>>>>   Register)
>>>> - the Transmit Data Register and its shift register are empty.
>>>>
>>>> WARNING: if the LASTXFER bit is set into the Control Register then new
>>>> data are written into the Transmit Data Register fast enough to keep its
>>>> shifter not empty, the chip-select output pin remains asserted. Only when
>>>> the shifter becomes empty, the chip-select output pin is unasserted.
>>>>
>>>> When the CSAAT bit is clear in the Chip Select Register, the LASTXFER bit
>>>> is ignored in both the Control Register and the Transmit Data Register.
>>>> The internal chip-select output pin remains active as long as the Transmit
>>>> Data Register or its shift register are not empty.
>>>>
>>>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>>>> ---
>>>>  drivers/spi/spi-atmel.c | 37 ++++++++++++++++++++++++++++---------
>>>>  1 file changed, 28 insertions(+), 9 deletions(-)
>>>
>>> [...]
>>>
>>>> @@ -1338,6 +1350,13 @@ static int atmel_spi_probe(struct platform_device *pdev)
>>>>
>>>>  	atmel_get_caps(as);
>>>>
>>>> +	as->use_cs_gpios = true;
>>>> +	if (atmel_spi_is_v2(as) &&
>>>> +	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
>>>> +		as->use_cs_gpios = false;
>>>> +		master->num_chipselect = 4;
>>>> +	}
>>>
>>> This part breaks the AVR32 boards and probably anything else that
>>> doesn't use devicetree but does use GPIOs for chip select.
>>
>> Hi Mans,
>>
>> I have difficulties finding why you may enter this test. So, maybe you
>> can give me a clue by reading for me the value that resides in the SPI
>> version register: you can have it by reading at 0xFFE000FC for instance
>> (actually the atmel_get_caps() dev_info() call gives it as well in the
>> boot log which is somewhat easier: I tried to find one on the Internet
>> without success...).
>>
>> So I think that just fixing the logic in atmel_get_caps() introduced by
>> d4820b7496219edd9a7055022681364d304525f7 can make it come back to a
>> situation where the ARV32 was more tested than nowadays.
> 
> atmel_spi atmel_spi.0: version: 0x171
> atmel_spi atmel_spi.0: Atmel SPI Controller at 0xffe00000 (irq 3)
> 
> atmel_spi_is_v2() returns true for version > 0x121.

Ok, thanks: we thought that AVR32 didn't have a v2 IP: obviously it has.
So yes, I extract the patch by Cyrille to correct this and send it right
now.

If you can test it, it's even better ;-)

Thanks, bye.
-- 
Nicolas Ferre
