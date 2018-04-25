From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 25 Apr 2018 14:53:23 +0530
Subject: [PATCH] ARM: davinci: board-dm355-evm: fix broken networking
Message-ID: <20180425092323.21898-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 09f3756bb9a8 ("dm9000: Return an ERR_PTR() in all
error conditions of dm9000_parse_dt()"), passing either non-NULL
platform data or device-tree for dm9000 driver to probe is
mandatory.

DM335 board was using none, so networking failed to initialize.
Fix it by passing non-NULL (but empty) platform data.

Fixes: 09f3756bb9a8 ("dm9000: Return an ERR_PTR() in all error conditions of dm9000_parse_dt()")
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 14557f893798..d04381d3f05b 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -19,6 +19,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 #include <linux/clk.h>
+#include <linux/dm9000.h>
 #include <linux/videodev2.h>
 #include <media/i2c/tvp514x.h>
 #include <linux/spi/spi.h>
@@ -179,11 +180,16 @@ static struct resource dm355evm_dm9000_rsrc[] = {
 	},
 };
 
+static struct dm9000_plat_data dm335evm_dm9000_platdata;
+
 static struct platform_device dm355evm_dm9000 = {
 	.name		= "dm9000",
 	.id		= -1,
 	.resource	= dm355evm_dm9000_rsrc,
 	.num_resources	= ARRAY_SIZE(dm355evm_dm9000_rsrc),
+	.dev		= {
+		.platform_data = &dm335evm_dm9000_platdata,
+	},
 };
 
 static struct tvp514x_platform_data tvp5146_pdata = {
-- 
2.16.2
