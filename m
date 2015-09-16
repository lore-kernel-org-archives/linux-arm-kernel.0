From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 16 Sep 2015 10:34:35 +0200
Subject: [linux-next RFC v7 2/6] mtd: spi-nor: read JEDEC ID with multiple
 I/O protocols
In-Reply-To: <CAD6G_RQV--nRk-pf347ThnEbQ=+tozXq8PKZL818cEK7nAi+gA@mail.gmail.com>
References: <cover.1442330503.git.cyrille.pitchen@atmel.com>
 <900653cccf2903386a992ea2b702b04dc8205407.1442330503.git.cyrille.pitchen@atmel.com>
 <CAD6G_RQV--nRk-pf347ThnEbQ=+tozXq8PKZL818cEK7nAi+gA@mail.gmail.com>
Message-ID: <55F9299B.5030104@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jagan,

Le 15/09/2015 19:53, Jagan Teki a ?crit :
> On 15 September 2015 at 20:58, Cyrille Pitchen
> <cyrille.pitchen@atmel.com> wrote:
>> When their quad or dual I/O mode is enabled, Micron and Macronix spi-nor
>> memories don't reply to the regular Read ID (0x9f) command. Instead they
>> reply to a new dedicated command Read ID Multiple I/O (0xaf).
>>
>> If the Read ID (0x9f) command fails (the read ID is all 1's or all 0's),
>> then the Read ID Multiple I/O (0xaf) is used, first with SPI 4-4-4 protocol
>> (supported by both Micron and Macronix memories), lately with SPI-2-2-2
>> protocol (supported only by Micron memories).
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>> ---
>>  drivers/mtd/devices/m25p80.c      |  8 +-----
>>  drivers/mtd/spi-nor/fsl-quadspi.c |  2 +-
>>  drivers/mtd/spi-nor/nxp-spifi.c   | 13 +++------
>>  drivers/mtd/spi-nor/spi-nor.c     | 59 ++++++++++++++++++++++++++++++++++-----
>>  include/linux/mtd/spi-nor.h       | 27 +++++++++++++++---
>>  5 files changed, 81 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
>> index 4b5d7a4655fd..1457866a4930 100644
>> --- a/drivers/mtd/devices/m25p80.c
>> +++ b/drivers/mtd/devices/m25p80.c
>> @@ -179,7 +179,6 @@ static int m25p_probe(struct spi_device *spi)
>>         struct flash_platform_data      *data;
>>         struct m25p *flash;
>>         struct spi_nor *nor;
>> -       enum read_mode mode = SPI_NOR_NORMAL;
>>         char *flash_name = NULL;
>>         int ret;
>>
>> @@ -205,11 +204,6 @@ static int m25p_probe(struct spi_device *spi)
>>         spi_set_drvdata(spi, flash);
>>         flash->spi = spi;
>>
>> -       if (spi->mode & SPI_RX_QUAD)
>> -               mode = SPI_NOR_QUAD;
>> -       else if (spi->mode & SPI_RX_DUAL)
>> -               mode = SPI_NOR_DUAL;
>> -
>>         if (data && data->name)
>>                 nor->mtd.name = data->name;
>>
>> @@ -223,7 +217,7 @@ static int m25p_probe(struct spi_device *spi)
>>         else
>>                 flash_name = spi->modalias;
>>
>> -       ret = spi_nor_scan(nor, flash_name, mode);
>> +       ret = spi_nor_scan(nor, flash_name, spi->mode);
> 
> IMHO, this is certainly incorrect because spi-nor never know anything
> about spi (Linux) that is why this framework got into picture.
> 

OK but what to use instead? Because we need to know the SPI controller
capabilities as compared to what the SPI NOR memory expects.

SPI_NOR_QUAD is just not enough as it doesn't allow us to make the difference
between SPI 1-1-4, 1-4-4 or 4-4-4 protocols.
Some manufacturer specific commands like Multiple I/O Read ID (0xaf) only work
with the SPI 4-4-4 protocol.

Also patch 3 (mtd: spi-nor: set the read op code and protocol based on the
manufacturer) makes use of the SPI controller capabilities to select the right
Fast Read op code and SPI protocol to match the SPI NOR memory interface.

Currently the framework always uses the Fast Read Quad Output 1-1-4 (0x6b).
Then for Macronix QSPI memories, the framework also enables their QPI mode.
However the datasheet of Macronix MX66L1G claims this command (0x6b) is only
supported in in SPI mode but not in QPI mode.

Also for Micron QSPI memories, the framework turns their Quad mode on but once
enabled the spi-nor memories expected ALL commands to use the SPI 4-4-4
protocol. SPI controllers have no mean to be notified about that protocol
change.

Besides, the m25p80 driver only checks the SPI_RX_QUAD flag before asking the
spi-nor framework to use some Quad SPI mode but in many cases it's not enough;
the SPI_TX_QUAD flag is also needed.

Of course there are other ways to provide the spi-nor framework with the SPI
controller. Maybe we can still use a bitmask for its simplicity of use by
changing a little bit the definition of the spi_protocol constants:

#define SPI_PROTO_1_1_1    0x0001
#define SPI_PROTO_1_1_2    0x0002
#define SPI_PROTO_1_1_4    0x0004
#define SPI_PROTO_1_2_2    0x0008
#define SPI_PROTO_1_4_4    0x0010
#define SPI_PROTO_2_2_2    0x0020
#define SPI_PROTO_4_4_4    0x0040

Then for instance in m25p80.c, we do something like:

unsigned int supported_protocols = SPI_PROTO_1_1_1;

if (spi->mode & SPI_RX_QUAD) {
        supported_protocols |= SPI_PROTO_1_1_4;

        if (spi->mode & SPI_TX_QUAD)
                supported_protocols |= (SPI_PROTO_1_4_4 | SPI_PROTO_4_4_4);
}

if (spi->mode & SPI_RX_DUAL) {
        supported_protocols |= SPI_PROTO_1_1_2;

        if (spi->mode & SPI_TX_DUAL)
                supported_protocols |= (SPI_PROTO_1_2_2 | SPI_PROTO_2_2_2);
}

ret = spi_nor_scan(nor, flash_name, supported_protocols);

Does it sound better to you so we don't use the flags defined in
<linux/spi/spi.h> in the spi-nor framework ?


[...]
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 8818d4325d20..1908038c8f2e 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/mtd/cfi.h>
>>  #include <linux/mtd/mtd.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/spi/spi.h>
> 
> Same comment as above - don't use spi on spi-nor.
> 
>>  #include <linux/spi/flash.h>
>>  #include <linux/mtd/spi-nor.h>
>>
>> @@ -61,6 +62,11 @@ struct flash_info {
>>
>>  #define JEDEC_MFR(info)        ((info)->id[0])
>>
>> +struct read_id_proto {
>> +       enum spi_protocol       proto;  /* SPI protocol to read the JEDEC ID */
>> +       u16                     mode;   /* SPI controller required caps */
>> +};
>> +
>>  static const struct flash_info *spi_nor_match_id(const char *name);
>>
>>  /*
>> @@ -701,11 +707,15 @@ static const struct flash_info spi_nor_ids[] = {
>>         { },
>>  };
>>
>> -static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>> +static const struct flash_info *spi_nor_read_id(struct spi_nor *nor, u16 mode)
>>  {
>> -       int                     tmp;
>> +       int                     i, tmp;
>>         u8                      id[SPI_NOR_MAX_ID_LEN];
>>         const struct flash_info *info;
>> +       static const struct read_id_proto proto[] = {
>> +               { SPI_PROTO_4_4_4, SPI_RX_QUAD | SPI_TX_QUAD },
>> +               { SPI_PROTO_2_2_2, SPI_RX_DUAL | SPI_TX_DUAL }
>> +       };
>>
>>         tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
>>         if (tmp < 0) {
>> @@ -713,6 +723,35 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>>                 return ERR_PTR(tmp);
>>         }
>>
>> +       /* Special case for Micron/Macronix qspi nor. */
>> +       for (i = 0; i < ARRAY_SIZE(proto); ++i) {
>> +               if (!((id[0] == 0xff && id[1] == 0xff && id[2] == 0xff) ||
>> +                     (id[0] == 0x00 && id[1] == 0x00 && id[2] == 0x00)))
>> +                       break;
>> +
>> +               /* Check whether the SPI controller supports this protocol. */
>> +               if ((mode & proto[i].mode) != proto[i].mode)
>> +                       continue;
>> +
>> +               nor->erase_proto = proto[i].proto;
>> +               nor->read_proto = proto[i].proto;
>> +               nor->write_proto = proto[i].proto;
>> +               nor->reg_proto = proto[i].proto;
>> +
>> +               /*
>> +                * Multiple I/O Read ID only returns the Manufacturer ID
>> +                * (1 byte) and the Device ID (2 bytes). So we reset the
>> +                * remaining bytes.
>> +                */
>> +               memset(id, 0, sizeof(id));
>> +               tmp = nor->read_reg(nor, SPINOR_OP_MIO_RDID, id, 3);
>> +               if (tmp < 0) {
>> +                       dev_dbg(nor->dev,
>> +                               " error %d reading JEDEC ID (MULTI IO)\n", tmp);
>> +                       return ERR_PTR(tmp);
>> +               }
>> +       }
>> +
>>         for (tmp = 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
>>                 info = &spi_nor_ids[tmp];
>>                 if (info->id_len) {
[...]
> 
> 
> thanks!
> 

Best Regards,

Cyrille
