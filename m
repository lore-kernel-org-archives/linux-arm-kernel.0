From: b32955@freescale.com (Huang Shijie)
Date: Mon, 26 May 2014 13:20:32 +0800
Subject: [PATCH 1/2] ARM: clk: imx: add a new helper which can re-parent the
 clock
Message-ID: <1401081633-12190-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocks for Quadspi controller may be different when different
NOR flashes are connected to the board.

This patch adds a new helper to register the clock which needs the
re-parent capability.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/mach-imx/clk.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index e29f6eb..2e3c4fe 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -112,6 +112,16 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
 			&imx_ccm_lock);
 }
 
+/* we can use this helper to register the clock which needs the re-parent. */
+static inline struct clk *imx_clk_mux_flags_reparent(const char *name,
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
1.7.8
