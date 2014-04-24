From: b32955@freescale.com (Huang Shijie)
Date: Thu, 24 Apr 2014 12:58:40 +0800
Subject: [PATCH v1 5/7] mtd: fsl-quadspi: get the dummy cycles for DDR
 Quad read from the DT property
In-Reply-To: <201404232148.51034.marex@denx.de>
References: <a> <1398248215-26768-6-git-send-email-b32955@freescale.com>
 <201404232148.51034.marex@denx.de>
Message-ID: <20140424045838.GC29664@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 09:48:50PM +0200, Marek Vasut wrote:
> On Wednesday, April 23, 2014 at 12:16:53 PM, Huang Shijie wrote:
> > Check the "spi-nor,ddr-quad-read-dummy" DT property to get the
> > dummy cycles for DDR quad read.
> > 
> > Signed-off-by: Huang Shijie <b32955@freescale.com>
> > ---
> >  drivers/mtd/spi-nor/fsl-quadspi.c |    7 +++++++
> >  1 files changed, 7 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c
> > b/drivers/mtd/spi-nor/fsl-quadspi.c index 8d659a2..15bdeb9 100644
> > --- a/drivers/mtd/spi-nor/fsl-quadspi.c
> > +++ b/drivers/mtd/spi-nor/fsl-quadspi.c
> > @@ -883,6 +883,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
> >  	for_each_available_child_of_node(dev->of_node, np) {
> >  		const struct spi_device_id *id;
> >  		char modalias[40];
> > +		u32 dummy = 0;
> > 
> >  		/* skip the holes */
> >  		if (!has_second_chip)
> > @@ -918,6 +919,12 @@ static int fsl_qspi_probe(struct platform_device
> > *pdev) if (ret < 0)
> >  			goto map_failed;
> > 
> > +		/* Set the dummy cycles for the DDR Quad Read */
> > +		ret = of_property_read_u32(np, "spi-nor,ddr-quad-read-dummy",
> > +				&dummy);
> > +		if (!ret && dummy > 0 && dummy < 8)
> > +			nor->read_dummy = dummy;
> 
> Is there any reason for the upper limit on number of dummy cycles ?
I actually tested two kinds of NOR flash, the Spansion s25fl128s and Micron N25q256a.
The dummy cycles are all less then 8.

but i admit the upper limit here is not proper.
I can remove it in the next version.

thanks
Huang Shijie
