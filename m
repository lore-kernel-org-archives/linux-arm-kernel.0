From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Wed, 16 Sep 2009 14:59:36 +0900
Subject: [PATCH] Samsung SoCs: Cpu detection support (v3)
Message-ID: <20090916055936.GA13338@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Store the CPU ID to cpu_id variable and use it to detect CPU

On S3C64XX, Some pheripherals such as OneNAND have different configuration
and handle it differently to do this it needs to detect CPU ID.

Also S5PC1XX is supported.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/plat-s3c/init.c b/arch/arm/plat-s3c/init.c
index 6790edf..b3bc18f 100644
--- a/arch/arm/plat-s3c/init.c
+++ b/arch/arm/plat-s3c/init.c
@@ -31,6 +31,45 @@
 
 static struct cpu_table *cpu;
 
+static unsigned long cpu_id;
+
+unsigned long samsung_cpu_id(void)
+{
+        return cpu_id;
+}
+EXPORT_SYMBOL(samsung_cpu_id);
+
+static void __init set_cpu_id(unsigned int idcode)
+{
+	/*
+	 * cpu_id encoding is as follows
+	 * cpu_id & 0xff000000 -> S3C Class (24xx/64xx/C1xx)
+	 * cpu_id & 0xfff00000 -> S3C Sub Class (241x/244x)
+	 * cpu_id & 0xffff0000 -> S3C Type (2410/2440/6400/6410/C100/C110)
+	 *
+	 * Remains[15:0] are reserved
+	 *
+	 * 24xx/64xx is started from 0x30000000
+	 * C1xx is started from 0x40000000
+	 *
+	 * Exception:
+	 *  Store Revision A to 1 such as
+	 *  s3c2410A to s3c2411
+	 *  s3c2440A to s3c2441
+	 */
+	if ((idcode >> 28) == 0x4)
+		cpu_id = 0xC0000000 | ((idcode & 0x00fff000) << 4);
+	else
+		cpu_id = (idcode & 0x0ffff000) << 4;
+
+	if (idcode == 0x32410002 || idcode == 0x32440001)
+		cpu_id |= (0x1 << 16);
+	if (idcode == 0x32440aaa)       /* s3c2442 */
+		cpu_id |= (0x2 << 16);
+	if (idcode == 0x0)              /* s3c2400 */
+		cpu_id |= (0x2400 << 16);
+}
+
 static struct cpu_table * __init s3c_lookup_cpu(unsigned long idcode,
 						struct cpu_table *tab,
 						unsigned int count)
@@ -53,6 +92,8 @@ void __init s3c_init_cpu(unsigned long idcode,
 		panic("Unknown S3C24XX CPU");
 	}
 
+	set_cpu_id(idcode);
+
 	printk("CPU %s (id 0x%08lx)\n", cpu->name, idcode);
 
 	if (cpu->map_io == NULL || cpu->init == NULL) {
