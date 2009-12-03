From: tony@atomide.com (Tony Lindgren)
Date: Wed, 02 Dec 2009 16:21:22 -0800
Subject: [PATCH 1/9] omap2: mux: intoduce omap_mux_{read,write}
In-Reply-To: <20091203001601.2769.20621.stgit@localhost>
References: <20091203001601.2769.20621.stgit@localhost>
Message-ID: <20091203002122.2769.78843.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Rapoport <mike@compulab.co.il>

intoduce omap_mux_{read,write}

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |   44 ++++++++++++++++++++++++++++++++++++++------
 1 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index c18a94e..64250c5 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -35,7 +35,27 @@
 
 #ifdef CONFIG_OMAP_MUX
 
+#define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
+#define OMAP_MUX_BASE_SZ		0x5ca
+
 static struct omap_mux_cfg arch_mux_cfg;
+static void __iomem *mux_base;
+
+static inline u16 omap_mux_read(u16 reg)
+{
+	if (cpu_is_omap24xx())
+		return __raw_readb(mux_base + reg);
+	else
+		return __raw_readw(mux_base + reg);
+}
+
+static inline void omap_mux_write(u16 val, u16 reg)
+{
+	if (cpu_is_omap24xx())
+		__raw_writeb(val, mux_base + reg);
+	else
+		__raw_writew(val, mux_base + reg);
+}
 
 /* NOTE: See mux.h for the enumeration */
 
@@ -581,10 +601,7 @@ static void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u16 r
 	u16 orig;
 	u8 warn = 0, debug = 0;
 
-	if (cpu_is_omap24xx())
-		orig = omap_ctrl_readb(cfg->mux_reg);
-	else
-		orig = omap_ctrl_readw(cfg->mux_reg);
+	orig = omap_mux_read(cfg->mux_reg - OMAP_MUX_BASE_OFFSET);
 
 #ifdef	CONFIG_OMAP_MUX_DEBUG
 	debug = cfg->debug;
@@ -614,7 +631,7 @@ static int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 	if (cfg->pu_pd_val)
 		reg |= OMAP2_PULL_UP;
 	omap2_cfg_debug(cfg, reg);
-	omap_ctrl_writeb(reg, cfg->mux_reg);
+	omap_mux_write(reg, cfg->mux_reg - OMAP_MUX_BASE_OFFSET);
 	spin_unlock_irqrestore(&mux_spin_lock, flags);
 
 	return 0;
@@ -633,7 +650,7 @@ static int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
 	spin_lock_irqsave(&mux_spin_lock, flags);
 	reg |= cfg->mux_val;
 	omap2_cfg_debug(cfg, reg);
-	omap_ctrl_writew(reg, cfg->mux_reg);
+	omap_mux_write(reg, cfg->mux_reg - OMAP_MUX_BASE_OFFSET);
 	spin_unlock_irqrestore(&mux_spin_lock, flags);
 
 	return 0;
@@ -644,6 +661,21 @@ static int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
 
 int __init omap2_mux_init(void)
 {
+	u32 mux_pbase;
+
+	if (cpu_is_omap2420())
+		mux_pbase = OMAP2420_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
+	else if (cpu_is_omap2430())
+		mux_pbase = OMAP243X_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
+	else if (cpu_is_omap34xx())
+		mux_pbase = OMAP343X_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
+
+	mux_base = ioremap(mux_pbase, OMAP_MUX_BASE_SZ);
+	if (!mux_base) {
+		printk(KERN_ERR "mux: Could not ioremap\n");
+		return -ENODEV;
+	}
+
 	if (cpu_is_omap24xx()) {
 		arch_mux_cfg.pins	= omap24xx_pins;
 		arch_mux_cfg.size	= OMAP24XX_PINS_SZ;
