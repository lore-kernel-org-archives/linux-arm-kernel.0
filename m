From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Aug 2015 12:09:36 +0100
Subject: [PATCH v1 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <1440489885.10987.26.camel@linaro.org>
References: <1439977055-1747-1-git-send-email-leo.yan@linaro.org>
 <1439977055-1747-4-git-send-email-leo.yan@linaro.org>
 <20150821184059.GB2000@svinekod>
 <20150824091845.GA28290@leoy-linaro>
 <20150824095144.GA7139@leverpostej>
 <1440411596.3517.12.camel@linaro.org>
 <20150824124800.GD7139@leverpostej>
 <1440489885.10987.26.camel@linaro.org>
Message-ID: <20150825110936.GC13471@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 25, 2015 at 09:04:45AM +0100, Haojian Zhuang wrote:
> On Mon, 2015-08-24 at 13:48 +0100, Mark Rutland wrote:
> > > > > > I don't see why you need reserved-memory here, given you're not referring to
> > > > > > these regions by phandle anyway.
> > > > > 
> > > > > - Now we have enabled EFI_STUB, so the memory node will be removed in
> > > > >   kernel:
> > > > >     efi_entry()
> > > > >       \-> allocate_new_fdt_and_exit_boot()
> > > > >             \-> update_fdt();
> > > > > 
> > > > >   Finally in kernel it cannot use memory node to carve out reseved
> > > > >   memory regions.
> > > > > 
> > > > > - On the other hand, DTS's the memory node is to "describes the
> > > > >   physical memory layout for the system"; so it's better to use it only
> > > > >   to describe the hardware info for memory. We can use reserved-memory
> > > > >   to help manage the memory regions which are reserved from software
> > > > >   perspective.
> > > > 
> > > > The fact that you have no-map means that the memory should not be
> > > > described to the kernel as mappable in the first place. It's wrong to
> > > > place such memory in the memory node, even if listed in reserved-memory.
> > > > 
> > > > If your EFI memory map describes the memory as mappable, it is wrong.
> > > 
> > > When kernel is working, kernel will create its own page table based on
> > > UEFI memory map. Since it's reserved in DTS file as Leo's patch, it'll
> > > be moved to reserved memblock. Why is it wrong?
> > 
> > That is a _Linux_ detail, not a _UEFI_ detail.
> > 
> > Anything which only handles UEFI and knows nothing of reserved-memory
> > (e.g. GRUB) will be broken and/or break the Linux use of the region, as
> > it will happily try to allocate memory in the region (and could even
> > decide to reserve it permanently for its own usage).
> > 
> > If the memory is truly specific to the mailbox, then UEFI needs to know
> > that it is reserved as such. If it is not, then it need not be described
> > in the DT and can be allocated dynamically by the kernel.
> 
> No. We support both UEFI and uboot on hikey. We must reserve these
> mailbox buffer in DT. Otherwise, it's a problem to support uboot.

The same solution applies to both: don't describe the memory in the
first place. Don't place it in a memory node, and don't give it
attributes allowing it to be mapped and used in the UEFI memory map.

> We should only deliver one kernel and one DTB to support both UEFI and
> uboot.

I do not disagree with this point generally, but it's irrelevant to the
point at hand.

> And mailbox driver is already upgraded from beginning. Nobody can say
> that it won't be upgraded again in the future.

This doesn't follow. If you want to pointlessly change things, you will
encounter pain. That's not an argument for hacking a partial solution
into the DT and ignoring the problems this causes.

As I tried to ask earlier, how is the mailbox memory used? Does the
kernel configure the address in the hardware, or is this pre-configured?
Could the kernel choose a region of memory to use dynamically?

> By the way, UEFI is loaded in the upper memory region of hikey. It won't
> break anything in linux kernel.

The code might be there, but UEFI can make use of any memory it knows
about for stacks, pool allocations and so on. It needs to be prevented
from using the mailbox memory.

> > > In the second, UEFI is firmware. When it's stable, nobody should change
> > > it without any reason. These reserved memory are used in mailbox driver.
> > > Look. It's driver, so it could be changed at any time. Why do you want
> > > to UEFI knowing this memory range? Do you hope UEFI to change when
> > > mailbox driver is changed?
> > 
> > It shouldn't need to change if that memory is truly reserved for the
> > sole use of the mailbox. If that's not the case then we have a different
> > issue.
> > 
> > If the memory range to use can be allocated by the driver, then I don't
> > see why it should be described in reserved-memory. It certainly should
> > not require a no-map attribute.
> > 
> > Additionally, the driver needs to ensure that the requisite cache
> > maintenance takes place prior to the use of the memory region given
> > prior agents may have ampped it as cacheable, leaving stale (perhaps
> > dirty) lines in the caches.
> > 
> 
> Since those mailbox buffer is declared as reserved with "no-map"
> property, it means that linux kernel won't create the page table of
> them.

I am well aware of how this works. Please re-read my replies, this is
not the issue I describe.

> The meaning of "no-map" is removing it from memory memblock.
> setup_arch()
>   |
>   ---> efi_init() -- Get memory map information from UEFI
>   |
>   ---> arm64_memblock_init()
>   |      |
>   |      ---> early_init_fdt_scan_reserved_mem()
>   |           Get reserved memory buffer from DT. Split memory
>   |           memblock according to reserved buffer.
>   ---> paging_init()
>          |--> map_mem()
>               _Only_ map the discrete memory memblock into kernel
>               page table.
> 
> From this working flow, we could know that those mailbox buffers
> won't be mapped into kernel page table. So there's no concern on
> cache maintenance.

This is simply not true. If UEFI (or any UEFI application) mapped the
memory as cacheable in the past, you need to perform cache maintenance
to get rid of any stale (dirty) cachelines.

This is one of the reasons that the UEFI memory map needs to not
describe the memory as being available to be mapped and used, and why
having a reserved-memory node is insufficient.

> > > > > According to upper info, we still need to use reserved-memory node to
> > > > > depict the reserved memory regions. i have no knowledge about EFI_STUB,
> > > > > so please confirm or correct as needed.
> > > > 
> > > > If the memory shouldn't be mapped, it should neither be in the memory
> > > > node nor EFI memory map (with attributes allowing it to be mapped) to
> > > > begin with.
> > > 
> > > As I said above, kernel will create its own page table. When kernel's
> > > page table is working, UEFI's page table is destroying. So the memory
> > > won't be mapped twice at the same time. What's wrong?
> > > > 
> > > > As far as I can see you do not need to use reserved-memory.
> > > 
> > > 1. Are we talking on the same thing? Leo already mentioned that all
> > > memory node in DTB will be destroyed by kernel when EFI_STUB is enabled
> > > on arm. Did you read the source code after his reply?
> > > And you suggested that Leo to use discrete memory region in DTB. It is
> > > really wrong. Kernel only gets memory map information from UEFI, not
> > > DTB.
> > 
> > I did _not_ suggest that Leo use discrete memory. I suggested that
> > reserved regions should not be described in the memory node (the same
> > premise applying to the UEFI memory map).
> 
> I agree that reserved region shouldn't be described in the memory node.
> And Leo didn't describe reserved region in memory node too.

The issue is that the region you describe in reserved-memory also falls
within an existing region in a memory node (or the UEFI memory map).

The no-map forces a memblock_remove after the memory was added to
memblock, but before it was mapped. This ensures Linux won't map the
memory. This does not ensure that UEFI or UEFI application will not map,
reserve, or use the memory for their own purposes.

> > w.r.t. UEFI, please see my comments above. If you're using the UEFI
> > memory map, you have to use the UEFI memory map, not the UEFI memory map
> > with additional (non-UEFI) caveats applied atop.
> 
> The main concern is that we're supporting both UEFI and uboot.
> Declaring these reserved buffer in DTB will be a better choice.

Unfortunately this is insufficient. This leaves a slew of problems when
using UEFI, and given that, it's not a common solution.

Using reserved-memory in this case only gives a semblance of
correctness, but doesn't mean you are doing the right thing.

> > > 4. Again and again. Memory node should be only used to describe the
> > > RAM information.
> > 
> > The memory node describes the memory available to the OS. There are some
> > caveats w.r.t. /memreserve/, regions which may be mapped but remain
> > unused and so on, but the memory node does generally encode a policy
> > that the memory may be used.
> > 
> > Describing unusable memory in a memory node is pointless, and has an
> > adverse effect on clients which don't support reserved-memory. It's
> > doubly harmful when that memory should never be mapped.
> > 
> 
> He didn't declare those buffer in memory node. He only declared it
> in reserved-memory node. And it's not never be mapped. He use ioremap()
> in the driver.

If the memory is not in the memory nodes nor the UEFI memory map, there
is no need for a reserved-memory entry. If it exists in the UEFI memory
map, the reserved-memory entry is insufficient for the reasons I have
stated previously.

Likewise for the MCU firmware memory.

Thanks,
Mark.
