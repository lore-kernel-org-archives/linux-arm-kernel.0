From: joe@perches.com (Joe Perches)
Date: Thu, 16 Feb 2017 23:11:16 -0800
Subject: [PATCH 03/35] arm64: Convert remaining uses of pr_warning to pr_warn
In-Reply-To: <cover.1487314666.git.joe@perches.com>
References: <cover.1487314666.git.joe@perches.com>
Message-ID: <74c2cc72b91dbe639f153c601900f7f46a920fb9.1487314666.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable eventual removal of pr_warning

This makes pr_warn use consistent for arch/arm64

Prior to this patch, there were 7 uses of pr_warning and
27 uses of pr_warn in arch/arm64

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm64/include/asm/syscall.h  | 8 ++++----
 arch/arm64/kernel/hw_breakpoint.c | 8 ++++----
 arch/arm64/kernel/smp.c           | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 709a574468f0..231f2c3fcf81 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -68,8 +68,8 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	if (i + n > SYSCALL_MAX_ARGS) {
 		unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
 		unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
-		pr_warning("%s called with max args %d, handling only %d\n",
-			   __func__, i + n, SYSCALL_MAX_ARGS);
+		pr_warn("%s called with max args %d, handling only %d\n",
+			__func__, i + n, SYSCALL_MAX_ARGS);
 		memset(args_bad, 0, n_bad * sizeof(args[0]));
 	}
 
@@ -92,8 +92,8 @@ static inline void syscall_set_arguments(struct task_struct *task,
 		return;
 
 	if (i + n > SYSCALL_MAX_ARGS) {
-		pr_warning("%s called with max args %d, handling only %d\n",
-			   __func__, i + n, SYSCALL_MAX_ARGS);
+		pr_warn("%s called with max args %d, handling only %d\n",
+			__func__, i + n, SYSCALL_MAX_ARGS);
 		n = SYSCALL_MAX_ARGS - i;
 	}
 
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 0296e7924240..6fa79ffd0c43 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -62,7 +62,7 @@ int hw_breakpoint_slots(int type)
 	case TYPE_DATA:
 		return get_num_wrps();
 	default:
-		pr_warning("unknown slot type: %d\n", type);
+		pr_warn("unknown slot type: %d\n", type);
 		return 0;
 	}
 }
@@ -123,7 +123,7 @@ static u64 read_wb_reg(int reg, int n)
 	GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_WVR, AARCH64_DBG_REG_NAME_WVR, val);
 	GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_WCR, AARCH64_DBG_REG_NAME_WCR, val);
 	default:
-		pr_warning("attempt to read from unknown breakpoint register %d\n", n);
+		pr_warn("attempt to read from unknown breakpoint register %d\n", n);
 	}
 
 	return val;
@@ -138,7 +138,7 @@ static void write_wb_reg(int reg, int n, u64 val)
 	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_WVR, AARCH64_DBG_REG_NAME_WVR, val);
 	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_WCR, AARCH64_DBG_REG_NAME_WCR, val);
 	default:
-		pr_warning("attempt to write to unknown breakpoint register %d\n", n);
+		pr_warn("attempt to write to unknown breakpoint register %d\n", n);
 	}
 	isb();
 }
@@ -156,7 +156,7 @@ static enum dbg_active_el debug_exception_level(int privilege)
 	case AARCH64_BREAKPOINT_EL1:
 		return DBG_ACTIVE_EL1;
 	default:
-		pr_warning("invalid breakpoint privilege level %d\n", privilege);
+		pr_warn("invalid breakpoint privilege level %d\n", privilege);
 		return -EINVAL;
 	}
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 827d52d78b67..9c396e34c090 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -925,8 +925,8 @@ void smp_send_stop(void)
 		udelay(1);
 
 	if (num_online_cpus() > 1)
-		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
-			   cpumask_pr_args(cpu_online_mask));
+		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
+			cpumask_pr_args(cpu_online_mask));
 }
 
 /*
-- 
2.10.0.rc2.1.g053435c
