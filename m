From: yunhui.cui@nxp.com (Yunhui Cui)
Date: Wed, 2 Mar 2016 01:50:15 +0000
Subject: [PATCH v2 3/4] mtd:spi-nor:fsl-quadspi:Add fast-read mode support
In-Reply-To: <20160229201714.GA18909@shlinux2.ap.freescale.net>
References: <1454326208-4533-1-git-send-email-B56489@freescale.com>
 <1454326208-4533-3-git-send-email-B56489@freescale.com>
 <20160217180742.GB17485@shlinux2>
 <DB5PR0401MB1912C9D041FF2B408652F4CD94A60@DB5PR0401MB1912.eurprd04.prod.outlook.com>
 <20160226163145.GA2182@shlinux2.ap.freescale.net>
 <DB5PR0401MB1912E33280B6EB755144995D94BA0@DB5PR0401MB1912.eurprd04.prod.outlook.com>
 <20160229201714.GA18909@shlinux2.ap.freescale.net>
Message-ID: <DB5PR0401MB191277E0B76D656565C1AC6294BC0@DB5PR0401MB1912.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Han,

Thanks for your suggestions about this patch. I will update it in driver next version patch set. 

Do you have some other comments for the patch set except for removing  "+ ret = of_property_read_bool(np, "m25p,fast-read");" in driver ?


Thanks
Yunhui
-----Original Message-----
From: Han Xu [mailto:xhnjupt at gmail.com] 
Sent: Tuesday, March 01, 2016 4:17 AM
To: Yunhui Cui
Cc: Yunhui Cui; dwmw2 at infradead.org; computersforpeace at gmail.com; han.xu at freescale.com; linux-mtd at lists.infradead.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Yao Yuan
Subject: Re: [PATCH v2 3/4] mtd:spi-nor:fsl-quadspi:Add fast-read mode support

On Mon, Feb 29, 2016 at 03:43:36AM +0000, Yunhui Cui wrote:
> Hi Han,
> 
> But I don't think QuadSPI driver need to check the m25p,fast-read property again since spi-nor layer has already done that. Adding the property in flash node should work in the same way.
> 
> [Yunhui]: There are three modes in fsl-quadspi driver , fast mode, quad mode, ddr quad read. The last parameter mode of spi_nor_scan() I have to specify . Otherwise, flash is still set to quad mode.

If the Nor chip behaves as you said only support fasst-read, the (info->flags &
SPI_NOR_QUAD_READ) can only take false path.

> spi-nor.c: 
> 
> 1419         if (mode == SPI_NOR_QUAD && info->flags & SPI_NOR_QUAD_READ) {
> 1420                 ret = set_quad_mode(nor, info);
> 1421                 if (ret) {
> 1422                         dev_err(dev, "quad mode not supported\n");
> 1423                         return ret;
> 1424                 }
> 1425                 nor->flash_read = SPI_NOR_QUAD;
> 1426         } else if (mode == SPI_NOR_DUAL && info->flags & SPI_NOR_DUAL_READ) {
> 1427                 nor->flash_read = SPI_NOR_DUAL;
> 1428         }
> 
> 
> Thanks
> Yunhui
> -----Original Message-----
> From: Han Xu [mailto:xhnjupt at gmail.com]
> Sent: Saturday, February 27, 2016 12:32 AM
> To: Yunhui Cui
> Cc: Yunhui Cui; dwmw2 at infradead.org; computersforpeace at gmail.com; 
> han.xu at freescale.com; linux-mtd at lists.infradead.org; 
> linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; 
> Yao Yuan
> Subject: Re: [PATCH v2 3/4] mtd:spi-nor:fsl-quadspi:Add fast-read mode 
> support
> 
> On Thu, Feb 25, 2016 at 08:07:22AM +0000, Yunhui Cui wrote:
> > Hi Han,
> > 
> > I have provided the options " m25p,fast-read ", because there are probable some flashes can't support quad mode.
> > So we should support fast-read mode in our driver. Moreover,  There is a option to select fast-read mode in spi_nor.c :
> >                /* If we were instantiated by DT, use it */
> >                  if (of_property_read_bool(np, "m25p,fast-read"))
> >                          nor->flash_read = SPI_NOR_FAST;
> 
> Did you have some REAL cases using SPI NOR that only supports upto fast-read with Quad SPI driver? Neither fast-read or normal-read, which is actually more general, supported in the driver, just because I didn't see any REAL cases till now.
> 
> I didn't run against the patch, although IMO it's not that necessary. But I don't think QuadSPI driver need to check the m25p,fast-read property again since spi-nor layer has already done that. Adding the property in flash node should work in the same way.
>  
> > 
> > Thanks
> > Yunhui
> > 
> > -----Original Message-----
> > From: Han Xu [mailto:xhnjupt at gmail.com]
> > Sent: Thursday, February 18, 2016 2:08 AM
> > To: Yunhui Cui
> > Cc: dwmw2 at infradead.org; computersforpeace at gmail.com; 
> > han.xu at freescale.com; linux-mtd at lists.infradead.org; 
> > linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > Yao Yuan
> > Subject: Re: [PATCH v2 3/4] mtd:spi-nor:fsl-quadspi:Add fast-read 
> > mode support
> > 
> > On Mon, Feb 01, 2016 at 07:30:07PM +0800, Yunhui Cui wrote:
> > > The qspi driver add generic fast-read mode for different flash 
> > > venders. There are some different board flash work on different 
> > > mode, such fast-read, quad-mode.
> > > So we have to modify the third entrace parameter of spi_nor_scan().
> > > 
> > > Signed-off-by: Yunhui Cui <B56489@freescale.com>
> > > ---
> > >  drivers/mtd/spi-nor/fsl-quadspi.c | 27 
> > > +++++++++++++++++++++------
> > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c
> > > b/drivers/mtd/spi-nor/fsl-quadspi.c
> > > index 9861290..0a31cb1 100644
> > > --- a/drivers/mtd/spi-nor/fsl-quadspi.c
> > > +++ b/drivers/mtd/spi-nor/fsl-quadspi.c
> > > @@ -389,11 +389,21 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
> > >  	/* Read */
> > >  	lut_base = SEQID_READ * 4;
> > >  
> > > -	qspi_writel(q, LUT0(CMD, PAD1, read_op) | LUT1(ADDR, PAD1, addrlen),
> > > -			base + QUADSPI_LUT(lut_base));
> > > -	qspi_writel(q, LUT0(DUMMY, PAD1, read_dm) |
> > > -		    LUT1(FSL_READ, PAD4, rxfifo),
> > > -			base + QUADSPI_LUT(lut_base + 1));
> > > +	if (nor->flash_read == SPI_NOR_FAST) {
> > > +		qspi_writel(q, LUT0(CMD, PAD1, read_op) |
> > > +			    LUT1(ADDR, PAD1, addrlen),
> > > +				base + QUADSPI_LUT(lut_base));
> > > +		qspi_writel(q,  LUT0(DUMMY, PAD1, read_dm) |
> > > +			    LUT1(FSL_READ, PAD1, rxfifo),
> > > +				base + QUADSPI_LUT(lut_base + 1));
> > > +	} else if (nor->flash_read == SPI_NOR_QUAD) {
> > > +		qspi_writel(q, LUT0(CMD, PAD1, read_op) |
> > > +			    LUT1(ADDR, PAD1, addrlen),
> > > +				base + QUADSPI_LUT(lut_base));
> > > +		qspi_writel(q, LUT0(DUMMY, PAD1, read_dm) |
> > > +			    LUT1(FSL_READ, PAD4, rxfifo),
> > > +				base + QUADSPI_LUT(lut_base + 1));
> > > +	}
> > >  
> > >  	/* Write enable */
> > >  	lut_base = SEQID_WREN * 4;
> > > @@ -468,6 +478,7 @@ static int fsl_qspi_get_seqid(struct fsl_qspi 
> > > *q,
> > > u8 cmd)  {
> > >  	switch (cmd) {
> > >  	case SPINOR_OP_READ_1_1_4:
> > > +	case SPINOR_OP_READ_FAST:
> > >  		return SEQID_READ;
> > >  	case SPINOR_OP_WREN:
> > >  		return SEQID_WREN;
> > > @@ -963,6 +974,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
> > >  	struct spi_nor *nor;
> > >  	struct mtd_info *mtd;
> > >  	int ret, i = 0;
> > > +	enum read_mode mode = SPI_NOR_QUAD;
> > >  
> > >  	q = devm_kzalloc(dev, sizeof(*q), GFP_KERNEL);
> > >  	if (!q)
> > > @@ -1064,7 +1076,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
> > >  		/* set the chip address for READID */
> > >  		fsl_qspi_set_base_addr(q, nor);
> > >  
> > > -		ret = spi_nor_scan(nor, NULL, SPI_NOR_QUAD);
> > > +		ret = of_property_read_bool(np, "m25p,fast-read");
> > > +		mode = (ret) ? SPI_NOR_FAST : SPI_NOR_QUAD;
> > > +
> > > +		ret = spi_nor_scan(nor, NULL, mode);
> > >  		if (ret)
> > >  			goto mutex_failed;
> > >  
> > I understand you want to provide a more generic read mode, but this is a quad spi driver, I prefer to provide the options, either quad read/quad IO read, or just normal read.
> > > --
> > > 2.1.0.27.g96db324
> > > 
> > > 
> > > ______________________________________________________
> > > Linux MTD discussion mailing list
> > > http://lists.infradead.org/mailman/listinfo/linux-mtd/
