From: marcin.krzeminski@nokia.com (Krzeminski, Marcin (Nokia - PL/Wroclaw))
Date: Thu, 15 Sep 2016 06:50:55 +0000
Subject: [PATCH v3 6/9] mtd: spi-nor: Support R/W for S25FS-S family flash
In-Reply-To: <CA+EcR20NkBzFjMJ_ArWw9ALZY-x1SqwS1nUyGYAnjsygTk8K-Q@mail.gmail.com>
References: <1471505884-33996-1-git-send-email-B56489@freescale.com>
 <1471505884-33996-6-git-send-email-B56489@freescale.com>
 <CA+EcR20NkBzFjMJ_ArWw9ALZY-x1SqwS1nUyGYAnjsygTk8K-Q@mail.gmail.com>
Message-ID: <AM4PR0701MB21308B262DB7B94E0F7FC34EFEF00@AM4PR0701MB2130.eurprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> -----Original Message-----
> From: linux-mtd [mailto:linux-mtd-bounces at lists.infradead.org] On Behalf
> Of Han Xu
> Sent: Wednesday, September 14, 2016 9:49 PM
> To: Yunhui Cui <B56489@freescale.com>
> Cc: Yunhui Cui <yunhui.cui@nxp.com>; David Woodhouse
> <dwmw2@infradead.org>; linux-kernel at vger.kernel.org; linux-
> mtd at lists.infradead.org; han.xu at freescale.com; Brian Norris
> <computersforpeace@gmail.com>; jagannadh.teki at gmail.com; linux-arm-
> kernel at lists.infradead.org; Yao Yuan <yao.yuan@nxp.com>
> Subject: Re: [PATCH v3 6/9] mtd: spi-nor: Support R/W for S25FS-S family
> flash
> 
> On Thu, Aug 18, 2016 at 2:38 AM, Yunhui Cui <B56489@freescale.com>
> wrote:
> > From: Yunhui Cui <yunhui.cui@nxp.com>
> >
> > With the physical sectors combination, S25FS-S family flash requires
> > some special operations for read/write functions.
> >
> > Signed-off-by: Yunhui Cui <yunhui.cui@nxp.com>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 56
> > +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c
> > b/drivers/mtd/spi-nor/spi-nor.c index d0fc165..495d0bb 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -39,6 +39,10 @@
> >
> >  #define SPI_NOR_MAX_ID_LEN     6
> >  #define SPI_NOR_MAX_ADDR_WIDTH 4
> > +/* Added for S25FS-S family flash */
> > +#define SPINOR_CONFIG_REG3_OFFSET      0x800004
> > +#define CR3V_4KB_ERASE_UNABLE  0x8
> > +#define SPINOR_S25FS_FAMILY_EXT_JEDEC  0x81
> >
> >  struct flash_info {
> >         char            *name;
> > @@ -78,6 +82,7 @@ struct flash_info {
> >  };
> >
> >  #define JEDEC_MFR(info)        ((info)->id[0])
> > +#define EXT_JEDEC(info)        ((info)->id[5])
> >
> >  static const struct flash_info *spi_nor_match_id(const char *name);
> >
> > @@ -899,6 +904,7 @@ static const struct flash_info spi_nor_ids[] = {
> >          */
> >         { "s25sl032p",  INFO(0x010215, 0x4d00,  64 * 1024,  64,
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >         { "s25sl064p",  INFO(0x010216, 0x4d00,  64 * 1024, 128,
> > SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +       { "s25fs256s1", INFO6(0x010219, 0x4d0181, 64 * 1024, 512, 0)},
> >         { "s25fl256s0", INFO(0x010219, 0x4d00, 256 * 1024, 128, 0) },
> >         { "s25fl256s1", INFO(0x010219, 0x4d01,  64 * 1024, 512,
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >         { "s25fl512s",  INFO(0x010220, 0x4d00, 256 * 1024, 256,
> > SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) }, @@ -1036,6 +1042,50
> @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
> >         return ERR_PTR(-ENODEV);
> >  }
> >
> > +/*
> > + * The S25FS-S family physical sectors may be configured as a
> > + * hybrid combination of eight 4-kB parameter sectors
> > + * at the top or bottom of the address space with all
> > + * but one of the remaining sectors being uniform size.
> > + * The Parameter Sector Erase commands (20h or 21h) must
> > + * be used to erase the 4-kB parameter sectors individually.
> > + * The Sector (uniform sector) Erase commands (D8h or DCh)
> > + * must be used to erase any of the remaining
> > + * sectors, including the portion of highest or lowest address
> > + * sector that is not overlaid by the parameter sectors.
> > + * The uniform sector erase command has no effect on parameter
> sectors.
> > + */
> > +static int spansion_s25fs_disable_4kb_erase(struct spi_nor *nor) {
> > +       u32 cr3v_addr  = SPINOR_CONFIG_REG3_OFFSET;
> > +       u8 cr3v = 0x0;
> > +       int ret = 0x0;
> > +
> > +       nor->cmd_buf[2] = cr3v_addr >> 16;
> > +       nor->cmd_buf[1] = cr3v_addr >> 8;
> > +       nor->cmd_buf[0] = cr3v_addr >> 0;
> > +
> > +       ret = nor->read_reg(nor, SPINOR_OP_SPANSION_RDAR, &cr3v, 1);
> > +       if (ret)
> > +               return ret;
> > +       if (cr3v & CR3V_4KB_ERASE_UNABLE)
> > +               return 0;
> > +       ret = nor->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
> > +       if (ret)
> > +               return ret;
> > +       cr3v = CR3V_4KB_ERASE_UNABLE;
> > +       nor->program_opcode = SPINOR_OP_SPANSION_WRAR;
> > +       nor->write(nor, cr3v_addr, 1, &cr3v);
> > +
> > +       ret = nor->read_reg(nor, SPINOR_OP_SPANSION_RDAR, &cr3v, 1);
> > +       if (ret)
> > +               return ret;
> > +       if (!(cr3v & CR3V_4KB_ERASE_UNABLE))
> > +               return -EPERM;
> > +
> > +       return 0;
> > +}
> > +
> >  static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
> >                         size_t *retlen, u_char *buf)  { @@ -1361,6
> > +1411,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
> enum read_mode mode)
> >                 spi_nor_wait_till_ready(nor);
> >         }
> >
> > +       if (EXT_JEDEC(info) == SPINOR_S25FS_FAMILY_EXT_JEDEC) {
> > +               ret = spansion_s25fs_disable_4kb_erase(nor);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> >         if (!mtd->name)
> >                 mtd->name = dev_name(dev);
> >         mtd->priv = nor;
> > --
> > 2.1.0.27.g96db324
> >
> >
> Hi Brian, I will ack this change but still feel it's kind of hacking code.
> 
> Acked-by: Han xu <han.xu@nxp.com>

I am new on the list so I am not sure if this topic has been discussed.
Generally our product functionality relay on those 4KiB sectors.
I know that this hack is already in u-boot, but if you mainstream this
you will force users of those 4KiB sectors to do hack the hack...
I believe the proper solution here is to use erase regions functionality,
I send and RFS about that some time ago.

Thanks,
Marcin

> > ______________________________________________________
> > Linux MTD discussion mailing list
> > http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
> 
> 
> --
> Sincerely,
> 
> Han XU
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
