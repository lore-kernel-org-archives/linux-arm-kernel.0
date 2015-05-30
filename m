From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 30 May 2015 18:51:54 +0200
Subject: [PATCH 1/2] mtd: spi-nor: add driver for NXP SPI Flash Interface
 (SPIFI)
In-Reply-To: <5569DAB9.9070105@vanguardiasur.com.ar>
References: <1432921816-10765-1-git-send-email-manabian@gmail.com>
 <1432921816-10765-2-git-send-email-manabian@gmail.com>
 <5569DAB9.9070105@vanguardiasur.com.ar>
Message-ID: <CAGhQ9VwsiPaFw=cMXhQrKfg8zWGa7RMOd+H6_VXfRepOwWbtYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 30 May 2015 at 17:43, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> Hi Joachim,
>
> Looks pretty neat. I've just a couple comments.
>
> On 05/29/2015 02:50 PM, Joachim Eastwood wrote:
>> Add SPI-NOR driver for the SPI Flash Interface (SPIFI)
>> controller that is found newer NXP MCU devices.
>>
>> The controller supports serial SPI Flash devices with 1-, 2-
>> and 4-bit width in either SPI mode 0 or 3. The controller
>> can operate in either command or memory mode. In memory mode
>> the Flash is exposed as normal memory and can be directly
>> accessed by the CPU.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>>  drivers/mtd/spi-nor/Kconfig     |  10 +
>>  drivers/mtd/spi-nor/Makefile    |   1 +
>>  drivers/mtd/spi-nor/nxp-spifi.c | 508 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 519 insertions(+)
>>  create mode 100644 drivers/mtd/spi-nor/nxp-spifi.c
>>
>> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
>> index 64a4f0edabc7..f10a37f1a4ef 100644
>> --- a/drivers/mtd/spi-nor/Kconfig
>> +++ b/drivers/mtd/spi-nor/Kconfig
>> @@ -28,4 +28,14 @@ config SPI_FSL_QUADSPI
>>         This enables support for the Quad SPI controller in master mode.
>>         We only connect the NOR to this controller now.
>>
>> +config SPI_NXP_SPIFI
>> +     tristate "NXP SPI Flash Interface (SPIFI)"
>> +     depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
>
> Since you are adding COMPILE_TEST, maybe you want
> 'depends on HAS_IOMEM' as well?

Since MTD depends on GENERIC_IO is that needed?
Or am I confusing the config options here(?)

>> +static int nxp_spifi_wait_for_event(struct nxp_spifi *spifi, u32 event)
>> +{
>> +     int retry = 3;
>> +     u32 stat;
>> +
>> +     do {
>> +             stat = readb(spifi->io_base + SPIFI_STAT);
>> +             if (!(stat & event))
>> +                     return 0;
>> +
>> +             udelay(10);
>> +     } while (retry--);
>> +
>> +     return -ETIMEDOUT;
>
> This could be replaced with the readb_poll_timeout_atomic().
> But it seems you would also use readb_poll_timeout(), since won't be
> called in atomic context.

Didn't know about the readX_poll_timeout functions and does indeed
look usable. Thanks for the tip.


>> +static int nxp_spifi_set_memory_mode_on(struct nxp_spifi *spifi)
>> +{
>> +     int retry = 3;
>> +     u32 stat;
>> +
>> +     stat = readb(spifi->io_base + SPIFI_STAT);
>> +     if (stat & SPIFI_STAT_MCINIT)
>> +             return 0;
>
> Do you think it makes sense to cache the memory/command mode
> instead of reading it?

I think that's good idea.

>Would it affect throughput in any sense?

Maybe. It's done for every read/write operation so making it a bit
faster is good idea. I don't see any downsides to implement it the way
you suggest either.


> I'm thinking these slow-clocked microcontrollers might benefit from
> such tricks, but I don't have actual numbers to back this up.
>
>> +
>> +     writel(spifi->mcmd, spifi->io_base + SPIFI_MCMD);
>> +
>> +     do {
>> +             stat = readb(spifi->io_base + SPIFI_STAT);
>> +             if (stat & SPIFI_STAT_MCINIT)
>> +                     return 0;
>> +
>> +             udelay(10);
>> +     } while (retry--);
>
> Same here about using iopoll variants.

Yeah, got it.


>> +
>> +     dev_err(spifi->dev, "unable to enter memory mode\n");
>> +
>> +     return -ETIMEDOUT;
>> +}
>> +
>> +static int nxp_spifi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
>> +{
>> +     struct nxp_spifi *spifi = nor->priv;
>> +     u32 cmd;
>> +     int ret;
>> +
>> +     ret = nxp_spifi_set_memory_mode_off(spifi);
>> +     if (ret)
>> +             return ret;
>> +
>> +     cmd = SPIFI_CMD_DATALEN(len) |
>> +           SPIFI_CMD_OPCODE(opcode) |
>> +           SPIFI_CMD_FIELDFORM_ALL_SERIAL |
>> +           SPIFI_CMD_FRAMEFORM_OPCODE_ONLY;
>> +     writel(cmd, spifi->io_base + SPIFI_CMD);
>> +
>> +     while (len--)
>> +             *buf++  = readb(spifi->io_base + SPIFI_DATA);
>
> Nit: extra whitespace here.

Well spotted!


>> +static int nxp_spifi_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *flash_np;
>> +     struct nxp_spifi *spifi;
>> +     struct resource *res;
>> +     int ret;
>> +
>> +     spifi = devm_kzalloc(&pdev->dev, sizeof(*spifi), GFP_KERNEL);
>> +     if (!spifi)
>> +             return -ENOMEM;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "spifi");
>> +     spifi->io_base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(spifi->io_base))
>> +             return PTR_ERR(spifi->io_base);
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "flash");
>> +     spifi->flash_base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(spifi->flash_base))
>> +             return PTR_ERR(spifi->flash_base);
>> +
>
> Just curious: is the memory mapping fixed?

On LPC43xx you can chose between two different mappings; 0x1400 0000
and 0x8000 0000

The first only support up 64 MB, as opposed to 128 MB for the second,
but is slightly faster according to the data sheet. See Table 444 in
the data sheet.

Other LPC families have different mappings as well.


Thanks for looking, Ezequiel.


regards,
Joachim Eastwood
