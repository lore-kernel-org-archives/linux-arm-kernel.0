From: yao.yuan@nxp.com (Yao Yuan)
Date: Mon, 21 Nov 2016 09:18:32 +0000
Subject: [PATCH v3 6/9] mtd: spi-nor: Support R/W for S25FS-S family flash
In-Reply-To: <AM4PR0701MB21302252988A38FE2A393FE4FEB50@AM4PR0701MB2130.eurprd07.prod.outlook.com>
References: <1471505884-33996-1-git-send-email-B56489@freescale.com>
 <1471505884-33996-6-git-send-email-B56489@freescale.com>
 <CA+EcR20NkBzFjMJ_ArWw9ALZY-x1SqwS1nUyGYAnjsygTk8K-Q@mail.gmail.com>
 <AM4PR0701MB21308B262DB7B94E0F7FC34EFEF00@AM4PR0701MB2130.eurprd07.prod.outlook.com>
 <20161116171058.GA21300@Cayman.am.freescale.net>
 <AM4PR0701MB2130273C90BE0EE615382718FEB10@AM4PR0701MB2130.eurprd07.prod.outlook.com>
 <DB6PR0401MB24077A46D3FC5147DC4C69D989B10@DB6PR0401MB2407.eurprd04.prod.outlook.com>
 <AM4PR0701MB213027FC738E6E377A593B60FEB10@AM4PR0701MB2130.eurprd07.prod.outlook.com>
 <DB6PR0401MB24074D231C8EBCC56E168CC989B00@DB6PR0401MB2407.eurprd04.prod.outlook.com>
 <AM4PR0701MB21302592BE1B712D6E74C569FEB00@AM4PR0701MB2130.eurprd07.prod.outlook.com>
 <DB6PR0401MB24070BB49A1F5152A915AE3289B50@DB6PR0401MB2407.eurprd04.prod.outlook.com>
 <AM4PR0701MB21302252988A38FE2A393FE4FEB50@AM4PR0701MB2130.eurprd07.prod.outlook.com>
Message-ID: <DB6PR0401MB240761382B1B43FA63F67E6189B50@DB6PR0401MB2407.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2016 at 03:15 PM +0800, Krzeminski, Marcin (Nokia - PL/Wroclaw) wrote:
> > -----Original Message-----
> > From: Yao Yuan [mailto:yao.yuan at nxp.com]
> > Sent: Monday, November 21, 2016 7:28 AM
> > To: Krzeminski, Marcin (Nokia - PL/Wroclaw)
> > <marcin.krzeminski@nokia.com>; Han Xu <xhnjupt@gmail.com>
> > Cc: David Woodhouse <dwmw2@infradead.org>; linux-
> > kernel at vger.kernel.org; linux-mtd at lists.infradead.org;
> > han.xu at freescale.com; Brian Norris <computersforpeace@gmail.com>;
> > jagannadh.teki at gmail.com; linux-arm-kernel at lists.infradead.org;
> > Cyrille Pitchen <cyrille.pitchen@atmel.com>
> > Subject: RE: [PATCH v3 6/9] mtd: spi-nor: Support R/W for S25FS-S
> > family flash
> >
> > On Thu, Nov 18, 2016 at 07:00 PM +0000, Krzeminski, Marcin (Nokia -
> > PL/Wroclaw) wrote:
> > > > -----Original Message-----
> > > > From: Yao Yuan [mailto:yao.yuan at nxp.com]
> > > > Sent: Friday, November 18, 2016 5:20 AM
> > > > To: Krzeminski, Marcin (Nokia - PL/Wroclaw)
> > > > <marcin.krzeminski@nokia.com>; Han Xu <xhnjupt@gmail.com>
> > > > Cc: David Woodhouse <dwmw2@infradead.org>; linux-
> > > > kernel at vger.kernel.org; linux-mtd at lists.infradead.org;
> > > > han.xu at freescale.com; Brian Norris <computersforpeace@gmail.com>;
> > > > jagannadh.teki at gmail.com; linux-arm-kernel at lists.infradead.org
> > > > Subject: RE: [PATCH v3 6/9] mtd: spi-nor: Support R/W for S25FS-S
> > > > family flash
> > > >
> > > > On Thu, Nov 17, 2016 at 10:14:55AM +0000, Krzeminski, Marcin
> > > > (Nokia
> > > > -
> > > > PL/Wroclaw) wrote:
> > > > > > On Thu, Nov 17, 2016 at 06:50:55AM +0000, Krzeminski, Marcin
> > > > > > (Nokia
> > > > > > -
> > > > > > PL/Wroclaw) wrote:
> > > > > > > > > > On Thu, Aug 18, 2016 at 2:38 AM, Yunhui Cui
> > > > > > > > > > <B56489@freescale.com>
> > > > > > > > > > wrote:
> > > > > > > > > > > From: Yunhui Cui <yunhui.cui@nxp.com>
> > > > > > > > > > >
> > > > > > > > > > > With the physical sectors combination, S25FS-S
> > > > > > > > > > > family flash requires some special operations for
> > > > > > > > > > > read/write
> > functions.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Yunhui Cui <yunhui.cui@nxp.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/mtd/spi-nor/spi-nor.c | 56
> > > > > > > > > > > +++++++++++++++++++++++++++++++++++++++++++
> > > > > > > > > > >  1 file changed, 56 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/mtd/spi-nor/spi-nor.c
> > > > > > > > > > > b/drivers/mtd/spi-nor/spi-nor.c index
> > > > > > > > > > > d0fc165..495d0bb
> > > > > > > > > > > 100644
> > > > > > > > > > > --- a/drivers/mtd/spi-nor/spi-nor.c
> > > > > > > > > > > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > > > > > > > > > > @@ -39,6 +39,10 @@
> > > > > > > > > > >
> > > > > > > > > > >  #define SPI_NOR_MAX_ID_LEN     6
> > > > > > > > > > >  #define SPI_NOR_MAX_ADDR_WIDTH 4
> > > > > > > > > > > +/* Added for S25FS-S family flash */
> > > > > > > > > > > +#define SPINOR_CONFIG_REG3_OFFSET      0x800004
> > > > > > > > > > > +#define CR3V_4KB_ERASE_UNABLE  0x8 #define
> > > > > > > > > > > +SPINOR_S25FS_FAMILY_EXT_JEDEC  0x81
> > > > > > > > > > >
> > > > > > > > > > >  struct flash_info {
> > > > > > > > > > >         char            *name;
> > > > > > > > > > > @@ -78,6 +82,7 @@ struct flash_info {  };
> > > > > > > > > > >
> > > > > > > > > > >  #define JEDEC_MFR(info)        ((info)->id[0])
> > > > > > > > > > > +#define EXT_JEDEC(info)        ((info)->id[5])
> > > > > > > > > > >
> > > > > > > > > > >  static const struct flash_info
> > > > > > > > > > > *spi_nor_match_id(const char *name);
> > > > > > > > > > >
> > > > > > > > > > > @@ -899,6 +904,7 @@ static const struct flash_info
> > > > spi_nor_ids[] = {
> > > > > > > > > > >          */
> > > > > > > > > > >         { "s25sl032p",  INFO(0x010215, 0x4d00,  64 *
> > > > > > > > > > > 1024, 64,
> > > > > > > > > > SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > > > > > > > > > >         { "s25sl064p",  INFO(0x010216, 0x4d00,  64 *
> > > > > > > > > > > 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> > },
> > > > > > > > > > > +       { "s25fs256s1", INFO6(0x010219, 0x4d0181, 64
> > > > > > > > > > > + * 1024, 512, 0)},
> > > > > > > > > > >         { "s25fl256s0", INFO(0x010219, 0x4d00, 256 *
> > > > > > > > > > > 1024, 128,
> > 0) },
> > > > > > > > > > >         { "s25fl256s1", INFO(0x010219, 0x4d01,  64 *
> > > > > > > > > > > 1024, 512,
> > > > > > > > > > SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > > > > > > > > > >         { "s25fl512s",  INFO(0x010220, 0x4d00, 256 *
> > > > > > > > > > > 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> > },
> > > @@
> > > > > > > > > > > -
> > > > 1036,6
> > > > > > > > +1042,50
> > > > > > > > > > @@ static const struct flash_info
> > > > > > > > > > *spi_nor_read_id(struct spi_nor
> > > > > > > > > > *nor)
> > > > > > > > > > >         return ERR_PTR(-ENODEV);  }
> > > > > > > > > > >
> > > > > > > > > > > +/*
> > > > > > > > > > > + * The S25FS-S family physical sectors may be
> > > > > > > > > > > +configured as a
> > > > > > > > > > > + * hybrid combination of eight 4-kB parameter
> > > > > > > > > > > +sectors
> > > > > > > > > > > + * at the top or bottom of the address space with
> > > > > > > > > > > +all
> > > > > > > > > > > + * but one of the remaining sectors being uniform size.
> > > > > > > > > > > + * The Parameter Sector Erase commands (20h or 21h)
> > > > > > > > > > > +must
> > > > > > > > > > > + * be used to erase the 4-kB parameter sectors individually.
> > > > > > > > > > > + * The Sector (uniform sector) Erase commands (D8h
> > > > > > > > > > > +or
> > > > > > > > > > > +DCh)
> > > > > > > > > > > + * must be used to erase any of the remaining
> > > > > > > > > > > + * sectors, including the portion of highest or
> > > > > > > > > > > +lowest address
> > > > > > > > > > > + * sector that is not overlaid by the parameter sectors.
> > > > > > > > > > > + * The uniform sector erase command has no effect
> > > > > > > > > > > +on parameter
> > > > > > > > > > sectors.
> > > > > > > > > > > + */
> > > > > > > > > > > +static int spansion_s25fs_disable_4kb_erase(struct
> > > > > > > > > > > +spi_nor
> > > > *nor) {
> > > > > > > > > > > +       u32 cr3v_addr  = SPINOR_CONFIG_REG3_OFFSET;
> > > > > > > > > > > +       u8 cr3v = 0x0;
> > > > > > > > > > > +       int ret = 0x0;
> > > > > > > > > > > +
> > > > > > > > > > > +       nor->cmd_buf[2] = cr3v_addr >> 16;
> > > > > > > > > > > +       nor->cmd_buf[1] = cr3v_addr >> 8;
> > > > > > > > > > > +       nor->cmd_buf[0] = cr3v_addr >> 0;
> > > > > > > > > > > +
> > > > > > > > > > > +       ret = nor->read_reg(nor,
> > > > > > > > > > > + SPINOR_OP_SPANSION_RDAR,
> > > > > > &cr3v, 1);
> > > > > > > > > > > +       if (ret)
> > > > > > > > > > > +               return ret;
> > > > > > > > > > > +       if (cr3v & CR3V_4KB_ERASE_UNABLE)
> > > > > > > > > > > +               return 0;
> > > > > > > > > > > +       ret = nor->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
> > > > > > > > > > > +       if (ret)
> > > > > > > > > > > +               return ret;
> > > > > > > > > > > +       cr3v = CR3V_4KB_ERASE_UNABLE;
> > > > > > > > > > > +       nor->program_opcode =
> > SPINOR_OP_SPANSION_WRAR;
> > > > > > > > > > > +       nor->write(nor, cr3v_addr, 1, &cr3v);
> > > > > > > > > > > +
> > > > > > > > > > > +       ret = nor->read_reg(nor,
> > > > > > > > > > > + SPINOR_OP_SPANSION_RDAR,
> > > > > > &cr3v, 1);
> > > > > > > > > > > +       if (ret)
> > > > > > > > > > > +               return ret;
> > > > > > > > > > > +       if (!(cr3v & CR3V_4KB_ERASE_UNABLE))
> > > > > > > > > > > +               return -EPERM;
> > > > > > > > > > > +
> > > > > > > > > > > +       return 0;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  static int spi_nor_read(struct mtd_info *mtd,
> > > > > > > > > > > loff_t from, size_t
> > > > > > len,
> > > > > > > > > > >                         size_t *retlen, u_char *buf)
> > > > > > > > > > > { @@
> > > > > > > > > > > -1361,6
> > > > > > > > > > > +1411,12 @@ int spi_nor_scan(struct spi_nor *nor,
> > > > > > > > > > > +const char *name,
> > > > > > > > > > enum read_mode mode)
> > > > > > > > > > >                 spi_nor_wait_till_ready(nor);
> > > > > > > > > > >         }
> > > > > > > > > > >
> > > > > > > > > > > +       if (EXT_JEDEC(info) ==
> > > > > > > > > > > + SPINOR_S25FS_FAMILY_EXT_JEDEC)
> > > > {
> > > > > > > > > > > +               ret = spansion_s25fs_disable_4kb_erase(nor);
> > > > > > > > > > > +               if (ret)
> > > > > > > > > > > +                       return ret;
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > >         if (!mtd->name)
> > > > > > > > > > >                 mtd->name = dev_name(dev);
> > > > > > > > > > >         mtd->priv = nor;
> > > > > > > > > > > --
> > > > > > > > > > > 2.1.0.27.g96db324
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > Hi Brian, I will ack this change but still feel it's
> > > > > > > > > > kind of hacking
> > code.
> > > > > > > > > >
> > > > > > > > > > Acked-by: Han xu <han.xu@nxp.com>
> > > > > > > > >
> > > > > > > > > I am new on the list so I am not sure if this topic has
> > > > > > > > > been
> > discussed.
> > > > > > > > > Generally our product functionality relay on those 4KiB sectors.
> > > > > > > > > I know that this hack is already in u-boot, but if you
> > > > > > > > > mainstream this you will force users of those 4KiB
> > > > > > > > > sectors to do hack the
> > > > > hack...
> > > > > > > > > I believe the proper solution here is to use erase
> > > > > > > > > regions functionality, I send and RFS about that some time ago.
> > > > > > > >
> > > > > > > > Do you mind to send me a link for reference?
> > > > > > > >
> > > > > > > Han,
> > > > > > >
> > > > > > > Sorry, It seem I have not posted erase region changes (only
> > > > > > > those regarding DUAL/QUAD I/O).
> > > > > > > Generally, in this flash you need to create 3 erase regions
> > > > > > > (because in FS-S family support only  4KiB erase on
> > > > > > > parameters sector -
> > > > eg.
> > > > > > > 1.2.2.4 in
> > > > > > S25FS512S).
> > > > > > > In my case regions are:
> > > > > > > 1. 0-32KiB (8*4KiB) - 4K_ERASE (0x20/0x21) 2. 32 - 256 -
> > > > > > > SE_CMD
> > > > > > (0xd8/0xdc) 3.
> > > > > > > Rest of the flash SE_CMD (0xd8/0xdc)
> > > > > > >
> > > > > > > To erase whole flash you can also use CHIP_ERASE_CMD
> > > > > > > (0x60/0xC7) command, you just need to add one more mtd
> > > > > > > partition that will cover
> > > > > > whole flash.
> > > > > > >
> > > > > >
> > > > > > Hi Krzeminski,
> > > > > >
> > > > > > Do you think is there any great advantages for enable 4KB?
> > > > > > Because for NXP(Freescale) QSPI controller, there is only
> > > > > > support max to 16 groups command.
> > > > > >
> > > > > > So It's hard to give 3 groups command just for erase
> > > > > > (0x21,0xdc and
> > 0xc7).
> > > > > > So we have to disable the 4kb erase and only use 256kbytes in
> > > > > > this
> > patch.
> > > > > >
> > > > > Yes, if you disable parameters sector in spi-nor framework you
> > > > > will disable it for all spi-nor clients not only for NXP QSPI controller.
> > > > > There are users (at least me) that relay on parameters sector
> > functionality.
> > > > This patch will brake it.
> > > > >
> > > > > Thanks,
> > > >
> > > > Hi Krzeminski,
> > > >
> > > > Get it.
> > > > So do you think how about that I add a flag in dts to select it?
> > > > The user want's disable 4kb, he can add the flag.
> > > >
> > > > In spi-nor.c:
> > > > if (of_property_read_bool(np, "spi-nor, disable-4kb")) {
> > > > 	spansion_s25fs_disable_4kb_erase();
> > > > }
> > > >                 else
> > > > ...
> > > >
> > > > In dts:
> > > >
> > > > &qspi {
> > > >         num-cs = <2>;
> > > >         bus-num = <0>;
> > > >         status = "okay";
> > > >
> > > >         qflash0: s25fs512s at 0 {
> > > >                 compatible = "spansion, s25fs512s";
> > > > 	 spi-nor, disable-4kb
> > > >                 #address-cells = <1>;
> > > >                 #size-cells = <1>;
> > > >                 spi-max-frequency = <20000000>;
> > > >                 reg = <0>;
> > > >         };
> > > >
> > > > I think it should be a better way.
> > > >
> > > > How about your think?
> > >
> > > This looks much better - at least for me.
> > > There are some parameters in JESD216 standard regarding parameters
> > > sector, but unfortunately I have not investigated that. You can take
> > > a look at Cyrille series, that adds support for JESD216  standard.
> > >
> >
> > Ok, I will resend v4 for add this.
> >
> > BTW, the 4-kytes block for S25FS is just only the first 8 blocks, the
> > other block is 256kytes.
> > Do out SPI-NOR support erase those specific combination?
> >
> > If not, do you have any plan for add it?
> > It seems I can't fine the support in spi-nor.
> >
> Those erase regions are solution for such flash, current upstream version does
> not have this. My solution is not universal, so probably I will not add it.
> 

Ok, Get it.
We will not use the specific 4kb combination mode for S25FS also.
So I will add the patch to disable 4kb for S25FS. But I will add a flag in dts that
the user can do the choice.

Thanks.
