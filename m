From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 23 Oct 2013 13:46:16 +0100
Subject: [PATCH] arm: add support for the Cortex-A12 processor
Message-ID: <1382532376-22758-1-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A12 behaves as the A7/A15 does with respect to setting the SMP bit, and
doesn't require TLB ops broadcasting to be explicitly enabled like the A9 does.

Note that as the ACTLR cannot (usually) be written from non-secure, it is the
responsibility of the bootloader/firmware to set this bit per core - it is
done here in Linux as last resort in case of bad firmware.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
---
 arch/arm/mm/proc-v7.S |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3a5922d..9745288 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -164,6 +164,7 @@ __v7_cr7mp_setup:
 	mov	r10, #(1 << 0)			@ Cache/TLB ops broadcasting
 	b	1f
 __v7_ca7mp_setup:
+__v7_ca12mp_setup:
 __v7_ca15mp_setup:
 	mov	r10, #0
 1:
@@ -440,6 +441,16 @@ __v7_ca7mp_proc_info:
 	.size	__v7_ca7mp_proc_info, . - __v7_ca7mp_proc_info
 
 	/*
+	 * ARM Ltd. Cortex A12 processor.
+	 */
+	.type	__v7_ca12mp_proc_info, #object
+__v7_ca12mp_proc_info:
+	.long	0x410fc0d0
+	.long	0xff0ffff0
+	__v7_proc __v7_ca12mp_setup
+	.size	__v7_ca12mp_proc_info, . - __v7_ca12mp_proc_info
+
+	/*
 	 * ARM Ltd. Cortex A15 processor.
 	 */
 	.type	__v7_ca15mp_proc_info, #object
-- 
1.7.9.5
