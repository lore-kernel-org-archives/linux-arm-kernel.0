From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 20 Aug 2011 14:05:58 +0900
Subject: [PATCH 3/4] ARM: SAMSUNG: Add support for handling of cpu revision
In-Reply-To: <1313816759-14564-1-git-send-email-kgene.kim@samsung.com>
References: <1313816759-14564-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1313816759-14564-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds plat-samsung/cpu.c for detecting of cpu id and
silicon revision.

This patch was originally from Changhwan Youn <chaos.youn@samsung.com>

Acked-by: Changhwan Youn <chaos.youn@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/cpu.c              |   10 +----
 arch/arm/plat-s3c24xx/cpu.c              |    1 +
 arch/arm/plat-s5p/cpu.c                  |    4 ++-
 arch/arm/plat-samsung/Makefile           |    2 +-
 arch/arm/plat-samsung/cpu.c              |   58 ++++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/cpu.h |    4 ++
 arch/arm/plat-samsung/init.c             |    1 -
 7 files changed, 69 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/plat-samsung/cpu.c

diff --git a/arch/arm/mach-s3c64xx/cpu.c b/arch/arm/mach-s3c64xx/cpu.c
index 7b665f3..6c498f9 100644
--- a/arch/arm/mach-s3c64xx/cpu.c
+++ b/arch/arm/mach-s3c64xx/cpu.c
@@ -144,14 +144,8 @@ void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
 	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
 	iotable_init(mach_desc, size);
 
-	samsung_cpu_id = __raw_readl(S3C_VA_SYS + 0x118);
-	if (!samsung_cpu_id) {
-		/* S3C6400 has the ID register in a different place,
-		 * and needs a write before it can be read. */
-
-		__raw_writel(0x0, S3C_VA_SYS + 0xA1C);
-		samsung_cpu_id = __raw_readl(S3C_VA_SYS + 0xA1C);
-	}
+	/* detect cpu id */
+	s3c64xx_init_cpu();
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
 }
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index ead21a4..3c63353 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -224,6 +224,7 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 	} else {
 		samsung_cpu_id = s3c24xx_read_idcode_v4();
 	}
+	s3c24xx_init_cpu();
 
 	arm_pm_restart = s3c24xx_pm_restart;
 
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index 3ef6734..04392c7 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -119,6 +119,8 @@ void __init s5p_init_io(struct map_desc *mach_desc,
 	if (mach_desc)
 		iotable_init(mach_desc, size);
 
-	samsung_cpu_id = __raw_readl(cpuid_addr);
+	/* detect cpu id and rev. */
+	s5p_init_cpu(cpuid_addr);
+
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
 }
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 853764b..3de756d 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -11,7 +11,7 @@ obj-				:=
 
 # Objects we always build independent of SoC choice
 
-obj-y				+= init.o
+obj-y				+= init.o cpu.o
 obj-$(CONFIG_ARCH_USES_GETTIMEOFFSET)   += time.o
 obj-y				+= clock.o
 obj-y				+= pwm-clock.o
diff --git a/arch/arm/plat-samsung/cpu.c b/arch/arm/plat-samsung/cpu.c
new file mode 100644
index 0000000..fb3b293
--- /dev/null
+++ b/arch/arm/plat-samsung/cpu.c
@@ -0,0 +1,58 @@
+/* linux/arch/arm/plat-samsung/cpu.c
+ *
+ * Copyright (c) 2009-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung CPU Support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <asm/system.h>
+
+#include <mach/map.h>
+#include <plat/cpu.h>
+
+unsigned long samsung_cpu_id;
+static unsigned int samsung_cpu_rev;
+
+unsigned int samsung_rev(void)
+{
+	return samsung_cpu_rev;
+}
+EXPORT_SYMBOL(samsung_rev);
+
+void __init s3c24xx_init_cpu(void)
+{
+	/* nothing here yet */
+
+	samsung_cpu_rev = 0;
+}
+
+void __init s3c64xx_init_cpu(void)
+{
+	samsung_cpu_id = __raw_readl(S3C_VA_SYS + 0x118);
+	if (!samsung_cpu_id) {
+		/*
+		 * S3C6400 has the ID register in a different place,
+		 * and needs a write before it can be read.
+		 */
+		__raw_writel(0x0, S3C_VA_SYS + 0xA1C);
+		samsung_cpu_id = __raw_readl(S3C_VA_SYS + 0xA1C);
+	}
+
+	samsung_cpu_rev = 0;
+}
+
+void __init s5p_init_cpu(void __iomem *cpuid_addr)
+{
+	samsung_cpu_id = __raw_readl(cpuid_addr);
+	samsung_cpu_rev = samsung_cpu_id & 0xF;
+}
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index b762b37..16238c8 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -140,6 +140,10 @@ extern void s3c64xx_init_io(struct map_desc *mach_desc, int size);
 extern void s5p_init_io(struct map_desc *mach_desc,
 			int size, void __iomem *cpuid_addr);
 
+extern void s3c24xx_init_cpu(void);
+extern void s3c64xx_init_cpu(void);
+extern void s5p_init_cpu(void __iomem *cpuid_addr);
+
 extern void s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 
 extern void s3c24xx_init_clocks(int xtal);
diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
index 40b1228..79d10fc 100644
--- a/arch/arm/plat-samsung/init.c
+++ b/arch/arm/plat-samsung/init.c
@@ -30,7 +30,6 @@
 #include <plat/regs-serial.h>
 
 static struct cpu_table *cpu;
-unsigned long samsung_cpu_id;
 
 static struct cpu_table * __init s3c_lookup_cpu(unsigned long idcode,
 						struct cpu_table *tab,
-- 
1.7.1
