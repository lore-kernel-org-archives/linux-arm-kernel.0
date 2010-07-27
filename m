From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 27 Jul 2010 19:59:17 +0530
Subject: Issue with file transfers to a mass storage device on SMP	system
In-Reply-To: <20100727142113.GE11468@n2100.arm.linux.org.uk>
References: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707@dbde02.ent.ti.com>
	<20100727100121.GB7846@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF75B@dbde02.ent.ti.com>
	<20100727104133.GA10665@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF83C@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF8F3@dbde02.ent.ti.com>
	<20100727135939.GD11468@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF90B@dbde02.ent.ti.com>
	<20100727142113.GE11468@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF91F@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, July 27, 2010 7:51 PM
> To: Shilimkar, Santosh
> Cc: Mankad, Maulik Ojas; linux-usb at vger.kernel.org; linux-
> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: Issue with file transfers to a mass storage device on SMP
> system
> 
> On Tue, Jul 27, 2010 at 07:44:20PM +0530, Shilimkar, Santosh wrote:
> > OMAP doesn't override because the default definition is good enough now.
> 
> Ah, good to know.
> 
> > Shouldn't below work ?
> > #elif __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
> > #define mb()            do { dsb(); outer_sync(); } while (0)
> > #define rmb()           dmb()
> > #define wmb()           mb()
> 
> Yes, that should get it out of the CPU and caches, and onto the bus.
> However, I need to check up exactly what a write to the L2x0 SYNC
> register gives us...
> 
> > > As the OMAP mandatory barrier implementation isn't in mainline, I
> can't
> > > comment on that.  However, I feel certain that this is where the
> problem
> > > is.
> >
> > Do you think with above setting it should be still a problem ? I mean
> > with " CONFIG_ARCH_HAS_BARRIERS" not enabled
> 
> Well, the question is whether getting it out of the outer cache (and
> performing an effective memory barrier to the outer cache) is sufficient
> for the DMA agent to see the data.
> 
> Could the data be sitting somewhere in the interconnect between the
> CPU pushing it out of the outer cache and the DMA agent trying to read
> from memory?
Once it's pushed out of L2X WB, it will hit the memory. Just to give an additional data point, with CATC analyzer what we see that only those 
16 bytes CDB are 0x0. This buffer was memset to 0x0 just before the
memcpy.

I am just wondering who will issue a barrier(wmb) on this buffer before DMA
start if we don't use dma-mapping APIs? May be for dma_alloc_coherent
buffers, we need to explicitly issue the barrier.

Is that the expectation? If yes then the work-around we used seems to the
fix.

Regards,
Santosh 
