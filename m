From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 18 Mar 2014 17:01:59 +0200
Subject: [linux-next][regression] [PATCH] percpu: add preemption checks to
 __this_cpu ops
Message-ID: <53285FE7.5010203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

The regression is observed in the current linux-next on ARM Keystone 2 SoC:
- system is booted till console and in a second or two and then stall, no messages displayed
(CONFIG_DEBUG_PREEMPT=y).

The cause of regression has been bisected to the commit:

commit 589a606f9539663f162e4a110d117527833b58a4
Author: Christoph Lameter <cl@linux.com>
Date:   Mon Mar 17 11:27:41 2014 +1100

    percpu: add preemption checks to __this_cpu ops
    
    We define a check function in order to avoid trouble with the include
    files.  Then the higher level __this_cpu macros are modified to invoke the
    preemption check.
    
    Signed-off-by: Christoph Lameter <cl@linux.com>
    Acked-by: Ingo Molnar <mingo@kernel.org>
    Cc: Tejun Heo <tj@kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[=== 1 ===]
If above patch is reverted - system can boot again.

[=== 2 ===]
If I apply below change - system can boot again.

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index a270dce..73a2004 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -58,9 +58,6 @@ EXPORT_SYMBOL(debug_smp_processor_id);
 
 notrace void __this_cpu_preempt_check(const char *op)
 {
-       char text[40];
-
-       snprintf(text, sizeof(text), "__this_cpu_%s()", op);
-       check_preemption_disabled(text);
+       check_preemption_disabled(op);
 }
 EXPORT_SYMBOL(__this_cpu_preempt_check);


linux-next top commits:
3bd688c Add linux-next specific files for 20140318
9a63a74 Merge branch 'akpm/master'
ccdf335 mm: add strictlimit knob
589a606 percpu: add preemption checks to __this_cpu ops
cdbd87c net: replace __this_cpu_inc in route.c with raw_cpu_inc
049fcfe modules: use raw_cpu_write for initialization of per cpu refcount.
b46b094 mm: use raw_cpu ops for determining current NUMA node
d934df8 percpu: add raw_cpu_ops
c4a8790 arm: move arm_dma_limit to setup_dma_zone

Regards,
-grygorii
