From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jul 2018 14:56:53 +0100
Subject: [PATCHv5 18/21] arm64: use {COMPAT,}SYSCALL_DEFINE0 for sigreturn
In-Reply-To: <20180711135656.20670-1-mark.rutland@arm.com>
References: <20180711135656.20670-1-mark.rutland@arm.com>
Message-ID: <20180711135656.20670-19-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't currently annotate our various sigreturn functions as syscalls,
as we need to do to use pt_regs syscall wrappers.

Let's mark them as real syscalls.

For compat_sys_sigreturn and compat_sys_rt_sigreturn, this changes the
return type from int to long, matching the prototypes in sys32.c.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/signal.c   | 2 +-
 arch/arm64/kernel/signal32.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index f03e664f773f..f8b0ba50e55e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -539,7 +539,7 @@ static int restore_sigframe(struct pt_regs *regs,
 	return err;
 }
 
-asmlinkage long sys_rt_sigreturn(void)
+SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe __user *frame;
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index cb10588a7cb2..1948566dcccf 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -282,7 +282,7 @@ static int compat_restore_sigframe(struct pt_regs *regs,
 	return err;
 }
 
-asmlinkage int compat_sys_sigreturn(void)
+COMPAT_SYSCALL_DEFINE0(sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct compat_sigframe __user *frame;
@@ -313,7 +313,7 @@ asmlinkage int compat_sys_sigreturn(void)
 	return 0;
 }
 
-asmlinkage int compat_sys_rt_sigreturn(void)
+COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct compat_rt_sigframe __user *frame;
-- 
2.11.0
