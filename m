From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 May 2017 10:35:49 +0200
Subject: [PATCH] soc: renesas: Provide dummy rcar_rst_read_mode_pins() for
 compile-testing
In-Reply-To: <cover.1493713942.git.horms+renesas@verge.net.au>
References: <cover.1493713942.git.horms+renesas@verge.net.au>
Message-ID: <7b4ccb3c466f62bbf2f4dd5d6a143d945a6f3051.1493713942.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

If the R-Car RST driver is not included, compile-testing R-Car clock
drivers fails with a link error:

    undefined reference to `rcar_rst_read_mode_pins'

To fix this, provide a dummy version.  Use the exact same test logic as
in drivers/soc/renesas/Makefile, as there is no Kconfig symbol (yet) to
control compilation of the R-Car RST driver.

Fixes: 527c02f66d263d2e ("soc: renesas: Add R-Car RST driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/linux/soc/renesas/rcar-rst.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/soc/renesas/rcar-rst.h b/include/linux/soc/renesas/rcar-rst.h
index a18e0783946b..787e7ad53d45 100644
--- a/include/linux/soc/renesas/rcar-rst.h
+++ b/include/linux/soc/renesas/rcar-rst.h
@@ -1,6 +1,11 @@
 #ifndef __LINUX_SOC_RENESAS_RCAR_RST_H__
 #define __LINUX_SOC_RENESAS_RCAR_RST_H__
 
+#if defined(CONFIG_ARCH_RCAR_GEN1) || defined(CONFIG_ARCH_RCAR_GEN2) || \
+    defined(CONFIG_ARCH_R8A7795) || defined(CONFIG_ARCH_R8A7796)
 int rcar_rst_read_mode_pins(u32 *mode);
+#else
+static inline int rcar_rst_read_mode_pins(u32 *mode) { return -ENODEV; }
+#endif
 
 #endif /* __LINUX_SOC_RENESAS_RCAR_RST_H__ */
-- 
2.1.4
