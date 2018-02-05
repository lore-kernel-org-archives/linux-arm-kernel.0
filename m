From: will.deacon@arm.com (Will Deacon)
Date: Mon,  5 Feb 2018 15:34:21 +0000
Subject: [PATCH 6/9] arm64: uaccess: Prevent speculative use of the current
 addr_limit
In-Reply-To: <1517844864-15887-1-git-send-email-will.deacon@arm.com>
References: <1517844864-15887-1-git-send-email-will.deacon@arm.com>
Message-ID: <1517844864-15887-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A mispredicted conditional call to set_fs could result in the wrong
addr_limit being forwarded under speculation to a subsequent access_ok
check, potentially forming part of a spectre-v1 attack using uaccess
routines.

This patch prevents this forwarding from taking place, but putting heavy
barriers in set_fs after writing the addr_limit.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/uaccess.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e49fe723d72d..2057deed7697 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -42,6 +42,13 @@ static inline void set_fs(mm_segment_t fs)
 {
 	current_thread_info()->addr_limit = fs;
 
+	/*
+	 * Prevent a mispredicted conditional call to set_fs from forwarding
+	 * the wrong address limit to access_ok under speculation.
+	 */
+	dsb(nsh);
+	isb();
+
 	/* On user-mode return, check fs is correct */
 	set_thread_flag(TIF_FSCHECK);
 
-- 
2.1.4
