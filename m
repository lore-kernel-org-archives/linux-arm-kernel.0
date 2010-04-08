From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Apr 2010 10:48:18 +0100
Subject: [RFC] Prohibit ioremap() on kernel managed RAM
Message-ID: <20100408094818.GD31407@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv6 and above have a restriction whereby aliasing virtual:physical
mappings must not have differing memory type and sharability
attributes.  Strictly, this covers the memory type (strongly ordered,
device, memory), cache attributes (uncached, write combine, write
through, write back read alloc, write back write alloc) and the
shared bit.

However, using ioremap() and its variants on system RAM results in
mappings which differ in these attributes from the main system RAM
mapping.  Other architectures which similar restrictions approch this
problem in the same way - they do not permit ioremap on main system
RAM.

Make ARM behave in the same way, with a WARN_ON() such that users can
be traced and an alternative approach found.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 28c8b95..03f1193 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -268,6 +268,12 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 	if (pfn >= 0x100000 && (__pfn_to_phys(pfn) & ~SUPERSECTION_MASK))
 		return NULL;
 
+	/*
+	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
+	 */
+	if (WARN_ON(pfn_valid(pfn)))
+		return NULL;
+
 	type = get_mem_type(mtype);
 	if (!type)
 		return NULL;
