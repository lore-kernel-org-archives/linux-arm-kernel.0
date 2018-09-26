From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 26 Sep 2018 14:56:21 +0100
Subject: [PATCH 4/7] arm64: Add fast-path for stack alignment
In-Reply-To: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1537970184-44348-5-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoiding stack alignment for already aligned stack can give a small
performance boost.

Branch out of the aligning code when the stack is known to be aligned.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 arch/arm64/kernel/entry.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 8fb66e4..bd8d52c 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -61,6 +61,10 @@
 
 	.macro force_stack_align
 	xchg_sp	x0
+
+	tst	x0, #0xf
+	b.eq	0f
+
 	str	x1, [x0] // store x1 far away from S_SP
 
 	// aligned_sp[S_SP] = old_sp
@@ -69,6 +73,11 @@
 
 	ldr	x1, [x0]
 	bic	x0, x0, #0xf	// x0 = aligned_sp
+	b	1f
+
+0:
+	str	x0, [x0, #S_SP]
+1:
 	xchg_sp	x0
 	.endm
 
-- 
1.9.1
