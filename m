From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Jul 2014 16:22:54 +0200
Subject: [PATCH] ARM: imx: build cpu_is_imx6sl function conditionally
Message-ID: <4295402.oOSEcbAj2f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx6q_pm_enter calls imx6sl_set_wait_clk when run on an imx6sl
based machine. However if support for imx6sl is not enabled
at compile time, this prevents us from building the kernel and
we get this link error instead:

arch/arm/mach-imx/built-in.o: In function `imx6q_pm_enter':
:(.text+0x4b84): undefined reference to `imx6sl_set_wait_clk'

This makes the cpu_is_imx6sl function conditionally return false
if imx6sl is disabled at compile-time, which matches what the
older cpu_is_mx* macros did. We have similar inline functions for
the other imx6 variants, but so far I have not run into a case
where the extra #ifdef is necessary.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 75d6a37..b03b808 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -156,7 +156,11 @@ extern unsigned int __mxc_cpu_type;
 #ifndef __ASSEMBLY__
 static inline bool cpu_is_imx6sl(void)
 {
+#ifdef CONFIG_SOC_IMX6SL
 	return __mxc_cpu_type == MXC_CPU_IMX6SL;
+#else
+	return 0;
+#endif
 }
 
 static inline bool cpu_is_imx6dl(void)
