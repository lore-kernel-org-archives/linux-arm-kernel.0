From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 28 Nov 2013 11:10:30 -0800
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131128102845.GB21354@mudshark.cambridge.arm.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131127230650.GA6162@kroah.com>
 <20131128102845.GB21354@mudshark.cambridge.arm.com>
Message-ID: <20131128191030.GA2385@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 10:28:45AM +0000, Will Deacon wrote:
> Hi Greg,
> 
> On Wed, Nov 27, 2013 at 11:06:50PM +0000, Greg KH wrote:
> > On Wed, Nov 27, 2013 at 05:28:06PM +0000, Dave Martin wrote:
> > > >From will.deacon at arm.com Wed Nov 20 12:06:22 2013
> > > A number of discussion points remain to be resolved:
> > > 
> > >   - Use of the ranges property and describing slave vs master bus
> > >     address ranges. In the latter case, we actually want to describe our
> > >     address space with respect to the bus on which the bus masters,
> > >     rather than the parent. This could potentially be achieved by adding
> > >     properties such as dma-parent and dma-ranges (already used by PPC?)
> > > 
> > >   - Describing masters that master through multiple different buses
> > > 
> > >   - How on Earth this fits in with the Linux device model (it doesn't)
> > 
> > How does this _not_ fit into the Linux device model?  What am I missing
> > here that precludes the use of the "driver/device/bus" model we have
> > today?
> 
> The main problem is that we have devices which slave on one bus and master
> on another. That then complicates probing, power-management, IOMMU
> configuration, address mapping (e.g. I walk the slave buses to figure out
> where the slave registers live, but then I need a way to work out where
> exactly I master on a different bus) and dynamic coherency, amongst other
> things.
> 
> If we try to use the current infrastructure then we end up with one bus per
> device, which usually ends up being a fake bus representing both the slave
> and master buses (which is how the platform bus gets abused) and then device
> drivers having their own idea of the system topology where it's required.
> This is fairly horrible and doesn't work for anything other than the trivial
> case, where one or both of the buses are `dumb' and don't require any work
> from Linux.

Then just put everything on a single "bus", there's nothing in the
driver core that requires a bus to work in a specific way.

> > >  .../devicetree/bindings/arm/coherent-bus.txt       | 110 +++++++++++++++++++++
> > 
> > Why "arm"?
> > 
> > What makes it ARM specific?
> 
> This is just an RFC, so I'd be happy to put the binding somewhere more
> broad. I'm not sure how much of an issue this is outside of the SoC space,
> though.

There aren't "SoC"s on other architectures?  :)

thanks,

greg k-h
