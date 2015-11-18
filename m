From: yang.shi@linaro.org (Yang Shi)
Date: Wed, 18 Nov 2015 10:48:55 -0800
Subject: [V2 PATCH] arm64: restore bogomips information in /proc/cpuinfo
Message-ID: <1447872535-31117-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As what Pavel Machek reported [1], some userspace applications depend on
bogomips showed by /proc/cpuinfo.

Although there is much less legacy impact on aarch64 than arm, but it does
break libvirt.

Basically, this patch reverts commit 326b16db9f69fd0d279be873c6c00f88c0a4aad5
("arm64: delay: don't bother reporting bogomips in /proc/cpuinfo"), but with
some tweak due to context change.

[1] https://lkml.org/lkml/2015/1/4/132

Acked-by: Will Deacon <will.deacon@arm.com>
Cc: <stable@vger.kernel.org> #3.12+
Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
V2 --> V1:
* Remove double new line and unnecessary bogomips sum info

 arch/arm64/kernel/cpuinfo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 706679d..212ae63 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -30,6 +30,7 @@
 #include <linux/seq_file.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
+#include <linux/delay.h>
 
 /*
  * In case the boot CPU is hotpluggable, we record its initial state and
@@ -112,6 +113,10 @@ static int c_show(struct seq_file *m, void *v)
 		 */
 		seq_printf(m, "processor\t: %d\n", i);
 
+		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
+			   loops_per_jiffy / (500000UL/HZ),
+			   loops_per_jiffy / (5000UL/HZ) % 100);
+
 		/*
 		 * Dump out the common processor features in a single line.
 		 * Userspace should read the hwcaps with getauxval(AT_HWCAP)
-- 
2.0.2
