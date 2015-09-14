From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 14 Sep 2015 15:09:34 +0200
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <20150914122858.GI4530@olila.local.net-space.pl>
References: <20150910121514.GE29293@leverpostej>
 <alpine.DEB.2.02.1509101429480.2672@kaball.uk.xensource.com>
 <20150910144938.GI29293@leverpostej>
 <alpine.DEB.2.02.1509101655020.2672@kaball.uk.xensource.com>
 <20150910162302.GN29293@leverpostej>
 <20150911124643.GB4530@olila.local.net-space.pl>
 <20150911162559.GA8726@leverpostej>
 <20150912113655.GG4530@olila.local.net-space.pl>
 <20150914092518.GA10307@leverpostej>
 <CAKv+Gu9ER1cKvPHobq-wo7ggPesJj4OQ7=aTr24GVpubHvVqjQ@mail.gmail.com>
 <20150914122858.GI4530@olila.local.net-space.pl>
Message-ID: <CAKv+Gu_z2X=9-qgoKTS7dKLqtSUvysyu9LzZryJqcSR4X8Ss6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 September 2015 at 14:28, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> On Mon, Sep 14, 2015 at 11:43:27AM +0200, Ard Biesheuvel wrote:
>> On 14 September 2015 at 11:25, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Sat, Sep 12, 2015 at 12:36:55PM +0100, Daniel Kiper wrote:
>> >> On Fri, Sep 11, 2015 at 05:25:59PM +0100, Mark Rutland wrote:
>> >> > On Fri, Sep 11, 2015 at 01:46:43PM +0100, Daniel Kiper wrote:
>> >> > > On Thu, Sep 10, 2015 at 05:23:02PM +0100, Mark Rutland wrote:
>> >>
>> >> [...]
>> >>
>> >> > > > What's troublesome with the boot services?
>> >> > > >
>> >> > > > What can't be simulated?
>> >> > >
>> >> > > How do you want to access bare metal EFI boot services from dom0 if they
>> >> > > were shutdown long time ago before loading dom0 image?
>> >> >
>> >> > I don't want to.
>> >> >
>> >> > I asked "What can't be simulated?" because I assumed everything
>> >> > necessary/mandatory could be simulated without needinng access to any
>> >> > real EFI boot services.
>> >> >
>> >> > As far as I can see all that's necessary is to provide a compatible
>> >> > interface.
>> >>
>> >> Could you be more precise what do you need? Please enumerate. UEFI spec has
>> >> more than 2500 pages and I do not think that we need all stuff in dom0.
>> >>
>> >> > > What do you need from EFI boot services in dom0?
>> >> >
>> >> > The ability to call ExitBootServices() and SetVirtualAddressMap() on a
>> >> > _virtual_ address map for _virtual_ services provided by the hypervisor.
>> >>
>> >> I am confused. Why do you need that? Please remember, EFI is owned and
>> >> operated by Xen hypervisor. dom0 does not have direct access to EFI.
>> >
>> > Let's take a step back.
>> >
>> > My objection here is to passing the Dom0 kernel properties as if it were
>> > booted with direct access to a full UEFI, then later fixing that up
>> > (when Xen is detected and we apply its hypercall EFI implementation).
>> >
>>
>> To be honest, I don't think that has ever been suggested here. What
>> was suggested is to provide a minimal EFI like environment that allows
>> the post-stub EFI code to proceed and find the ACPI root pointer.
>>
>> > If the kernel cannot use EFI natively, why pretend to the kernel that it
>> > can? The hypercall implementation is _not_ EFI (though it provides
>> > access to some services).
>> >
>>
>> To get access to the ACPI root pointer, for which there is only one
>> specified way of obtaining it on ARM, which is via the UEFI
>> configuration table database
>>
>> > The two ways I can see providing Dom0 with EFI services are:
>> >
>> > * Have Xen create shims for any services, in which any hypercalls live,
>> >   and pass these to the kernel with a virtual system table. This keeps
>> >   the interface to the kernel the same regardless of Xen.
>> >
>> > * Have the kernel detect Xen EFI capability via Xen, without passing the
>> >   usual native EFI parameters. This can then be installed into the
>> >   kernel in a Xen-specific manner, and we know from the outset that
>> >   Xen-specific caveats apply.
>> >
>> > As per my original email, I'm not against the renaming of the stub
>> > parameters if we standardise the rest of the details, but I believe
>> > that's orthogonal to the Xen Dom0 case.
>> >
>>
>> Xen will not boot the kernel via the stub, but directly. It needs to
>> supply a EFI like environment so that the kernel can boot via ACPI.
>> There is no reason whatsoever to mock up boot services or other pieces
>> of UEFI functionality that are not needed. The core kernel does not
>> call any boot services or SetVirtualAddressMap/ConvertPointer, and
>> there is already paravirtualized plumbing in place for the remaining
>> runtime services.
>>
>> Hence my claim earlier that we should cope with the runtime services
>> pointer being NULL, since that is really the only thing standing in
>
> I suppose that you thought about EFI_INVALID_TABLE_ADDR...
>

Simply whatever we decide, so perhaps EFI_INVALID_TABLE_ADDR is better
if x86 uses that already. But that value is still outside of the UEFI
spec, so in that sense, it is not more appropriate than NULL.

>> the way from the kernel side. If you feel that violates the spec in
>
> If yes then you should know that dom0 on x86 EFI platform works
> with efi.runtime == EFI_INVALID_TABLE_ADDR without any issue.
> So, I think that all problems are solved.
>

So there is precedent, which is good. But please note that x86 has a
lot of baggage and *lots* of quirks for buggy firmware that was only
ever tested with Windows. So before blindly copying x86 when it comes
to UEFI interworking, we still need to have the discussion whether
what x86 is appropriate for ARM as well (since it does not have the
above problems)

-- 
Ard.
