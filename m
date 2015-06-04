From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 4 Jun 2015 17:58:07 +0200
Subject: [PATCH v2 1/2] mtd: spi-nor: add driver for NXP SPI Flash
 Interface (SPIFI)
In-Reply-To: <5570692E.2050603@vanguardiasur.com.ar>
References: <1433106362-6032-1-git-send-email-manabian@gmail.com>
 <1433106362-6032-2-git-send-email-manabian@gmail.com>
 <5570692E.2050603@vanguardiasur.com.ar>
Message-ID: <CAGhQ9VzU+J1ZT45e-yZ+BAmyZvLUm1cyXE2T__O_4gGjtHrX-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 June 2015 at 17:05, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> Joachim,
>
> I tested the driver and found an issue with it.
>
> On 05/31/2015 06:06 PM, Joachim Eastwood wrote:
>> +
>> +     spifi->mtd.priv  = &spifi->nor;
>> +     spifi->nor.mtd   = &spifi->mtd;
>> +     spifi->nor.dev   = spifi->dev;
>> +     spifi->nor.priv  = spifi;
>> +     spifi->nor.read  = nxp_spifi_read;
>> +     spifi->nor.write = nxp_spifi_write;
>> +     spifi->nor.erase = nxp_spifi_erase;
>> +     spifi->nor.read_reg  = nxp_spifi_read_reg;
>> +     spifi->nor.write_reg = nxp_spifi_write_reg;
>> +
>> +     ret = of_modalias_node(np, modalias, sizeof(modalias));
>> +     if (ret < 0) {
>> +             dev_err(spifi->dev, "unable to get device modalias\n");
>> +             return ret;
>> +     }
>> +
>> +     /*
>> +      * The first read on a hard reset isn't reliable so do a
>> +      * dummy read of the id before calling spi_nor_scan().
>> +      * The reason for this problem is unknown.
>> +      *
>> +      * The official NXP spifilib uses more or less the same
>> +      * workaround that is applied here by reading the device
>> +      * id multiple times.
>> +      */
>> +     nxp_spifi_dummy_id_read(&spifi->nor);
>> +
>
> Actually, I think there's an issue here. See how m25p80 deals
> with modalias:
>
>         [..]
>         else if (!strcmp(spi->modalias, "spi-nor"))
>                 flash_name = NULL; /* auto-detect */
>         else
>                 flash_name = spi->modalias;
>
>         ret = spi_nor_scan(nor, flash_name, mode);
>         if (ret)
>                 return ret;
>
> I think the "auto-detect" quirk is really needed, or you are will
> otherwise fail to probe with the generic "jedec,spi-nor" compatible
> string.

I see.

Seem easy enough to fix. I'll send out new version after doing some
more tests here.

Note that this code was copied from fsl-quadspi so I assume it has the
same problem.


Thanks for testing and catching the issue, Ezequiel.


regards,
Joachim Eastwood
