From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Mon, 3 Sep 2018 04:47:25 +0000
Subject: [PATCH 1/7] spi: add slave device size in spi_device struct
In-Reply-To: <20180831135807.22255bce@karo-electronics.de>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1535711404-29528-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180831135807.22255bce@karo-electronics.de>
Message-ID: <VI1PR04MB103801BA8203421C517199BB990C0@VI1PR04MB1038.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

> -----Original Message-----
> From: Lothar Wa?mann [mailto:LW at KARO-electronics.de]
> Sent: Friday, August 31, 2018 5:28 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd at lists.infradead.org; boris.brezillon at bootlin.com;
> marek.vasut at gmail.com; linux-spi at vger.kernel.org;
> devicetree at vger.kernel.org; mark.rutland at arm.com; robh at kernel.org; linux-
> kernel at vger.kernel.org; frieder.schrempf at exceet.de;
> computersforpeace at gmail.com; shawnguo at kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 1/7] spi: add slave device size in spi_device struct
> 
> Hi,
> 
> On Fri, 31 Aug 2018 15:59:58 +0530 Yogesh Gaur wrote:
> > Add 'size' data variable in spi_device struct.
> > This is to save the size of the connected slave device.
> >
> > After slave device scan, spi_nor_scan, size being assigned to this
> > from MTD layer.
> >
> > SFDP read is being requested before completion of spi_nor_scan()
> > routine, thus populate device size before making read request to the
> > SPI controller.
> >
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > ---
> >  drivers/mtd/devices/m25p80.c  | 6 ++++++
> > drivers/mtd/spi-nor/spi-nor.c | 2 ++
> >  include/linux/spi/spi.h       | 2 ++
> >  3 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/mtd/devices/m25p80.c
> > b/drivers/mtd/devices/m25p80.c index fe260cc..6c7ad86 100644
> > --- a/drivers/mtd/devices/m25p80.c
> > +++ b/drivers/mtd/devices/m25p80.c
> > @@ -124,6 +124,10 @@ static ssize_t m25p80_read(struct spi_nor *nor,
> loff_t from, size_t len,
> >  	/* convert the dummy cycles to the number of bytes */
> >  	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> >
> > +	/* for case of SFDP header read commands, populate spi device size */
> > +	if (flash->spimem->spi->size == 0)
> > +		flash->spimem->spi->size = nor->mtd.size;
> > +
> If the 'size' is an spimem specific variable it should be added to the spi_mem
> struct rather than the spi_device struct.

Sure, would move 'size' from struct spi_device to the struct spi_mem.

--
Regards
Yogesh Gaur.

> 
> Lothar Wa?mann
