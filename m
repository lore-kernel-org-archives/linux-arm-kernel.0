From: JBeulich@suse.com (Jan Beulich)
Date: Thu, 10 Sep 2015 06:55:25 -0600
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <alpine.DEB.2.02.1509101223580.2672@kaball.uk.xensource.com>
References: <1441874516-11364-1-git-send-email-zhaoshenglong@huawei.com>
 <20150910095208.GA29293@leverpostej>
 <alpine.DEB.2.02.1509101116580.2672@kaball.uk.xensource.com>
 <20150910112418.GC29293@leverpostej>
 <alpine.DEB.2.02.1509101223580.2672@kaball.uk.xensource.com>
Message-ID: <55F199DD02000078000A1B1E@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 10.09.15 at 13:37, <stefano.stabellini@eu.citrix.com> wrote:
> On Thu, 10 Sep 2015, Mark Rutland wrote:
>> Why can't Xen give a virtual EFI interface to Dom0 / guests? e.g.
>> create pages of RuntimeServicesCode that are trivial assembly shims
>> doing hypercalls, and plumb these into the virtual EFI memory map and
>> tables?
>> 
>> That would keep things sane for any guest, allow for easy addition of
>> EFI features, and you could even enter the usual EFI entry point,
>> simulate ExitBootServices(), SetVirtualAddressMap(), and allow the guest
>> to make things sane for itself...
> 
> That's the way it was done on x86 and now we have common code both in
> Linux (drivers/xen/efi.c) and Xen (xen/common/efi) which implement this
> scheme.  Switching to a different solution for ARM, would mean diverging
> with x86, which is not nice, or reimplementing the x86 solution too,
> which is expensive.
> 
> BTW I think that the idea you proposed was actually considered at the
> time and deemed hard to implement, if I recall correctly.

Considering that the EFI support is just for Dom0, and Dom0 (at
the time) had to be PV anyway, it was the more natural solution to
expose the interface via hypercalls, the more that this allows better
control over what is and primarily what is not being exposed to
Dom0. With the wrapper approach we'd be back to the same
problem (discussed elsewhere) of which EFI version to surface: The
host one would impose potentially missing extensions, while the
most recent hypervisor known one might imply hiding valuable
information from Dom0. Plus there are incompatible changes like
the altered meaning of EFI_MEMORY_WP in 2.5.

Jan
