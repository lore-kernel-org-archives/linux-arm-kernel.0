From: ryan.harkin@linaro.org (Ryan Harkin)
Date: Mon, 25 Feb 2013 12:40:07 +0000
Subject: [PATCH] arm64: compat_sys_sigsuspend: init local blocked mask not
 current process mask
Message-ID: <1361796007-20143-1-git-send-email-ryan.harkin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original version changed the signal mask in the current process, and then passed an unitialized variable to sigsuspend, which in turn, besides the other work, sets current->blocked.

The value of mask, passed from a process, was effectively overwritten by some random value.  If the random value was zero, all signals were blocked and pipes no longer work.

Signed-off-by: Ryan Harkin <ryan.harkin@linaro.org>
---
 arch/arm64/kernel/signal32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index a4db3d2..0bc9461 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -347,7 +347,7 @@ asmlinkage int compat_sys_sigsuspend(int restart, compat_ulong_t oldmask,
 {
 	sigset_t blocked;
 
-	siginitset(&current->blocked, mask);
+	siginitset(&blocked, mask);
 	return sigsuspend(&blocked);
 }
 
-- 
1.7.9.5
