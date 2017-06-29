From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Thu, 29 Jun 2017 16:24:48 +0200
Subject: [PATCH v2] arm64: fix missing __user in compat_vfp_set()
In-Reply-To: <20170629100418.GC14607@arm.com>
References: <20170628145816.24807-1-luc.vanoostenryck@gmail.com>
 <20170629100418.GC14607@arm.com>
Message-ID: <20170629142447.juiwwut4yhfsdbmo@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

compat_vfp_set() is a helper writting some values via put_user()
and put_user() need a pointer annotated with '__user'.
The buffer used by the helper is correctly annotated with '__user'
but need to be casted to a real type before being given to
put_user().

The problem is that this cast lack a '__user' annotation.

Fix this by adding the missing '__user'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
Change since v1:
- rebase against arm64/for-next/core
- drop the change for compat_vfp_get() which is no more needed
---
 arch/arm64/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 35846f155..3a323e2b9 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -946,7 +946,7 @@ static int compat_vfp_set(struct task_struct *target,
 				 VFP_STATE_SIZE - sizeof(compat_ulong_t));
 
 	if (count && !ret) {
-		ret = get_user(fpscr, (compat_ulong_t *)ubuf);
+		ret = get_user(fpscr, (compat_ulong_t __user *)ubuf);
 		uregs->fpsr = fpscr & VFP_FPSCR_STAT_MASK;
 		uregs->fpcr = fpscr & VFP_FPSCR_CTRL_MASK;
 	}
-- 
2.13.0
