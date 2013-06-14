From: chao.xie@marvell.com (Chao Xie)
Date: Fri, 14 Jun 2013 04:42:16 -0400
Subject: [PATCH] arm: pj4: check cpu id for pj4 cp0 access
Message-ID: <1371199336-28027-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check cpu id in pj4_cp0_init. So for no-PJ4 V7 cpus,
pj4_cpu0_init just return.
This fix will help to make the all the V7 cpus(pj4 and no-PJ4)
use same platform code.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/kernel/pj4-cp0.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
index 679cf4d..684dec7 100644
--- a/arch/arm/kernel/pj4-cp0.c
+++ b/arch/arm/kernel/pj4-cp0.c
@@ -18,6 +18,9 @@
 #include <linux/io.h>
 #include <asm/thread_notify.h>
 
+#define CORE_PJ4_MASK	0xfffffff0
+#define CORE_PJ4_ID	0x562f5840
+
 static int iwmmxt_do(struct notifier_block *self, unsigned long cmd, void *t)
 {
 	struct thread_info *thread = t;
@@ -79,6 +82,15 @@ static void __init pj4_cp_access_write(u32 value)
 static int __init pj4_cp0_init(void)
 {
 	u32 cp_access;
+	u32 cpuid;
+
+	__asm__ __volatile__ (
+		"mrc	p15, 0, %0, c0, c0\n\t"
+		: "=r" (cpuid));
+
+	/* If it is not a pj4 core, skip it. */
+	if ((cpuid & CORE_PJ4_MASK) != CORE_PJ4_ID)
+		return 0;
 
 	cp_access = pj4_cp_access_read() & ~0xf;
 	pj4_cp_access_write(cp_access);
-- 
1.7.4.1
