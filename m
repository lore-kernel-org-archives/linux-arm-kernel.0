From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Apr 2013 10:09:56 +0200
Subject: [PATCH v2 6/7] ARM: KVM: switch to a dual-step HYP init code
In-Reply-To: <CAEDV+gK5P+8TEaQoqLoR6a2JWV+kP2tHwShK25tf+xD4k26OdA@mail.gmail.com>
References: <1365435403-29265-1-git-send-email-marc.zyngier@arm.com>
 <1365435403-29265-7-git-send-email-marc.zyngier@arm.com>
 <20130409091813.GC24090@mudshark.cambridge.arm.com>
 <5163F0B0.2000400@arm.com>
 <CAEDV+gK5P+8TEaQoqLoR6a2JWV+kP2tHwShK25tf+xD4k26OdA@mail.gmail.com>
Message-ID: <77d236959fe1da1865e8dce60e475479@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Apr 2013 11:28:07 -0700, Christoffer Dall
<cdall@cs.columbia.edu>
wrote:
> On Tue, Apr 9, 2013 at 3:42 AM, Marc Zyngier <marc.zyngier@arm.com>
wrote:
>> On 09/04/13 10:18, Will Deacon wrote:
>>> On Mon, Apr 08, 2013 at 04:36:42PM +0100, Marc Zyngier wrote:
>>>> Our HYP init code suffers from two major design issues:
>>>> - it cannot support CPU hotplug, as we tear down the idmap very early
>>>> - it cannot perform a TLB invalidation when switching from init to
>>>>   runtime mappings, as pages are manipulated from PL1 exclusively
>>>>
>>>> The hotplug problem mandates that we keep two sets of page tables
>>>> (boot and runtime). The TLB problem mandates that we're able to
>>>> transition from one PGD to another while in HYP, invalidating the
TLBs
>>>> in the process.
>>>>
>>>> To be able to do this, we need to share a page between the two page
>>>> tables. A page that will have the same VA in both configurations. All
>>>> we
>>>> need is a VA that has the following properties:
>>>> - This VA can't be used to represent a kernel mapping.
>>>> - This VA will not conflict with the physical address of the kernel
>>>> text
>>>>
>>>> The vectors page seems to satisfy this requirement:
>>>> - The kernel never maps anything else there
>>>> - The kernel text being copied at the beginning of the physical
memory,
>>>>   it is unlikely to use the last 64kB (I doubt we'll ever support KVM
>>>>   on a system with something like 4MB of RAM, but patches are very
>>>>   welcome).
>>>>
>>>> Let's call this VA the trampoline VA.
>>>>
>>>> Now, we map our init page at 3 locations:
>>>> - idmap in the boot pgd
>>>> - trampoline VA in the boot pgd
>>>> - trampoline VA in the runtime pgd
>>>>
>>>> The init scenario is now the following:
>>>> - We jump in HYP with four parameters: boot HYP pgd, runtime HYP pgd,
>>>>   runtime stack, runtime vectors
>>>> - Enable the MMU with the boot pgd
>>>> - Jump to a target into the trampoline page (remember, this is the
same
>>>>   physical page!)
>>>> - Now switch to the runtime pgd (same VA, and still the same physical
>>>>   page!)
>>>> - Invalidate TLBs
>>>> - Set stack and vectors
>>>> - Profit! (or eret, if you only care about the code).
>>>>
>>>> Note that we keep the boot mapping permanently (it is not strictly an
>>>> idmap anymore) to allow for CPU hotplug in later patches.
>>>>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---

[...]

>>>>  int kvm_mmu_init(void)
>>>>  {
>>>> -       unsigned long hyp_idmap_start =
>>>> virt_to_phys(__hyp_idmap_text_start);
>>>> -       unsigned long hyp_idmap_end =
>>>> virt_to_phys(__hyp_idmap_text_end);
>>>>         int err;
>>>>
>>>> +       hyp_idmap_start = virt_to_phys(__hyp_idmap_text_start);
>>>> +       hyp_idmap_end = virt_to_phys(__hyp_idmap_text_end);
>>>> +       hyp_idmap_vector = virt_to_phys(__kvm_hyp_init);
>>>> +
>>>> +       if ((hyp_idmap_start ^ hyp_idmap_end) & PAGE_MASK) {
>>>> +               /*
>>>> +                * Our init code is crossing a page boundary.
Allocate
>>>> +                * a bounce page, copy the code over and use that.
>>>> +                */
>>>> +               size_t len = __hyp_idmap_text_end -
>>>> __hyp_idmap_text_start;
>>>> +               phys_addr_t phys_base;
>>>> +
>>>> +               init_bounce_page = kzalloc(PAGE_SIZE, GFP_KERNEL);
>>>> +               if (!init_bounce_page) {
>>>> +                       kvm_err("Couldn't allocate HYP init bounce
>>>> page\n");
>>>> +                       err = -ENOMEM;
>>>> +                       goto out;
>>>> +               }
>>>
>>> Given that you don't really need a lowmem page for the bounce page,
this
>>> might be better expressed using alloc_page and kmap for the memcpy.
>>
>> I'm a bit dubious about that. We have to make sure that the memory is
>> within the 4GB range, and the only flag I can spot for alloc_page is
>> GFP_DMA32, which is not exactly what we want, even if it may work.
>>
>> And yes, we have a problem with platforms having *all* their memory
>> above 4GB.
>>
> 
> now when we're picking at this, do we really need to memset an entire
> page to zero? I know it's nice for debugging, but it is really
> unnecessary and would slow down boot so slightly, no?

Sure, we don't need the page clearing. Not that it would appear anywhere
on the radar, but I'll turn it into a plain kmalloc call.

Thanks,

        M.
-- 
Fast, cheap, reliable. Pick two.
