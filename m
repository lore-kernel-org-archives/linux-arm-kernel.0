From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:35 -0500
Subject: [PATCH 17/23] ARM: move initialization of the high_memory variable
 earlier
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-18-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Some upcoming changes must know the VMALLOC_START value, which is based
on high_memory, before bootmem_init() is called.

The best location to set it is in sanity_check_meminfo() where the needed
computation is already done, and in the non MMU case it is trivial to do
now that the meminfo array is already sorted at that point.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mm/init.c  |    2 --
 arch/arm/mm/mmu.c   |    1 +
 arch/arm/mm/nommu.c |    2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index d366051e14..786adddf1a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -381,8 +381,6 @@ void __init bootmem_init(void)
 	 */
 	arm_bootmem_free(min, max_low, max_high);
 
-	high_memory = __va(((phys_addr_t)max_low << PAGE_SHIFT) - 1) + 1;
-
 	/*
 	 * This doesn't seem to be used by the Linux memory manager any
 	 * more, but is used by ll_rw_block.  If we can get rid of it, we
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index dc8c550e6c..0aa8b7d5b2 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -860,6 +860,7 @@ void __init sanity_check_meminfo(void)
 	}
 #endif
 	meminfo.nr_banks = j;
+	high_memory = __va(lowmem_limit - 1) + 1;
 	memblock_set_current_limit(lowmem_limit);
 }
 
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 941a98c9e8..9348730a6b 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -29,6 +29,8 @@ void __init arm_mm_memblock_reserve(void)
 
 void __init sanity_check_meminfo(void)
 {
+	phys_addr_t end = bank_phys_end(&meminfo.bank[meminfo.nr_banks - 1]);
+	high_memory = __va(end - 1) + 1;
 }
 
 /*
-- 
1.7.7.1.431.g10b2a
