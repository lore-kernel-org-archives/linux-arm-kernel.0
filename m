From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Thu, 2 Nov 2017 03:14:56 +0800
Subject: [PATCH v1 2/3] arm64: add error synchronization barrier in
 kernel_entry/kernel_exit
In-Reply-To: <1509563697-6359-1-git-send-email-gengdongjiu@huawei.com>
References: <1509563697-6359-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <1509563697-6359-3-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If taking an exception from or return to user space, insert
a Error Synchronization Barrier(ESB) to isolate the error.

If a user space process is pending a SError, when enter to
kernel, the SError will be immediately synchronized in the
handler entry. Otherwise if kernel space is pending a SError,
before return to user space, the SError will be synchronized
in the handler exit.

In order to reduce impact on performance, not check the DISR_EL1
to see whether an SError is consumed by an ESB instruction.
This is because DISR_EL1 is RAZ/WI in firmware-first RAS
solution, if happen SError, it will immediately trap to EL3
firmware.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm64/kernel/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e147c1d..6dde644 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -138,6 +138,7 @@
 	stp	x28, x29, [sp, #16 * 14]
 
 	.if	\el == 0
+	error_synchronize
 	mrs	x21, sp_el0
 	ldr_this_cpu	tsk, __entry_task, x20	// Ensure MDSCR_EL1.SS is clear,
 	ldr	x19, [tsk, #TSK_TI_FLAGS]	// since we can unmask debug
@@ -281,6 +282,7 @@ alternative_if ARM64_WORKAROUND_845719
 1:
 alternative_else_nop_endif
 #endif
+	error_synchronize
 	.endif
 
 	msr	elr_el1, x21			// set up the return data
-- 
1.9.1
