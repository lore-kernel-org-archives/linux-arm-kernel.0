From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 27 Jul 2010 19:44:20 +0530
Subject: Issue with file transfers to a mass storage device on SMP system
In-Reply-To: <20100727135939.GD11468@n2100.arm.linux.org.uk>
References: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707@dbde02.ent.ti.com>
	<20100727100121.GB7846@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF75B@dbde02.ent.ti.com>
	<20100727104133.GA10665@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF83C@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF8F3@dbde02.ent.ti.com>
	<20100727135939.GD11468@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF90B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, July 27, 2010 7:30 PM
> To: Shilimkar, Santosh
> Cc: Mankad, Maulik Ojas; linux-usb at vger.kernel.org; linux-
> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: Issue with file transfers to a mass storage device on SMP
> system
> 
> On Tue, Jul 27, 2010 at 07:15:25PM +0530, Shilimkar, Santosh wrote:
> > > -----Original Message-----
> > > From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> > > owner at vger.kernel.org] On Behalf Of Shilimkar, Santosh
> > > Sent: Tuesday, July 27, 2010 5:31 PM
> > > To: Russell King - ARM Linux
> > > Cc: Mankad, Maulik Ojas; linux-usb at vger.kernel.org; linux-
> > > omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> > > Subject: RE: Issue with file transfers to a mass storage device on SMP
> > > system
> > >
> > > We have already those patches Russell and still see the issue. I think
> WMB
> > > is helping because data is just 16 bytes which can reside in WB. Had
> it
> > > been a bigger buffer this wouldn't have worked.
> > >
> > > Will get back to you with more data on this.
> >
> > Maulik and I looked at the code and below is what seems to be an issue.
> > The mass storage USB layer is not respecting the DMA/CPU buffer
> ownership.
> >
> > "usb_stor_Bulk_transport" gets "us-iobuf" which is already mapped for
> DMA.
> > But inside this function the buffers is updated by the CPU which should
> not
> > be done as per rule. Same buffer passed down for DMA to transfer where
> the
> > data might remain in CPU cache/WB. The dma map is not done on this
> buffer
> > because it's being done already before passing it to
> 'usb_stor_Bulk_transport'
> 
> Hang on.
> 
> us->iobuf is a DMA coherent buffer, allocated by usb_alloc_coherent(),
> in turn hcd_buffer_alloc().  This comes from either a DMA pool, or
> dma_alloc_coherent().  These buffers are simultaneously owned by both
> the CPU and the DMA agent.
> 
Good point. We thought it's a kmalloc. Now it makes complete sense about the barrier effectiveness

> So to talk about the buffer "already being mapped" and "buffer ownership"
> is wrong.  It's supposed to be a DMA coherent buffer, and trying to use
> dma_map_*() on it definitely won't work.
> 
Fully agree 
> This memory will be mapped in as 'normal memory, uncached', and with
> Catalins IO ordering patches, we rely upon wmb() ensuring that data
> written to it becomes visible to the DMA agents.  (wmb() by default
> aliases to mb(), which is a dsb() followed by outer_sync().)
> 
> I think OMAP overrides the definitions of the mandatory barriers -
> the question is whether the OMAP implementation is sufficient to ensure
> that data written to a 'normal memory, uncached' mapping makes it out
> RAM so that the DMA agents can see it.
> 
OMAP doesn't override because the default definition is good enough now.
Shouldn't below work ?
#elif __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
#define mb()            do { dsb(); outer_sync(); } while (0)
#define rmb()           dmb()
#define wmb()           mb()

> As the OMAP mandatory barrier implementation isn't in mainline, I can't
> comment on that.  However, I feel certain that this is where the problem
> is.

Do you think with above setting it should be still a problem ? I mean
with " CONFIG_ARCH_HAS_BARRIERS" not enabled

Regards,
Santosh
