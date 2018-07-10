From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Jul 2018 19:01:22 +0100
Subject: [PATCH 1/2] arm64: fix possible spectre-v1 write in
 ptrace_hbp_set_event()
In-Reply-To: <20180710180123.56461-1-mark.rutland@arm.com>
References: <20180710180123.56461-1-mark.rutland@arm.com>
Message-ID: <20180710180123.56461-2-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's possible for userspace to control idx. Sanitize idx when using it
as an array index, to inhibit the potential spectre-v1 write gadget.

Found by smatch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/ptrace.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5c338ce5a7fa..db5440339ab3 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -277,19 +277,22 @@ static int ptrace_hbp_set_event(unsigned int note_type,
 
 	switch (note_type) {
 	case NT_ARM_HW_BREAK:
-		if (idx < ARM_MAX_BRP) {
-			tsk->thread.debug.hbp_break[idx] = bp;
-			err = 0;
-		}
+		if (idx >= ARM_MAX_BRP)
+			goto out;
+		idx = array_index_nospec(idx, ARM_MAX_BRP);
+		tsk->thread.debug.hbp_break[idx] = bp;
+		err = 0;
 		break;
 	case NT_ARM_HW_WATCH:
-		if (idx < ARM_MAX_WRP) {
-			tsk->thread.debug.hbp_watch[idx] = bp;
-			err = 0;
-		}
+		if (idx >= ARM_MAX_WRP)
+			goto out;
+		idx = array_index_nospec(idx, ARM_MAX_WRP);
+		tsk->thread.debug.hbp_watch[idx] = bp;
+		err = 0;
 		break;
 	}
 
+out:
 	return err;
 }
 
-- 
2.11.0
