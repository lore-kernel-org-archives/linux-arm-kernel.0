From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 9 Jul 2012 18:41:09 +0530
Subject: [PATCH 1/2] ARM: OMAP4: Add L2 Cache Controller in Device Tree
In-Reply-To: <1341839470-5586-1-git-send-email-santosh.shilimkar@ti.com>
References: <1341839470-5586-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1341839470-5586-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This provides PL310 Level 2 Cache Controller Device Tree
support for OMAP4 based devices.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi       |    7 +++++++
 arch/arm/mach-omap2/omap4-common.c |    6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 359c497..57f7cd4 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -36,6 +36,13 @@
 		};
 	};
 
+	L2: l2-cache-controller {
+		compatible = "arm,pl310-cache";
+		reg = <0x48242000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is uses for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index a8161e5..40bb560 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/memblock.h>
+#include <linux/of.h>
 
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -169,7 +170,10 @@ static int __init omap_l2_cache_init(void)
 	/* Enable PL310 L2 Cache controller */
 	omap_smc1(0x102, 0x1);
 
-	l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
+	if (of_have_populated_dt())
+		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
+	else
+		l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
 
 	/*
 	 * Override default outer_cache.disable with a OMAP4
-- 
1.7.9.5
