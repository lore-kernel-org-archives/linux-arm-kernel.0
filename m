From: chao.xie@marvell.com (Chao Xie)
Date: Fri, 21 Mar 2014 15:01:58 +0800
Subject: [PATCH 1/2] ARM: add cpu_is_pj4() to distinguish PJ4 core
Message-ID: <1395385319-25386-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PJ4 is based on V7, but it has some changes. For example, some
coprocessor settings.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/include/asm/cputype.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 42f0889..c651e3b 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -221,4 +221,23 @@ static inline int cpu_is_xsc3(void)
 #define	cpu_is_xscale()	1
 #endif
 
+/*
+ * Marvell's PJ4 core is based on V7 version. It has some modification
+ * for coprocessor setting. For this reason, we need a way to distinguish
+ * it.
+ */
+#ifndef CONFIG_CPU_PJ4
+#define cpu_is_pj4()	0
+#else
+static inline int cpu_is_pj4(void)
+{
+	unsigned int id;
+
+	id = read_cpuid_id();
+	if ((id & 0xfffffff0) == 0x562f5840)
+		return 1;
+
+	return 0;
+}
+#endif
 #endif
-- 
1.8.3.2
