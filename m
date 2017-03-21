From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 19:20:45 +0000
Subject: [PATCH v4 15/28] ARM: Expose the VA/IDMAP offset
In-Reply-To: <20170321192058.9300-1-marc.zyngier@arm.com>
References: <20170321192058.9300-1-marc.zyngier@arm.com>
Message-ID: <20170321192058.9300-16-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The KVM code needs to be able to compute the address of
symbols in its idmap page (the equivalent of a virt_to_idmap()
call). Unfortunately, virt_to_idmap is slightly complicated,
depending on the use of arch_phys_to_idmap_offset or not, and
none of that is readily available at HYP.

Instead, expose a single kimage_voffset variable which contains the
offset between a kernel VA and its idmap address, enabling the
VA->IDMAP conversion. This allows the KVM code to behave similarily
to its arm64 counterpart.

Tested-by: Keerthy <j-keerthy@ti.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4e016d7f37b3..e98a2b5c4e85 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -87,6 +87,8 @@ struct cachepolicy {
 #define s2_policy(policy)	0
 #endif
 
+unsigned long kimage_voffset __ro_after_init;
+
 static struct cachepolicy cache_policies[] __initdata = {
 	{
 		.policy		= "uncached",
@@ -1635,4 +1637,7 @@ void __init paging_init(const struct machine_desc *mdesc)
 
 	empty_zero_page = virt_to_page(zero_page);
 	__flush_dcache_page(NULL, empty_zero_page);
+
+	/* Compute the virt/idmap offset, mostly for the sake of KVM */
+	kimage_voffset = (unsigned long)&kimage_voffset - virt_to_idmap(&kimage_voffset);
 }
-- 
2.11.0
