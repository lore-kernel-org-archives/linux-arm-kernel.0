From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:50 +0800
Subject: [PATCH 28/29] arm64: entry: Reword comment about
 post_ttbr_update_workaround
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-29-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit f167211a93ac upstream.

We don't fully understand the Cavium ThunderX erratum, but it appears
that mapping the kernel as nG can lead to horrible consequences such as
attempting to execute userspace from kernel context. Since kpti isn't
enabled for these CPUs anyway, simplify the comment justifying the lack
of post_ttbr_update_workaround in the exception trampoline.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/entry.S | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index c00921e..8d50b28 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -883,16 +883,9 @@ __ni_sys_trace:
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
+	 * it's only needed by Cavium ThunderX, which requires KPTI to be
+	 * disabled.
 	 */
 	.endm
 
-- 
2.7.4
