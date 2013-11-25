From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 25 Nov 2013 15:36:36 -0700
Subject: Build breakage from 'ARM: mm: use phys_addr_t appropriately in p2v
 and v2p conversions'
Message-ID: <20131125223636.GA20822@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Santosh,

Testing v3.13-rc1 I see build breakage from this patch:

commit ca5a45c06cd4764fb8510740f7fc550d9a0208d4
Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date:   Wed Jul 31 12:44:41 2013 -0400

    ARM: mm: use phys_addr_t appropriately in p2v and v2p conversions
    
    Fix remainder types used when converting back and forth between
    physical and virtual addresses.
    
    Cc: Russell King <linux@arm.linux.org.uk>
    
    Acked-by: Nicolas Pitre <nico@linaro.org>
    Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


In file included from /scratchl/jgg/3.13/linux/arch/arm/include/asm/page.h:163:0,
                 from /scratchl/jgg/3.13/linux/include/linux/mm_types.h:16,
                 from /scratchl/jgg/3.13/linux/include/linux/sched.h:24,
                 from /scratchl/jgg/3.13/linux/arch/arm/kernel/asm-offsets.c:13:
/scratchl/jgg/3.13/linux/arch/arm/include/asm/memory.h: In function '__virt_to_phys':
/scratchl/jgg/3.13/linux/arch/arm/include/asm/memory.h:244:40: error: 'PHYS_OFFSET' undeclared (first use in this function)
/scratchl/jgg/3.13/linux/arch/arm/include/asm/memory.h:244:40: note: each undeclared identifier is reported only once for each function it appears in
/scratchl/jgg/3.13/linux/arch/arm/include/asm/memory.h: In function '__phys_to_virt':
/scratchl/jgg/3.13/linux/arch/arm/include/asm/memory.h:249:13: error: 'PHYS_OFFSET' undeclared (first use in this function)

My config doesn't set CONFIG_ARM_PATCH_PHYS_VIRT, which means
PHYS_OFFSET is not defined at this point:

static inline phys_addr_t __virt_to_phys(unsigned long x)
{
        return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
}

The definition my config uses follows this path:

#ifndef PHYS_OFFSET
#ifdef PLAT_PHYS_OFFSET
#define PHYS_OFFSET     PLAT_PHYS_OFFSET
#else
#define PHYS_OFFSET     UL(CONFIG_PHYS_OFFSET)
#endif
#endif

Which is after your new inlines..

An elegant fix wasn't obvious to me :)

Regards,
Jason
