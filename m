From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Apr 2018 13:11:22 +0100
Subject: [PATCH] arm64: ptrace: remove addr_limit manipulation
Message-ID: <20180424121122.30294-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We transiently switch to KERNEL_DS in compat_ptrace_gethbpregs() and
compat_ptrace_sethbpregs(), but in either case this is pointless as we
don't perform any uaccess during this window.

let's rip out the redundant addr_limit manipulation.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/ptrace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 71d99af24ef2..7a832ce6552f 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1458,9 +1458,7 @@ static int compat_ptrace_gethbpregs(struct task_struct *tsk, compat_long_t num,
 {
 	int ret;
 	u32 kdata;
-	mm_segment_t old_fs = get_fs();
 
-	set_fs(KERNEL_DS);
 	/* Watchpoint */
 	if (num < 0) {
 		ret = compat_ptrace_hbp_get(NT_ARM_HW_WATCH, tsk, num, &kdata);
@@ -1471,7 +1469,6 @@ static int compat_ptrace_gethbpregs(struct task_struct *tsk, compat_long_t num,
 	} else {
 		ret = compat_ptrace_hbp_get(NT_ARM_HW_BREAK, tsk, num, &kdata);
 	}
-	set_fs(old_fs);
 
 	if (!ret)
 		ret = put_user(kdata, data);
@@ -1484,7 +1481,6 @@ static int compat_ptrace_sethbpregs(struct task_struct *tsk, compat_long_t num,
 {
 	int ret;
 	u32 kdata = 0;
-	mm_segment_t old_fs = get_fs();
 
 	if (num == 0)
 		return 0;
@@ -1493,12 +1489,10 @@ static int compat_ptrace_sethbpregs(struct task_struct *tsk, compat_long_t num,
 	if (ret)
 		return ret;
 
-	set_fs(KERNEL_DS);
 	if (num < 0)
 		ret = compat_ptrace_hbp_set(NT_ARM_HW_WATCH, tsk, num, &kdata);
 	else
 		ret = compat_ptrace_hbp_set(NT_ARM_HW_BREAK, tsk, num, &kdata);
-	set_fs(old_fs);
 
 	return ret;
 }
-- 
2.11.0
