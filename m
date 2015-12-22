From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Dec 2015 17:16:12 +0000
Subject: [PATCH] arm64: fix off-by-one in compat syscall table for syscalls
 over 382
Message-ID: <1450804573-322-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[fix targetting -stable only, no upstream commit required]

In the bad old days, our compat syscall table was a linear array
defined in assembly code using a series of .quad directives generated
from a preprocessed header file.

When I added compat support for memfd_create and getrandom in commit
a97a42c47608 ("arm64: compat: wire up memfd_create and getrandom
syscalls for aarch32"), I forgot to pad the gap where seccomp was due
to go, and so the new syscalls actually ended up being off-by-one in the
table for v3.17 and v3.18 (in 3.19 seccomp was added and in v4.0 we
moved the table construction into C).

This patch is intended for -stable trees based on v3.17 or v3.18.

Cc: <stable@vger.kernel.org> # 3.17 and 3.18 only
Fixes: a97a42c47608 ("arm64: compat: wire up memfd_create and getrandom syscalls for aarch32")
Reported-by: Edmund Grimley-Evans <Edmund.Grimley-Evans@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/unistd32.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 9dfdac4a74a1..fbe1ab059bbb 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -788,6 +788,7 @@ __SYSCALL(__NR_sched_getattr, sys_sched_getattr)
 #define __NR_renameat2 382
 __SYSCALL(__NR_renameat2, sys_renameat2)
 			/* 383 for seccomp */
+__SYSCALL(383, sys_ni_syscall)
 #define __NR_getrandom 384
 __SYSCALL(__NR_getrandom, sys_getrandom)
 #define __NR_memfd_create 385
-- 
2.1.4
