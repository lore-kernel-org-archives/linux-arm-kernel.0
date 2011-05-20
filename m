From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 20 May 2011 14:37:09 +0200
Subject: [RFC PATCH] shmobile: add arch specific ioremap support
Message-ID: <1305895029-12758-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
---
this is just compile

Best Regards,
J.
 arch/arm/mach-shmobile/include/mach/io.h |    6 ++++++
 arch/arm/mach-shmobile/map_io.c          |   29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/io.h b/arch/arm/mach-shmobile/include/mach/io.h
index 7339fe4..82bdd61 100644
--- a/arch/arm/mach-shmobile/include/mach/io.h
+++ b/arch/arm/mach-shmobile/include/mach/io.h
@@ -6,4 +6,10 @@
 #define __io(a)			((void __iomem *)(a))
 #define __mem_pci(a)		(a)
 
+#define __arch_ioremap	shmobile_ioremap
+#define __arch_iounmap	shmobile_iounmap
+
+void __iomem *shmobile_ioremap(unsigned long phys, size_t size, unsigned int type);
+void shmobile_iounmap(volatile void __iomem *addr);
+
 #endif /* __ASM_MACH_IO_H */
diff --git a/arch/arm/mach-shmobile/map_io.c b/arch/arm/mach-shmobile/map_io.c
index 1a62855..597ee52 100644
--- a/arch/arm/mach-shmobile/map_io.c
+++ b/arch/arm/mach-shmobile/map_io.c
@@ -16,9 +16,11 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mm.h>
 
 #include <mach/common.h>
 
@@ -38,6 +40,33 @@ static struct map_desc shmobile_io_desc[] __initdata = {
 	},
 };
 
+void __iomem *shmobile_ioremap(unsigned long p, size_t size, unsigned int type)
+{
+	int i;
+	struct map_desc *io_desc;
+	phys_addr_t pa;
+
+	for (i = 0; i < ARRAY_SIZE(shmobile_io_desc); i++) {
+		io_desc = &shmobile_io_desc[i];
+		pa = __pfn_to_phys(io_desc->pfn);
+
+		if (p >= pa && p <= (pa + io_desc->length - 1))
+			return (void __iomem *)(p - pa + io_desc->virtual);
+	}
+
+	return __arm_ioremap_caller(p, size, type, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(shmobile_ioremap);
+
+void shmobile_iounmap(volatile void __iomem *addr)
+{
+	unsigned long virt = (unsigned long)addr;
+
+	if (virt >= VMALLOC_START && virt < VMALLOC_END)
+		__iounmap(addr);
+}
+EXPORT_SYMBOL(shmobile_iounmap);
+
 void __init shmobile_map_io(void)
 {
 	iotable_init(shmobile_io_desc, ARRAY_SIZE(shmobile_io_desc));
-- 
1.7.4.1
