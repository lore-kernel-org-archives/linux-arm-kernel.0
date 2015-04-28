From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Apr 2015 11:36:51 +0800
Subject: [PATCH 2/8] spi: sirf: request and free cs gpio in setup and
 cleanup callbacks
In-Reply-To: <D031CA8D.21605%21cnbao@gmail.com>
References: <20140906135735.GE2601@sirena.org.uk>
 <D031CA8D.21605%21cnbao@gmail.com>
Message-ID: <CAGsJ_4yhSFnzyZV6B3j90LyJbstsyBJHCnk=LZqVDsL_u8foPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>>> > I'm not quite sure I understand the rationale here - as far as I can
>>> > tell this is making the GPIO request happen later not earlier so it's
>>> > not clear to me what the problem this is fixing in the existing code.
>>> > If the goal is to move the request around in the probe function why
>>>not
>>> > just move the existing code earlier in probe()?
>>
>>> As GPIO cs can be high or low validate and the used GPIO pin with
>>> default value may high or low,
>>> it is need do spi device's chipselect invalidation work in spi_setup,
>>> the patch purpose for it.
>>> master->cs_gpios only assigned after spi_bitbang_start and the
>>> function call spi_setup,
>>> if keep the existing code there will result gpio usage before gpio
>>>request.
>>> just move gpio request code in spi_sirfsoc_setup before gpio use.
>>
>>I'm still having a hard time understanding why pulling the code earlier
>>in probe isn't a better fix here.
>
> Gpio is unknown before spi_bitbang_start(). Everything is done in the big
> routine spi_bitbang_start(). It includes:
> Get cs_gpios, extend spi devices, and setup cs to de-active.

Mark, i'd like to re-call this patch. "pulling the code earlier in
probe" is impossible based on current SPI core codes. because before
spi master is registerred,
cs_gpios is NULL. but once it is registered, cs_gpios are assigned in
spi_register_master:

1446 static int of_spi_register_master(struct spi_master *master)
1447 {
1448         int nb, i, *cs;
1449         struct device_node *np = master->dev.of_node;
1450
1451         if (!np)
1452                 return 0;
1453
1454         nb = of_gpio_named_count(np, "cs-gpios");
1455         master->num_chipselect = max_t(int, nb, master->num_chipselect);
1456
1457         /* Return error only for an incorrectly formed cs-gpios property */
1458         if (nb == 0 || nb == -ENOENT)
1459                 return 0;
1460         else if (nb < 0)
1461                 return nb;
1462
1463         cs = devm_kzalloc(&master->dev,
1464                           sizeof(int) * master->num_chipselect,
1465                           GFP_KERNEL);
1466         master->cs_gpios = cs;
1467
1468         if (!master->cs_gpios)
1469                 return -ENOMEM;
1470
1471         for (i = 0; i < master->num_chipselect; i++)
1472                 cs[i] = -ENOENT;
1473
1474         for (i = 0; i < nb; i++)
1475                 cs[i] = of_get_named_gpio(np, "cs-gpios", i);


we can get cs_gpios earlier in probe(), but this will definitely
reduplicated with SPI core.

and in the setup() stage, we need the CS to be de-active, so we need
the cs_gpio. that means we have to move gpio_request codes earlier,
but the current SPI core stop us from get ting gpio earlier than
spi_bitbang_start() being called. it looks the setup() itself is the
best place to get the cs.

drivers/spi/spi-clps711x.c is doing cs_gpios earlier in probe(), but
it is a non-OF driver, which will not have of_spi_register_master() to
set cs_gpios.


-barry
