From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:16:11 +0200
Subject: [PATCH 4/5] soc: renesas: rcar-sysc: Move SYSC interrupt config to
 rcar-sysc driver
In-Reply-To: <cover.1467292648.git.horms+renesas@verge.net.au>
References: <cover.1467292648.git.horms+renesas@verge.net.au>
Message-ID: <053239987f89f9a6299e78610bad010764bccd71.1467292648.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

On R-Car H1 and Gen2, the SYSC interrupt registers are always configured
using hardcoded values in platform code. For R-Car Gen2, values are
provided for H2 and M2-W only, other SoCs are not yet supported, and
never will be.

Move this configuration from SoC-specific platform code to the
rcar_sysc_init() wrapper, so it can be skipped if the SYSC is configured
from DT. This would be the case not only for H1, H2, and M2-W using a
modern DTS, but also for other R-Car Gen2 SoCs not supported by the
platform code, relying purely on DT.

There is no longer a need to return the mapped register block, hence
make the function return void.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-r8a7779.c   |  6 +-----
 arch/arm/mach-shmobile/pm-rcar-gen2.c |  6 +-----
 drivers/soc/renesas/rcar-sysc.c       | 12 ++++++++----
 include/linux/soc/renesas/rcar-sysc.h |  2 +-
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 4174cbcbc467..5c9a93f5e650 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -23,11 +23,7 @@
 
 static void __init r8a7779_sysc_init(void)
 {
-	void __iomem *base = rcar_sysc_init(0xffd85000);
-
-	/* enable all interrupt sources, but do not use interrupt handler */
-	iowrite32(0x0131000e, base + SYSCIER);
-	iowrite32(0, base + SYSCIMR);
+	rcar_sysc_init(0xffd85000, 0x0131000e);
 }
 
 #else /* CONFIG_PM || CONFIG_SMP */
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 691ac166a277..7768fd1bce65 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -37,11 +37,7 @@
 
 static void __init rcar_gen2_sysc_init(u32 syscier)
 {
-	void __iomem *base = rcar_sysc_init(0xe6180000);
-
-	/* enable all interrupt sources, but do not use interrupt handler */
-	iowrite32(syscier, base + SYSCIER);
-	iowrite32(0, base + SYSCIMR);
+	rcar_sysc_init(0xe6180000, syscier);
 }
 
 #else /* CONFIG_SMP */
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 68d6856c9d3c..22f0d646225c 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -400,10 +400,14 @@ out_put:
 }
 early_initcall(rcar_sysc_pd_init);
 
-void __iomem * __init rcar_sysc_init(phys_addr_t base)
+void __init rcar_sysc_init(phys_addr_t base, u32 syscier)
 {
-	if (rcar_sysc_pd_init())
-		rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
+	if (!rcar_sysc_pd_init())
+		return;
 
-	return rcar_sysc_base;
+	rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
+
+	/* enable all interrupt sources, but do not use interrupt handler */
+	iowrite32(syscier, rcar_sysc_base + SYSCIER);
+	iowrite32(0, rcar_sysc_base + SYSCIMR);
 }
diff --git a/include/linux/soc/renesas/rcar-sysc.h b/include/linux/soc/renesas/rcar-sysc.h
index 92fc613ab23d..7b8b280c181b 100644
--- a/include/linux/soc/renesas/rcar-sysc.h
+++ b/include/linux/soc/renesas/rcar-sysc.h
@@ -11,6 +11,6 @@ struct rcar_sysc_ch {
 
 int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch);
 int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch);
-void __iomem *rcar_sysc_init(phys_addr_t base);
+void rcar_sysc_init(phys_addr_t base, u32 syscier);
 
 #endif /* __LINUX_SOC_RENESAS_RCAR_SYSC_H__ */
-- 
2.7.0.rc3.207.g0ac5344
