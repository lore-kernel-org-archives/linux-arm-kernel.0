From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 15:11:51 +0000
Subject: [PATCH RFC 18/26] ARM: omap: remove references to disable_irq_lch
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Message-ID: <E1Vyjw7-0005F8-KL@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The disable_irq_lch method is never actually used, so there's not much
point it existing; remove it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/dma.c |    1 -
 arch/arm/mach-omap2/dma.c |   10 ----------
 include/linux/omap-dma.h  |    1 -
 3 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 5bb8ce86d54b..d292055d3117 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -363,7 +363,6 @@ static int __init omap1_system_dma_init(void)
 	p->clear_dma		= omap1_clear_dma;
 	p->dma_write		= dma_write;
 	p->dma_read		= dma_read;
-	p->disable_irq_lch	= NULL;
 
 	p->errata = configure_dma_errata();
 
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 49fd0d501c9b..81c2d3383bc5 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -112,15 +112,6 @@ static inline u32 dma_read(int reg, int lch)
 	return val;
 }
 
-static inline void omap2_disable_irq_lch(int lch)
-{
-	u32 val;
-
-	val = dma_read(IRQENABLE_L0, lch);
-	val &= ~(1 << lch);
-	dma_write(val, IRQENABLE_L0, lch);
-}
-
 static void omap2_clear_dma(int lch)
 {
 	int i = dma_common_ch_start;
@@ -239,7 +230,6 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	}
 
 	p->dma_attr		= (struct omap_dma_dev_attr *)oh->dev_attr;
-	p->disable_irq_lch	= omap2_disable_irq_lch;
 	p->show_dma_caps	= omap2_show_dma_caps;
 	p->clear_dma		= omap2_clear_dma;
 	p->dma_write		= dma_write;
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index d631658e2237..0bb7de77d478 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -275,7 +275,6 @@ struct omap_dma_dev_attr {
 struct omap_system_dma_plat_info {
 	struct omap_dma_dev_attr *dma_attr;
 	u32 errata;
-	void (*disable_irq_lch)(int lch);
 	void (*show_dma_caps)(void);
 	void (*clear_lch_regs)(int lch);
 	void (*clear_dma)(int lch);
-- 
1.7.4.4
