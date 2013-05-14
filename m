From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 13:26:57 +0100
Subject: [PATCH 2/3] ARM: add Cortex-R7 Processor Info
In-Reply-To: <1368534418-11287-1-git-send-email-jonathan.austin@arm.com>
References: <1368534418-11287-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368534418-11287-3-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds processor info for ARM Ltd. Cortex-R7.

The R7 has many similarities to the A9 and though the ACTLR layout is not
identical, the bits associated with cache operations broadcasting and SMP
modes are the same for A9, A5 and R7 (Though in the A-class processors the
same bits toggle TLB-ops broadcasting as well as cache-ops)

HWCAP_IDIV need not be specified as this is now auto-detected

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mm/proc-v7.S |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index a851e34..f85ae8c 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -159,7 +159,8 @@ ENDPROC(cpu_v7_do_resume)
  */
 __v7_ca5mp_setup:
 __v7_ca9mp_setup:
-	mov	r10, #(1 << 0)			@ TLB ops broadcasting
+__v7_cr7mp_setup:
+	mov	r10, #(1 << 0)			@ Cache/TLB ops broadcasting
 	b	1f
 __v7_ca7mp_setup:
 __v7_ca15mp_setup:
@@ -419,6 +420,16 @@ __v7_pj4b_proc_info:
 	.size	__v7_pj4b_proc_info, . - __v7_pj4b_proc_info
 
 	/*
+	 * ARM Ltd. Cortex R7 processor.
+	 */
+	.type	__v7_cr7mp_proc_info, #object
+__v7_cr7mp_proc_info:
+	.long	0x410fc170
+	.long	0xff0ffff0
+	__v7_proc __v7_cr7mp_setup
+	.size	__v7_cr7mp_proc_info, . - __v7_cr7mp_proc_info
+
+	/*
 	 * ARM Ltd. Cortex A7 processor.
 	 */
 	.type	__v7_ca7mp_proc_info, #object
-- 
1.7.9.5
