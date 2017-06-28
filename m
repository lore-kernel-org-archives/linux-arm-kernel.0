From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Wed, 28 Jun 2017 16:58:16 +0200
Subject: [PATCH] arm64: fix missing __user in compat_vfp_{get,set}()
Message-ID: <20170628145816.24807-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

compat_vfp_get() & compat_vfp_set() are two helpers reading
or writting some values via {get,put}_user() which need a
pointer annotated with '__user'.
The buffers used by the two helpers are correctly '__user'
annotated but need to be casted to a real type before being
given to {get,put}_user().

The problem is that this cast lack a '__user' annotation.

Fix this by adding the missing '__user'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm64/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index c142459a8..c77f425c7 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -908,7 +908,7 @@ static int compat_vfp_get(struct task_struct *target,
 	if (count && !ret) {
 		fpscr = (uregs->fpsr & VFP_FPSCR_STAT_MASK) |
 			(uregs->fpcr & VFP_FPSCR_CTRL_MASK);
-		ret = put_user(fpscr, (compat_ulong_t *)ubuf);
+		ret = put_user(fpscr, (compat_ulong_t __user *)ubuf);
 	}
 
 	return ret;
@@ -932,7 +932,7 @@ static int compat_vfp_set(struct task_struct *target,
 				 VFP_STATE_SIZE - sizeof(compat_ulong_t));
 
 	if (count && !ret) {
-		ret = get_user(fpscr, (compat_ulong_t *)ubuf);
+		ret = get_user(fpscr, (compat_ulong_t __user *)ubuf);
 		uregs->fpsr = fpscr & VFP_FPSCR_STAT_MASK;
 		uregs->fpcr = fpscr & VFP_FPSCR_CTRL_MASK;
 	}
-- 
2.13.0
