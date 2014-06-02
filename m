From: will.deacon@arm.com (Will Deacon)
Date: Mon,  2 Jun 2014 11:47:23 +0100
Subject: [PATCH] arm64: ptrace: change fs when passing kernel pointer to
 regset code
Message-ID: <1401706043-1741-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our compat PTRACE_POKEUSR implementation simply passes the user data to
regset_copy_from_user after some simple range checking. Unfortunately,
the data in question has already been copied to the kernel stack by this
point, so the subsequent access_ok check fails and the ptrace request
returns -EFAULT. This causes problems tracing fork() with older versions
of strace.

This patch briefly changes the fs to KERNEL_DS, so that the access_ok
check passes even with a kernel address.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/ptrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6a8928bba03c..bf288e443a9f 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -821,6 +821,7 @@ static int compat_ptrace_write_user(struct task_struct *tsk, compat_ulong_t off,
 				    compat_ulong_t val)
 {
 	int ret;
+	mm_segment_t old_fs = get_fs();
 
 	if (off & 3 || off >= COMPAT_USER_SZ)
 		return -EIO;
@@ -828,10 +829,13 @@ static int compat_ptrace_write_user(struct task_struct *tsk, compat_ulong_t off,
 	if (off >= sizeof(compat_elf_gregset_t))
 		return 0;
 
+	set_fs(KERNEL_DS);
 	ret = copy_regset_from_user(tsk, &user_aarch32_view,
 				    REGSET_COMPAT_GPR, off,
 				    sizeof(compat_ulong_t),
 				    &val);
+	set_fs(old_fs);
+
 	return ret;
 }
 
-- 
1.9.2
