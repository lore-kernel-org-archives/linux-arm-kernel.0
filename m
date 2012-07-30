From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 30 Jul 2012 04:58:20 -0700
Subject: [PATCH 11/11] ARM: Get rid of .LCcralign local label usage in
 alignment_trap macro
In-Reply-To: <20120730115719.GA5742@lizard>
References: <20120730115719.GA5742@lizard>
Message-ID: <1343649500-18491-11-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the code more izolated.

The downside of this is that we now have an additional branch and the
code itself is 8 bytes longer. But on the bright side, this new layout
can be more cache friendly since cr_alignment address might be already
in the cache line (not that I measured anything, it's just fun to think
about it).

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/arm/kernel/entry-armv.S     |    2 --
 arch/arm/kernel/entry-header.S   |    6 +++++-
 arch/arm/kernel/kgdb_fiq_entry.S |    3 ---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 6aeb9b8..6b04ab5 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -266,8 +266,6 @@ __pabt_svc:
 ENDPROC(__pabt_svc)
 
 	.align	5
-.LCcralign:
-	.word	cr_alignment
 #ifdef MULTI_DABORT
 .LCprocfns:
 	.word	processor
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index c3c09ac..5a05e7f 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -38,9 +38,13 @@
 
 	.macro	alignment_trap, rtemp
 #ifdef CONFIG_ALIGNMENT_TRAP
-	ldr	\rtemp, .LCcralign
+	ldr	\rtemp, 1f
 	ldr	\rtemp, [\rtemp]
 	mcr	p15, 0, \rtemp, c1, c0
+	b	2f
+1:
+	.word	cr_alignment
+2:
 #endif
 	.endm
 
diff --git a/arch/arm/kernel/kgdb_fiq_entry.S b/arch/arm/kernel/kgdb_fiq_entry.S
index 7be3726..e7c05fc 100644
--- a/arch/arm/kernel/kgdb_fiq_entry.S
+++ b/arch/arm/kernel/kgdb_fiq_entry.S
@@ -18,9 +18,6 @@
 
 	.text
 
-@ This is needed for usr_entry/alignment_trap
-.LCcralign:
-	.long	cr_alignment
 .LCdohandle:
 	.long	kgdb_fiq_do_handle
 
-- 
1.7.10.4
