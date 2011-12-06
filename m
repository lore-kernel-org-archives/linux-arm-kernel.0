From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 6 Dec 2011 16:15:59 +0530
Subject: [PATCH] ARM: davinci: dm368 evm: add support for CPLD version
 specific cpu_is_* macro
Message-ID: <1323168359-17943-1-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>

DM368 and DM365 EVMs have different CPLD versions. This patch
adds function which differentiates DM368 from DM365 EVMs.

Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
---
 arch/arm/mach-davinci/include/mach/common.h  |    1 +
 arch/arm/mach-davinci/include/mach/cputype.h |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index a57cba2..f89cd2a 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -52,6 +52,7 @@ struct davinci_soc_info {
 	u32				cpu_id;
 	u32				jtag_id;
 	u32				jtag_id_reg;
+	u8				cpld_version;
 	struct davinci_id		*ids;
 	unsigned long			ids_num;
 	struct clk_lookup		*cpu_clks;
diff --git a/arch/arm/mach-davinci/include/mach/cputype.h b/arch/arm/mach-davinci/include/mach/cputype.h
index 957fb87..ef02ab1 100644
--- a/arch/arm/mach-davinci/include/mach/cputype.h
+++ b/arch/arm/mach-davinci/include/mach/cputype.h
@@ -49,6 +49,15 @@ IS_DAVINCI_CPU(da830, DAVINCI_CPU_ID_DA830)
 IS_DAVINCI_CPU(da850, DAVINCI_CPU_ID_DA850)
 IS_DAVINCI_CPU(tnetv107x, DAVINCI_CPU_ID_TNETV107X)
 
+#define IS_DAVINCI_CPU_CPLD_VER(type, id, cpld_ver)			\
+static inline int is_davinci_ ##type(void)				\
+{									\
+	return ((davinci_soc_info.cpu_id == (id)) &&			\
+		(davinci_soc_info.cpld_version == (cpld_ver)));		\
+}
+
+IS_DAVINCI_CPU_CPLD_VER(dm368, DAVINCI_CPU_ID_DM365, 0x21)
+
 #ifdef CONFIG_ARCH_DAVINCI_DM644x
 #define cpu_is_davinci_dm644x() is_davinci_dm644x()
 #else
@@ -69,8 +78,10 @@ IS_DAVINCI_CPU(tnetv107x, DAVINCI_CPU_ID_TNETV107X)
 
 #ifdef CONFIG_ARCH_DAVINCI_DM365
 #define cpu_is_davinci_dm365() is_davinci_dm365()
+#define cpu_is_davinci_dm368() is_davinci_dm368()
 #else
 #define cpu_is_davinci_dm365() 0
+#define cpu_is_davinci_dm368() 0
 #endif
 
 #ifdef CONFIG_ARCH_DAVINCI_DA830
-- 
1.7.1
