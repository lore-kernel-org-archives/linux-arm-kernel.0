From: robh@kernel.org (Rob Herring)
Date: Sat, 6 Jun 2015 10:29:06 -0500
Subject: [PATCH v3] ARM: early fixmap support for earlycon
In-Reply-To: <25ac891cd5876d4141e03317bf0d4173@agner.ch>
References: <1433593888-7142-1-git-send-email-stefan@agner.ch>
 <20150606124800.GR7557@n2100.arm.linux.org.uk>
 <25ac891cd5876d4141e03317bf0d4173@agner.ch>
Message-ID: <CAL_JsqJbVu3sOwCb102Lgz1Mad2EAP1kpKV+fo2cxMQTZ9LBHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 6, 2015 at 8:29 AM, Stefan Agner <stefan@agner.ch> wrote:
> On 2015-06-06 14:48, Russell King - ARM Linux wrote:
>> On Sat, Jun 06, 2015 at 02:31:28PM +0200, Stefan Agner wrote:
> <snip>
>>> --- a/arch/arm/include/asm/fixmap.h
>>> +++ b/arch/arm/include/asm/fixmap.h
>>> @@ -6,9 +6,13 @@
>>>  #define FIXADDR_TOP         (FIXADDR_END - PAGE_SIZE)
>>>
>>>  #include <asm/kmap_types.h>
>>> +#include <asm/pgtable.h>
>>>
>>>  enum fixed_addresses {
>>> -    FIX_KMAP_BEGIN,
>>> +    FIX_EARLYCON_MEM_BASE,
>>> +    __end_of_permanent_fixed_addresses,
>>> +
>>> +    FIX_KMAP_BEGIN = __end_of_permanent_fixed_addresses,
>>>      FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
>>>
>>>      /* Support writing RO kernel text via kprobes, jump labels, etc. */
>>> @@ -18,7 +22,14 @@ enum fixed_addresses {
>>>      __end_of_fixed_addresses
>>>  };
>>>
>>> +#define FIXMAP_PAGE_COMMON  (L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN | L_PTE_DIRTY)
>>> +
>>> +#define FIXMAP_PAGE_NORMAL  (FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
>>> +#define FIXMAP_PAGE_IO              (FIXMAP_PAGE_COMMON | L_PTE_MT_DEV_SHARED | L_PTE_SHARED)
>>> +#define FIXMAP_PAGE_NOCACHE FIXMAP_PAGE_IO
>>
>> I'm really not happy with this.  What are the expected semantics of the
>> set_fixmap_nocache() and set_fixmap_offset_nocache() ?  Are they there
>> for mapping a device, or are they there for mapping _memory_ ?
>>
>> I would prefer that FIXMAP_PAGE_NOCACHE is _not_ provided until the
>> semantics of that can be clarified, as there is a difference between the
>> two on ARM.
>
> set_fixmap_nocache is used for PCIe and IO APIC stuff, so actually IO
> devices. However, as far as I understand the x86 page table definitions
> in pgtable_types.h, IO devices are not explicitly uncached on x86. The
> define set_fixmap_nocache make sure IO devices are mapped uncached...
> Maybe set_fixmap_io_nocache instead of set_fixmap_nocache would be more
> appropriate...?
>
> Maybe the initial authors of the common fixmap.h have a more clear
> understanding of the expected semantics, Mark?

They should be the same as ioremap and ioremap_nocache which are
aliases of each other on ARM. If you want RAM then you should be using
FIXMAP_PAGE_NORMAL. Perhaps we can come up with some error checking
here.

> Since the focus currently is on set_fixmap_io, we could define
> FIXMAP_PAGE_IO only for the time being...?

We could, but I think it is better to sort this out now.

Rob
