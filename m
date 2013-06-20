From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 15:21:24 +0100
Subject: [PATCH v2 10/12] ARM: mcpm: use -st dsb option prior to sev
 instructions
In-Reply-To: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
References: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
Message-ID: <1371738086-6707-11-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a similar manner to our spinlock implementation, mcpm uses sev to
wake up cores waiting on a lock when the lock is unlocked. In order to
ensure that the final write unlocking the lock is visible, a dsb
instruction is executed immediately prior to the sev.

This patch changes these dsbs to use the -st option, since we only
require that the store unlocking the lock is made visible.

Acked-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/common/mcpm_head.S | 2 +-
 arch/arm/common/vlock.S     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
index 8178705..5cdf619 100644
--- a/arch/arm/common/mcpm_head.S
+++ b/arch/arm/common/mcpm_head.S
@@ -151,7 +151,7 @@ mcpm_setup_leave:
 
 	mov	r0, #INBOUND_NOT_COMING_UP
 	strb	r0, [r8, #MCPM_SYNC_CLUSTER_INBOUND]
-	dsb
+	dsb	st
 	sev
 
 	mov	r0, r11
diff --git a/arch/arm/common/vlock.S b/arch/arm/common/vlock.S
index ff19858..8b7df28 100644
--- a/arch/arm/common/vlock.S
+++ b/arch/arm/common/vlock.S
@@ -42,7 +42,7 @@
 	dmb
 	mov	\rscratch, #0
 	strb	\rscratch, [\rbase, \rcpu]
-	dsb
+	dsb	st
 	sev
 .endm
 
@@ -102,7 +102,7 @@ ENTRY(vlock_unlock)
 	dmb
 	mov	r1, #VLOCK_OWNER_NONE
 	strb	r1, [r0, #VLOCK_OWNER_OFFSET]
-	dsb
+	dsb	st
 	sev
 	bx	lr
 ENDPROC(vlock_unlock)
-- 
1.8.2.2
