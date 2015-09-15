From: jteki@openedev.com (Jagan Teki)
Date: Tue, 15 Sep 2015 23:23:23 +0530
Subject: [linux-next RFC v7 2/6] mtd: spi-nor: read JEDEC ID with multiple
 I/O protocols
In-Reply-To: <900653cccf2903386a992ea2b702b04dc8205407.1442330503.git.cyrille.pitchen@atmel.com>
References: <cover.1442330503.git.cyrille.pitchen@atmel.com>
 <900653cccf2903386a992ea2b702b04dc8205407.1442330503.git.cyrille.pitchen@atmel.com>
Message-ID: <CAD6G_RQV--nRk-pf347ThnEbQ=+tozXq8PKZL818cEK7nAi+gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 September 2015 at 20:58, Cyrille Pitchen
<cyrille.pitchen@atmel.com> wrote:
> When their quad or dual I/O mode is enabled, Micron and Macronix spi-nor
> memories don't reply to the regular Read ID (0x9f) command. Instead they
> reply to a new dedicated command Read ID Multiple I/O (0xaf).
>
> If the Read ID (0x9f) command fails (the read ID is all 1's or all 0's),
> then the Read ID Multiple I/O (0xaf) is used, first with SPI 4-4-4 protocol
> (supported by both Micron and Macronix memories), lately with SPI-2-2-2
> protocol (supported only by Micron memories).
>
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  drivers/mtd/devices/m25p80.c      |  8 +-----
>  drivers/mtd/spi-nor/fsl-quadspi.c |  2 +-
>  drivers/mtd/spi-nor/nxp-spifi.c   | 13 +++------
>  drivers/mtd/spi-nor/spi-nor.c     | 59 ++++++++++++++++++++++++++++++++++-----
>  include/linux/mtd/spi-nor.h       | 27 +++++++++++++++---
>  5 files changed, 81 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 4b5d7a4655fd..1457866a4930 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -179,7 +179,6 @@ static int m25p_probe(struct spi_device *spi)
>         struct flash_platform_data      *data;
>         struct m25p *flash;
>         struct spi_nor *nor;
> -       enum read_mode mode = SPI_NOR_NORMAL;
>         char *flash_name = NULL;
>         int ret;
>
> @@ -205,11 +204,6 @@ static int m25p_probe(struct spi_device *spi)
>         spi_set_drvdata(spi, flash);
>         flash->spi = spi;
>
> -       if (spi->mode & SPI_RX_QUAD)
> -               mode = SPI_NOR_QUAD;
> -       else if (spi->mode & SPI_RX_DUAL)
> -               mode = SPI_NOR_DUAL;
> -
>         if (data && data->name)
>                 nor->mtd.name = data->name;
>
> @@ -223,7 +217,7 @@ static int m25p_probe(struct spi_device *spi)
>         else
>                 flash_name = spi->modalias;
>
> -       ret = spi_nor_scan(nor, flash_name, mode);
> +       ret = spi_nor_scan(nor, flash_name, spi->mode);

IMHO, this is certainly incorrect because spi-nor never know anything
about spi (Linux) that is why this framework got into picture.

>         if (ret)
>                 return ret;
>
> diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
> index 2954f89fc8be..1ded5dbe2240 100644
> --- a/drivers/mtd/spi-nor/fsl-quadspi.c
> +++ b/drivers/mtd/spi-nor/fsl-quadspi.c
> @@ -1033,7 +1033,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
>                 /* set the chip address for READID */
>                 fsl_qspi_set_base_addr(q, nor);
>
> -               ret = spi_nor_scan(nor, NULL, SPI_NOR_QUAD);
> +               ret = spi_nor_scan(nor, NULL, SPI_RX_QUAD);
>                 if (ret)
>                         goto mutex_failed;
>
> diff --git a/drivers/mtd/spi-nor/nxp-spifi.c b/drivers/mtd/spi-nor/nxp-spifi.c
> index 9e82098ae644..c499f3258245 100644
> --- a/drivers/mtd/spi-nor/nxp-spifi.c
> +++ b/drivers/mtd/spi-nor/nxp-spifi.c
> @@ -272,7 +272,6 @@ static int nxp_spifi_setup_flash(struct nxp_spifi *spifi,
>                                  struct device_node *np)
>  {
>         struct mtd_part_parser_data ppdata;
> -       enum read_mode flash_read;
>         u32 ctrl, property;
>         u16 mode = 0;
>         int ret;
> @@ -304,16 +303,12 @@ static int nxp_spifi_setup_flash(struct nxp_spifi *spifi,
>                SPIFI_CTRL_CSHIGH(15) |
>                SPIFI_CTRL_FBCLK;
>
> -       if (mode & SPI_RX_DUAL) {
> +       if (mode & SPI_RX_DUAL)
>                 ctrl |= SPIFI_CTRL_DUAL;
> -               flash_read = SPI_NOR_DUAL;
> -       } else if (mode & SPI_RX_QUAD) {
> +       else if (mode & SPI_RX_QUAD)
>                 ctrl &= ~SPIFI_CTRL_DUAL;
> -               flash_read = SPI_NOR_QUAD;
> -       } else {
> +       else
>                 ctrl |= SPIFI_CTRL_DUAL;
> -               flash_read = SPI_NOR_NORMAL;
> -       }
>
>         switch (mode & (SPI_CPHA | SPI_CPOL)) {
>         case SPI_MODE_0:
> @@ -349,7 +344,7 @@ static int nxp_spifi_setup_flash(struct nxp_spifi *spifi,
>          */
>         nxp_spifi_dummy_id_read(&spifi->nor);
>
> -       ret = spi_nor_scan(&spifi->nor, NULL, flash_read);
> +       ret = spi_nor_scan(&spifi->nor, NULL, mode);
>         if (ret) {
>                 dev_err(spifi->dev, "device scan failed\n");
>                 return ret;
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 8818d4325d20..1908038c8f2e 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -20,6 +20,7 @@
>  #include <linux/mtd/cfi.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/of_platform.h>
> +#include <linux/spi/spi.h>

Same comment as above - don't use spi on spi-nor.

>  #include <linux/spi/flash.h>
>  #include <linux/mtd/spi-nor.h>
>
> @@ -61,6 +62,11 @@ struct flash_info {
>
>  #define JEDEC_MFR(info)        ((info)->id[0])
>
> +struct read_id_proto {
> +       enum spi_protocol       proto;  /* SPI protocol to read the JEDEC ID */
> +       u16                     mode;   /* SPI controller required caps */
> +};
> +
>  static const struct flash_info *spi_nor_match_id(const char *name);
>
>  /*
> @@ -701,11 +707,15 @@ static const struct flash_info spi_nor_ids[] = {
>         { },
>  };
>
> -static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
> +static const struct flash_info *spi_nor_read_id(struct spi_nor *nor, u16 mode)
>  {
> -       int                     tmp;
> +       int                     i, tmp;
>         u8                      id[SPI_NOR_MAX_ID_LEN];
>         const struct flash_info *info;
> +       static const struct read_id_proto proto[] = {
> +               { SPI_PROTO_4_4_4, SPI_RX_QUAD | SPI_TX_QUAD },
> +               { SPI_PROTO_2_2_2, SPI_RX_DUAL | SPI_TX_DUAL }
> +       };
>
>         tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
>         if (tmp < 0) {
> @@ -713,6 +723,35 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>                 return ERR_PTR(tmp);
>         }
>
> +       /* Special case for Micron/Macronix qspi nor. */
> +       for (i = 0; i < ARRAY_SIZE(proto); ++i) {
> +               if (!((id[0] == 0xff && id[1] == 0xff && id[2] == 0xff) ||
> +                     (id[0] == 0x00 && id[1] == 0x00 && id[2] == 0x00)))
> +                       break;
> +
> +               /* Check whether the SPI controller supports this protocol. */
> +               if ((mode & proto[i].mode) != proto[i].mode)
> +                       continue;
> +
> +               nor->erase_proto = proto[i].proto;
> +               nor->read_proto = proto[i].proto;
> +               nor->write_proto = proto[i].proto;
> +               nor->reg_proto = proto[i].proto;
> +
> +               /*
> +                * Multiple I/O Read ID only returns the Manufacturer ID
> +                * (1 byte) and the Device ID (2 bytes). So we reset the
> +                * remaining bytes.
> +                */
> +               memset(id, 0, sizeof(id));
> +               tmp = nor->read_reg(nor, SPINOR_OP_MIO_RDID, id, 3);
> +               if (tmp < 0) {
> +                       dev_dbg(nor->dev,
> +                               " error %d reading JEDEC ID (MULTI IO)\n", tmp);
> +                       return ERR_PTR(tmp);
> +               }
> +       }
> +
>         for (tmp = 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
>                 info = &spi_nor_ids[tmp];
>                 if (info->id_len) {
> @@ -999,7 +1038,7 @@ static int spi_nor_check(struct spi_nor *nor)
>         return 0;
>  }
>
> -int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
> +int spi_nor_scan(struct spi_nor *nor, const char *name, u16 mode)
>  {
>         const struct flash_info *info = NULL;
>         struct device *dev = nor->dev;
> @@ -1012,11 +1051,17 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>         if (ret)
>                 return ret;
>
> +       /* Reset SPI protocol for all commands */
> +       nor->erase_proto = SPI_PROTO_1_1_1;
> +       nor->read_proto = SPI_PROTO_1_1_1;
> +       nor->write_proto = SPI_PROTO_1_1_1;
> +       nor->reg_proto = SPI_PROTO_1_1_1;
> +
>         if (name)
>                 info = spi_nor_match_id(name);
>         /* Try to auto-detect if chip name wasn't specified or not found */
>         if (!info)
> -               info = spi_nor_read_id(nor);
> +               info = spi_nor_read_id(nor, mode);
>         if (IS_ERR_OR_NULL(info))
>                 return -ENOENT;
>
> @@ -1027,7 +1072,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>         if (name && info->id_len) {
>                 const struct flash_info *jinfo;
>
> -               jinfo = spi_nor_read_id(nor);
> +               jinfo = spi_nor_read_id(nor, mode);
>                 if (IS_ERR(jinfo)) {
>                         return PTR_ERR(jinfo);
>                 } else if (jinfo != info) {
> @@ -1126,14 +1171,14 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>                 nor->flash_read = SPI_NOR_NORMAL;
>
>         /* Quad/Dual-read mode takes precedence over fast/normal */
> -       if (mode == SPI_NOR_QUAD && info->flags & SPI_NOR_QUAD_READ) {
> +       if (mode & SPI_RX_QUAD && info->flags & SPI_NOR_QUAD_READ) {
>                 ret = set_quad_mode(nor, info);
>                 if (ret) {
>                         dev_err(dev, "quad mode not supported\n");
>                         return ret;
>                 }
>                 nor->flash_read = SPI_NOR_QUAD;
> -       } else if (mode == SPI_NOR_DUAL && info->flags & SPI_NOR_DUAL_READ) {
> +       } else if (mode & SPI_RX_DUAL && info->flags & SPI_NOR_DUAL_READ) {
>                 nor->flash_read = SPI_NOR_DUAL;
>         }
>
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 672595a381c5..32339e82cb9d 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -57,8 +57,9 @@
>  #define SPINOR_OP_BRWR         0x17    /* Bank register write */
>
>  /* Used for Micron flashes only. */
> -#define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
> -#define SPINOR_OP_WD_EVCR      0x61    /* Write EVCR register */
> +#define SPINOR_OP_MIO_RDID     0xaf    /* Multiple I/O Read JEDEC ID */
> +#define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
> +#define SPINOR_OP_WD_EVCR      0x61    /* Write EVCR register */
>
>  /* Status Register bits. */
>  #define SR_WIP                 1       /* Write in progress */
> @@ -87,6 +88,16 @@ enum read_mode {
>         SPI_NOR_QUAD,
>  };
>
> +enum spi_protocol {
> +       SPI_PROTO_1_1_1,        /* SPI */
> +       SPI_PROTO_1_1_2,        /* Dual Output */
> +       SPI_PROTO_1_1_4,        /* Quad Output */
> +       SPI_PROTO_1_2_2,        /* Dual IO */
> +       SPI_PROTO_1_4_4,        /* Quad IO */
> +       SPI_PROTO_2_2_2,        /* Dual Command */
> +       SPI_PROTO_4_4_4,        /* Quad Command */
> +};
> +
>  #define SPI_NOR_MAX_CMD_SIZE   8
>  enum spi_nor_ops {
>         SPI_NOR_OPS_READ = 0,
> @@ -117,6 +128,10 @@ struct mtd_info;
>   * @flash_read:                the mode of the read
>   * @sst_write_second:  used by the SST write operation
>   * @flags:             flag options for the current SPI-NOR (SNOR_F_*)
> + * @erase_proto:       the SPI protocol used by erase operations
> + * @read_proto:                the SPI protocol used by read operations
> + * @write_proto:       the SPI protocol used by write operations
> + * @reg_proto          the SPI protocol used by read_reg/write_reg operations
>   * @cmd_buf:           used by the write_reg
>   * @prepare:           [OPTIONAL] do some preparations for the
>   *                     read/write/erase/lock/unlock operations
> @@ -143,6 +158,10 @@ struct spi_nor {
>         u8                      read_opcode;
>         u8                      read_dummy;
>         u8                      program_opcode;
> +       enum spi_protocol       erase_proto;
> +       enum spi_protocol       read_proto;
> +       enum spi_protocol       write_proto;
> +       enum spi_protocol       reg_proto;
>         enum read_mode          flash_read;
>         bool                    sst_write_second;
>         u32                     flags;
> @@ -169,7 +188,7 @@ struct spi_nor {
>   * spi_nor_scan() - scan the SPI NOR
>   * @nor:       the spi_nor structure
>   * @name:      the chip type name
> - * @mode:      the read mode supported by the driver
> + * @mode:      the bitmask or TX/RX modes supported by the driver
>   *
>   * The drivers can use this fuction to scan the SPI NOR.
>   * In the scanning, it will try to get all the necessary information to
> @@ -179,6 +198,6 @@ struct spi_nor {
>   *
>   * Return: 0 for success, others for failure.
>   */
> -int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode);
> +int spi_nor_scan(struct spi_nor *nor, const char *name, u16 mode);
>
>  #endif
> --
> 1.8.2.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


thanks!
-- 
Jagan | openedev.
