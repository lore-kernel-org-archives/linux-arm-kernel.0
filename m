From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 30 Jul 2015 13:55:04 +0200
Subject: [PATCH v3 1/3] ARM: at91/soc: add basic support for new sama5d2 SoC
In-Reply-To: <1438257306-12517-1-git-send-email-nicolas.ferre@atmel.com>
References: <1438257306-12517-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1438257306-12517-2-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Kconfig entries, header file changes and addition to the documentation.
The early debug infrastructure is also added for easy development.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---

Changes in v3:
- collect Ack by Alexandre

Changes in v2:
- change the meaningless config HAVE_AT91_GENERATED to HAVE_AT91_GENERATED_CLK
- modify README file for clarity

 Documentation/arm/Atmel/README                       |  5 +++++
 Documentation/devicetree/bindings/arm/atmel-at91.txt |  2 ++
 arch/arm/Kconfig.debug                               |  6 ++++++
 arch/arm/include/debug/at91.S                        |  5 ++++-
 arch/arm/mach-at91/Kconfig                           | 12 ++++++++++++
 arch/arm/mach-at91/sama5.c                           |  3 +++
 arch/arm/mach-at91/soc.h                             |  3 +++
 7 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm/Atmel/README b/Documentation/arm/Atmel/README
index c53a19b4aab2..0931cf7e2e56 100644
--- a/Documentation/arm/Atmel/README
+++ b/Documentation/arm/Atmel/README
@@ -90,6 +90,11 @@ the Atmel website: http://www.atmel.com.
         + Datasheet
           http://www.atmel.com/Images/Atmel-11238-32-bit-Cortex-A5-Microcontroller-SAMA5D4_Datasheet.pdf
 
+      - sama5d2 family
+        - sama5d27
+        + Datasheet
+          Coming soon
+
 
 Linux kernel information
 ------------------------
diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index dd998b9c0433..23c097812d98 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -27,6 +27,8 @@ compatible: must be one of:
     o "atmel,at91sam9xe"
  * "atmel,sama5" for SoCs using a Cortex-A5, shall be extended with the specific
    SoC family:
+    o "atmel,sama5d2" shall be extended with the specific SoC compatible:
+       - "atmel,sama5d27"
     o "atmel,sama5d3" shall be extended with the specific SoC compatible:
        - "atmel,sama5d31"
        - "atmel,sama5d33"
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index fc1533016622..0cfd7f947f6b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -141,6 +141,12 @@ choice
 		depends on ARCH_AT91
 		depends on SOC_SAMA5
 
+	config AT91_DEBUG_LL_DBGU3
+		bool "Kernel low-level debugging on sama5d2"
+		select DEBUG_AT91_UART
+		depends on ARCH_AT91
+		depends on SOC_SAMA5
+
 	config DEBUG_BCM2835
 		bool "Kernel low-level debugging on BCM2835 PL011 UART"
 		depends on ARCH_BCM2835
diff --git a/arch/arm/include/debug/at91.S b/arch/arm/include/debug/at91.S
index c3c45e628e33..2556a8801c8c 100644
--- a/arch/arm/include/debug/at91.S
+++ b/arch/arm/include/debug/at91.S
@@ -13,9 +13,12 @@
 #define AT91_DBGU 0xfffff200 /* AT91_BASE_DBGU0 */
 #elif defined(CONFIG_AT91_DEBUG_LL_DBGU1)
 #define AT91_DBGU 0xffffee00 /* AT91_BASE_DBGU1 */
-#else
+#elif defined(CONFIG_AT91_DEBUG_LL_DBGU2)
 /* On sama5d4, use USART3 as low level serial console */
 #define AT91_DBGU 0xfc00c000 /* SAMA5D4_BASE_USART3 */
+#else
+/* On sama5d2, use UART1 as low level serial console */
+#define AT91_DBGU 0xf8020000
 #endif
 
 #ifdef CONFIG_MMU
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index e8273e79f6ba..92673006e55c 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -8,6 +8,18 @@ menuconfig ARCH_AT91
 	select SOC_BUS
 
 if ARCH_AT91
+config SOC_SAMA5D2
+	bool "SAMA5D2 family" if ARCH_MULTI_V7
+	select SOC_SAMA5
+	select CACHE_L2X0
+	select HAVE_FB_ATMEL
+	select HAVE_AT91_UTMI
+	select HAVE_AT91_USB_CLK
+	select HAVE_AT91_H32MX
+	select HAVE_AT91_GENERATED_CLK
+	help
+	  Select this if ou are using one of Atmel's SAMA5D2 family SoC.
+
 config SOC_SAMA5D3
 	bool "SAMA5D3 family" if ARCH_MULTI_V7
 	select SOC_SAMA5
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index 41d829d8e7d5..90c3c3051ae7 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -18,6 +18,8 @@
 #include "soc.h"
 
 static const struct at91_soc sama5_socs[] = {
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27_EXID_MATCH,
+		 "sama5d27", "sama5d2"),
 	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D31_EXID_MATCH,
 		 "sama5d31", "sama5d3"),
 	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D33_EXID_MATCH,
@@ -64,6 +66,7 @@ DT_MACHINE_START(sama5_dt, "Atmel SAMA5")
 MACHINE_END
 
 static const char *sama5_alt_dt_board_compat[] __initconst = {
+	"atmel,sama5d2",
 	"atmel,sama5d4",
 	NULL
 };
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index be23c400596b..8ede0ef86172 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -62,6 +62,9 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
 #define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
 
+#define SAMA5D2_CIDR_MATCH		0x0a5c08c0
+#define SAMA5D27_EXID_MATCH		0x00000021
+
 #define SAMA5D3_CIDR_MATCH		0x0a5c07c0
 #define SAMA5D31_EXID_MATCH		0x00444300
 #define SAMA5D33_EXID_MATCH		0x00414300
-- 
2.1.3
