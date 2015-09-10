From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Sep 2015 12:24:19 +0100
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <alpine.DEB.2.02.1509101116580.2672@kaball.uk.xensource.com>
References: <1441874516-11364-1-git-send-email-zhaoshenglong@huawei.com>
 <20150910095208.GA29293@leverpostej>
 <alpine.DEB.2.02.1509101116580.2672@kaball.uk.xensource.com>
Message-ID: <20150910112418.GC29293@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Does Xen not talk to EFI itself and/or give the kernel a virtual EFI
> > interface?
> 
> Xen talks to EFI itself but the interface provided to dom0 is somewhat
> different: there are no BootServices (Xen calls ExitBootServices before
> running the kernel), and the RuntimeServices go via hypercalls (see
> drivers/xen/efi.c).

That's somewhat hideous; a non Xen-aware OS wouild presumably die if
trying to use any runtime services the normal way? I'm not keen on
describing things that the OS cannot use.

Why can't Xen give a virtual EFI interface to Dom0 / guests? e.g.
create pages of RuntimeServicesCode that are trivial assembly shims
doing hypercalls, and plumb these into the virtual EFI memory map and
tables?

That would keep things sane for any guest, allow for easy addition of
EFI features, and you could even enter the usual EFI entry point,
simulate ExitBootServices(), SetVirtualAddressMap(), and allow the guest
to make things sane for itself...

Mark.
