From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 22 May 2011 11:04:40 +0200
Subject: [RFC PATCH 2/2] omap: switch to ioremap function pointer
In-Reply-To: <1306055080-30420-1-git-send-email-plagnioj@jcrosoft.com>
References: <1306055080-30420-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1306055080-30420-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-omap1/io.c             |    3 +++
 arch/arm/mach-omap2/io.c             |    4 ++++
 arch/arm/plat-omap/include/plat/io.h |    2 ++
 arch/arm/plat-omap/io.c              |    6 ++++++
 4 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 870886a..ca80286 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -99,6 +99,9 @@ void __init omap1_map_common_io(void)
 	local_flush_tlb_all();
 	flush_cache_all();
 
+	/* we set the arch_ioremap and arch_iounmap */
+	omap_set_ioremap();
+
 	/* We want to check CPU revision early for cpu_is_omapxxxx() macros.
 	 * IO space mapping must be initialized before we can do that.
 	 */
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 441e79d..a178f9d 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -249,6 +249,10 @@ static void __init _omap2_map_common_io(void)
 	flush_cache_all();
 
 	omap2_check_revision();
+
+	/* we set the arch_ioremap and arch_iounmap */
+	omap_set_ioremap();
+
 	omap_sram_init();
 }
 
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index d72ec85..75c7a68 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -309,6 +309,8 @@ extern void omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
 void __iomem *omap_ioremap(unsigned long phys, size_t size, unsigned int type);
 void omap_iounmap(volatile void __iomem *addr);
 
+void __init omap_set_ioremap(void);
+
 #endif
 
 #endif
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index f1ecfa9..285a0d4 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -23,6 +23,12 @@
 #define BETWEEN(p,st,sz)	((p) >= (st) && (p) < ((st) + (sz)))
 #define XLATE(p,pst,vst)	((void __iomem *)((p) - (pst) + (vst)))
 
+void __init omap_set_ioremap(void)
+{
+	arch_ioremap = omap_ioremap;
+	arch_iounmap = omap_iounmap;
+}
+
 /*
  * Intercept ioremap() requests for addresses in our fixed mapping regions.
  */
-- 
1.7.4.1
