From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 13 Feb 2015 17:11:26 +0200
Subject: [PATCH 9/9] RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN
In-Reply-To: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1423840286-18377-10-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRA7xx's CTRL_CORE_CONTROL_IO_2 register contains bits for various
subsystems, including PCIe, DCAN, QSPI and DSS. At the moment only DCAN
bits are used by the SW via syscon.

For DSS there is DSS_DESHDCP_CLKEN bit. This (presumably) enables a
clock related to DSS's HDCP. If that clock is off, DSS module does not
start at all, causing OCP errors. This means that the HWMOD code is not
able to reset and initialize DSS.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/io.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index a1bd6affb508..2206fb13f195 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -700,6 +700,17 @@ void __init dra7xx_init_early(void)
 	dra7xx_hwmod_init();
 	omap_hwmod_init_postsetup();
 	omap_clk_soc_init = dra7xx_dt_clk_init;
+
+	if (soc_is_dra7xx()) {
+		u32 v;
+		const u16 ctrl_core_control_io_2 = 0x558;
+
+		/* set CTRL_CORE_CONTROL_IO_2:DSS_DESHDCP_CLKEN */
+
+		v = omap_ctrl_readl(ctrl_core_control_io_2);
+		v |= 1;
+		omap_ctrl_writel(v, ctrl_core_control_io_2);
+	}
 }
 
 void __init dra7xx_init_late(void)
-- 
2.3.0
