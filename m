From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 11 Sep 2015 14:14:09 +0100
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <20150911124643.GB4530@olila.local.net-space.pl>
References: <1441874516-11364-1-git-send-email-zhaoshenglong@huawei.com>
 <20150910095208.GA29293@leverpostej>
 <alpine.DEB.2.02.1509101116580.2672@kaball.uk.xensource.com>
 <20150910112418.GC29293@leverpostej>
 <alpine.DEB.2.02.1509101223580.2672@kaball.uk.xensource.com>
 <20150910121514.GE29293@leverpostej>
 <alpine.DEB.2.02.1509101429480.2672@kaball.uk.xensource.com>
 <20150910144938.GI29293@leverpostej>
 <alpine.DEB.2.02.1509101655020.2672@kaball.uk.xensource.com>
 <20150910162302.GN29293@leverpostej>
 <20150911124643.GB4530@olila.local.net-space.pl>
Message-ID: <alpine.DEB.2.02.1509111410180.2672@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2015, Daniel Kiper wrote:
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
> were shutdown long time ago before loading dom0 image? What do you need
> from EFI boot services in dom0?

That's right. Trying to emulate BootServices after the real
ExitBootServices has already been called seems like a very bad plan.

I think that whatever interface we come up with, would need to be past
ExitBootServices.
