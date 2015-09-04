From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Fri,  4 Sep 2015 14:23:05 +0000
Subject: [RFC PATCH 1/3] arm64: entry: Remove unnecessary calculation for S_SP
 in EL1h
In-Reply-To: <1441376587-12979-1-git-send-email-jungseoklee85@gmail.com>
References: <1441376587-12979-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <1441376587-12979-2-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Under EL1h, S_SP data is not seen in kernel_exit. Thus, x21 calculation
is not needed in kernel_entry. Currently, S_SP information is vaild only
when sp_el0 is used.

Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
 arch/arm64/kernel/entry.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e163518..d23ca0d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -91,8 +91,6 @@
 	get_thread_info tsk			// Ensure MDSCR_EL1.SS is clear,
 	ldr	x19, [tsk, #TI_FLAGS]		// since we can unmask debug
 	disable_step_tsk x19, x20		// exceptions when scheduling.
-	.else
-	add	x21, sp, #S_FRAME_SIZE
 	.endif
 	mrs	x22, elr_el1
 	mrs	x23, spsr_el1
-- 
1.9.1
