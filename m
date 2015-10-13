From: salyzyn@android.com (Mark Salyzyn)
Date: Tue, 13 Oct 2015 14:30:51 -0700
Subject: Aarch32 user space PC alignment exception
Message-ID: <1444771874-22714-1-git-send-email-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

armv7 does not have a PC alignment exception. armv8 Aarch32
user space however can produce a PC alignment exception. Add
handler so the we do not dump an unexpected stack trace in
the logs.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 arch/arm64/kernel/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 4306c93..7ed3d75 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -430,6 +430,8 @@ el0_sync_compat:
 	b.eq	el0_fpsimd_acc
 	cmp	x24, #ESR_ELx_EC_FP_EXC32	// FP/ASIMD exception
 	b.eq	el0_fpsimd_exc
+	cmp	x24, #ESR_ELx_EC_PC_ALIGN	// pc alignment exception
+	b.eq	el0_sp_pc
 	cmp	x24, #ESR_ELx_EC_UNKNOWN	// unknown exception in EL0
 	b.eq	el0_undef
 	cmp	x24, #ESR_ELx_EC_CP15_32	// CP15 MRC/MCR trap
-- 
2.6.0.rc2.230.g3dd15c0
