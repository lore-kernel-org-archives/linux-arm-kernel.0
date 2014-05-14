From: superlibj8301@gmail.com (Richard Lee)
Date: Wed, 14 May 2014 16:18:52 +0800
Subject: [PATCHv2 2/2] ARM: ioremap: Add IO mapping space reused support.
In-Reply-To: <1400055532-13134-1-git-send-email-superlibj8301@gmail.com>
References: <1400055532-13134-1-git-send-email-superlibj8301@gmail.com>
Message-ID: <1400055532-13134-3-git-send-email-superlibj8301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the IO mapping, the same physical address space maybe
mapped more than one time, for example, in some SoCs:
  - 0x20001000 ~ 0x20001400 --> 1KB for Dev1
  - 0x20001400 ~ 0x20001800 --> 1KB for Dev2
  and the page size is 4KB.

Then both Dev1 and Dev2 will do ioremap operations, and the IO
vmalloc area's virtual address will be aligned down to 4KB, and
the size will be aligned up to 4KB. That's to say, only one
4KB size's vmalloc area could contain Dev1 and Dev2 IO mapping area
at the same time.

For this case, we can ioremap only one time, and the later ioremap
operation will just return the exist vmalloc area.

This patch add IO mapping space reused support.

Signed-off-by: Richard Lee <superlibj8301@gmail.com>
---
 arch/arm/mm/ioremap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index f9c32ba..be69333 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -301,6 +301,12 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 	if (WARN_ON(pfn_valid(pfn)))
 		return NULL;
 
+	area = find_vm_area_paddr(paddr, size, &offset, VM_IOREMAP);
+	if (area) {
+		addr = (unsigned long)area->addr;
+		return (void __iomem *)(offset + addr);
+	}
+
 	area = get_vm_area_caller(size, VM_IOREMAP, caller);
  	if (!area)
  		return NULL;
-- 
1.8.4
