From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Sep 2015 17:25:59 +0100
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <20150911124643.GB4530@olila.local.net-space.pl>
References: <20150910095208.GA29293@leverpostej>
 <alpine.DEB.2.02.1509101116580.2672@kaball.uk.xensource.com>
 <20150910112418.GC29293@leverpostej>
 <alpine.DEB.2.02.1509101223580.2672@kaball.uk.xensource.com>
 <20150910121514.GE29293@leverpostej>
 <alpine.DEB.2.02.1509101429480.2672@kaball.uk.xensource.com>
 <20150910144938.GI29293@leverpostej>
 <alpine.DEB.2.02.1509101655020.2672@kaball.uk.xensource.com>
 <20150910162302.GN29293@leverpostej>
 <20150911124643.GB4530@olila.local.net-space.pl>
Message-ID: <20150911162559.GA8726@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 01:46:43PM +0100, Daniel Kiper wrote:
> On Thu, Sep 10, 2015 at 05:23:02PM +0100, Mark Rutland wrote:
> > > > C) When you could go:
> > > >
> > > >    DT -> Discover Xen -> Xen-specific stuff -> Xen-specific EFI/ACPI discovery
> > >
> > > I take you mean discovering Xen with the usual Xen hypervisor node on
> > > device tree. I think that C) is a good option actually. I like it. Not
> > > sure why we didn't think about this earlier. Is there anything EFI or
> > > ACPI which is needed before Xen support is discovered by
> > > arch/arm64/kernel/setup.c:setup_arch -> xen_early_init()?
> >
> > Currently lots (including the memory map). With the stuff to support
> > SPCR, the ACPI discovery would be moved before xen_early_init().
> >
> > > If not, we could just go for this. A lot of complexity would go away.
> >
> > I suspect this would still be fairly complex, but would at least prevent
> > the Xen-specific EFI handling from adversely affecting the native case.
> >
> > > > D) If you want to be generic:
> > > >    EFI -> EFI application -> EFI tables -> ACPI tables -> Xen-specific stuff
> > > >           \------------------------------------------/
> > > > 	   (virtualize these, provide shims to Dom0, but handle
> > > > 	    everything in Xen itself)
> > >
> > > I think that this is good in theory but could turn out to be a lot of
> > > work in practice. We could probably virtualize the RuntimeServices but
> > > the BootServices are troublesome.
> >
> > What's troublesome with the boot services?
> >
> > What can't be simulated?
> 
> How do you want to access bare metal EFI boot services from dom0 if they
> were shutdown long time ago before loading dom0 image?

I don't want to.

I asked "What can't be simulated?" because I assumed everything
necessary/mandatory could be simulated without needinng access to any
real EFI boot services.

As far as I can see all that's necessary is to provide a compatible
interface.

> What do you need from EFI boot services in dom0?

The ability to call ExitBootServices() and SetVirtualAddressMap() on a
_virtual_ address map for _virtual_ services provided by the hypervisor.
A console so that I can log things early on.

Mark.
