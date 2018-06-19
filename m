From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 19 Jun 2018 20:26:20 -0000
Subject: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED	L1
 entries
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C64A2363@dbde02.ent.ti.com>
References: <1281262672-27626-1-git-send-email-santosh.shilimkar@ti.com>
 <20100808113403.GA23623@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C64A2363@dbde02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6552EDC@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Sunday, August 08, 2010 5:16 PM
> To: Russell King - ARM Linux
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED
> L1 entries
> 
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> > Sent: Sunday, August 08, 2010 5:04 PM
> > To: Shilimkar, Santosh
> > Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and
> MT_MEMORY_NONACHED
> > L1 entries
> >
> > On Sun, Aug 08, 2010 at 03:47:52PM +0530, Santosh Shilimkar wrote:
> > > @@ -475,6 +486,9 @@ static void __init build_mem_type_table(void)
> > >  	mem_types[MT_LOW_VECTORS].prot_l1 |= ecc_mask;
> > >  	mem_types[MT_HIGH_VECTORS].prot_l1 |= ecc_mask;
> > >  	mem_types[MT_MEMORY].prot_sect |= ecc_mask | cp->pmd;
> > > +	mem_types[MT_MEMORY].prot_pte |= kern_pgprot;
> > > +	mem_types[MT_MEMORY_NONCACHED].prot_sect |= ecc_mask | cp->pmd;
> > > +	mem_types[MT_MEMORY_NONCACHED].prot_pte |= kern_pgprot;
> >
> > This is wrong - it will result in the non-cached memory mapped in as
> > sections having the same cache settings as MT_MEMORY - in other
> > words, probably write back.
> You are right. Will fix this in next version.
> 
Updated version with Russell's comments incorporated.

--------------------------------------------------------------------
>From 23d712c1846d78bdb09979087261911e5d80f014 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Sun, 8 Aug 2010 12:05:25 +0530
Subject: [PATCH 1/3 v2] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONCACHED L1 entries

This patch populates the L1 entries for MT_MEMORY and MT_MEMORY_NONCACHED
types so that at boot-up, we can map memories outside system memory
at page level granularity

Previously the mapping was limiting to section level, which creates
unnecessary additional mapping for which physical memory may not
present. On the newer ARM with speculation, this is dangerous and can
result in untraceable aborts.

The patch is based on inputs from Russell King

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
arch/arm/mm/mmu.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6e1c4f6..3e986a6 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -246,6 +246,9 @@ static struct mem_type mem_types[] = {
 		.domain    = DOMAIN_USER,
 	},
 	[MT_MEMORY] = {
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				L_PTE_USER | L_PTE_EXEC,
+		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
 	},
@@ -254,6 +257,9 @@ static struct mem_type mem_types[] = {
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_NONCACHED] = {
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				L_PTE_USER | L_PTE_EXEC | L_PTE_MT_BUFFERABLE,
+		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
 	},
@@ -411,9 +417,12 @@ static void __init build_mem_type_table(void)
 	 * Enable CPU-specific coherency if supported.
 	 * (Only available on XSC3 at the moment.)
 	 */
-	if (arch_is_coherent() && cpu_is_xsc3())
+	if (arch_is_coherent() && cpu_is_xsc3()) {
 		mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
-
+		mem_types[MT_MEMORY].prot_pte |= L_PTE_SHARED;
+		mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
+		mem_types[MT_MEMORY_NONCACHED].prot_pte |= L_PTE_SHARED;
+	}
 	/*
 	 * ARMv6 and above have extended page tables.
 	 */
@@ -438,7 +447,9 @@ static void __init build_mem_type_table(void)
 		mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
 		mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
 		mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
+		mem_types[MT_MEMORY].prot_pte |= L_PTE_SHARED;
 		mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
+		mem_types[MT_MEMORY_NONCACHED].prot_pte |= L_PTE_SHARED;
 #endif
 	}
 
@@ -475,6 +486,8 @@ static void __init build_mem_type_table(void)
 	mem_types[MT_LOW_VECTORS].prot_l1 |= ecc_mask;
 	mem_types[MT_HIGH_VECTORS].prot_l1 |= ecc_mask;
 	mem_types[MT_MEMORY].prot_sect |= ecc_mask | cp->pmd;
+	mem_types[MT_MEMORY].prot_pte |= kern_pgprot;
+	mem_types[MT_MEMORY_NONCACHED].prot_sect |= ecc_mask;
 	mem_types[MT_ROM].prot_sect |= cp->pmd;
 
 	switch (cp->pmd) {
-- 
1.6.0.4

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-mmu-Setup-MT_MEMORY-and-MT_MEMORY_NONCACHED-L1.patch
Type: application/octet-stream
Size: 3089 bytes
Desc: 0001-ARM-mmu-Setup-MT_MEMORY-and-MT_MEMORY_NONCACHED-L1.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180619/542cd699/attachment.obj>
