From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2016 12:50:01 +0200
Subject: [PATCH 6/6] ARM: imx: remove cpu_is_mx*()
In-Reply-To: <20160624105001.3166287-1-arnd@arndb.de>
References: <20160624105001.3166287-1-arnd@arndb.de>
Message-ID: <20160624105001.3166287-7-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxc_cpu_type and cpu_is_mx() logic is largely unused, and the
few remaining users were easy to convert into simpler code. Now that
they are gone, we can remove all those macros as well.

The related cpu_is_imx6*() set of function unfortunately is harder
to remove, so those are staying around for now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/cpu.c |   2 -
 arch/arm/mach-imx/mxc.h | 101 ------------------------------------------------
 2 files changed, 103 deletions(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 6a96b7cf468f..b3347d32349f 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -10,8 +10,6 @@
 #include "common.h"
 
 unsigned int __mxc_cpu_type;
-EXPORT_SYMBOL(__mxc_cpu_type);
-
 static unsigned int imx_soc_revision;
 
 void mxc_set_cpu_type(unsigned int type)
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index d32704256781..34f2ff62583c 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -45,105 +45,7 @@
 
 #ifndef __ASSEMBLY__
 extern unsigned int __mxc_cpu_type;
-#endif
-
-#ifdef CONFIG_SOC_IMX1
-# ifdef mxc_cpu_type
-#  undef mxc_cpu_type
-#  define mxc_cpu_type __mxc_cpu_type
-# else
-#  define mxc_cpu_type MXC_CPU_MX1
-# endif
-# define cpu_is_mx1()		(mxc_cpu_type == MXC_CPU_MX1)
-#else
-# define cpu_is_mx1()		(0)
-#endif
-
-#ifdef CONFIG_SOC_IMX21
-# ifdef mxc_cpu_type
-#  undef mxc_cpu_type
-#  define mxc_cpu_type __mxc_cpu_type
-# else
-#  define mxc_cpu_type MXC_CPU_MX21
-# endif
-# define cpu_is_mx21()		(mxc_cpu_type == MXC_CPU_MX21)
-#else
-# define cpu_is_mx21()		(0)
-#endif
 
-#ifdef CONFIG_SOC_IMX25
-# ifdef mxc_cpu_type
-#  undef mxc_cpu_type
-#  define mxc_cpu_type __mxc_cpu_type
-# else
-#  define mxc_cpu_type MXC_CPU_MX25
-# endif
-# define cpu_is_mx25()		(mxc_cpu_type == MXC_CPU_MX25)
-#else
-# define cpu_is_mx25()		(0)
-#endif
-
-#ifdef CONFIG_SOC_IMX27
-# ifdef mxc_cpu_type
-#  undef mxc_cpu_type
-#  define mxc_cpu_type __mxc_cpu_type
-# else
-#  define mxc_cpu_type MXC_CPU_MX27
-# endif
-# define cpu_is_mx27()		(mxc_cpu_type == MXC_CPU_MX27)
-#else
-# define cpu_is_mx27()		(0)
-#endif
-
-#ifdef CONFIG_SOC_IMX31
-# ifdef mxc_cpu_type
-#  undef mxc_cpu_type
-#  define mxc_cpu_type __mxc_cpu_type
-# else
-#  define mxc_cpu_type MXC_CPU_MX31
-# endif
-# define cpu_is_mx31()		(mxc_cpu_type == MXC_CPU_MX31)
-#else
-# define cpu_is_mx31()		(0)
-#endif
-
-#ifdef CONFIG_SOC_IMX35
-# ifdef mxc_cpu_type
-#  undef mxc_cpu_type
-#  define mxc_cpu_type __mxc_cpu_type
-# else
-#  define mxc_cpu_type MXC_CPU_MX35
-# endif
-# define cpu_is_mx35()		(mxc_cpu_type == MXC_CPU_MX35)
-#else
-# define cpu_is_mx35()		(0)
-#endif
-
-#ifdef CONFIG_SOC_IMX51
-# ifdef mxc_cpu_type
-#  undef mxc_cpu_type
-#  define mxc_cpu_type __mxc_cpu_type
-# else
-#  define mxc_cpu_type MXC_CPU_MX51
-# endif
-# define cpu_is_mx51()		(mxc_cpu_type == MXC_CPU_MX51)
-#else
-# define cpu_is_mx51()		(0)
-#endif
-
-#ifdef CONFIG_SOC_IMX53
-# ifdef mxc_cpu_type
-#  undef mxc_cpu_type
-#  define mxc_cpu_type __mxc_cpu_type
-# else
-#  define mxc_cpu_type MXC_CPU_MX53
-# endif
-# define cpu_is_mx53()		(mxc_cpu_type == MXC_CPU_MX53)
-#else
-# define cpu_is_mx53()		(0)
-#endif
-
-#ifndef __ASSEMBLY__
 #ifdef CONFIG_SOC_IMX6SL
 static inline bool cpu_is_imx6sl(void)
 {
@@ -190,9 +92,6 @@ int tzic_enable_wake(void);
 extern struct cpu_op *(*get_cpu_op)(int *op);
 #endif
 
-#define cpu_is_mx3()	(cpu_is_mx31() || cpu_is_mx35())
-#define cpu_is_mx2()	(cpu_is_mx21() || cpu_is_mx27())
-
 #define imx_readl	readl_relaxed
 #define imx_readw	readw_relaxed
 #define imx_writel	writel_relaxed
-- 
2.9.0
