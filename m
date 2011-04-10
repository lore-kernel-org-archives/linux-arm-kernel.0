From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 10 Apr 2011 21:49:02 +0200
Subject: [PATCH 5/6] ARM: mx3: make ioremap quirk ready for multi-SoC kernels
In-Reply-To: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1302464943-20721-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to compile e.g. i.MX31 and i.MX51 in a single kernel image
the ioremap quirk needs a runtime check.

While touching this code make the comment more understandable by adding
a sentence from the commit log that introduced it
(eadefef ([ARM] MX3: Use ioremap wrapper to map SoC devices nonshared)).

As mach/io.h now uses cpu_is_ some header reshuffling in mach/hardware.h
was necessary. (mach/mx27.h and mach/mx31.h #include <linux/io.h> which
\#includes <mach/io.h>. So mach/mxc.h which provides the cpu_is_ macros
needs to be included before mach/mx27.h and mach/mx31.h.)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/hardware.h |    4 ++--
 arch/arm/plat-mxc/include/mach/io.h       |   23 +++++++++++++++--------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index a881db5..67d3e2b 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -95,6 +95,8 @@
 
 #define IMX_IO_ADDRESS(x)	IOMEM(IMX_IO_P2V(x))
 
+#include <mach/mxc.h>
+
 #ifdef CONFIG_ARCH_MX5
 #include <mach/mx50.h>
 #include <mach/mx51.h>
@@ -125,8 +127,6 @@
 # include <mach/mx25.h>
 #endif
 
-#include <mach/mxc.h>
-
 #define imx_map_entry(soc, name, _type)	{				\
 	.virtual = soc ## _IO_P2V(soc ## _ ## name ## _BASE_ADDR),	\
 	.pfn = __phys_to_pfn(soc ## _ ## name ## _BASE_ADDR),		\
diff --git a/arch/arm/plat-mxc/include/mach/io.h b/arch/arm/plat-mxc/include/mach/io.h
index b4f2de7..4347a87 100644
--- a/arch/arm/plat-mxc/include/mach/io.h
+++ b/arch/arm/plat-mxc/include/mach/io.h
@@ -14,19 +14,26 @@
 /* Allow IO space to be anywhere in the memory */
 #define IO_SPACE_LIMIT 0xffffffff
 
-#ifdef CONFIG_ARCH_MX3
-#define __arch_ioremap __mx3_ioremap
+#if defined(CONFIG_SOC_IMX31) || defined(CONFIG_SOC_IMX35)
+#include <mach/hardware.h>
+
+#define __arch_ioremap __imx_ioremap
 #define __arch_iounmap __iounmap
 
+#define addr_in_module(addr, mod) \
+	((unsigned long)(addr) - mod ## _BASE_ADDR < mod ## _SIZE)
+
 static inline void __iomem *
-__mx3_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
+__imx_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
 {
-	if (mtype == MT_DEVICE) {
-		/* Access all peripherals below 0x80000000 as nonshared device
-		 * but leave l2cc alone.
+	if (mtype == MT_DEVICE && (cpu_is_mx31() || cpu_is_mx35())) {
+		/*
+		 * Access all peripherals below 0x80000000 as nonshared device
+		 * on mx3, but leave l2cc alone.  Otherwise cache corruptions
+		 * can occur.
 		 */
-		if ((phys_addr < 0x80000000) && ((phys_addr < 0x30000000) ||
-			(phys_addr >= 0x30000000 + SZ_1M)))
+		if (phys_addr < 0x80000000 &&
+				!addr_in_module(phys_addr, MX3x_L2CC))
 			mtype = MT_DEVICE_NONSHARED;
 	}
 
-- 
1.7.2.3
