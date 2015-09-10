From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Sep 2015 13:15:14 +0100
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <alpine.DEB.2.02.1509101223580.2672@kaball.uk.xensource.com>
References: <1441874516-11364-1-git-send-email-zhaoshenglong@huawei.com>
 <20150910095208.GA29293@leverpostej>
 <alpine.DEB.2.02.1509101116580.2672@kaball.uk.xensource.com>
 <20150910112418.GC29293@leverpostej>
 <alpine.DEB.2.02.1509101223580.2672@kaball.uk.xensource.com>
Message-ID: <20150910121514.GE29293@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 12:37:57PM +0100, Stefano Stabellini wrote:
> On Thu, 10 Sep 2015, Mark Rutland wrote:
> > > > Does Xen not talk to EFI itself and/or give the kernel a virtual EFI
> > > > interface?
> > > 
> > > Xen talks to EFI itself but the interface provided to dom0 is somewhat
> > > different: there are no BootServices (Xen calls ExitBootServices before
> > > running the kernel), and the RuntimeServices go via hypercalls (see
> > > drivers/xen/efi.c).
> > 
> > That's somewhat hideous; a non Xen-aware OS wouild presumably die if
> > trying to use any runtime services the normal way? I'm not keen on
> > describing things that the OS cannot use.
>  
> I agree that is somewhat hideous, but a non-Xen aware OS traditionally
> has never been able to even boot as Dom0. On ARM it can, but it still
> wouldn't be very useful (one couldn't use it to start other guests).

Sure, but it feels odd to provide the usual information in this manner
if it cannot be used. If you require Xen-specific code to make things
work, I would imagine this information could be dciscovered in a
Xen-specific manner.

> > Why can't Xen give a virtual EFI interface to Dom0 / guests? e.g.
> > create pages of RuntimeServicesCode that are trivial assembly shims
> > doing hypercalls, and plumb these into the virtual EFI memory map and
> > tables?
> > 
> > That would keep things sane for any guest, allow for easy addition of
> > EFI features, and you could even enter the usual EFI entry point,
> > simulate ExitBootServices(), SetVirtualAddressMap(), and allow the guest
> > to make things sane for itself...
> 
> That's the way it was done on x86 and now we have common code both in
> Linux (drivers/xen/efi.c) and Xen (xen/common/efi) which implement this
> scheme.

This code is not currently used on arm. It might live in a location
where it may be shared, but that doesn't mean that it's common code yet.

> Switching to a different solution for ARM, would mean diverging
> with x86, which is not nice, or reimplementing the x86 solution too,
> which is expensive.
> 
> BTW I think that the idea you proposed was actually considered at the
> time and deemed hard to implement, if I recall correctly.

I appreciate that divergence is painful. We already diverge in other
respects (e.g. lack of PV page tables) because things that used to be
the case on x86 never applied to ARM.

It would be interesting to see why that was the case for x86, and
whether that applies to ARM.

> In any case this should be separate from the shim ABI discussion.

I disagree; I think this is very much relevant to the ABI discussion.
That's not to say that I insist on a particular approach, but I think
that they need to be considered together.

Thanks,
Mark.
