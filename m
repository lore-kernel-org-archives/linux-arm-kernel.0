From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 May 2011 18:28:37 +0100
Subject: [PATCH v5 03/19] ARM: LPAE: Use unsigned long for
	__phys_to_virt and __virt_to_phys
In-Reply-To: <20110508214437.GP27807@n2100.arm.linux.org.uk>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
	<1304859098-10760-4-git-send-email-catalin.marinas@arm.com>
	<20110508214437.GP27807@n2100.arm.linux.org.uk>
Message-ID: <1305566917.19230.158.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-05-08 at 22:44 +0100, Russell King - ARM Linux wrote:
> On Sun, May 08, 2011 at 01:51:22PM +0100, Catalin Marinas wrote:
> > The !CONFIG_ARM_PATCH_PHYS_VIRT case uses macros for __phys_to_virt and
> > __virt_to_phys but does not use any type casting. This causes issues
> 
> It might be a good idea to include the compiler warning message in the
> commit log, so that the 'issues' being addressed are readily known.

Here's the new log:

    ARM: LPAE: Use unsigned long for __phys_to_virt and __virt_to_phys
    
    The !CONFIG_ARM_PATCH_PHYS_VIRT case uses macros for __phys_to_virt and
    __virt_to_phys but does not use any type casting. This causes compiler
    warnings with LPAE where the phys_addr_t and dma_addr_t are 64-bit:
    
      CC      arch/arm/mm/dma-mapping.o
    In file included from /work/Linux/linux-marc/include/linux/dma-mapping.h:93:0,
                     from /work/Linux/linux-marc/arch/arm/mm/dma-mapping.c:19:
    /work/Linux/linux-marc/arch/arm/include/asm/dma-mapping.h: In function 'dma_to_virt':
    /work/Linux/linux-marc/arch/arm/include/asm/dma-mapping.h:35:9: warning:
            cast to pointer from integer of different size
    
    Note that these macros are only valid for lowmem physical addresses
    where the range is within 32-bit address range.
    
    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
