From: x0082077@ti.com (Maulik)
Date: Thu, 5 Aug 2010 18:24:31 +0530
Subject: [PATCH] usb: musb: host: Issue a memory barrier before staring
	the DMA
In-Reply-To: <4C5AB13F.8060706@ru.mvista.com>
References: <1281001990-29755-1-git-send-email-santosh.shilimkar@ti.com>
	<4C5AB13F.8060706@ru.mvista.com>
Message-ID: <001201cb349d$5bb96e60$808918ac@apr.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov at mvista.com]
> Sent: Thursday, August 05, 2010 6:11 PM
> To: Santosh Shilimkar
> Cc: linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Maulik Mankad; Russell King; Felipe Balbi
> Subject: Re: [PATCH] usb: musb: host: Issue a memory barrier before
> staring the DMA
> 
> Hello.
> 
> Santosh Shilimkar wrote:
> 
> > This patch fixes the issue which was observed while transfering
> > a large file ( > 20MB) over USB (OMAP MUSB controller acts as USB host)
> > to an attached USB thumb drive.
> 
> > It was found that CDB field of CBW packet was set to 0x0. This was
> > due to missing a barrier before DMA engine starts transfer.
> > This  buffer is  allocated using dma_alloc_coherent which gives
> > non-cacheble but bufferable memory and hence needed a write
> > memory barrier to flush the write buffer.
> 
> > More info on this thread is here:
> > 	http://www.spinics.net/lists/linux-omap/msg33987.html
> 
> > Signed-off-by: Maulik Mankad <x0082077@ti.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Cc: Felipe Balbi <felipebalbi@users.sourceforge.net>
> > ---
> >  drivers/usb/musb/musb_host.c |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> > Index: omap4_integration/drivers/usb/musb/musb_host.c
> > ===================================================================
> > --- omap4_integration.orig/drivers/usb/musb/musb_host.c
> > +++ omap4_integration/drivers/usb/musb/musb_host.c
> > @@ -628,6 +628,11 @@ static bool musb_tx_dma_program(struct d
> >  	u8			mode;
> >
> >  #ifdef	CONFIG_USB_INVENTRA_DMA
> > +	/*
> > +	 * Ensure the data reaches to main memory before starting
> > +	 * DMA transfer
> > +	 */
> > +	wmb();
> 
>     Are you sure this is only needed for Inventra DMA?

Yes. This is seen only on SMP system such as OMAP4 which uses Inventra DMA.
We did not see the issue when SMP is disabled. 

Regards,
Maulik
