From: wangyuhang2014@gmail.com (yuhang wang)
Date: Fri, 23 Aug 2013 17:05:10 +0800
Subject: [PATCH V1 3/5] mtd: m25p80: add the quad-read support
In-Reply-To: <1376885403-12156-4-git-send-email-b32955@freescale.com>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <1376885403-12156-4-git-send-email-b32955@freescale.com>
Message-ID: <CAHSAbzN166J=DFi+1koPUpnFpJVHwtbC1AP21ywhAAissQxPxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shijie

2013/8/19 Huang Shijie <b32955@freescale.com>:
> This patch adds the quad read support:
>
> (1) Add the relative commands:
>       OPCODE_QIOR, OPCODE_4QIOR, OPCODE_RDCR,
>
>     also add the relative macro for the Configuartion Register.
>
> (2) add the "m25p,quad-read" property for the m25p80 driver
>     If the dts has the "m25p,quad-read" property, the kernel will
>     set the Quad bit of the configuration register, and when the
>     setting is suceeded, we set the read opcode with OPCODE_QIOR.
>
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  Documentation/devicetree/bindings/mtd/m25p80.txt |    5 ++
>  drivers/mtd/devices/m25p80.c                     |   51 ++++++++++++++++++++++
>  include/linux/mtd/spi-nor.h                      |    6 +++
>  3 files changed, 62 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mtd/m25p80.txt b/Documentation/devicetree/bindings/mtd/m25p80.txt
> index 6d3d576..b33313f 100644
> --- a/Documentation/devicetree/bindings/mtd/m25p80.txt
> +++ b/Documentation/devicetree/bindings/mtd/m25p80.txt
> @@ -17,6 +17,11 @@ Optional properties:
>                     Refer to your chips' datasheet to check if this is supported
>                     by your chip.
>
> +- m25p,quad-read : Use the "quad read" opcode to read data from the chip instead
> +                   of the usual "read" opcode. This opcode is not supported by
> +                   all chips and support for it can not be detected at runtime.
> +                   Refer to your chips' datasheet to check if this is supported
> +                   by your chip.
>  Example:
>
>         flash: m25p80 at 0 {
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index f3598c1..4bc9b1b 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -103,6 +103,40 @@ static int write_sr(struct m25p *flash, u8 val)
>  }
>
>  /*
> + * Read the configuration register, returning its value in the location
> + * Return the configuration register value.
> + * Returns negative if error occurred.
> + */
> +static int read_cr(struct m25p *flash)
> +{
> +       u8 code = OPCODE_RDCR;
> +       int ret;
> +       u8 val;
> +
> +       ret = spi_write_then_read(flash->spi, &code, 1, &val, 1);
> +       if (ret < 0) {
> +               dev_err(&flash->spi->dev, "error %d reading CR\n", ret);
> +               return ret;
> +       }
> +       return val;
> +}
> +
> +/*
> + * Write status register and configuration register with 2 bytes
> + * The first byte will be written to the status register, while the second byte
> + * will be written to the configuration register.
> + * Returns negative if error occurred.
> + */
> +static int write_sr_cr(struct m25p *flash, u16 val)
> +{
> +       flash->command[0] = OPCODE_WRSR;
> +       flash->command[1] = 0;
> +       flash->command[2] = (val >> 8);
> +
> +       return spi_write(flash->spi, flash->command, 3);
> +}
> +
> +/*
>   * Set write enable latch with Write Enable command.
>   * Returns negative if error occurred.
>   */
> @@ -880,6 +914,8 @@ static int m25p_probe(struct spi_device *spi)
>         unsigned                        i;
>         struct mtd_part_parser_data     ppdata;
>         struct device_node __maybe_unused *np = spi->dev.of_node;
> +       u16 sr_cr;
> +       int ret;
>
>  #ifdef CONFIG_MTD_OF_PARTS
>         if (!of_device_is_available(np))
> @@ -1014,6 +1050,21 @@ static int m25p_probe(struct spi_device *spi)
>         else
>                 flash->read_opcode = OPCODE_NORM_READ;
>
> +       /* Try to enable the Quad Read */
> +       if (np && of_property_read_bool(np, "m25p,quad-read")) {
> +               /* The configuration register is set by the second byte. */
> +               sr_cr = CR_QUAD << 8;
> +
> +               /* Write the QUAD bit to the Configuration Register. */
> +               write_enable(flash);
> +               if (write_sr_cr(flash, sr_cr) == 0) {
> +                       /* read back and check it */
> +                       ret = read_cr(flash);
> +                       if (ret > 0 && (ret & CR_QUAD))
> +                               flash->read_opcode = OPCODE_QIOR;
> +               }
> +       }
> +

Well, M25p80.c support lots of flash devices, so driver should be as
general as possible. Firstly not all the devices m25p80 supports set
quad mode as your sequence, perhaps write_sr_cr can not match all the
m25p80 flash. Secondly, why you only support QIOR(high performance)
not QOR or DOR. Maybe QIOR seems too special, so what if user want to
use QOR if he set quad mode in DTS.

Another point, if command changed to OPCODE_QIOR, there should also
should be some correct in m25p_read. such as the number of dummy data.
QIOR can support read without read command if set the certain bit in
transfer, these aspects did not reflect in your patch.

>         flash->program_opcode = OPCODE_PP;
>
>         if (info->addr_width)
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index b420a5b..d5b189d 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -39,6 +39,9 @@
>
>  /* Used for Spansion flashes only. */
>  #define        OPCODE_BRWR             0x17    /* Bank register write */
> +#define OPCODE_QIOR            0xeb    /* Quad read */
> +#define OPCODE_4QIOR           0xec    /* Quad read */
> +#define        OPCODE_RDCR             0x35    /* Read configuration register */
>
>  /* Status Register bits. */
>  #define        SR_WIP                  1       /* Write in progress */
> @@ -49,4 +52,7 @@
>  #define        SR_BP2                  0x10    /* Block protect 2 */
>  #define        SR_SRWD                 0x80    /* SR write protect */
>
> +/* Configuration Register bits. */
> +#define CR_QUAD                        0x2     /* Quad I/O */
> +
>  #endif /* __LINUX_MTD_SPI_NOR_H */
> --
> 1.7.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
