From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 7 Nov 2014 12:42:48 +0100
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <20141107113517.GE4585@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <20141031075209.GH3290@darkstar.nay.redhat.com>
 <20141103194634.GA30366@leverpostej>
 <20141106015642.GA2569@darkstar.nay.redhat.com>
 <20141106150846.GE23706@leverpostej>
 <CACxGe6u=J_k3XZxyiyti=i=rtW+a5xxuukg3TgOyM+ra1vAACQ@mail.gmail.com>
 <20141107101642.GA4585@leverpostej>
 <CAKv+Gu9kJ6GHcPm9fa6m84gse9DQat6D54zFD0G0X9od=sYVpw@mail.gmail.com>
 <20141107113517.GE4585@leverpostej>
Message-ID: <CAKv+Gu-t3VrwZcgtx+05Zj3O=yUEgRivFHs3tGBaUdpBZL3ODg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 November 2014 12:35, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Nov 07, 2014 at 10:41:11AM +0000, Ard Biesheuvel wrote:
>> On 7 November 2014 11:16, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Fri, Nov 07, 2014 at 12:41:45AM +0000, Grant Likely wrote:
>> >> On Thu, Nov 6, 2014 at 3:08 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> > On Thu, Nov 06, 2014 at 01:56:42AM +0000, Dave Young wrote:
>> >> >> On 11/03/14 at 07:46pm, Mark Rutland wrote:
>> >> >> > On Fri, Oct 31, 2014 at 07:52:09AM +0000, Dave Young wrote:
>> >> >> > > Hi Geoff
>> >> >> > >
>> >> >> > > I tested your patches. The macihne is using spin-table cpu enable method
>> >> >> > > so I tried maxcpus=1 as you suggested.
>> >> >> > >
>> >> >> > > There's below issues for me, thoughts?
>> >> >> > >
>> >> >> > > 1. For acpi booting there's no /proc/device-tree so kexec can not find dtb
>> >> >> > > to use.
>> >> >> >
>> >> >> > Are you absolutely certain of this?
>> >> >> >
>> >> >> > To use ACPI, you must have booted via EFI, as the only mechanism for
>> >> >> > finding the ACPI tables is via EFI. If booted via EFI, the stub will
>> >> >> > have created a stub DTB if there is no provided DTB, to pass the command
>> >> >> > line and pointers to EFI data structures. This stub DTB should be
>> >> >> > present in the usual place.
>> >> >>
>> >> >> Mark, I used kexec-tools from Geoff's git tree, it will create dtb from procfs
>> >> >> maybe I can pass external dtb to kexec-tools. What you mentioned should be true
>> >> >> though but I have not get idea how to get the dtb which kernel is using for boot
>> >> >> since it is not unflattened.
>> >> >
>> >> > Ah, sorry. I see the problem now. For ACPI you don't unflatten the tree,
>> >> > so there's nothing to expose at in sysfs/procfs.
>> >> >
>> >> > Somehow we need to unflatten the DTB without exposing it to drivers,
>> >> > such that it can be exposed to userspace in the usual place but drivers
>> >> > don't being probing based off of it.
>> >>
>> >> Is that even necessary? If the tree isn't unflattened, then it is just
>> >> a stub tree. There really isn't anything interesting in it.
>> >
>> > We need to UEFI properties [1] from /chosen to access the memory map and
>> > system table (both of which are necessary to access any ACPI tables).
>> >
>> >> Kexec should recreate the tree from scratch in that case.
>> >
>> > I'm not sure if the required information is exposed to userspace
>> > elsewhere. Ard, Leif?
>> >
>>
>> Personally, I think we should not be using /proc/device-tree at all,
>> but instead retain the original blob in some way and expose that.
>
> Grant took objection to that approach previously.
>
>> We already have /sys/firmware/efi/systab which contains the physical
>> addresses of the UEFI configuration tables. We should probably add an
>> entry for the FDT there anyway, but we would still be looking at
>> mmap(/dev/mem) to access it, which is not a practice we want to
>> encourage, I suppose.
>
> We should not encourage use of /dev/mem.
>

Agreed.

> Using /sys/firmware/efi/systab doesn't get us the memory map though,
> unless that's also exposed?
>

The address of the memory map is in /chosen/linux,uefi-mmap-start, but
-as I replied-to-self earlier- the DT UEFI configuration table does
not contain the properties added by the stub, so that is not going to
work anyway.

>> Also, we *must* take the secure boot scenario into account. Booting
>> with an arbitrary user generated DTB is nice, but if you are doing
>> kexec without an initrd, for instance, it would also be nice if we
>> could just reuse the existing DTB without bothering the user for it at
>> all, which would be something we could also allow when running
>> securely.
>
> Secure boot has to be handled completely differently. That will require
> new syscall support, in-kernel purgatory, and so on.
>
> That should not affect the non-secureboot cases where a user wants to
> load their own DTB (or other objects) into memory for the next OS (which
> might not be Linux).
>

OK, fair enough. So ideally, we should expose the binary blob
somewhere, in a similar fashion to how config.gz is exposed, perhaps?

-- 
Ard.
