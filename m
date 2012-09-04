From: robherring2@gmail.com (Rob Herring)
Date: Tue, 04 Sep 2012 07:44:16 -0500
Subject: linux-next: manual merge of the arm-soc tree with the arm-current
 tree
In-Reply-To: <20120904090132.GG24085@n2100.arm.linux.org.uk>
References: <20120904160626.f1dcb67ebbb145053c49da8c@canb.auug.org.au>
 <201209040808.25103.arnd@arndb.de>
 <20120904090132.GG24085@n2100.arm.linux.org.uk>
Message-ID: <5045F7A0.1090400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2012 04:01 AM, Russell King - ARM Linux wrote:
> On Tue, Sep 04, 2012 at 08:08:24AM +0000, Arnd Bergmann wrote:
>> On Tuesday 04 September 2012, Stephen Rothwell wrote:
>>> Today's linux-next merge of the arm-soc tree got a conflict in
>>> arch/arm/mm/mmu.c between commit a849088aa155 ("ARM: Fix ioremap() of
>>> address zero") from the arm-current tree and commit c2794437091a ("ARM:
>>> Add fixed PCI i/o mapping") from the arm-soc tree.
>>>
>>> I am not sure how to fix this, so I have used the arm-current version of
>>> the change to pmd_empty_section_gap() since that changed the vm->flags.
>>> It may be that just changing the vm->flags value in vm_reserve_area_early()
>>> would be ok?
>>
>> If I read this correctly, we want pci_reserve_io to use VM_ARM_STATIC_MAPPING
>> while pmd_empty_section_gap should use VM_ARM_EMPTY_MAPPING, so we probably
>> want to add a flag argument to the vm_reserve_area_early() function.
> 
> Whereas Rob said to me that both can use VM_ARM_EMPTY_MAPPING when I
> queried this conflict last week.

Right. The PCI i/o reserved area has a dummy physical address of 0 and 
needs to be skipped by ioremap searches. So we don't set 
VM_ARM_STATIC_MAPPING to prevent matches by ioremap. The vm_struct settings
don't really matter when we do the real mapping of the i/o space.

Here's my merge:

diff --cc arch/arm/mm/mmu.c
index 4c2d045,c2fa21d,512b2c0..18144e6
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@@@ -785,6 -785,6 -786,19 +786,19 @@@@ void __init iotable_init(struct map_des
        }
   }
   
++ void __init vm_reserve_area_early(unsigned long addr, unsigned long size,
++                                void *caller)
++ {
++      struct vm_struct *vm;
++ 
++      vm = early_alloc_aligned(sizeof(*vm), __alignof__(*vm));
++      vm->addr = (void *)addr;
++      vm->size = size;
  -     vm->flags = VM_IOREMAP | VM_ARM_STATIC_MAPPING;
+++     vm->flags = VM_IOREMAP | VM_ARM_EMPTY_MAPPING;
++      vm->caller = caller;
++      vm_area_add_early(vm);
++ }
++ 
   #ifndef CONFIG_ARM_LPAE
   
   /*
