From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 28 Aug 2017 23:54:03 +0200
Subject: [PATCH 1/2] mtd: spi-nor: add an option to force 3byte adressing
 mode
In-Reply-To: <CAMuHMdX0b=J9AuPAvdRXGGVXvc7f9n7TJ0_VKR13P05toq9REw@mail.gmail.com>
References: <1503954854-30963-1-git-send-email-mw@semihalf.com>
 <1503954854-30963-2-git-send-email-mw@semihalf.com>
 <CAMuHMdX0b=J9AuPAvdRXGGVXvc7f9n7TJ0_VKR13P05toq9REw@mail.gmail.com>
Message-ID: <CAPv3WKf3ra5tiK2gjQYUaTpiiM=kg=UGqceVesinqtjjk=RUnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

>> +- spi-3byte-addressing - Empty property indicating device access to be done
>> +                   only in 3byte addressing mode.
>
> spi-force-3byte-addressing?

I can change it, no problem. I thought of this, but was affraid if the
property wouldn't be too long.

>
>>  Some SPI controllers and devices support Dual and Quad SPI transfer mode.
>>  It allows data in the SPI system to be transferred using 2 wires (DUAL) or 4
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 1413828..029c87d 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -2002,7 +2002,17 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>>                 if (JEDEC_MFR(info) == SNOR_MFR_SPANSION ||
>>                     info->flags & SPI_NOR_4B_OPCODES)
>>                         spi_nor_set_4byte_opcodes(nor, info);
>> -               else
>> +               else if (of_property_read_bool(np, "spi-3byte-addressing")) {
>> +                       /*
>> +                        * Do not enter 4byte mode in order to prevent
>> +                        * the early bootloader to come up on non-default
>> +                        * SPI NOR memory during boot. Limit accessible
>> +                        * size to 16MiB.
>> +                        */
>> +                       nor->addr_width = 3;
>> +                       mtd->size = 0x1000000;
>
> What if the device is smaller than 16 MiB?
>
> mtd->size = min(mtd->size, 0x1000000);

Not needed - this code is executed only for mtd->size > 0x1000000. See
bigger context:

        if (info->addr_width)
                nor->addr_width = info->addr_width;
        else if (mtd->size > 0x1000000) {
                /* enable 4-byte addressing if the device exceeds 16MiB */
                nor->addr_width = 4;
                if (JEDEC_MFR(info) == SNOR_MFR_SPANSION ||
                    info->flags & SPI_NOR_4B_OPCODES)
                        spi_nor_set_4byte_opcodes(nor, info);
                else if (of_property_read_bool(np, "spi-3byte-addressing")) {
                        /*
                         * Do not enter 4byte mode in order to prevent
                         * the early bootloader to come up on non-default
                         * SPI NOR memory during boot. Limit accessible
                         * size to 16MiB.
                         */
                        nor->addr_width = 3;
                        mtd->size = 0x1000000;
                        dev_info(dev, "Force 3B addressing mode\n");
                } else
                        set_4byte(nor, info, 1);
        } else {
                nor->addr_width = 3;
        }


Best regards,
Marcin
