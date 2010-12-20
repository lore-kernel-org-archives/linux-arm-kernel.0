From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 20 Dec 2010 13:55:22 +0530
Subject: [PATCH V3 01/63] ARM: move sev definition to common system.h include
	file
In-Reply-To: <cover.1292833228.git.viresh.kumar@st.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
Message-ID: <bba96776f330b7a56c567e51086b78e9325acb57.1292833228.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

sev is used to send wakeup event to other cores in ARMv6K and above.
This has been moved from platform specific part to standard common
ARM header file (asm/system.h). Also introduced wfi() and wfe().

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 arch/arm/include/asm/system.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 1120f18..9ab8d7e 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -119,6 +119,13 @@ extern unsigned int user_debug;
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
-- 
1.7.2.2
