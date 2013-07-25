From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Jul 2013 18:01:44 +0100
Subject: [PATCH v3 1/4] ARM: entry: allow ARM-private syscalls to be restarted
In-Reply-To: <1374771707-2619-1-git-send-email-will.deacon@arm.com>
References: <1374771707-2619-1-git-send-email-will.deacon@arm.com>
Message-ID: <1374771707-2619-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

System calls will only be restarted after signal handling if they (a)
return an error code indicating that a restart is required and (b) have
`why' set to a non-zero value, to indicate that the signal interrupted
them.

This patch leaves `why' set to a non-zero value for ARM-private syscalls
, and only zeroes it for syscalls that are not implemented.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/entry-common.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 94104bf..74ad15d1 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -442,10 +442,10 @@ local_restart:
 	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
 
 	add	r1, sp, #S_OFF
-2:	mov	why, #0				@ no longer a real syscall
 	cmp	scno, #(__ARM_NR_BASE - __NR_SYSCALL_BASE)
 	eor	r0, scno, #__NR_SYSCALL_BASE	@ put OS number back
-	bcs	arm_syscall	
+	bcs	arm_syscall
+2:	mov	why, #0				@ no longer a real syscall
 	b	sys_ni_syscall			@ not private func
 
 #if defined(CONFIG_OABI_COMPAT) || !defined(CONFIG_AEABI)
-- 
1.8.2.2
