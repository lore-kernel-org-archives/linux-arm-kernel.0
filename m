From: pkluba@dension.com (Patrik, Kluba)
Date: Sat, 15 Dec 2012 08:51:29 +0100
Subject: Fw: [PATCH 01/01] arm: fix a preempt_count() corruption for
 CONFIG_PREEMPT=n
Message-ID: <20121215085129.71d203b2.pkluba@dension.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi All,

Maybe this list is a better place for the following request.
I've checked, and this bug is also present in the linux-next tree.

Regards,
Patrik


Begin forwarded message:

Date: Fri, 14 Dec 2012 15:13:57 +0100
From: "Patrik, Kluba" <pkluba@dension.com>
To: linux-kernel at vger.kernel.org
Subject: [PATCH 01/01] arm: fix a preempt_count() corruption for
CONFIG_PREEMPT=n


Hi All,

After a hard days' work, I've managed to track down a ghost causing
sporadic kernel warnings and system crashes. The patch applies for the
HEAD of linux-stable. I don't know how to create and submit patches
correctly, and hope that somebody will pick it up...

Regards,
Patrik
---
>From 4dd31e88a2715389e5ac198dcf00b48b4f148ea6 Mon Sep 17 00:00:00 2001
From: Patrik Kluba <pkluba@dension.com>
Date: Fri, 14 Dec 2012 14:36:27 +0100
Subject: [PATCH] arm: fix a preempt_count() corruption for
CONFIG_PREEMPT=n

All the preempt-disabling assembly code is under CONFIG_PREEMPT,
while VFP_bounce calls preempt_enable() uncoditionally, leading to
a preempt_count() corruption (gets set to 0xffffffff). Fix the
imbalance by adding #ifdef CONFIG_PREEMPT before preempt_enable().
---
 arch/arm/vfp/vfpmodule.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 3b44e0d..2184f7e 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -428,7 +428,10 @@ void VFP_bounce(u32 trigger, u32 fpexc, struct
pt_regs *regs) if (exceptions)
 		vfp_raise_exceptions(exceptions, trigger, orig_fpscr,
regs); exit:
+#ifdef CONFIG_PREEMPT
 	preempt_enable();
+#endif
+	return;
 }
 
 static void vfp_enable(void *unused)
-- 
1.7.10.4
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
