From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 25 Dec 2014 16:34:18 +0800
Subject: [PATCH 2/4] ARM: sirf: add atlas7 machine support
In-Reply-To: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
References: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1419496460-4929-3-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhiwu Song <Zhiwu.Song@csr.com>

atlas7 is next-gen auto soc from CSR.
It could bring to customers most integrated SoC solution:
- World leading Bluetooth 4.0 and GNSS baseband
- Audio processing, analog CODEC and ADC
- Analog video input
- SDR accelerators

Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 Documentation/devicetree/bindings/arm/sirf.txt |  2 ++
 arch/arm/mach-prima2/Kconfig                   | 13 ++++++++++++-
 arch/arm/mach-prima2/common.c                  | 15 +++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/sirf.txt b/Documentation/devicetree/bindings/arm/sirf.txt
index c6ba6d3..018de18 100644
--- a/Documentation/devicetree/bindings/arm/sirf.txt
+++ b/Documentation/devicetree/bindings/arm/sirf.txt
@@ -3,7 +3,9 @@ CSR SiRFprimaII and SiRFmarco device tree bindings.
 
 Required root node properties:
     - compatible:
+    - "sirf,atlas7-cb" : atlas7 device based board
     - "sirf,prima2-cb" : prima2 "cb" evaluation board
     - "sirf,marco-cb" : marco "cb" evaluation board
+    - "sirf,atlas7" : atlas7 device based board
     - "sirf,prima2" : prima2 device based board
     - "sirf,marco" : marco device based board
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 042f693..e8f17c9 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -11,7 +11,7 @@ menuconfig ARCH_SIRF
 
 if ARCH_SIRF
 
-comment "CSR SiRF atlas6/primaII/Marco/Polo Specific Features"
+comment "CSR SiRF atlas6/primaII/Marco/Atlas7 Specific Features"
 
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
index a860ea2..2f45d48 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -75,3 +75,18 @@ DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
 	.dt_compat      = marco_dt_match,
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
+	.map_io         = sirfsoc_map_io,
+	.init_late	= sirfsoc_init_late,
+	.dt_compat      = atlas7_dt_match,
+MACHINE_END
+#endif
-- 
2.2.0
