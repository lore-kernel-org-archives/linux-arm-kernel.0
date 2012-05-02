From: tim.bird@am.sony.com (Tim Bird)
Date: Wed, 2 May 2012 13:53:11 -0700
Subject: Fwd: [PATCH] arm: Add extra clobber registers for assembly in
 kernel_execve
In-Reply-To: <4F7F2DA2.4040805@am.sony.com>
References: <4F7F2DA2.4040805@am.sony.com>
Message-ID: <4FA19EB7.7080000@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Anyone interested in this?

-------- Original Message --------
Subject: [PATCH] arm: Add extra clobber registers for assembly in kernel_execve
Date: Fri, 6 Apr 2012 10:53:38 -0700
From: Tim Bird <tim.bird@am.sony.com>
To: linux-arm-kernel at lists.infradead.org <linux-arm-kernel@lists.infradead.org>, Russell King <rmk@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>


The inline assembly in kernel_execve() uses r8 and r9.  Since this
code sequence does not return, it usually doesn't matter if the
register clobber list is accurate.  However, I saw a case where a
particular version of gcc used r8 as an intermediate for the value
eventually passed to r9.  Because r8 is used in the inline
assembly, and not mentioned in the clobber list, r9 was set
to an incorrect value.

This resulted in a kernel panic on execution of the first user-space
program in the system.  r9 is used in ret_to_user as the thread_info
pointer, and if it's wrong, bad things happen.

Signed off by: Tim Bird <tim.bird@am.sony.com>
---
 arch/arm/kernel/sys_arm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/sys_arm.c b/arch/arm/kernel/sys_arm.c
index 62e7c61..0264ab4 100644
--- a/arch/arm/kernel/sys_arm.c
+++ b/arch/arm/kernel/sys_arm.c
@@ -115,7 +115,7 @@ int kernel_execve(const char *filename,
 		  "Ir" (THREAD_START_SP - sizeof(regs)),
 		  "r" (&regs),
 		  "Ir" (sizeof(regs))
-		: "r0", "r1", "r2", "r3", "ip", "lr", "memory");
+		: "r0", "r1", "r2", "r3", "r8", "r9", "ip", "lr", "memory");

  out:
 	return ret;
-- 
