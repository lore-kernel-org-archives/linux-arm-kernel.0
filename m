From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 18:06:31 +0100
Subject: [PATCH] ARM: get rid of a few StrongARM cache-related build
	time constants
In-Reply-To: <alpine.LFD.2.00.1107060912490.14596@xanadu.home>
References: <1309919636-20546-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706075542.GK8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107060912490.14596@xanadu.home>
Message-ID: <20110707170631.GB20403@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 09:21:33AM -0400, Nicolas Pitre wrote:
> Could you test this patch as well?  You're the only one I know who might 
> still have access to the affected hardware.

Tested on Assabet, and unfortunately, this doesn't work on its own because
we don't permit iotable_init() to create pages with MT_CACHECLEAN and
MT_MINICLEAN.

<4>BUG: map for 0xe0000000 at 0xfffe0000 can not be mapped using pages, ignoring.
<4>BUG: map for 0xe0004000 at 0xfffe4000 can not be mapped using pages, ignoring.
<4>BUG: map for 0xe0008000 at 0xfffe8000 can not be mapped using pages, ignoring.
<4>BUG: map for 0xe000c000 at 0xfffec000 can not be mapped using pages, ignoring.

The fix is below (probably with offsets):

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 027f118..8aeaf25 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -225,12 +225,16 @@ static struct mem_type mem_types[] = {
 		.domain		= DOMAIN_IO,
 	},
 	[MT_CACHECLEAN] = {
-		.prot_sect = PMD_TYPE_SECT | PMD_SECT_XN,
-		.domain    = DOMAIN_KERNEL,
+		.prot_pte	= L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				  L_PTE_XN,
+		.prot_l1	= PMD_TYPE_TABLE,
+		.domain		= DOMAIN_KERNEL,
 	},
 	[MT_MINICLEAN] = {
-		.prot_sect = PMD_TYPE_SECT | PMD_SECT_XN | PMD_SECT_MINICACHE,
-		.domain    = DOMAIN_KERNEL,
+		.prot_pte	= L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				  L_PTE_XN | L_PTE_MT_MINICACHE,
+		.prot_l1	= PMD_TYPE_TABLE,
+		.domain		= DOMAIN_KERNEL,
 	},
 	[MT_LOW_VECTORS] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
@@ -437,8 +430,6 @@ static void __init build_mem_type_table(void)
 		 * from SVC mode and no access from userspace.
 		 */
 		mem_types[MT_ROM].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
-		mem_types[MT_MINICLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
-		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 
 		if (is_smp()) {
 			/*
@@ -506,16 +488,8 @@ static void __init build_mem_type_table(void)
 	mem_types[MT_MEMORY].prot_pte |= kern_pgprot;
 	mem_types[MT_MEMORY_NONCACHED].prot_sect |= ecc_mask;
 	mem_types[MT_ROM].prot_sect |= cp->pmd;
+	mem_types[MT_CACHECLEAN].prot_pte |= kern_pgprot;
 
-	switch (cp->pmd) {
-	case PMD_SECT_WT:
-		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_WT;
-		break;
-	case PMD_SECT_WB:
-	case PMD_SECT_WBWA:
-		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_WB;
-		break;
-	}
 	printk("Memory policy: ECC %sabled, Data cache %s\n",
 		ecc_mask ? "en" : "dis", cp->policy);
 
