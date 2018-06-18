From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Jun 2018 13:02:52 +0100
Subject: [PATCHv3 01/19] arm64: consistently use unsigned long for thread flags
In-Reply-To: <20180618120310.39527-1-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
Message-ID: <20180618120310.39527-2-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In do_notify_resume, we manipulate thread_flags as a 32-bit unsigned
int, whereas thread_info::flags is a 64-bit unsigned long, and elsewhere
(e.g. in the entry assembly) we manipulate the flags as a 64-bit
quantity.

For consistency, and to avoid problems if we end up with more than 32
flags, let's make do_notify_resume take the flags as a 64-bit unsigned
long.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 511af13e8d8f..70287634706e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -910,7 +910,7 @@ static void do_signal(struct pt_regs *regs)
 }
 
 asmlinkage void do_notify_resume(struct pt_regs *regs,
-				 unsigned int thread_flags)
+				 unsigned long thread_flags)
 {
 	/*
 	 * The assembly code enters us with IRQs off, but it hasn't
-- 
2.11.0
