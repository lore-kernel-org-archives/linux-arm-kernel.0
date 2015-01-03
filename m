From: 21cnbao@gmail.com (Barry Song)
Date: Sat,  3 Jan 2015 09:36:45 +0800
Subject: [PATCH V2 7/9] ARM: sirf: add atlas7 machine support
In-Reply-To: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
References: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1420249007-8262-8-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhiwu Song <Zhiwu.Song@csr.com>

atlas7 is next-gen auto soc from CSR.
It could bring to customers most integrated SoC solution:
- World leading Bluetooth 4.0 and GNSS baseband
- Audio processing, analog CODEC and ADC by DSP
- Analog video input
- SDR accelerators
- CAN bus support by Cortex-M3

Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 Documentation/devicetree/bindings/arm/sirf.txt |  4 ++++
 arch/arm/mach-prima2/Kconfig                   | 13 ++++++++++++-
 arch/arm/mach-prima2/common.c                  | 13 +++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/sirf.txt b/Documentation/devicetree/bindings/arm/sirf.txt
index 9daa1c1..7b28ee6 100644
--- a/Documentation/devicetree/bindings/arm/sirf.txt
+++ b/Documentation/devicetree/bindings/arm/sirf.txt
@@ -3,5 +3,9 @@ CSR SiRFprimaII and SiRFmarco device tree bindings.
 
 Required root node properties:
     - compatible:
+    - "sirf,atlas6-cb" : atlas6 "cb" evaluation board
+    - "sirf,atlas6" : atlas6 device based board
+    - "sirf,atlas7-cb" : atlas7 "cb" evaluation board
+    - "sirf,atlas7" : atlas7 device based board
     - "sirf,prima2-cb" : prima2 "cb" evaluation board
     - "sirf,prima2" : prima2 device based board
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index cc1c323..a219dc3 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -11,7 +11,7 @@ menuconfig ARCH_SIRF
 
 if ARCH_SIRF
 
-comment "CSR SiRF atlas6/primaII/Marco/Polo Specific Features"
+comment "CSR SiRF atlas6/primaII/Atlas7 Specific Features"
 
 config ARCH_ATLAS6
 	bool "CSR SiRFSoC ATLAS6 ARM Cortex A9 Platform"
@@ -20,6 +20,17 @@ config ARCH_ATLAS6
 	help
           Support for CSR SiRFSoC ARM Cortex A9 Platform
 
+config ARCH_ATLAS7
+	bool "CSR SiRFSoC ATLAS7 ARM Cortex A7 Platform"
+	default y
+	select ARM_GIC
+	select CPU_V7
+	select HAVE_ARM_SCU if SMP
+	select HAVE_SMP
+	select SMP_ON_UP if SMP
+	help
+          Support for CSR SiRFSoC ARM Cortex A7 Platform
+
 config ARCH_PRIMA2
 	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
 	default y
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index c62ff68..0c819bb 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -50,3 +50,16 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	.dt_compat      = prima2_dt_match,
 MACHINE_END
 #endif
+
+#ifdef CONFIG_ARCH_ATLAS7
+static const char *atlas7_dt_match[] __initdata = {
+	"sirf,atlas7",
+	NULL
+};
+
+DT_MACHINE_START(ATLAS7_DT, "Generic ATLAS7 (Flattened Device Tree)")
+	/* Maintainer: Barry Song <baohua.song@csr.com> */
+	.smp            = smp_ops(sirfsoc_smp_ops),
+	.dt_compat      = atlas7_dt_match,
+MACHINE_END
+#endif
-- 
2.2.1
