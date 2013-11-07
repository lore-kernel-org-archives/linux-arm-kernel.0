From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Thu,  7 Nov 2013 18:08:41 +0530
Subject: [RFC v1 PATCH] ARM64: KGDB: Add FP/SIMD debug support
In-Reply-To: <1383827921-18526-1-git-send-email-vijay.kilari@gmail.com>
References: <1383827921-18526-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1383827921-18526-2-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Add KGDB debug support for FP/SIMD processor.This support
only debugging of FP/SIMD in kernel mode.
With this patch one can view or set FP/SIMD registers in
kernel context

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
---
 arch/arm64/kernel/kgdb.c |   98 ++++++++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index f10f2ba..07d3d00 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -23,6 +23,14 @@
 #include <linux/kdebug.h>
 #include <linux/kgdb.h>
 #include <asm/traps.h>
+#include <asm/fpsimd.h>
+
+#ifdef CONFIG_KERNEL_MODE_NEON
+/*
+ * Structure to hold FP/SIMD register contents
+ */
+struct fpsimd_state kgdb_fpsimd_regs;
+#endif
 
 struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
 	{ "x0", 8, offsetof(struct pt_regs, regs[0])},
@@ -59,40 +67,40 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
 	{ "sp", 8, offsetof(struct pt_regs, sp)},
 	{ "pc", 8, offsetof(struct pt_regs, pc)},
 	{ "pstate", 4, offsetof(struct pt_regs, pstate)},
-	{ "v0", 16, -1 },
-	{ "v1", 16, -1 },
-	{ "v2", 16, -1 },
-	{ "v3", 16, -1 },
-	{ "v4", 16, -1 },
-	{ "v5", 16, -1 },
-	{ "v6", 16, -1 },
-	{ "v7", 16, -1 },
-	{ "v8", 16, -1 },
-	{ "v9", 16, -1 },
-	{ "v10", 16, -1 },
-	{ "v11", 16, -1 },
-	{ "v12", 16, -1 },
-	{ "v13", 16, -1 },
-	{ "v14", 16, -1 },
-	{ "v15", 16, -1 },
-	{ "v16", 16, -1 },
-	{ "v17", 16, -1 },
-	{ "v18", 16, -1 },
-	{ "v19", 16, -1 },
-	{ "v20", 16, -1 },
-	{ "v21", 16, -1 },
-	{ "v22", 16, -1 },
-	{ "v23", 16, -1 },
-	{ "v24", 16, -1 },
-	{ "v25", 16, -1 },
-	{ "v26", 16, -1 },
-	{ "v27", 16, -1 },
-	{ "v28", 16, -1 },
-	{ "v29", 16, -1 },
-	{ "v30", 16, -1 },
-	{ "v31", 16, -1 },
-	{ "fpsr", 4, -1 },
-	{ "fpcr", 4, -1 },
+	{ "v0", 16, offsetof(struct fpsimd_state, vregs[0])},
+	{ "v1", 16, offsetof(struct fpsimd_state, vregs[1])},
+	{ "v2", 16, offsetof(struct fpsimd_state, vregs[2])},
+	{ "v3", 16, offsetof(struct fpsimd_state, vregs[3])},
+	{ "v4", 16, offsetof(struct fpsimd_state, vregs[4])},
+	{ "v5", 16, offsetof(struct fpsimd_state, vregs[5])},
+	{ "v6", 16, offsetof(struct fpsimd_state, vregs[6])},
+	{ "v7", 16, offsetof(struct fpsimd_state, vregs[7])},
+	{ "v8", 16, offsetof(struct fpsimd_state, vregs[8])},
+	{ "v9", 16, offsetof(struct fpsimd_state, vregs[9])},
+	{ "v10", 16, offsetof(struct fpsimd_state, vregs[10])},
+	{ "v11", 16, offsetof(struct fpsimd_state, vregs[11])},
+	{ "v12", 16, offsetof(struct fpsimd_state, vregs[12])},
+	{ "v13", 16, offsetof(struct fpsimd_state, vregs[13])},
+	{ "v14", 16, offsetof(struct fpsimd_state, vregs[14])},
+	{ "v15", 16, offsetof(struct fpsimd_state, vregs[15])},
+	{ "v16", 16, offsetof(struct fpsimd_state, vregs[16])},
+	{ "v17", 16, offsetof(struct fpsimd_state, vregs[17])},
+	{ "v18", 16, offsetof(struct fpsimd_state, vregs[18])},
+	{ "v19", 16, offsetof(struct fpsimd_state, vregs[19])},
+	{ "v20", 16, offsetof(struct fpsimd_state, vregs[20])},
+	{ "v21", 16, offsetof(struct fpsimd_state, vregs[21])},
+	{ "v22", 16, offsetof(struct fpsimd_state, vregs[22])},
+	{ "v23", 16, offsetof(struct fpsimd_state, vregs[23])},
+	{ "v24", 16, offsetof(struct fpsimd_state, vregs[24])},
+	{ "v25", 16, offsetof(struct fpsimd_state, vregs[25])},
+	{ "v26", 16, offsetof(struct fpsimd_state, vregs[26])},
+	{ "v27", 16, offsetof(struct fpsimd_state, vregs[27])},
+	{ "v28", 16, offsetof(struct fpsimd_state, vregs[28])},
+	{ "v29", 16, offsetof(struct fpsimd_state, vregs[29])},
+	{ "v30", 16, offsetof(struct fpsimd_state, vregs[30])},
+	{ "v31", 16, offsetof(struct fpsimd_state, vregs[31])},
+	{ "fpsr", 4, offsetof(struct fpsimd_state, fpsr)},
+	{ "fpcr", 4, offsetof(struct fpsimd_state, fpcr)},
 };
 
 char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
@@ -100,11 +108,18 @@ char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
 	if (regno >= DBG_MAX_REG_NUM || regno < 0)
 		return NULL;
 
-	if (dbg_reg_def[regno].offset != -1)
+	if (dbg_reg_def[regno].offset != -1 && regno < _GP_REGS)
 		memcpy(mem, (void *)regs + dbg_reg_def[regno].offset,
 		       dbg_reg_def[regno].size);
-	else
+	else {
+#ifdef CONFIG_KERNEL_MODE_NEON
+		fpsimd_save_state(&kgdb_fpsimd_regs);
+		memcpy(mem, (void *)&kgdb_fpsimd_regs +
+			dbg_reg_def[regno].offset, dbg_reg_def[regno].size);
+#else
 		memset(mem, 0, dbg_reg_def[regno].size);
+#endif
+	}
 	return dbg_reg_def[regno].name;
 }
 
@@ -113,9 +128,16 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
 	if (regno >= DBG_MAX_REG_NUM || regno < 0)
 		return -EINVAL;
 
-	if (dbg_reg_def[regno].offset != -1)
+	if (dbg_reg_def[regno].offset != -1 && regno < _GP_REGS)
 		memcpy((void *)regs + dbg_reg_def[regno].offset, mem,
-		       dbg_reg_def[regno].size);
+			dbg_reg_def[regno].size);
+#ifdef CONFIG_KERNEL_MODE_NEON
+	else {
+		memcpy((void *)&kgdb_fpsimd_regs + dbg_reg_def[regno].offset,
+			mem, dbg_reg_def[regno].size);
+		fpsimd_load_state(&kgdb_fpsimd_regs);
+	}
+#endif
 	return 0;
 }
 
-- 
1.7.9.5
