From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri,  5 Feb 2010 08:26:12 -0800
Subject: [PATCHv3 3/7] mxc: changes to common plat-mxc code to add support for
	i.MX5
In-Reply-To: <553d86cf968ba78a26b67098c2e1849407a51ba1.1265385421.git.amit.kucheria@canonical.com>
References: <cover.1265385421.git.amit.kucheria@canonical.com>
	<367110fafb57f7340bbffec9b394ed2fa6e89da5.1265385421.git.amit.kucheria@canonical.com>
	<553d86cf968ba78a26b67098c2e1849407a51ba1.1265385421.git.amit.kucheria@canonical.com>
Message-ID: <bf84de08e5c511325fb94a742f5d6efabece06b6.1265385421.git.amit.kucheria@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare for i.MX5 SoC code by adding the relevant macros to common plat-mxc
code.

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 arch/arm/plat-mxc/include/mach/debug-macro.S |    9 +++++++++
 arch/arm/plat-mxc/include/mach/hardware.h    |    4 ++++
 arch/arm/plat-mxc/include/mach/irqs.h        |    3 +++
 arch/arm/plat-mxc/include/mach/memory.h      |    3 +++
 arch/arm/plat-mxc/include/mach/mxc.h         |   13 +++++++++++++
 arch/arm/plat-mxc/include/mach/timex.h       |    2 ++
 6 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 15b2b14..9d41bfd 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -44,6 +44,15 @@
 #define UART_VADDR	AIPS1_IO_ADDRESS(UART1_BASE_ADDR)
 #endif
 
+#ifdef CONFIG_ARCH_MX5
+#ifdef UART_PADDR
+#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
+#endif
+#include <mach/mx51.h>
+#define UART_PADDR	MX51_UART1_BASE_ADDR
+#define UART_VADDR	MX51_AIPS1_IO_ADDRESS(MX51_UART1_BASE_ADDR)
+#endif
+
 #ifdef CONFIG_ARCH_MXC91231
 #ifdef UART_PADDR
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index 78db754..55ebe88 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -22,6 +22,10 @@
 
 #include <asm/sizes.h>
 
+#ifdef CONFIG_ARCH_MX5
+#include <mach/mx51.h>
+#endif
+
 #ifdef CONFIG_ARCH_MX3
 #include <mach/mx3x.h>
 #include <mach/mx31.h>
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 4c51083..24c066e 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -30,6 +30,8 @@
 #define MXC_GPIO_IRQS		(32 * 3)
 #elif defined CONFIG_ARCH_MX25
 #define MXC_GPIO_IRQS		(32 * 4)
+#elif defined CONFIG_ARCH_MX5
+#define MXC_GPIO_IRQS		(32 * 4)
 #elif defined CONFIG_ARCH_MXC91231
 #define MXC_GPIO_IRQS		(32 * 4)
 #endif
@@ -50,6 +52,7 @@
 #else
 #define MX3_IPU_IRQS 0
 #endif
+/* REVISIT: Add IPU irqs on IMX51 */
 
 #define NR_IRQS			(MXC_IPU_IRQ_START + MX3_IPU_IRQS)
 
diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index d3afafd..e46626e 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -27,6 +27,9 @@
 #elif defined CONFIG_ARCH_MXC91231
 #define PHYS_OFFSET		UL(0x90000000)
 #endif
+#ifdef CONFIG_ARCH_MX5
+#define PHYS_OFFSET             UL(0x90000000)
+#endif
 
 #if defined(CONFIG_MX1_VIDEO)
 /*
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 5199053..555e5f8 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -30,6 +30,7 @@
 #define MXC_CPU_MX27		27
 #define MXC_CPU_MX31		31
 #define MXC_CPU_MX35		35
+#define MXC_CPU_MX51		51
 #define MXC_CPU_MXC91231	91231
 
 #ifndef __ASSEMBLY__
@@ -108,6 +109,18 @@ extern unsigned int __mxc_cpu_type;
 # define cpu_is_mx35()		(0)
 #endif
 
+#ifdef CONFIG_ARCH_MX5
+# ifdef mxc_cpu_type
+#  undef mxc_cpu_type
+#  define mxc_cpu_type __mxc_cpu_type
+# else
+#  define mxc_cpu_type MXC_CPU_MX51
+# endif
+# define cpu_is_mx51()		(mxc_cpu_type == MXC_CPU_MX51)
+#else
+# define cpu_is_mx51()		(0)
+#endif
+
 #ifdef CONFIG_ARCH_MXC91231
 # ifdef mxc_cpu_type
 #  undef mxc_cpu_type
diff --git a/arch/arm/plat-mxc/include/mach/timex.h b/arch/arm/plat-mxc/include/mach/timex.h
index 527a6c2..024416e 100644
--- a/arch/arm/plat-mxc/include/mach/timex.h
+++ b/arch/arm/plat-mxc/include/mach/timex.h
@@ -28,6 +28,8 @@
 #define CLOCK_TICK_RATE		16625000
 #elif defined CONFIG_ARCH_MX25
 #define CLOCK_TICK_RATE		16000000
+#elif defined CONFIG_ARCH_MX5
+#define CLOCK_TICK_RATE		8000000
 #elif defined CONFIG_ARCH_MXC91231
 #define CLOCK_TICK_RATE		13000000
 #endif
-- 
1.6.3.3
