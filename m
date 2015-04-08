From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 08 Apr 2015 10:45:24 +0100
Subject: [PATCH 4/6] ARM: keystone2: rename init_meminfo to pv_fixup
In-Reply-To: <20150408094438.GM12732@n2100.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
Message-ID: <E1YfmY0-0006Wz-Tz@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init_meminfo() method is not about initialising meminfo - it's about
fixing up the physical to virtual translation so that we use a different
physical address space, possibly above the 4GB physical address space.
Therefore, the name "init_meminfo()" is confusing.

Rename it to pv_fixup() instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/arch.h  | 2 +-
 arch/arm/mach-keystone/keystone.c | 4 ++--
 arch/arm/mm/mmu.c                 | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index e881913f7c3e..cb3a40717edd 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -51,7 +51,7 @@ struct machine_desc {
 	bool			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **);
 	void			(*dt_fixup)(void);
-	long long		(*init_meminfo)(void);
+	long long		(*pv_fixup)(void);
 	void			(*reserve)(void);/* reserve mem blocks	*/
 	void			(*map_io)(void);/* IO mapping function	*/
 	void			(*init_early)(void);
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index af8c92bc8188..e288010522f9 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -68,7 +68,7 @@ static phys_addr_t keystone_virt_to_idmap(unsigned long x)
 	return (phys_addr_t)(x) - CONFIG_PAGE_OFFSET + KEYSTONE_LOW_PHYS_START;
 }
 
-static long long __init keystone_init_meminfo(void)
+static long long __init keystone_pv_fixup(void)
 {
 	long long offset;
 	phys_addr_t mem_start, mem_end;
@@ -108,5 +108,5 @@ DT_MACHINE_START(KEYSTONE, "Keystone")
 	.smp		= smp_ops(keystone_smp_ops),
 	.init_machine	= keystone_init,
 	.dt_compat	= keystone_match,
-	.init_meminfo   = keystone_init_meminfo,
+	.pv_fixup	= keystone_pv_fixup,
 MACHINE_END
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 657b50085942..4eab87eab5aa 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1404,7 +1404,7 @@ void __init early_paging_init(const struct machine_desc *mdesc,
 	phys_addr_t phys;
 	int i;
 
-	if (!(mdesc->init_meminfo))
+	if (!mdesc->pv_fixup)
 		return;
 
 	/* remap kernel code and data */
@@ -1420,7 +1420,7 @@ void __init early_paging_init(const struct machine_desc *mdesc,
 	pudk = pud_offset(pgdk, map_start);
 	pmdk = pmd_offset(pudk, map_start);
 
-	offset = mdesc->init_meminfo();
+	offset = mdesc->pv_fixup();
 	if (offset == 0)
 		return;
 
@@ -1514,10 +1514,10 @@ void __init early_paging_init(const struct machine_desc *mdesc,
 {
 	long long offset;
 
-	if (!mdesc->init_meminfo)
+	if (!mdesc->pv_fixup)
 		return;
 
-	offset = mdesc->init_meminfo();
+	offset = mdesc->pv_fixup();
 	if (offset == 0)
 		return;
 
-- 
1.8.3.1
