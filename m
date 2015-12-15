From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 15 Dec 2015 11:43:43 +0000
Subject: [Linaro-acpi] Touching the initrd before paging_init
In-Reply-To: <566F9C3D.4090306@redhat.com> (Jon Masters's message of "Mon, 14
 Dec 2015 23:51:09 -0500")
References: <566D3090.9090509@redhat.com>
 <20151213165942.GN25034@bivouac.eciton.net>
 <23071B8C-D1F9-47A6-9DB4-B26842150B76@redhat.com>
 <566DEB04.2030806@redhat.com> <566DEDFC.909@redhat.com>
 <566F9C3D.4090306@redhat.com>
Message-ID: <yw1xd1u8gcnk.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon Masters <jcm@redhat.com> writes:

> On 12/13/2015 05:15 PM, Jon Masters wrote:
>> On 12/13/2015 05:02 PM, Jon Masters wrote:
>>> On 12/13/2015 04:36 PM, Jon Masters wrote:
>>>
>>>> Just thinking from a parity point of view - if you can do it on x86, it should be
>>>> doable on ARM. But that GRUB module approach I quite like!
>>>
>>> Sorry for top post earlier. Was on my phone. In any case, it looks like
>>> the "acpi" command in GRUB currently does an all-or-nothing replace of
>>> all of the tables, not just a named table. We need to be able to
>>> override e.g. just an DSDT or SSDT with a replacement test one.
>> 
>> I rescind that. Looking at the GRUB source clarifies things. It will
>> copy all host tables, then update the copied version if there are
>> additional tables with changes and recalculate checksums/pointers in the
>> XSDT etc. I seem to recall having looked at this before a couple years
>> ago or something and it might have grown some of the 64-bit XSDT logic
>> in that time. Either way, it does seem to do what I wanted. I will
>> followup. I'll probably still use the initrd approach for now.
>
> Addendum. I was able to get the initrd based ACPI table override
> working...HOWEVER...

Why do you need to override ACPI tables?  Isn't ACPI supposed to be
perfect?

> *** I had to implement a custom memcpy routine to do so ***
>
> Per some internal suggestions, I tried moving map_mem earlier (prior to
> doing boot time ACPI table parsing, in order to avoid needing to abuse
> fixmaps to touch the initrd contents), which works. For reading the
> ramdisk cpio content (the kernel code still uses a fixmap in the initrd
> override driver code to map the newly created tables in memory).
>
> But the reading of that cpio content into the new table locations is
> done using the kernel memcpy routine to early_ioremap'd memory (Device
> memory), which is architecturally sensitive to missaligned accesses.

As others have pointed out, your error is twofold: first using
early_ioremap() when early_memremap() would do, then using regular
memcpy() and not memcpy_fromio() on that.  Seems like your precious ACPI
code is to blame here.

> The in-kernel memcpy routine only checks the alignment of the source
> pointed when it begins copying, and doesn't handle the case that the
> natural alignment differs between source and destination. Therefore,
> the kernel rolls over and plays dead unless I provide a hacked up
> jcm_memcpy that just does byte copies. Then everything "works".

That's the right thing to do for normal memory on ARMv6 and up which
support unaligned accesses.  Hardware unaligned accesses are slightly
slower than aligned, so aligning the loads saves a few cycles.  The
manual shifts required to also align the destination are, however, more
expensive than simply letting the hardware do it.

-- 
M?ns Rullg?rd
