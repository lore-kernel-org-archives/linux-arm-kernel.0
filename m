From: toddpoynor@google.com (Todd Poynor)
Date: Tue,  9 Jul 2013 17:47:39 -0700
Subject: [PATCH] ARM: kgdb: ignore breakpoint instructions from user mode
Message-ID: <1373417259-22098-1-git-send-email-toddpoynor@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid conflicts with user mode usage of the same instructions, as with
Clang -ftrapv, and avoid a potential denial of service.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 arch/arm/kernel/kgdb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
index 778c2f7..b321c8f 100644
--- a/arch/arm/kernel/kgdb.c
+++ b/arch/arm/kernel/kgdb.c
@@ -144,6 +144,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 
 static int kgdb_brk_fn(struct pt_regs *regs, unsigned int instr)
 {
+	if (user_mode(regs))
+		return -1;
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
 
 	return 0;
@@ -151,6 +153,8 @@ static int kgdb_brk_fn(struct pt_regs *regs, unsigned int instr)
 
 static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned int instr)
 {
+	if (user_mode(regs))
+		return -1;
 	compiled_break = 1;
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
 
-- 
1.8.3
