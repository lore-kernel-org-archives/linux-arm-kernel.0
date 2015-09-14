From: ian.campbell@citrix.com (Ian Campbell)
Date: Mon, 14 Sep 2015 10:57:53 +0100
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <CAKv+Gu9ER1cKvPHobq-wo7ggPesJj4OQ7=aTr24GVpubHvVqjQ@mail.gmail.com>
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
 <CAKv+Gu9ER1cKvPHobq-wo7ggPesJj4OQ7=aTr24GVpubHvVqjQ@mail.gmail.com>
Message-ID: <1442224673.3549.131.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-09-14 at 11:43 +0200, Ard Biesheuvel wrote:

> Xen will not boot the kernel via the stub, but directly. It needs to
> supply a EFI like environment so that the kernel can boot via ACPI.
> There is no reason whatsoever to mock up boot services or other pieces
> of UEFI functionality that are not needed.

I'm correct that on native the EFI stub calls ExitBootServices, right?

So the flow for native is:

EFI -> Linux EFI Stub -> Exit Boot Services -> Non-EFI Linux head.S entrypoint

For Xen it is more like:

Xen domain builder -------  ...    ... ------> Non-EFI Linux head.S entrypoint

>  The core kernel does not call any boot services

And it cannot because ExitBootServices has already been called.

I think given all that there should no reason at all for Xen to be
providing boot services.

>  or SetVirtualAddressMap/ConvertPointer, and

These two are RTS, so in principal it could.

(I'm not sure about ConvertPointer, is it useful for OS kernels, or just
for "UEFI components" mentioned at http://wiki.phoenix.com/wiki/index.php/E
FI_RUNTIME_SERVICES#ConvertPointer.28.29 ?)

> there is already paravirtualized plumbing in place for the remaining
> runtime services.
> 
> Hence my claim earlier that we should cope with the runtime services
> pointer being NULL, since that is really the only thing standing in
> the way from the kernel side. If you feel that violates the spec in
> some way, we could at least conditionalise it on EFI_RUNTIME_SERVICES
> having been set already, this gives the Xen code a chance of
> overriding them.
> 
