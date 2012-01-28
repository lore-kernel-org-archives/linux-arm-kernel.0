From: rabin@rab.in (Rabin Vincent)
Date: Sat, 28 Jan 2012 19:05:20 +0530
Subject: [PATCHv2 1/6] ARM: ftrace: remove useless memory checks
In-Reply-To: <1327757725-10114-1-git-send-email-rabin@rab.in>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
Message-ID: <1327757725-10114-2-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before replacing an instruction, the ftrace code determines what the old
instruction should be and verifies that that's what's really there in
memory before replacing it.  This is useful if for example a bug in
mcountrecord causes it to record wrong locations.

However, in cases where we replace call sites in entry-common.S, these
checks are not needed.  For these, we currently just memcpy() the memory
content and then "verify" it -- this is quite useless and can be
removed.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/ftrace.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index c0062ad..e9488ad 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -125,11 +125,13 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
 {
 	unsigned long replaced;
 
-	if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
-		return -EFAULT;
+	if (old) {
+		if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
+			return -EFAULT;
 
-	if (replaced != old)
-		return -EINVAL;
+		if (replaced != old)
+			return -EINVAL;
+	}
 
 	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
 		return -EPERM;
@@ -141,23 +143,21 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
 
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
-	unsigned long pc, old;
+	unsigned long pc;
 	unsigned long new;
 	int ret;
 
 	pc = (unsigned long)&ftrace_call;
-	memcpy(&old, &ftrace_call, MCOUNT_INSN_SIZE);
 	new = ftrace_call_replace(pc, (unsigned long)func);
 
-	ret = ftrace_modify_code(pc, old, new);
+	ret = ftrace_modify_code(pc, 0, new);
 
 #ifdef CONFIG_OLD_MCOUNT
 	if (!ret) {
 		pc = (unsigned long)&ftrace_call_old;
-		memcpy(&old, &ftrace_call_old, MCOUNT_INSN_SIZE);
 		new = ftrace_call_replace(pc, (unsigned long)func);
 
-		ret = ftrace_modify_code(pc, old, new);
+		ret = ftrace_modify_code(pc, 0, new);
 	}
 #endif
 
-- 
1.7.8.3
