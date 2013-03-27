From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 27 Mar 2013 18:30:40 +0100
Subject: [PATCH v2 06/11] ARM i.MX: Add imx_clk_divider_flags and
 imx_clk_mux_flags
In-Reply-To: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1364405445-5271-7-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default is for dividers to set CLK_SET_PARENT_RATE and for muxes to
not set that flag. In the LDB clock tree, we need the opposite, so add
functions to create divider and mux clocks with configurable flags.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index 9d1f3b9..d9d9d9c 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -59,6 +59,14 @@ static inline struct clk *imx_clk_divider(const char *name, const char *parent,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk *imx_clk_divider_flags(const char *name,
+		const char *parent, void __iomem *reg, u8 shift, u8 width,
+		unsigned long flags)
+{
+	return clk_register_divider(NULL, name, parent, flags,
+			reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_gate(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
@@ -73,6 +81,15 @@ static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 			width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk *imx_clk_mux_flags(const char *name,
+		void __iomem *reg, u8 shift, u8 width, const char **parents,
+		int num_parents, unsigned long flags)
+{
+	return clk_register_mux(NULL, name, parents, num_parents,
+			flags, reg, shift, width, 0,
+			&imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_fixed_factor(const char *name,
 		const char *parent, unsigned int mult, unsigned int div)
 {
-- 
1.8.2.rc2
