From: chao.xie@marvell.com (Chao Xie)
Date: Fri, 21 Mar 2014 15:01:59 +0800
Subject: [PATCH 2/2] ARM: PJ4: check cpu id for PJ4 cp0 access
In-Reply-To: <1395385319-25386-1-git-send-email-chao.xie@marvell.com>
References: <1395385319-25386-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1395385319-25386-2-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check cpu id in pj4_cp0_init. So for no-PJ4 V7 cpus,
pj4_cpu0_init just return.
This fix will help to make the all the V7 cpus(PJ4 and no-PJ4)
use same platform code.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/kernel/pj4-cp0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
index 679cf4d..fc72086 100644
--- a/arch/arm/kernel/pj4-cp0.c
+++ b/arch/arm/kernel/pj4-cp0.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <asm/thread_notify.h>
+#include <asm/cputype.h>
 
 static int iwmmxt_do(struct notifier_block *self, unsigned long cmd, void *t)
 {
@@ -80,6 +81,9 @@ static int __init pj4_cp0_init(void)
 {
 	u32 cp_access;
 
+	if (!cpu_is_pj4())
+		return 0;
+
 	cp_access = pj4_cp_access_read() & ~0xf;
 	pj4_cp_access_write(cp_access);
 
-- 
1.8.3.2
