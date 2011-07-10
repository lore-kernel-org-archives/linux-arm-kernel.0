From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 10 Jul 2011 09:14:45 +0200
Subject: [PATCH] pxa2xx_spi: fix memory corruption
In-Reply-To: <20110709231108.GQ4812@n2100.arm.linux.org.uk>
References: <1310246098-21208-1-git-send-email-anarsoul@gmail.com>
	<201107100105.48168.marek.vasut@gmail.com>
	<20110709231108.GQ4812@n2100.arm.linux.org.uk>
Message-ID: <201107100914.45452.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, July 10, 2011 01:11:09 AM Russell King - ARM Linux wrote:
> On Sun, Jul 10, 2011 at 01:05:48AM +0200, Marek Vasut wrote:
> > On Saturday, July 09, 2011 11:14:58 PM Vasily Khoruzhick wrote:
> > > pxa2xx_spi_probe allocates struct driver_data and null_dma_buf
> > > at same time via spi_alloc_master(), but then calculates
> > > null_dma_buf pointer incorrectly, and it causes memory corruption
> > > later if DMA usage is enabled.
> > > 
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > ---
> > > 
> > >  drivers/spi/pxa2xx_spi.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> > > index dc25bee..ef38fbf 100644
> > > --- a/drivers/spi/pxa2xx_spi.c
> > > +++ b/drivers/spi/pxa2xx_spi.c
> > > @@ -1569,7 +1569,7 @@ static int __devinit pxa2xx_spi_probe(struct
> > > platform_device *pdev) master->transfer = transfer;
> > > 
> > >  	drv_data->ssp_type = ssp->type;
> > > 
> > > -	drv_data->null_dma_buf = (u32 *)ALIGN((u32)(drv_data +
> > > +	drv_data->null_dma_buf = (u32 *)ALIGN(((u32)drv_data +
> > > 
> > >  						sizeof(struct driver_data)), 8);
> > 
> > This thing looks a bit disturbing in itself. Like, where the heck is that
> > thing pointing in the end ? Since some data are written to address in
> > "null_dma_buf" ... isn't this just changing the corruption impact ?
> 
>         /* Allocate master with space for drv_data and null dma buffer */
>         master = spi_alloc_master(dev, sizeof(struct driver_data) + 16);
> 
> So there's 16 bytes at the end of driver_data.
> 
> However:
> 
> 	(u32)(drv_data + sizeof(struct driver_data))
> 
> is pointer arithmetic.  drv_data points at an object of sizeof(struct
> driver_data).  Adding one to this increments the pointer by
> sizeof(struct driver_data) bytes.  So the above expression increments
> the pointer by sizeof(struct driver_data)*sizeof(struct driver_data)
> bytes, which is obviously complete rubbish.
> 
> 	((u32)drv_data + sizeof(struct driver_data))
> 
> casts drv_data to a u32 first, then adds the sizeof(struct driver_data)
> which moves us into the 16 bytes allocated off the end of the struct.

The ptr arritmetic is clear, it was the 16 bytes after the structure I was 
missing ... if it's allocated there, it's fine. Thanks for clearing this.
