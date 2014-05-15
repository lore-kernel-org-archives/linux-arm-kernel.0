From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 15 May 2014 15:53:43 -0700
Subject: [PATCH v6 0/4] live migration dirty bitmap support for ARMv7
In-Reply-To: <20140515185145.GB6164@lvm>
References: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
 <20140515185145.GB6164@lvm>
Message-ID: <53754577.5090404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will do that, I'm sure there will be another iteration :).

On 05/15/2014 11:51 AM, Christoffer Dall wrote:
> On Thu, May 15, 2014 at 11:27:27AM -0700, Mario Smarduch wrote:
>> This is v6 patcheset of live mgiration support for ARMv7.
> 
> migration
> 
> This is an extremely terse cover letter.  It would have been nice with a
> few sentences of which existing features this leverages, which support
> was missing, what the preferred approach is, etc.  Also, links to a wiki
> page or just a few notes on how you did the testing below with which
> user space tools etc. would also have been great.
> 
>>
>> - Tested on two 4-way A15 hardware, QEMU 2-way/4-way SMP guest upto 2GB
>> - Various dirty data rates tested - 2GB/1s ... 2048 pgs/5ms
>> - validated source/destination memory image integrity
>>
>> Changes since v1:
>> - add unlock of VM mmu_lock to prevent a deadlock
>> - moved migratiion active inside mmu_lock acquire for visibility in 2nd stage
>>   data abort handler
>> - Added comments
>>
>> Changes since v2: 
>> - move initial VM write protect to memory region architecture prepare function
>>   (needed to make dirty logging function generic) 
>> - added stage2_mark_pte_ro() - to mark ptes ro - Marc's comment
>> - optimized initial VM memory region write protect to do fewer table lookups -
>>   applied Marc's comment for walking dirty bitmap mask
>> - added pud_addr_end() for stage2 tables, to make the walk 4-level
>> - added kvm_flush_remote_tlbs() to use ARM TLB invalidation, made the generic
>>   one weak, Marc's comment to for generic dirty bitmap log function
>> - optimized walking dirty bit map mask to skip upper tables - Marc's comment
>> - deleted x86,arm kvm_vm_ioctl_get_dirty_log(), moved to kvm_main.c tagged 
>>   the function weak - Marc's comment
>> - changed Data Abort handler pte index handling - Marc's comment
>>
>> Changes since v3:
>> - changed pte updates to reset write bit instead of setting default 
>>   value for existing pte's - Steve's comment
>> - In addition to PUD add 2nd stage >4GB range functions - Steves
>>   suggestion
>> - Restructured initial memory slot write protect function for PGD, PUD, PMD
>>   table walking - Steves suggestion
>> - Renamed variable types to resemble their use - Steves suggestions
>> - Added couple pte helpers for 2nd stage tables - Steves suggestion
>> - Updated unmap_range() that handles 2nd stage tables and identity mappings
>>   to handle 2nd stage addresses >4GB. Left ARMv8 unchanged.
>>
>> Changes since v4:
>> - rebased to 3.15.0-rc1 - 'next' to pickup p*addr_end patches - Gavins comment
>> - Update PUD address end function to support 4-level page table walk
>> - Elimiated 5th patch of the series that fixed unmap_range(), since it was
>>   fixed by Marcs patches.
>>
>> Changes since v5:
>> - Created seperate entry point for VMID TLB flush with no param - Christoffers
>>   comment
>> - Update documentation for kvm_flush_remote_tlbs() - Christoffers comment
>> - Simplified splitting of huge pages - inittial WP and 2nd stage DABT handler
>>   clear the huge page PMD, and use current code to fault in small pages.
>>   Removed kvm_split_pmd().
>>
>> Mario Smarduch (4):
>>   add ARMv7 HYP API to flush VM TLBs without address param
>>   live migration support for initial write protect of VM
>>   live migration support for VM dirty log management
>>   add 2nd stage page fault handling during live migration
>>
>>  arch/arm/include/asm/kvm_asm.h  |    1 +
>>  arch/arm/include/asm/kvm_host.h |   11 ++
>>  arch/arm/include/asm/kvm_mmu.h  |   10 ++
>>  arch/arm/kvm/arm.c              |    8 +-
>>  arch/arm/kvm/interrupts.S       |   11 ++
>>  arch/arm/kvm/mmu.c              |  292 ++++++++++++++++++++++++++++++++++++++-
>>  arch/x86/kvm/x86.c              |   86 ------------
>>  virt/kvm/kvm_main.c             |   84 ++++++++++-
>>  8 files changed, 409 insertions(+), 94 deletions(-)
>>
>> -- 
>> 1.7.9.5
>>
