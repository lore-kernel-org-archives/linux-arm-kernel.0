From: jamie@jamieiles.com (Jamie Iles)
Date: Mon,  1 Aug 2011 13:31:10 +0100
Subject: [PATCH 9/9] omap: make __arch_ioremap() with 0 size return NULL
In-Reply-To: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
References: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1312201870-12921-9-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without __arch_ioremap(), __get_vm_area_node() with a zero size will
return a NULL pointer.  Make the arch specific ioremap() do the same
thing.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/plat-omap/io.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index f1ecfa9..e7bc77f 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -28,6 +28,9 @@
  */
 void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 {
+	if (!size)
+		return NULL;
+
 #ifdef CONFIG_ARCH_OMAP1
 	if (cpu_class_is_omap1()) {
 		if (BETWEEN(p, OMAP1_IO_PHYS, OMAP1_IO_SIZE))
-- 
1.7.4.1
