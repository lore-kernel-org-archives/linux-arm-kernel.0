From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Mar 2012 13:05:05 +0000
Subject: [PATCH 09/10] ARM: ux500: Enable PL310 Level 2 Cache Controller in
 Device Tree
In-Reply-To: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1331730306-11461-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This provides PL310 Level 2 Cache Controller Device Tree
support for all u8500 based devices.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi    |    8 ++++++++
 arch/arm/mach-ux500/cache-l2x0.c |    7 ++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 9b5e06e..6ae7f69 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -29,6 +29,14 @@
 			      <0xa0410100 0x100>;
 		};
 
+		L2: l2-cache {
+			compatible = "arm,pl310-cache";
+			reg = <0xa0412000 0x1000>;
+			interrupts = <0 13 4>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
 		pmu {
 			compatible = "arm,cortex-a9-pmu";
 			interrupts = <7>;
diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index da5569d..77a75ed 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -5,6 +5,8 @@
  */
 
 #include <linux/io.h>
+#include <linux/of.h>
+
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <mach/hardware.h>
@@ -45,7 +47,10 @@ static int __init ux500_l2x0_init(void)
 	ux500_l2x0_unlock();
 
 	/* 64KB way size, 8 way associativity, force WA */
-	l2x0_init(l2x0_base, 0x3e060000, 0xc0000fff);
+	if (of_have_populated_dt())
+		l2x0_of_init(0x3e060000, 0xc0000fff);
+	else
+		l2x0_init(l2x0_base, 0x3e060000, 0xc0000fff);
 
 	/*
 	 * We can't disable l2 as we are in non secure mode, currently
-- 
1.7.5.4
