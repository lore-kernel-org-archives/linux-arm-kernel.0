From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 14 Sep 2015 10:47:12 +0100
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <20150914092518.GA10307@leverpostej>
References: <20150910112418.GC29293@leverpostej>
 <alpine.DEB.2.02.1509101223580.2672@kaball.uk.xensource.com>
 <20150910121514.GE29293@leverpostej>
 <alpine.DEB.2.02.1509101429480.2672@kaball.uk.xensource.com>
 <20150910144938.GI29293@leverpostej>
 <alpine.DEB.2.02.1509101655020.2672@kaball.uk.xensource.com>
 <20150910162302.GN29293@leverpostej>
 <20150911124643.GB4530@olila.local.net-space.pl>
 <20150911162559.GA8726@leverpostej>
 <20150912113655.GG4530@olila.local.net-space.pl>
 <20150914092518.GA10307@leverpostej>
Message-ID: <alpine.DEB.2.02.1509141043520.2672@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Sep 2015, Mark Rutland wrote:
> On Sat, Sep 12, 2015 at 12:36:55PM +0100, Daniel Kiper wrote:
> > On Fri, Sep 11, 2015 at 05:25:59PM +0100, Mark Rutland wrote:
> > > On Fri, Sep 11, 2015 at 01:46:43PM +0100, Daniel Kiper wrote:
> > > > On Thu, Sep 10, 2015 at 05:23:02PM +0100, Mark Rutland wrote:
> > 
> > [...]
> > 
> > > > > What's troublesome with the boot services?
> > > > >
> > > > > What can't be simulated?
> > > >
> > > > How do you want to access bare metal EFI boot services from dom0 if they
> > > > were shutdown long time ago before loading dom0 image?
> > >
> > > I don't want to.
> > >
> > > I asked "What can't be simulated?" because I assumed everything
> > > necessary/mandatory could be simulated without needinng access to any
> > > real EFI boot services.
> > >
> > > As far as I can see all that's necessary is to provide a compatible
> > > interface.
> > 
> > Could you be more precise what do you need? Please enumerate. UEFI spec has
> > more than 2500 pages and I do not think that we need all stuff in dom0.
> > 
> > > > What do you need from EFI boot services in dom0?
> > >
> > > The ability to call ExitBootServices() and SetVirtualAddressMap() on a
> > > _virtual_ address map for _virtual_ services provided by the hypervisor.
> > 
> > I am confused. Why do you need that? Please remember, EFI is owned and
> > operated by Xen hypervisor. dom0 does not have direct access to EFI.
> 
> Let's take a step back.
> 
> My objection here is to passing the Dom0 kernel properties as if it were
> booted with direct access to a full UEFI, then later fixing that up
> (when Xen is detected and we apply its hypercall EFI implementation).
> 
> If the kernel cannot use EFI natively, why pretend to the kernel that it
> can? The hypercall implementation is _not_ EFI (though it provides
> access to some services).
> 
> The two ways I can see providing Dom0 with EFI services are:
> 
> * Have Xen create shims for any services, in which any hypercalls live,
>   and pass these to the kernel with a virtual system table. This keeps
>   the interface to the kernel the same regardless of Xen.

A not a fan of three-point estimates, so I am just going to say that
"this looks like a lot of work". Also emulating services is known to be
prone to errors.


> * Have the kernel detect Xen EFI capability via Xen, without passing the
>   usual native EFI parameters. This can then be installed into the
>   kernel in a Xen-specific manner, and we know from the outset that
>   Xen-specific caveats apply.

I prefer this approach by far. In the future we might have to move the
xen_early_init call earlier (before ACPI and EFI Runtime Services get
initialized).


> As per my original email, I'm not against the renaming of the stub
> parameters if we standardise the rest of the details, but I believe
> that's orthogonal to the Xen Dom0 case.
