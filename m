From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 11 Jan 2016 16:37:03 +0000
Subject: [PATCH] spi: atmel: improve internal vs gpio chip-select choice
In-Reply-To: <5693D957.30103@atmel.com> (Cyrille Pitchen's message of "Mon, 11
 Jan 2016 17:33:27 +0100")
References: <1452211907-16074-1-git-send-email-mans@mansr.com>
 <5693C9A3.9040403@atmel.com> <5693D957.30103@atmel.com>
Message-ID: <yw1x8u3wvzrk.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cyrille Pitchen <cyrille.pitchen@atmel.com> writes:

> Hi Mans,
>
> Le 11/01/2016 16:26, Nicolas Ferre a ?crit :
>> Le 08/01/2016 01:11, Mans Rullgard a ?crit :
> [...]
>>> @@ -1569,13 +1576,6 @@ static int atmel_spi_probe(struct platform_device *pdev)
>>>  
>>>  	atmel_get_caps(as);
>>>  
>>> -	as->use_cs_gpios = true;
>>> -	if (atmel_spi_is_v2(as) &&
>> 
>> I don't see this atmel_spi_is_v2() test in the resulting code anymore:
>> did you make sure that the v1 of the peripheral is protected?
>> 
>>> -	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
>>> -		as->use_cs_gpios = false;
>>> -		master->num_chipselect = 4;
>> 
>> This line is pretty important: you mustn't remove it blindly!
>> 
>> 
>
> Actually, few lines above master->num_chipselect is initialized with:
> 	master->dev.of_node = pdev->dev.of_node;
> [...]
> 	master->num_chipselect = master->dev.of_node ? 0 : 4;
>
> So 0 in the case of DT support, 4 otherwise.
>
> Now looking at the source code of spi_register_master(), this function:
>
> 1 - calls of_spi_register_master(), which initializes master->num_chipselect:
> 	nb = of_gpio_name_count(np, "cs-gpios");
> 	master->num_chipselect = max_t(int, nb, master->num_chipselect);
>
> 	if (nb == 0 || nb == -ENOENT)
> 		return 0;
>
> 2 - check master->num_chipselect with:
> 	if (master->num_chipselect == 0)
> 		return -EINVAL;
>
> It means that in the case of DT support, master->num_chipselect was
> initialized according to the value of the "cs-gpios" DT
> property. Hence this property used to be mandatory but now we want it
> to be optional for hardware version 2 and later.
>
> This is why we added a check "hw version >= 2 and cs-gpios
> missing". In such a case the master->num_chipselect was initialized to
> 4 so spi_register_master() does not fail with -EINVAL.
>
> I have applied the following fix after your patch and now the driver works
> again on sama5d2:
>
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1576,6 +1576,11 @@ static int atmel_spi_probe(struct platform_device *pdev)
>
>         atmel_get_caps(as);
>
> +       if (atmel_spi_is_v2(as) &&
> +           master->dev.of_node &&
> +           !of_get_property(master->dev.of_node, "cs-gpios", NULL))
> +               master->num_chipselect = 4;
> +
>         as->use_dma = false;
>         as->use_pdc = false;
>         if (as->caps.has_dma_support) {

That's pretty much what I did (left the original alone) in v2 of the
patch.

Thanks for testing.

-- 
M?ns Rullg?rd
