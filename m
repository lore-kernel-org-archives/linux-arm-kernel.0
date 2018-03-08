From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu,  8 Mar 2018 13:41:14 +0000
Subject: [PATCH] ARM: Add support for Cortex-R8 processor
Message-ID: <1520516474-17914-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Luca Scalabrino <luca.scalabrino@arm.com>

Cortex-R8 has identical initialisation requirements to Cortex-R7, so
hook it up in proc-v7.S in the same way.

Signed-off-by: Luca Scalabrino <luca.scalabrino@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---

Even though there are no in-tree R-class users, it makes it a bit
easier to test R-class NOMMU code with out-of-tree platforms,
i.e. Fast Models.

 arch/arm/mm/proc-v7.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index c2d0a12..801a84e 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -272,6 +272,7 @@ ENDPROC(cpu_pj4b_do_resume)
 __v7_ca5mp_setup:
 __v7_ca9mp_setup:
 __v7_cr7mp_setup:
+__v7_cr8mp_setup:
 	mov	r10, #(1 << 0)			@ Cache/TLB ops broadcasting
 	b	1f
 __v7_ca7mp_setup:
@@ -646,6 +647,16 @@ __v7_cr7mp_proc_info:
 	.size	__v7_cr7mp_proc_info, . - __v7_cr7mp_proc_info
 
 	/*
+	 * ARM Ltd. Cortex R8 processor.
+	 */
+	.type	__v7_cr8mp_proc_info, #object
+__v7_cr8mp_proc_info:
+	.long	0x410fc180
+	.long	0xff0ffff0
+	__v7_proc __v7_cr8mp_proc_info, __v7_cr8mp_setup
+	.size	__v7_cr8mp_proc_info, . - __v7_cr8mp_proc_info
+
+	/*
 	 * ARM Ltd. Cortex A7 processor.
 	 */
 	.type	__v7_ca7mp_proc_info, #object
-- 
2.0.0
