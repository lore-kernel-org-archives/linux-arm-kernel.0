From: zhizhouzhang@asrmicro.com (Zhizhou Zhang)
Date: Wed, 5 Sep 2018 16:19:43 +0800
Subject: [PATCH] arm64: don't account for cpu offline time with irqsoff tracer
Message-ID: <1536135583-6607-1-git-send-email-zhizhouzhang@asrmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is no need to account for cpu offline time with irqsoff tracer.
We can trigger a large irqsoff latency with below commands:

$ echo irqsoff > /sys/kernel/debug/tracing/current_tracer
$ echo 0 > /sys/kernel/debug/tracing/options/function-trace
$ echo 1 > /sys/kernel/debug/tracing/tracing_on
$ echo 0 > /sys/devices/system/cpu/cpu1/online
$ # wait a while ...
$ echo 1 > /sys/devices/system/cpu/cpu1/online
$ cat /sys/kernel/debug/tracing/trace

Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
---
 arch/arm64/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 25fcd22..faed8f6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -346,6 +346,7 @@ void cpu_die(void)
 	idle_task_exit();
 
 	local_daif_mask();
+	stop_critical_timings();
 
 	/* Tell __cpu_die() that this CPU is now safe to dispose of */
 	(void)cpu_report_death();
-- 
1.9.1
