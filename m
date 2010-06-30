From: tony@atomide.com (Tony Lindgren)
Date: Wed, 30 Jun 2010 15:07:06 +0300
Subject: [PATCH 10/16] omap: mux: Select POP package for 2430SDP
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Message-ID: <20100630120706.2637.40524.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select POP package for 2430SDP

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig         |    1 +
 arch/arm/mach-omap2/board-2430sdp.c |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4158368..f67f037 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -61,6 +61,7 @@ config MACH_OMAP_APOLLON
 config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
 	depends on ARCH_OMAP2
+	select OMAP_PACKAGE_ZAC
 
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index ec920c9..281aa13 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -38,6 +38,7 @@
 #include <plat/usb.h>
 #include <plat/gpmc-smc91x.h>
 
+#include "mux.h"
 #include "hsmmc.h"
 
 #define SDP2430_CS0_BASE	0x04000000
@@ -217,10 +218,20 @@ static struct omap_usb_config sdp2430_usb_config __initdata = {
 	.pins[0]	= 3,
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init omap_2430sdp_init(void)
 {
 	int ret;
 
+	omap2430_mux_init(board_mux, OMAP_PACKAGE_ZAC);
+
 	omap2430_i2c_init();
 
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
