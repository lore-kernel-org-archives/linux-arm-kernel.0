From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 7 Feb 2015 01:44:19 +0000
Subject: [Linaro-acpi] [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <20150206141631.GA20549@localhost>
References: <1423066107.18187.99.camel@deneb.redhat.com>
 <20150204175734.GI26006@e104818-lin.cambridge.arm.com>
 <1423076294.18187.103.camel@deneb.redhat.com>
 <20150205104149.GA18158@e104818-lin.cambridge.arm.com>
 <1423144447.18187.110.camel@deneb.redhat.com>
 <54D39D6B.5090304@linaro.org>
 <20150205174826.GD21970@e104818-lin.cambridge.arm.com>
 <CAKv+Gu922UwYRN7ZgFNTR7yGGKPLTU8Us7KbvXX-Q8=rqLKNog@mail.gmail.com>
 <20150206103653.GA23190@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_ExGUkr0AJS4uSHLuz3LxO+x8sxnsnmDAYfVRAgHGXBA@mail.gmail.com>
 <20150206141631.GA20549@localhost>
Message-ID: <CAKv+Gu_E3VUA4yR2RC_gqQ3-zR27NAKB3U48eGWmZdu=OYLx3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 February 2015 at 14:16, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Feb 06, 2015 at 11:08:51AM +0000, Ard Biesheuvel wrote:
>> On 6 February 2015 at 10:36, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Thu, Feb 05, 2015 at 10:16:03PM +0000, Ard Biesheuvel wrote:
>> >> On 5 February 2015 at 17:48, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> >> > On Thu, Feb 05, 2015 at 04:42:19PM +0000, Al Stone wrote:
>> >> >> On 02/05/2015 06:54 AM, Mark Salter wrote:
>> >> >> > On Thu, 2015-02-05 at 10:41 +0000, Catalin Marinas wrote:
>> >> >> >> On Wed, Feb 04, 2015 at 06:58:14PM +0000, Mark Salter wrote:
>> >> >> >>> On Wed, 2015-02-04 at 17:57 +0000, Catalin Marinas wrote:
>> >> >> >>>> On Wed, Feb 04, 2015 at 04:08:27PM +0000, Mark Salter wrote:
>> >> >> >>>>> acpi_os_remap() is used to map ACPI tables. These tables may be in ram
>> >> >> >>>>> which are already included in the kernel's linear RAM mapping. So we
>> >> >> >>>>> need ioremap_cache to avoid two mappings to the same physical page
>> >> >> >>>>> having different caching attributes.
>> >> >> >>>>
>> >> >> >>>> What's the call path to acpi_os_ioremap() on such tables already in the
>> >> >> >>>> linear mapping? I can see an acpi_map() function which already takes
>> >> >> >>>> care of the RAM mapping case but there are other cases where
>> >> >> >>>> acpi_os_ioremap() is called directly. For example,
>> >> >> >>>> acpi_os_read_memory(), can it be called on both RAM and I/O?
>> >> >> >>>
>> >> >> >>> acpi_map() is the one I've seen.
>> >> >> >>
>> >> >> >> By default, if should_use_kmap() is not patched for arm64, it translates
>> >> >> >> to page_is_ram(); acpi_map() would simply use a kmap() which returns the
>> >> >> >> current kernel linear mapping on arm64.
>> >> >> >
>> >> >> > The problem with kmap() is that it only maps a single page. I've seen
>> >> >> > tables over 4k which is why I patched acpi_map() not to use kmap() on
>> >> >> > arm64.
>> >> >>
>> >> >> Right.  Mark replied to this before I could; using kmap() enforced a 4k
>> >> >> (one page) limit that we kept breaking with some ACPI tables being larger
>> >> >> than that (DSDTs and SSDTs, fwiw).  This would lead to some very odd behaviors
>> >> >> when most but not all of a device definition was within the page; using the
>> >> >> table checksums was one way of detecting the issues.
>> >> >
>> >> > OK. So I think Mark's original patch was ok, assuming that the System
>> >> > Memory cases mentioned by Graeme are detected with page_is_ram().
>> >>
>> >> page_is_ram() returns whether a pfn is covered by the linear mapping,
>> >> so memory before the kernel or after a mem= limit will be
>> >> misidentified.
>> >
>> > OK. So in conclusion acpi_os_ioremap() may need to create a cacheable
>> > mapping even when !page_is_ram() but it has no way of knowing that
>> > unless we change the core ACPI code to differentiate between
>> > ioremap_cache and ioremap_nocache. Did I get it right?
>>
>> Yes and no. Your analysis about the core issue is correct, but it is
>> something we can fix on our end if we like.
>> This issue has been on our radar for a while, and we proposed a way to
>> fix it here
>>
>> http://thread.gmane.org/gmane.linux.kernel.efi/5133
>
> I looked at it briefly but it had ACPI in the subject and decided it's
> not urgent ;).
>
> IIUC, it relies on the EFI system table to be available and the kernel
> will register the appropriate "System RAM" resources. This assumes in
> general that the kernel is booted via the EFI stub. Do we expect Xen or
> kexec to pass an EFI system table when not booting via EFI stub?
>

That's just one of the patches, and it is not actually the one that
addresses this issue.
(Registering the iomem resources is mainly to ensure MMIO regions for
the NOR flash or RTC are not claimed by a kernel driver if they are
being driven by the firmware at runtime)

The point of the series is to wire up the 'physmem' memblock table to
record what we know is system RAM, and use that to decide what flavor
of mapping to use. The series as-is addresses the non-UEFI case as
well, the only thing missing is wiring up page_is_ram() to
memblock_is_physmem() (the former is __weak already in the core code,
but perhaps it would be better to just use the latter directly)

With these changes, we no longer have to care whether a reserved
region sits below PHYS_OFFSET or above a mem= limit

Note that, in the non-UEFI case, we may need to consider removing
memreserve regions from the linear mapping. Code that assumes it is
mapped is broken anyway, due to the same concerns outlined above
(i.e., < PHYS_OFFSET or > mem=).
