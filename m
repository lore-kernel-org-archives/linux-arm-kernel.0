From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:21 +0530
Subject: [PATCH V2 01/69] ARM: move sev definition to common system.h include
	file
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <6f030a362bb051f8d97264f01c6d8302a2d038bb.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

sev is used to send wakeup event to other cores in ARMv6K and above.
This has been moved from platform specific part to standard common
ARM header file (asm/system.h). Also introduced wfi() and wfe().

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 arch/arm/include/asm/system.h  |    7 +++++++
 arch/arm/mach-omap2/omap-smp.c |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 8ba1ccf..2143d17 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -115,6 +115,13 @@ extern unsigned int user_debug;
 #define vectors_high()	(0)
 #endif
 
+#if __LINUX_ARM_ARCH__ >= 7 ||		\
+	(__LINUX_ARM_ARCH__ == 6 && defined(CONFIG_CPU_32v6K))
+#define sev()	__asm__ __volatile__ ("sev" : : : "memory")
+#define wfe()	__asm__ __volatile__ ("wfe" : : : "memory")
+#define wfi()	__asm__ __volatile__ ("wfi" : : : "memory")
+#endif
+
 #if __LINUX_ARM_ARCH__ >= 7
 #define isb() __asm__ __volatile__ ("isb" : : : "memory")
 #define dsb() __asm__ __volatile__ ("dsb" : : : "memory")
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 9e9f70e..c338efab 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -23,6 +23,7 @@
 #include <asm/cacheflush.h>
 #include <asm/localtimer.h>
 #include <asm/smp_scu.h>
+#include <asm/system.h>
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
 
-- 
1.7.2.2
