From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jun 2012 23:07:44 +0100
Subject: Another CMA build warning
Message-ID: <20120605220744.GB29782@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's another build warning, found by the latest OMAP randconfig build
in my build system.

arch/arm/mm/init.c:380: warning: comparison of distinct pointer types lacks a cast

caused by commit c79095092 (ARM: integrate CMA with DMA-mapping subsystem)
which adds:

+       dma_contiguous_reserve(min(arm_dma_limit, arm_lowmem_limit));


arch/arm/mm/mmu.c:phys_addr_t arm_lowmem_limit __initdata = 0;
arch/arm/mm/init.c:u32 arm_dma_limit;

Those are two potentially dis-similar types, so min() should not be used.
Use min_t() instead, or change arm_dma_limit to be phys_addr_t too, which
might make more sense.
