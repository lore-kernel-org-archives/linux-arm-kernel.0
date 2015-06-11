From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Jun 2015 13:52:30 +0200
Subject: [PATCH] ARM: mm: enable L1 prefetch on Cortex-A9
Message-ID: <1434023550-20147-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A9 has a L1 prefetch capability documented at
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388e/Chdejhgd.html:

  The Cortex-A9 data cache implements an automatic prefetcher that
  monitors cache misses done by the processor. This unit can monitor
  and prefetch two independent data streams. It can be activated in
  software using a CP15 Auxiliary Control Register bit. See Auxiliary
  Control Register.

This commit enables this L1 prefetch feature unconditionally on all
Cortex-A9 by setting bit 2 in the Auxiliary Control CP15
register. Note that since this bit only exists on Cortex-A9 but not on
Cortex-A5 or Cortex-R7, we separate the handling of Cortex-A9 from the
one of those two other cores.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mm/proc-v7.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3d1054f..106ea4d 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -257,8 +257,11 @@ ENDPROC(cpu_pj4b_do_resume)
  *	It is assumed that:
  *	- cache type register is implemented
  */
-__v7_ca5mp_setup:
 __v7_ca9mp_setup:
+	mov	r10, #(1 << 0)			@ Cache/TLB ops broadcasting
+	orr	r10, r10, #(1 << 2)		@ L1 prefetch
+	b	1f
+__v7_ca5mp_setup:
 __v7_cr7mp_setup:
 	mov	r10, #(1 << 0)			@ Cache/TLB ops broadcasting
 	b	1f
-- 
2.1.0
