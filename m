From: baruch@tkos.co.il (Baruch Siach)
Date: Tue,  9 Mar 2010 12:12:04 +0200
Subject: [PATCH 1/2] mx1: fix build when DEBUG_LL is enabled
Message-ID: <e5558b1571cff8472994ed51622339fd9e517f5e.1268129163.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "mx1: prefix SOC specific defines with MX1_ and deprecate old names"
redefined the IO_ADDRESS macro in a way that is incompatible with
debug-macro.S. Reintroduce AVIC_IO_ADDRESS, and use it in debug-macro.S.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/plat-mxc/include/mach/debug-macro.S |    2 +-
 arch/arm/plat-mxc/include/mach/mx1.h         |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 133d66b..8f82ff4 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -15,7 +15,7 @@
 #ifdef CONFIG_ARCH_MX1
 #include <mach/mx1.h>
 #define UART_PADDR	UART1_BASE_ADDR
-#define UART_VADDR	IO_ADDRESS(UART1_BASE_ADDR)
+#define UART_VADDR	AVIC_IO_ADDRESS(UART1_BASE_ADDR)
 #endif
 
 #ifdef CONFIG_ARCH_MX25
diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/plat-mxc/include/mach/mx1.h
index 5eba7e6..37d3560 100644
--- a/arch/arm/plat-mxc/include/mach/mx1.h
+++ b/arch/arm/plat-mxc/include/mach/mx1.h
@@ -72,6 +72,10 @@
 #define MX1_AVIC_BASE_ADDR		(0x23000 + MX1_IO_BASE_ADDR)
 #define MX1_CSI_BASE_ADDR		(0x24000 + MX1_IO_BASE_ADDR)
 
+/* define macro needed for entry-macro.S */
+#define AVIC_IO_ADDRESS(x)	((x) - MX1_IO_BASE_ADDR			\
+		+ MX1_IO_BASE_ADDR_VIRT)
+
 /* macro to get at IO space when running virtually */
 #define MX1_IO_ADDRESS(x) (						\
 	IMX_IO_ADDRESS(x, MX1_IO))
@@ -213,7 +217,6 @@
 #define AVIC_BASE_ADDR MX1_AVIC_BASE_ADDR
 #define CSI_BASE_ADDR MX1_CSI_BASE_ADDR
 #define IO_ADDRESS(x) MX1_IO_ADDRESS(x)
-#define AVIC_IO_ADDRESS(x) IO_ADDRESS(x)
 #define INT_SOFTINT MX1_INT_SOFTINT
 #define CSI_INT MX1_CSI_INT
 #define DSPA_MAC_INT MX1_DSPA_MAC_INT
-- 
1.7.0
