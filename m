From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat, 15 Sep 2012 11:34:36 -0400
Subject: [PATCH 01/15] ARM: add mem_type prot_pte accessor
In-Reply-To: <20120915153359.21241.86002.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
Message-ID: <20120915153436.21241.95691.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The KVM hypervisor mmu code requires access to the mem_type prot_pte
field when setting up page tables pointing to a device. Unfortunately,
the mem_type structure is opaque.

Add an accessor (get_mem_type_prot_pte()) to retrieve the prot_pte
value.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/mach/map.h |    1 +
 arch/arm/mm/mmu.c               |    6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index a6efcdd..3787c9f 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -37,6 +37,7 @@ extern void iotable_init(struct map_desc *, int);
 
 struct mem_type;
 extern const struct mem_type *get_mem_type(unsigned int type);
+extern pteval_t get_mem_type_prot_pte(unsigned int type);
 /*
  * external interface to remap single page with appropriate type
  */
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4c2d045..76bf4f5 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -301,6 +301,12 @@ const struct mem_type *get_mem_type(unsigned int type)
 }
 EXPORT_SYMBOL(get_mem_type);
 
+pteval_t get_mem_type_prot_pte(unsigned int type)
+{
+	return get_mem_type(type)->prot_pte;
+}
+EXPORT_SYMBOL(get_mem_type_prot_pte);
+
 /*
  * Adjust the PMD section entries according to the CPU in use.
  */
