From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 11 Dec 2013 17:27:09 +0530
Subject: [PATCH 5/5] ARM: dts: Setup the interrupt parent for max77686
In-Reply-To: <1386763029-8516-1-git-send-email-a.kesavan@samsung.com>
References: <1386763029-8516-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1386763029-8516-6-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warning message:
[ 2921.671238] WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:399 irq_create_mapping+0xe4/0xfc()
[ 2921.679907] irq_create_mapping(, b) called with NULL domain
[ 2921.685462] Modules linked in:
[ 2921.688498] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.13.0-rc1-00026-g36cc776 #67
[ 2921.696154] [<c0013c80>] (unwind_backtrace+0x0/0xf8) from [<c00110cc>] (show_stack+0x10/0x14)
[ 2921.704654] [<c00110cc>] (show_stack+0x10/0x14) from [<c03779fc>] (dump_stack+0x64/0xa4)
[ 2921.712725] [<c03779fc>] (dump_stack+0x64/0xa4) from [<c001c830>] (warn_slowpath_common+0x64/0x84)
[ 2921.721663] [<c001c830>] (warn_slowpath_common+0x64/0x84) from [<c001c8e4>] (warn_slowpath_fmt+0x30/0x40)
[ 2921.731210] [<c001c8e4>] (warn_slowpath_fmt+0x30/0x40) from [<c005a564>] (irq_create_mapping+0xe4/0xfc)
[ 2921.740590] [<c005a564>] (irq_create_mapping+0xe4/0xfc) from [<c029c85c>] (max77686_rtc_probe+0x110/0x21c)
[ 2921.750221] [<c029c85c>] (max77686_rtc_probe+0x110/0x21c) from [<c02253a8>] (platform_drv_probe+0x18/0x48)

Also setup the default state of the max77686 irq line.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/boot/dts/cros5250-common.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
index 6470536..dc853b9 100644
--- a/arch/arm/boot/dts/cros5250-common.dtsi
+++ b/arch/arm/boot/dts/cros5250-common.dtsi
@@ -27,6 +27,13 @@
 		i2c2_bus: i2c2-bus {
 			samsung,pin-pud = <0>;
 		};
+
+		max77686_irq: max77686-irq {
+			samsung,pins = "gpx3-2";
+			samsung,pin-function = <0>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
 	};
 
 	i2c at 12C60000 {
@@ -36,6 +43,10 @@
 		max77686 at 09 {
 			compatible = "maxim,max77686";
 			reg = <0x09>;
+			interrupt-parent = <&gpx3>;
+			interrupts = <2 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&max77686_irq>;
 
 			voltage-regulators {
 				ldo1_reg: LDO1 {
-- 
1.7.9.5
