From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  2 Nov 2017 16:12:03 +0000
Subject: [PATCH] arm64: ensure __dump_instr() checks addr_limit
Message-ID: <20171102161203.4704-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's possible for a user to deliberately trigger __dump_instr with a
chosen kernel address.

Let's avoid problems resulting from this by using get_user() rather than
__get_user(), ensuring that we don't erroneously access kernel memory.

Where we use __dump_instr() on kernel text, we already switch to
KERNEL_DS, so this shouldn't adversely affect those cases.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 60ffc30d5652810d ("arm64: Exception handling")
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: stable at vger.kernel.org
---
 arch/arm64/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5ea4b85aee0e..8383af15a759 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -118,7 +118,7 @@ static void __dump_instr(const char *lvl, struct pt_regs *regs)
 	for (i = -4; i < 1; i++) {
 		unsigned int val, bad;
 
-		bad = __get_user(val, &((u32 *)addr)[i]);
+		bad = get_user(val, &((u32 *)addr)[i]);
 
 		if (!bad)
 			p += sprintf(p, i == 0 ? "(%08x) " : "%08x ", val);
-- 
2.11.0
