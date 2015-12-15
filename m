From: jcm@redhat.com (Jon Masters)
Date: Mon, 14 Dec 2015 23:51:09 -0500
Subject: [Linaro-acpi] Touching the initrd before paging_init
In-Reply-To: <566DEDFC.909@redhat.com>
References: <566D3090.9090509@redhat.com>
 <20151213165942.GN25034@bivouac.eciton.net>
 <23071B8C-D1F9-47A6-9DB4-B26842150B76@redhat.com>
 <566DEB04.2030806@redhat.com> <566DEDFC.909@redhat.com>
Message-ID: <566F9C3D.4090306@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2015 05:15 PM, Jon Masters wrote:
> On 12/13/2015 05:02 PM, Jon Masters wrote:
>> On 12/13/2015 04:36 PM, Jon Masters wrote:
>>
>>> Just thinking from a parity point of view - if you can do it on x86, it should be
>>> doable on ARM. But that GRUB module approach I quite like!
>>
>> Sorry for top post earlier. Was on my phone. In any case, it looks like
>> the "acpi" command in GRUB currently does an all-or-nothing replace of
>> all of the tables, not just a named table. We need to be able to
>> override e.g. just an DSDT or SSDT with a replacement test one.
> 
> I rescind that. Looking at the GRUB source clarifies things. It will
> copy all host tables, then update the copied version if there are
> additional tables with changes and recalculate checksums/pointers in the
> XSDT etc. I seem to recall having looked at this before a couple years
> ago or something and it might have grown some of the 64-bit XSDT logic
> in that time. Either way, it does seem to do what I wanted. I will
> followup. I'll probably still use the initrd approach for now.

Addendum. I was able to get the initrd based ACPI table override
working...HOWEVER...

*** I had to implement a custom memcpy routine to do so ***

Per some internal suggestions, I tried moving map_mem earlier (prior to
doing boot time ACPI table parsing, in order to avoid needing to abuse
fixmaps to touch the initrd contents), which works. For reading the
ramdisk cpio content (the kernel code still uses a fixmap in the initrd
override driver code to map the newly created tables in memory).

But the reading of that cpio content into the new table locations is
done using the kernel memcpy routine to early_ioremap'd memory (Device
memory), which is architecturally sensitive to missaligned accesses. The
in-kernel memcpy routine only checks the alignment of the source pointed
when it begins copying, and doesn't handle the case that the natural
alignment differs between source and destination. Therefore, the kernel
rolls over and plays dead unless I provide a hacked up jcm_memcpy that
just does byte copies. Then everything "works".

Now sure, the official version of the initrd override code is going to
work differently from my hack I'm never posting that is for bringup of a
specific system, and it will all nicely be done by Linaro and so on, but
per my other thread, I am also not convinced that the kernel's
"optimized" memcpy library routine is behaving correctly in the case
that alignment differs. Surely it should handle the case that the
alignment is off on either side of the source and destination.

Once I figured out what in the heck was going on with memcpy nonsense:

SRAT ACPI table found in initrd [kernel/firmware/acpi/srat.aml][REDACT]
SLIT ACPI table found in initrd [kernel/firmware/acpi/slit.aml][REDACT]
SSDT ACPI table found in initrd [kernel/firmware/acpi/ssdt1.aml][REDACT]
ACPI: Early table checksum verification disabled
ACPI: RSDP REDACTED_ADDRESS REDACT (REDACTED)
ACPI: XSDT REDACTED_ADDRESS REDACT (REDACTED OEM)
ACPI: FACP REDACTED_ADDRESS REDACT (REDACTED OEM)
ACPI: DSDT REDACTED_ADDRESS REDACT (REDACTED OEM)
ACPI: APIC REDACTED_ADDRESS REDACT (REDACTED OEM)
ACPI: SSDT REDACTED_ADDRESS REDACT (REDACTED OEM)
ACPI: Override [SSDT- REDACTED], this is unsafe: tainting kernel

Needless to say rewriting the kernel memcpy library was slightly more
than I planned on doing to get a simple initrd override to work...

Jon.
