From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Tue,  9 Feb 2010 18:59:51 +0200
Subject: [PATCHv3 3/7] mxc: changes to common plat-mxc code to add support for
	i.MX5
In-Reply-To: <0f3332c4fabb2227b1bc15dc7542017d08f10a09.1265733173.git.amit.kucheria@canonical.com>
References: <cover.1265733173.git.amit.kucheria@canonical.com>
	<a003708ad4ee9384226251431c7953a24079ff80.1265733173.git.amit.kucheria@canonical.com>
	<0f3332c4fabb2227b1bc15dc7542017d08f10a09.1265733173.git.amit.kucheria@canonical.com>
Message-ID: <438caa3f6c91ba21c539a8547c4075b619dc6500.1265733173.git.amit.kucheria@canonical.com>
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
index 916d4fc..133d66b 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -45,6 +45,15 @@
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
index db14c56..ebadf4a 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -27,6 +27,10 @@
 	 (((unsigned long)((addr) - (module ## _BASE_ADDR)) < module ## _SIZE) ?\
 	 (addr) - (module ## _BASE_ADDR) + (module ## _BASE_ADDR_VIRT) : 0))
 
+#ifdef CONFIG_ARCH_MX5
+#include <mach/mx51.h>
+#endif
+
 #ifdef CONFIG_ARCH_MX3
 #include <mach/mx3x.h>
 #include <mach/mx31.h>
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 38f1501..a3ad643 100644
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
@@ -55,6 +57,7 @@
 #else
 #define MX3_IPU_IRQS 0
 #endif
+/* REVISIT: Add IPU irqs on IMX51 */
 
 #define NR_IRQS			(MXC_IPU_IRQ_START + MX3_IPU_IRQS)
 
diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index 002eb91..7cae9cb 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -16,6 +16,7 @@
 #define MX25_PHYS_OFFSET	UL(0x80000000)
 #define MX27_PHYS_OFFSET	UL(0xa0000000)
 #define MX3x_PHYS_OFFSET	UL(0x80000000)
+#define MX51_PHYS_OFFSET	UL(0x90000000)
 #define MXC91231_PHYS_OFFSET	UL(0x90000000)
 
 #if !defined(CONFIG_RUNTIME_PHYS_OFFSET)
@@ -31,6 +32,8 @@
 #  define PHYS_OFFSET		MX3x_PHYS_OFFSET
 # elif defined CONFIG_ARCH_MXC91231
 #  define PHYS_OFFSET		MXC91231_PHYS_OFFSET
+# elif defined CONFIG_ARCH_MX5
+#  define PHYS_OFFSET		MX51_PHYS_OFFSET
 # endif
 #endif
 
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 800ae2a..a790bf2 100644
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
