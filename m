From: stephan.lachowsky@maxim-ic.com (Stephan Lachowsky)
Date: Thu, 29 Oct 2009 11:51:18 -0700
Subject: [PATCH] [ARM] fix csum_partial_copy_from_user() fault handler
Message-ID: <1256842278.20770.78.camel@qu101.quarc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The framepointer setup for csum_partial_copy_from_user() was removed in
22acc4e65043d436bc286e6059960fa533e37356.  The fault handler needs to use
an offset from the stack pointer instead.

Signed-off-by: Stephan Lachowsky <stephan.lachowsky@maxim-ic.com>
---
 arch/arm/lib/csumpartialcopyuser.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 14677fb..afbf3cc 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -93,7 +93,7 @@
 		.section .fixup,"ax"
 		.align	4
 9001:		mov	r4, #-EFAULT
-		ldr	r5, [fp, #4]		@ *err_ptr
+		ldr	r5, [sp, #32]		@ *err_ptr
 		str	r4, [r5]
 		ldmia	sp, {r1, r2}		@ retrieve dst, len
 		add	r2, r2, r1
-- 
1.6.2.5
