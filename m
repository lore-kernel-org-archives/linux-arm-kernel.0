From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 28 Jul 2014 20:51:23 +0800
Subject: [PATCH v5 8/8] ARM: hisi: remove smp from machine descriptor
In-Reply-To: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
References: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1406551883-26154-9-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use CPU_METHOD_OF_DECLARE() instead. And declare smp method in dts file.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/boot/dts/hi3620.dtsi     | 1 +
 arch/arm/boot/dts/hix5hd2-dkb.dts | 1 +
 arch/arm/mach-hisi/hisilicon.c    | 4 ----
 arch/arm/mach-hisi/platsmp.c      | 3 +++
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
index ab1116d..ea6b0c1 100644
--- a/arch/arm/boot/dts/hi3620.dtsi
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -33,6 +33,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "hisilicon,hi3xxx-smp";
 
 		cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/hix5hd2-dkb.dts b/arch/arm/boot/dts/hix5hd2-dkb.dts
index 32c7fd1..556c98a 100644
--- a/arch/arm/boot/dts/hix5hd2-dkb.dts
+++ b/arch/arm/boot/dts/hix5hd2-dkb.dts
@@ -21,6 +21,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "hisilicon,hix5hd2-smp";
 
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 284f9a1..2544d84 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -18,8 +18,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include "core.h"
-
 #define HI3620_SYSCTRL_PHYS_BASE		0xfc802000
 #define HI3620_SYSCTRL_VIRT_BASE		0xfe802000
 
@@ -57,7 +55,6 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.dt_compat	= hi3xxx_compat,
 	.l2c_aux_val	= 0x0,
 	.l2c_aux_mask	= 0xffffffff,
-	.smp		= smp_ops(hi3xxx_smp_ops),
 MACHINE_END
 
 static const char *hix5hd2_compat[] __initconst = {
@@ -69,5 +66,4 @@ DT_MACHINE_START(HIX5HD2_DT, "Hisilicon HIX5HD2 (Flattened Device Tree)")
 	.dt_compat	= hix5hd2_compat,
 	.l2c_aux_val	= 0x00050000,
 	.l2c_aux_mask	= 0xfff0ffff,
-	.smp		= smp_ops(hix5hd2_smp_ops),
 MACHINE_END
diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index ecf7058..cc377b6 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -131,3 +131,6 @@ struct smp_operations hix5hd2_smp_ops __initdata = {
 	.cpu_die		= hix5hd2_cpu_die,
 #endif
 };
+
+CPU_METHOD_OF_DECLARE(hi3xxx_smp, "hisilicon,hi3xxx-smp", &hi3xxx_smp_ops);
+CPU_METHOD_OF_DECLARE(hix5hd2_smp, "hisilicon,hix5hd2-smp", &hix5hd2_smp_ops);
-- 
1.9.1
