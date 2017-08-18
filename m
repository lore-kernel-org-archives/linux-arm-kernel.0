From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 18 Aug 2017 17:14:14 +0100
Subject: [PATCH] bootwrapper: SVE: Enable SVE for EL2 and below
Message-ID: <1503072854-6794-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default, SVE will trap to EL3.  We also want to make sure that
lower ELs have access to the full SVE vector length before dropping
down.

This patch programs CPTR_EL3 and ZCR_EL3 appropriately to enable
SVE for lower exception levels and make sure that they can use the
full vector length provided by the hardware.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 boot.S   | 13 +++++++++++++
 common.S |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/boot.S b/boot.S
index c65590c..c789705 100644
--- a/boot.S
+++ b/boot.S
@@ -28,6 +28,19 @@ _start:
 
 	msr	cptr_el3, xzr			// Disable copro. traps to EL3
 
+	mrs	x0, id_aa64pfr0_el1
+	ubfx	x0, x0, #32, #4			// SVE present?
+	cbz	x0, 1f				// Skip SVE init if not
+
+	mrs	x0, cptr_el3
+	orr	x0, x0, #CPTR_EL3_EZ		// enable SVE
+	msr	cptr_el3, x0
+	isb
+
+	mov	x0, #ZCR_EL3_LEN_MASK		// SVE: Enable full vector len
+	msr	ZCR_EL3, x0			// for EL2.
+
+1:
 	ldr	x0, =CNTFRQ
 	msr	cntfrq_el0, x0
 
diff --git a/common.S b/common.S
index 7ddfad0..37643e1 100644
--- a/common.S
+++ b/common.S
@@ -23,6 +23,11 @@
 #define SPSR_F		(1 << 6)	/* FIQ masked */
 #define SPSR_EL2H	(9 << 0)	/* EL2 Handler mode */
 
+#define CPTR_EL3_EZ	(1 << 8)
+
+#define ZCR_EL3		s3_6_c1_c2_0
+#define ZCR_EL3_LEN_MASK	0x1ff
+
 #define SPSR_KERNEL	(SPSR_A | SPSR_D | SPSR_I | SPSR_F | SPSR_EL2H)
 
 	/*
-- 
2.1.4
