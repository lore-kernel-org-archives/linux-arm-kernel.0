From: gang.chen@asianux.com (Chen Gang)
Date: Sun, 26 May 2013 18:28:03 +0800
Subject: [PATCH] arch: arm64: kernel: sprintf(), 'str' needs additional 1
 byte for failure processing
Message-ID: <51A1E3B3.4060901@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


When failure occurs at the last looping cycle (when 'i == 0'), it will
print "bad PC value" instead of "(%08x) ", which needs additional 1
byte.

If not add 1 byte, the str will not be NUL terminated, and the next
printk() will cause issue.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm64/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 61d7dd2..c2f68d2 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -100,7 +100,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 {
 	unsigned long addr = instruction_pointer(regs);
 	mm_segment_t fs;
-	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
+	char str[sizeof("00000000 ") * 5 + 2 + 1 + 1], *p = str;
 	int i;
 
 	/*
-- 
1.7.7.6
