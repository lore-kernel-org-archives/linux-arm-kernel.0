From: superlibj8301@gmail.com (Richard Lee)
Date: Mon, 12 May 2014 10:19:55 +0800
Subject: [RFC][PATCH 2/2] ARM: ioremap: Add IO mapping space reused support.
In-Reply-To: <1399861195-21087-1-git-send-email-superlibj8301@gmail.com>
References: <1399861195-21087-1-git-send-email-superlibj8301@gmail.com>
Message-ID: <1399861195-21087-3-git-send-email-superlibj8301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the IO mapping, for the same physical address space maybe
mapped more than one time, for example, in some SoCs:
0x20000000 ~ 0x20001000: are global control IO physical map,
and this range space will be used by many drivers.
And then if each driver will do the same ioremap operation, we
will waste to much malloc virtual spaces.

This patch add IO mapping space reused support.

Signed-off-by: Richard Lee <superlibj@gmail.com>
---
 arch/arm/mm/ioremap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index f9c32ba..26a3744 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -260,7 +260,7 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 {
 	const struct mem_type *type;
 	int err;
-	unsigned long addr;
+	unsigned long addr, off;
 	struct vm_struct *area;
 	phys_addr_t paddr = __pfn_to_phys(pfn);
 
@@ -301,6 +301,12 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 	if (WARN_ON(pfn_valid(pfn)))
 		return NULL;
 
+	area = find_vm_area_paddr(paddr, size, &off, VM_IOREMAP);
+	if (area) {
+		addr = (unsigned long)area->addr;
+		return (void __iomem *)(offset + off + addr);
+	}
+
 	area = get_vm_area_caller(size, VM_IOREMAP, caller);
  	if (!area)
  		return NULL;
@@ -410,6 +416,9 @@ void __iounmap(volatile void __iomem *io_addr)
 	if (svm)
 		return;
 
+	if (!vm_area_is_aready_to_free((unsigned long)addr))
+		return;
+
 #if !defined(CONFIG_SMP) && !defined(CONFIG_ARM_LPAE)
 	{
 		struct vm_struct *vm;
-- 
1.8.4
