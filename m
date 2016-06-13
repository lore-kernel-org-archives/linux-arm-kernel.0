From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jun 2016 17:57:02 +0100
Subject: [PATCH] arm64: mm: mark fault_info table const
Message-ID: <1465837022-17582-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike the debug_fault_info table, we never intentionally alter the
fault_info table at runtime, and all derived pointers are treated as
const currently.

Make the table const so that it can be placed in .rodata and protected
from unintentional writes, as we do for the syscall tables.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ba3fc12..013e2cb 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -441,7 +441,7 @@ static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	return 1;
 }
 
-static struct fault_info {
+static const struct fault_info {
 	int	(*fn)(unsigned long addr, unsigned int esr, struct pt_regs *regs);
 	int	sig;
 	int	code;
-- 
1.9.1
