From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon,  2 Jun 2014 22:46:09 -0700
Subject: [PATCH] arm64: ptrace: fix empty registers set in prstatus of aarch32
 process core
In-Reply-To: <1401774369-7060-1-git-send-email-victor.kamensky@linaro.org>
References: <1401774369-7060-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1401774369-7060-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently core file of aarch32 process prstatus note has empty
registers set. As result aarch32 core files create by V8 kernel are
not very useful.

It happens because compat_gpr_get and compat_gpr_set functions can
copy registers values to/from either kbuf or ubuf. ELF core file
collection function fill_thread_core_info calls compat_gpr_get
with kbuf set and ubuf set to 0. But current compat_gpr_get and
compat_gpr_set function handle copy to/from only ubuf case.

Fix is to handle kbuf and ubuf as two separate cases in similar
way as other functions like user_regset_copyout, user_regset_copyin do.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm64/kernel/ptrace.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6a8928b..9c9c2b9 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -650,11 +650,16 @@ static int compat_gpr_get(struct task_struct *target,
 			reg = task_pt_regs(target)->regs[idx];
 		}
 
-		ret = copy_to_user(ubuf, &reg, sizeof(reg));
-		if (ret)
-			break;
-
-		ubuf += sizeof(reg);
+		if (kbuf) {
+			memcpy(kbuf, &reg, sizeof(reg));
+			kbuf += sizeof(reg);
+		} else {
+			ret = copy_to_user(ubuf, &reg, sizeof(reg));
+			if (ret)
+				break;
+
+			ubuf += sizeof(reg);
+		}
 	}
 
 	return ret;
@@ -684,11 +689,16 @@ static int compat_gpr_set(struct task_struct *target,
 		unsigned int idx = start + i;
 		compat_ulong_t reg;
 
-		ret = copy_from_user(&reg, ubuf, sizeof(reg));
-		if (ret)
-			return ret;
+		if (kbuf) {
+			memcpy(&reg, kbuf, sizeof(reg));
+			kbuf += sizeof(reg);
+		} else {
+			ret = copy_from_user(&reg, ubuf, sizeof(reg));
+			if (ret)
+				return ret;
 
-		ubuf += sizeof(reg);
+			ubuf += sizeof(reg);
+		}
 
 		switch (idx) {
 		case 15:
-- 
1.8.1.4
