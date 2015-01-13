From: zlim@broadcom.com (Zi Shen Lim)
Date: Mon, 12 Jan 2015 18:15:02 -0800
Subject: [PATCH boot-wrapper-aarch64 2/4] psci: remove sentinel from id_table
In-Reply-To: <1421115304-19580-1-git-send-email-zlim@broadcom.com>
References: <1421115304-19580-1-git-send-email-zlim@broadcom.com>
Message-ID: <1421115304-19580-3-git-send-email-zlim@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tweak the limit check in find_logical_id so we can
do away with the sentinel from id_table.

While at it, also remove unused label and fix up spacing.

Signed-off-by: Zi Shen Lim <zlim@broadcom.com>
---
 psci.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/psci.S b/psci.S
index 234493d..d045e56 100644
--- a/psci.S
+++ b/psci.S
@@ -69,7 +69,6 @@ vector:
 id_table:
 	.quad CPU_IDS
 __id_end:
-	.quad MPIDR_INVALID
 
 .equ	nr_cpus, ((__id_end - id_table) / 8)
 
@@ -159,17 +158,16 @@ psci_cpu_on:
  * Clobbers x1, x2, x3
  */
 find_logical_id:
-__find_logical_index:
 	adr	x2, id_table
 	mov	x1, xzr
 1:	mov	x3, #nr_cpus	// check we haven't walked off the end of the array
 	cmp	x1, x3
-	b.gt	3f
+	b.ge	3f
 	ldr	x3, [x2, x1, lsl #3]
 	cmp	x3, x0
 	b.eq	2f
 	add	x1, x1, #1
-	b 1b
+	b	1b
 2:	mov	x0, x1
 	ret
 3:	mov	x0, #MPIDR_INVALID
-- 
2.1.0
