From: alex.shi@linaro.org (Alex Shi)
Date: Mon, 26 Feb 2018 16:19:47 +0800
Subject: [PATCH 13/52] arm64: uaccess: Prevent speculative use of the current
 addr_limit
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519633227-29832-14-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit c2f0ad4fc089 upstream.

A mispredicted conditional call to set_fs could result in the wrong
addr_limit being forwarded under speculation to a subsequent access_ok
check, potentially forming part of a spectre-v1 attack using uaccess
routines.

This patch prevents this forwarding from taking place, but putting heavy
barriers in set_fs after writing the addr_limit.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	no set_thread_flag(TIF_FSCHECK) in arch/arm64/include/asm/uaccess.h
---
 arch/arm64/include/asm/uaccess.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 3531fec..00025c5 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -71,6 +71,13 @@ static inline void set_fs(mm_segment_t fs)
 	current_thread_info()->addr_limit = fs;
 
 	/*
+	 * Prevent a mispredicted conditional call to set_fs from forwarding
+	 * the wrong address limit to access_ok under speculation.
+	 */
+	dsb(nsh);
+	isb();
+
+	/*
 	 * Enable/disable UAO so that copy_to_user() etc can access
 	 * kernel memory with the unprivileged instructions.
 	 */
-- 
2.7.4
