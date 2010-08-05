From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 5 Aug 2010 18:57:08 +0530
Subject: [PATCH] usb: musb: host: Issue a memory barrier before staring
	the DMA
In-Reply-To: <20100805131212.GC23473@n2100.arm.linux.org.uk>
References: <1281001990-29755-1-git-send-email-santosh.shilimkar@ti.com>
	<4C5AB13F.8060706@ru.mvista.com>
	<001201cb349d$5bb96e60$808918ac@apr.dhcp.ti.com>
	<20100805131212.GC23473@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C64A1B66@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Thursday, August 05, 2010 6:42 PM
> To: Mankad, Maulik Ojas
> Cc: 'Sergei Shtylyov'; Shilimkar, Santosh; linux-usb at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; 'Felipe Balbi'
> Subject: Re: [PATCH] usb: musb: host: Issue a memory barrier before
> staring the DMA
> 
> On Thu, Aug 05, 2010 at 06:24:31PM +0530, Maulik wrote:
> > > > Index: omap4_integration/drivers/usb/musb/musb_host.c
> > > > ===================================================================
> > > > --- omap4_integration.orig/drivers/usb/musb/musb_host.c
> > > > +++ omap4_integration/drivers/usb/musb/musb_host.c
> > > > @@ -628,6 +628,11 @@ static bool musb_tx_dma_program(struct d
> > > >  	u8			mode;
> > > >
> > > >  #ifdef	CONFIG_USB_INVENTRA_DMA
> > > > +	/*
> > > > +	 * Ensure the data reaches to main memory before starting
> > > > +	 * DMA transfer
> > > > +	 */
> > > > +	wmb();
> > >
> > >     Are you sure this is only needed for Inventra DMA?
> >
> > Yes. This is seen only on SMP system such as OMAP4 which uses Inventra
> DMA.
> > We did not see the issue when SMP is disabled.
> 
> It'll be far safer to actually consider what's going on here, and realise
> that it's NOT a SMP issue but a write ordering issue.
> 
> What that means is that as OMAP systems progress, and the ordering becomes
> weaker, you will see the problem appearing on non-SMP.  So why not fix it
> properly now and avoid having to revisit this with yet more patches.
> 
> Think about what happens if writes to memory (DMA or otherwise) in the
> program become mis-ordered with writes to the device registers - and fix
> anything where that ordering matters by adding the necessary barriers.
> This will save you having to constantly revisit the driver time and time
> again to move the barriers around.

This patch fixes all OMAP processors. The other architecture Da-Vinci which uses same Mentor USB controller but different DMA engine(CPPI) may need this
fix but we are not sure about this.

Hence only OMAP is patched.

Regards,
Santosh
