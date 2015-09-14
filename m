From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 14 Sep 2015 12:02:24 +0200
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <1442224673.3549.131.camel@citrix.com>
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
 <1442224673.3549.131.camel@citrix.com>
Message-ID: <CAKv+Gu_Gh649EwdtodLY9Q28JhqYg8o6RShXXH1ZbxsfYRfi2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 September 2015 at 11:57, Ian Campbell <ian.campbell@citrix.com> wrote:
> On Mon, 2015-09-14 at 11:43 +0200, Ard Biesheuvel wrote:
>
>> Xen will not boot the kernel via the stub, but directly. It needs to
>> supply a EFI like environment so that the kernel can boot via ACPI.
>> There is no reason whatsoever to mock up boot services or other pieces
>> of UEFI functionality that are not needed.
>
> I'm correct that on native the EFI stub calls ExitBootServices, right?
>
> So the flow for native is:
>
> EFI -> Linux EFI Stub -> Exit Boot Services -> Non-EFI Linux head.S entrypoint
>
> For Xen it is more like:
>
> Xen domain builder -------  ...    ... ------> Non-EFI Linux head.S entrypoint
>
>>  The core kernel does not call any boot services
>
> And it cannot because ExitBootServices has already been called.
>
> I think given all that there should no reason at all for Xen to be
> providing boot services.
>

Indeed.

>>  or SetVirtualAddressMap/ConvertPointer, and
>
> These two are RTS, so in principal it could.
>
> (I'm not sure about ConvertPointer, is it useful for OS kernels, or just
> for "UEFI components" mentioned at http://wiki.phoenix.com/wiki/index.php/E
> FI_RUNTIME_SERVICES#ConvertPointer.28.29 ?)
>

No, there is no point. The stub calls SetVirtualAddressMap, so the
kernel proper can never call it, since it can only be called once.
ConvertPointer has little utility outside of the UEFI runtime
components that are invoked during SetVirtualAddressMap, so I don't
see a reason to supply that either.

-- 
Ard.
