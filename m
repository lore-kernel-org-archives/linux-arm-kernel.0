From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 27 Oct 2009 22:40:30 +0000
Subject: [RFC 00/11] Cache handling updates
Message-ID: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For RFC, this series of patches cleans up and updates various aspects
of the kernel's cache handling.  The 'fix errata 411920' patch is one
which I'm intending pushing to mainline once the current set has been
pulled.

A few things of note from this:
1. flush flush_dcache_page, on VIPT aliasing caches, we ended up
   flushing the I-cache multiple times.  This has been fixed.
2. we now avoid flush_dcache_page operating on the ZERO_PAGE (for bss)
3. ZERO_PAGE can now be allocated from highmem
4. reinforced I-cache handling for VIVT ASID-tagged caches (to be more
   like VIVT caches were)
5. fix the RX->RW->RX issue by flushing the I-cache in flush_cache_range()
6. it seems pointless flushing the I-cache of VIPT caches in flush_cache_mm

Russell King (11):
  ARM: Reduce __flush_dcache_page() visibility
  ARM: Fix errata 411920 workarounds
  ARM: move __flush_icache_all() out of flush_pfn_alias()
  ARM: Remove __flush_icache_all() from __flush_dcache_page()
  ARM: Avoid flush_dcache_page() for zero page
  ARM: Avoid duplicated implementation for VIVT cache flushing
  ARM: Allocate ZERO_PAGE from highmem
  ARM: Avoid evaluating page_address() multiple times
  ARM: Add I-cache invalidation for VIVT ASID tagged caches
  ARM: arrange for flush_cache_range() to always flush the I-cache
  ARM: avoid flushing I-cache in flush_cache_mm()

 arch/arm/include/asm/cacheflush.h |   27 ++++++++++---
 arch/arm/mm/context.c             |    4 +-
 arch/arm/mm/fault-armv.c          |    9 ++++
 arch/arm/mm/flush.c               |   74 ++++++++++++++++---------------------
 arch/arm/mm/init.c                |    9 ++++
 arch/arm/mm/mm.h                  |    2 +
 arch/arm/mm/mmu.c                 |   10 -----
 7 files changed, 74 insertions(+), 61 deletions(-)
