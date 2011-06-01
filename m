From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Wed,  1 Jun 2011 11:03:23 -0400
Subject: [PATCH 1/3] [v3] davinci: sram: ioremap the davinci_soc_info
	specified sram regions
In-Reply-To: <cover.1306940448.git.bengardiner@nanometrics.ca>
References: <20110601051753.GA5153@game.jcrosoft.org>
	<cover.1306940448.git.bengardiner@nanometrics.ca>
Message-ID: <0787ab1fe2a1db4f18feb4b45f6ba44f90e9da59.1306940448.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current davinci init sets up SRAM in iotables. There has been an observed
failure to boot a da850 with 128K specified in the iotable.

Make the davinci sram allocator -- now based on RMK's consolidated SRAM
support -- do an ioremap of the region specified by the entries in
davinci_soc_info before registering with gen_pool_add_virt().

This commit breaks runtime of davinci boards since the regions that
the sram init is now trying to ioremap have been iomapped by their
iotable entries. The iotable entries will be removed in the patches
to come.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
CC: Sekhar Nori <nsekhar@ti.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

---
Changes since v2:
 * Added Jean-Christophe PLAGNIOL-VILLARD's Ack
Changes since v1:
 * return -ENOMEM if ioremap fails (Sekhar Nori)

---
 arch/arm/mach-davinci/sram.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
index 2c53db2..68b05d5 100644
--- a/arch/arm/mach-davinci/sram.c
+++ b/arch/arm/mach-davinci/sram.c
@@ -8,6 +8,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/init.h>
 
@@ -25,6 +26,7 @@ EXPORT_SYMBOL_GPL(davinci_gen_pool);
  */
 static int __init sram_init(void)
 {
+	void *addr;
 	unsigned len = davinci_soc_info.sram_len;
 
 	if (!len)
@@ -36,8 +38,12 @@ static int __init sram_init(void)
 	if (!davinci_gen_pool)
 		return -ENOMEM;
 
-	WARN_ON(gen_pool_add_virt(davinci_gen_pool, SRAM_VIRT,
-				  davinci_soc_info.sram_phys, len, -1));
+	addr = ioremap(davinci_soc_info.sram_phys, len);
+	if (!addr)
+		return -ENOMEM;
+	if(WARN_ON(gen_pool_add_virt(davinci_gen_pool, addr,
+				  davinci_soc_info.sram_phys, len, -1)))
+		iounmap(addr);
 
 	return 0;
 }
-- 
1.7.4.1
