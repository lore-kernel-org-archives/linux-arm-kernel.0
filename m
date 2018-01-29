From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Jan 2018 11:59:58 +0000
Subject: [PATCH v2 7/9] arm64: entry: Reword comment about
 post_ttbr_update_workaround
In-Reply-To: <1517227200-20412-1-git-send-email-will.deacon@arm.com>
References: <1517227200-20412-1-git-send-email-will.deacon@arm.com>
Message-ID: <1517227200-20412-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't fully understand the Cavium ThunderX erratum, but it appears
that mapping the kernel as nG can lead to horrible consequences such as
attempting to execute userspace from kernel context. Since kpti isn't
enabled for these CPUs anyway, simplify the comment justifying the lack
of post_ttbr_update_workaround in the exception trampoline.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index b34e717d7597..fbe1444324b3 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1013,16 +1013,8 @@ alternative_else_nop_endif
 	orr	\tmp, \tmp, #USER_ASID_FLAG
 	msr	ttbr1_el1, \tmp
 	/*
-	 * We avoid running the post_ttbr_update_workaround here because the
-	 * user and kernel ASIDs don't have conflicting mappings, so any
-	 * "blessing" as described in:
-	 *
-	 *   http://lkml.kernel.org/r/56BB848A.6060603 at caviumnetworks.com
-	 *
-	 * will not hurt correctness. Whilst this may partially defeat the
-	 * point of using split ASIDs in the first place, it avoids
-	 * the hit of invalidating the entire I-cache on every return to
-	 * userspace.
+	 * We avoid running the post_ttbr_update_workaround here because
+	 * it's only needed by Cavium ThunderX, which doesn't require kpti.
 	 */
 	.endm
 
-- 
2.1.4
