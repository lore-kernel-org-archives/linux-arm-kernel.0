From: jamie@jamieiles.com (Jamie Iles)
Date: Mon,  1 Aug 2011 13:31:02 +0100
Subject: [PATCH 1/9] davinci: make __arch_ioremap() with 0 size return NULL
Message-ID: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without __arch_ioremap(), __get_vm_area_node() with a zero size will
return a NULL pointer.  Make the arch specific ioremap() do the same
thing.

Cc: Sekhar Nori <nsekhar@ti.com> (supporter:TI DAVINCI MACHIN...)
Cc: Kevin Hilman <khilman@ti.com> (supporter:TI DAVINCI MACHIN...)
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-davinci/io.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/io.c b/arch/arm/mach-davinci/io.c
index 8ea60a8..4eb169b 100644
--- a/arch/arm/mach-davinci/io.c
+++ b/arch/arm/mach-davinci/io.c
@@ -25,6 +25,9 @@ void __iomem *davinci_ioremap(unsigned long p, size_t size, unsigned int type)
 	int desc_num = davinci_soc_info.io_desc_num;
 	int i;
 
+	if (!size)
+		return NULL;
+
 	for (i = 0; i < desc_num; i++, desc++) {
 		unsigned long iophys = __pfn_to_phys(desc->pfn);
 		unsigned long iosize = desc->length;
-- 
1.7.4.1
