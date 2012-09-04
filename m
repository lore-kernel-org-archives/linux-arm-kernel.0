From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 4 Sep 2012 23:03:23 +1000
Subject: linux-next: manual merge of the arm-soc tree with the
 arm-current tree
In-Reply-To: <5045F7A0.1090400@gmail.com>
References: <20120904160626.f1dcb67ebbb145053c49da8c@canb.auug.org.au>
 <201209040808.25103.arnd@arndb.de>
 <20120904090132.GG24085@n2100.arm.linux.org.uk>
 <5045F7A0.1090400@gmail.com>
Message-ID: <20120904230323.4e7e4a9b1b73644ef44236cd@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, 04 Sep 2012 07:44:16 -0500 Rob Herring <robherring2@gmail.com> wrote:
>
> Right. The PCI i/o reserved area has a dummy physical address of 0 and 
> needs to be skipped by ioremap searches. So we don't set 
> VM_ARM_STATIC_MAPPING to prevent matches by ioremap. The vm_struct settings
> don't really matter when we do the real mapping of the i/o space.
> 
> Here's my merge:

Thanks, I shall use this in tomorrow's tree.

> diff --cc arch/arm/mm/mmu.c
> index 4c2d045,c2fa21d,512b2c0..18144e6
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@@@ -785,6 -785,6 -786,19 +786,19 @@@@ void __init iotable_init(struct map_des
>         }
>    }
>    
> ++ void __init vm_reserve_area_early(unsigned long addr, unsigned long size,
> ++                                void *caller)
> ++ {
> ++      struct vm_struct *vm;
> ++ 
> ++      vm = early_alloc_aligned(sizeof(*vm), __alignof__(*vm));
> ++      vm->addr = (void *)addr;
> ++      vm->size = size;
>   -     vm->flags = VM_IOREMAP | VM_ARM_STATIC_MAPPING;
> +++     vm->flags = VM_IOREMAP | VM_ARM_EMPTY_MAPPING;
> ++      vm->caller = caller;
> ++      vm_area_add_early(vm);
> ++ }
> ++ 

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120904/6b1ea622/attachment.sig>
