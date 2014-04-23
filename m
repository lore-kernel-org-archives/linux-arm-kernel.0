From: robherring2@gmail.com (Rob Herring)
Date: Wed, 23 Apr 2014 12:09:00 -0500
Subject: kdump for ARM Linux?
In-Reply-To: <CAGT-Hga-0zMCaSfj0PuLfX0dBTzEf8ONBKAeJrDoy4i0B1nDEQ@mail.gmail.com>
References: <132601cf5e89$94556a70$bd003f50$@gmail.com>
 <CAL_JsqKRqyQUMdDBavh5vfQAq9bNZ7OCSdooqOKiPGX8eOGPSw@mail.gmail.com>
 <CAGT-Hga-0zMCaSfj0PuLfX0dBTzEf8ONBKAeJrDoy4i0B1nDEQ@mail.gmail.com>
Message-ID: <CAL_JsqJ9i+8k3Mpq1rBK99tbCZ+b8ND3QJwnoPj6Jf1zuC2zsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 11:51 AM, Andrew Nicholas
<andy.nicholas.work@gmail.com> wrote:
>
>
>
> On Tue, Apr 22, 2014 at 6:36 PM, Rob Herring <robherring2@gmail.com> wrote:
>>
>> On Tue, Apr 22, 2014 at 7:18 PM, Andy Nicholas
>> <andy.nicholas.work@gmail.com> wrote:
>
>
>>
>> > Has this issue been addressed in any version of an ARM Linux kernel? Or,
>> > is
>> > there a work-around? If not, how does a crashdump file get generated
>> > when/if
>> > the kernel crashes or a driver faults?
>> >
>> >>> arch/arm/mm/ioremap.c:244
>> >>>        /*
>> >>>          * Don't allow RAM to be mapped - this causes problems with
>> > ARMv6+
>> >>>          */
>> >>>         if (WARN_ON(pfn_valid(pfn)))
>> >>>                 return NULL;
>> >
>> > Thanks in advance for any help.
>>
>> This is on purpose as the comment says because 2 mappings of different
>> types (of memory attributes) is undefined behavior on ARMv6+. RAM is
>> normal memory type and mmio devices are device memory. This check
>> could possibly be relaxed in the case the memory type is compatible
>> with normal RAM mappings. Then perhaps ioremap_cache could be used on
>> RAM for kdump.
>
>
> Thanks. I'm not very familiar with this code-path and looking at the code it
> seems one possibility is that pfn_valid() is returning false due to
> misconfiguration
> of the kernel.
>
> Considering that the -normal- kdump path to create the /proc/vmcore dumpfile
> via
> parse_crash_elf32_headers appears to use __arm_ioremap in order to copy the
> old memory from the old (presumably crashed) kernel -- this means that no
> one
> with an ARMv7 platform has ever gotten a dumpfile via kdump?

Why v7? I don't think kdump would work on any ARM platform since the
pfn_valid check was added. I'm not too surprised as kexec/kdump seem
to be rarely used in practice and frequently broken.

Something like this is what I had in mind. Alternatively, avoiding
ioremap entirely might be a better solution. I think kmap_atomic could
be used instead of ioremap.

diff --git a/arch/arm/kernel/crash_dump.c b/arch/arm/kernel/crash_dump.c
index 5d1286d..1adca4e 100644
--- a/arch/arm/kernel/crash_dump.c
+++ b/arch/arm/kernel/crash_dump.c
@@ -39,7 +39,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
        if (!csize)
                return 0;

-       vaddr = ioremap(__pfn_to_phys(pfn), PAGE_SIZE);
+       vaddr = ioremap_cache(__pfn_to_phys(pfn), PAGE_SIZE);
        if (!vaddr)
                return -ENOMEM;

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index f9c32ba..0cd30d6 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -298,7 +298,7 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
        /*
         * Don't allow RAM to be mapped - this causes problems with ARMv6+
         */
-       if (WARN_ON(pfn_valid(pfn)))
+       if (WARN_ON(pfn_valid(pfn) && mtype != MT_DEVICE_CACHED))
                return NULL;

        area = get_vm_area_caller(size, VM_IOREMAP, caller);
