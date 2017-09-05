From: cj.chengjian@huawei.com (Cheng Jian)
Date: Tue, 5 Sep 2017 19:03:13 +0800
Subject: [PATCH] arm64: Convert pr_warning to standard pr_warn for arm64
Message-ID: <1504609393-66164-1-git-send-email-cj.chengjian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch convert pr_warning to standard pr_warn for arm64.

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 arch/arm64/include/asm/syscall.h  | 4 ++--
 arch/arm64/kernel/hw_breakpoint.c | 8 ++++----
 arch/arm64/kernel/smp.c           | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 709a574..515d52b 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -68,7 +68,7 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	if (i + n > SYSCALL_MAX_ARGS) {
 		unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
 		unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
-		pr_warning("%s called with max args %d, handling only %d\n",
+		pr_warn("%s called with max args %d, handling only %d\n",
 			   __func__, i + n, SYSCALL_MAX_ARGS);
 		memset(args_bad, 0, n_bad * sizeof(args[0]));
 	}
@@ -92,7 +92,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
 		return;
 
 	if (i + n > SYSCALL_MAX_ARGS) {
-		pr_warning("%s called with max args %d, handling only %d\n",
+		pr_warn("%s called with max args %d, handling only %d\n",
 			   __func__, i + n, SYSCALL_MAX_ARGS);
 		n = SYSCALL_MAX_ARGS - i;
 	}
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 749f817..9ac4213 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -63,7 +63,7 @@ int hw_breakpoint_slots(int type)
 	case TYPE_DATA:
 		return get_num_wrps();
 	default:
-		pr_warning("unknown slot type: %d\n", type);
+		pr_warn("unknown slot type: %d\n", type);
 		return 0;
 	}
 }
@@ -124,7 +124,7 @@ static u64 read_wb_reg(int reg, int n)
 	GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_WVR, AARCH64_DBG_REG_NAME_WVR, val);
 	GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_WCR, AARCH64_DBG_REG_NAME_WCR, val);
 	default:
-		pr_warning("attempt to read from unknown breakpoint register %d\n", n);
+		pr_warn("attempt to read from unknown breakpoint register %d\n", n);
 	}
 
 	return val;
@@ -139,7 +139,7 @@ static void write_wb_reg(int reg, int n, u64 val)
 	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_WVR, AARCH64_DBG_REG_NAME_WVR, val);
 	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_WCR, AARCH64_DBG_REG_NAME_WCR, val);
 	default:
-		pr_warning("attempt to write to unknown breakpoint register %d\n", n);
+		pr_warn("attempt to write to unknown breakpoint register %d\n", n);
 	}
 	isb();
 }
@@ -157,7 +157,7 @@ static enum dbg_active_el debug_exception_level(int privilege)
 	case AARCH64_BREAKPOINT_EL1:
 		return DBG_ACTIVE_EL1;
 	default:
-		pr_warning("invalid breakpoint privilege level %d\n", privilege);
+		pr_warn("invalid breakpoint privilege level %d\n", privilege);
 		return -EINVAL;
 	}
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 9f7195a..efcaa05 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -972,7 +972,7 @@ void smp_send_stop(void)
 		udelay(1);
 
 	if (num_online_cpus() > 1)
-		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
+		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
 			   cpumask_pr_args(cpu_online_mask));
 }
 
@@ -1009,7 +1009,7 @@ void crash_smp_send_stop(void)
 		udelay(1);
 
 	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
+		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
 			   cpumask_pr_args(&mask));
 }
 
-- 
1.8.3.1
