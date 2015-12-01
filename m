From: kapilh@broadcom.com (Kapil Hali)
Date: Tue, 1 Dec 2015 11:24:09 -0500
Subject: [PATCH v4 5/5] ARM: BCM: Add SMP support for Broadcom 4708
In-Reply-To: <1448987049-17041-1-git-send-email-kapilh@broadcom.com>
References: <1448987049-17041-1-git-send-email-kapilh@broadcom.com>
Message-ID: <1448987049-17041-6-git-send-email-kapilh@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Mason <jonmason@broadcom.com>

Add SMP support for Broadcom's 4708 SoCs.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Tested-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Kapil Hali <kapilh@broadcom.com>
---
 arch/arm/boot/dts/bcm4708.dtsi | 2 ++
 arch/arm/mach-bcm/Kconfig      | 1 +
 arch/arm/mach-bcm/Makefile     | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
index 31141e8..eed4dd1 100644
--- a/arch/arm/boot/dts/bcm4708.dtsi
+++ b/arch/arm/boot/dts/bcm4708.dtsi
@@ -15,6 +15,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "brcm,bcm-nsp-smp";
 
 		cpu at 0 {
 			device_type = "cpu";
@@ -27,6 +28,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
+			secondary-boot-reg = <0xffff0400>;
 			reg = <0x1>;
 		};
 	};
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 83765a0..e85246f 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -54,6 +54,7 @@ config ARCH_BCM_NSP
 config ARCH_BCM_5301X
 	bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
 	select ARCH_BCM_IPROC
+	select HAVE_SMP
 	help
 	  Support for Broadcom BCM470X and BCM5301X SoCs with ARM CPU cores.
 
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 5193a25..7d66515 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -43,6 +43,9 @@ obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
 
 # BCM5301X
 obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
+ifeq ($(CONFIG_ARCH_BCM_5301X),y)
+obj-$(CONFIG_SMP)		+= platsmp.o
+endif
 
 # BCM63XXx
 ifeq ($(CONFIG_ARCH_BCM_63XX),y)
-- 
2.1.0
