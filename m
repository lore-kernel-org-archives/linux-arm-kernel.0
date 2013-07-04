From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Thu,  4 Jul 2013 16:45:42 +0200
Subject: [PATCH v3 4/4] ARM: reinsert ARCH_MULTI_V4 Kconfig option
Message-ID: <1372949142-8260-1-git-send-email-jonas.jensen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU_FA526 is thumbless and adding under e.g. ARCH_MULTI_V4T instead means inclusion of CPU_ARM920T
which in turn selects CPU_ABRT_EV4T, CPU_CACHE_V4WT, CPU_COPY_V4WB, CPU_TLB_V4WBI, which in turn can
mean trouble when the kernel eventually tries to exec init:

[    2.580000] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
[    2.580000]
[    2.580000] CPU: 0 PID: 1 Comm: init Not tainted 3.10.0-next-20130703+ #3
[    2.580000] [<c000cc64>] (unwind_backtrace+0x0/0xf0) from [<c000b524>] (show_stack+0x10/0x14)
[    2.580000] [<c000b524>] (show_stack+0x10/0x14) from [<c021d6dc>] (panic+0x90/0x1e0)
[    2.580000] [<c021d6dc>] (panic+0x90/0x1e0) from [<c0019664>] (do_exit+0x724/0x834)
[    2.580000] [<c0019664>] (do_exit+0x724/0x834) from [<c00197d8>] (do_group_exit+0x3c/0xb0)
[    2.580000] [<c00197d8>] (do_group_exit+0x3c/0xb0) from [<c0024c34>] (get_signal_to_deliver+0x2ec/0x598)
[    2.580000] [<c0024c34>] (get_signal_to_deliver+0x2ec/0x598) from [<c021d2a8>] (do_signal+0x9c/0x3cc)
[    2.580000] [<c021d2a8>] (do_signal+0x9c/0x3cc) from [<c000b110>] (do_work_pending+0xc4/0xe0)
[    2.580000] [<c000b110>] (do_work_pending+0xc4/0xe0) from [<c0009334>] (work_pending+0xc/0x20)

Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---
 arch/arm/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d84161c..87e93ab 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -878,6 +878,11 @@ menu "Multiple platform selection"
 
 comment "CPU Core family selection"
 
+config ARCH_MULTI_V4
+	bool "ARMv4 based platforms (FA526, StrongARM)"
+	depends on !ARCH_MULTI_V6_V7
+	select ARCH_MULTI_V4_V5
+
 config ARCH_MULTI_V4T
 	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
 	depends on !ARCH_MULTI_V6_V7
-- 
1.8.2.1
