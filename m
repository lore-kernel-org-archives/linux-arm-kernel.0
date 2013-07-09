From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  9 Jul 2013 15:16:04 +0100
Subject: [PATCH 1/3] arm: hyp: fix macro parameterisation
In-Reply-To: <1373379366-15689-1-git-send-email-mark.rutland@arm.com>
References: <1373379366-15689-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1373379366-15689-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, compare_cpu_mode_with_primary uses a mixture of macro
arguments and hardcoded registers, and does so incorrectly, as it
stores (__boot_cpu_mode_offset | BOOT_CPU_MODE_MISMATCH) to
(__boot_cpu_mode + &__boot_cpu_mode_offset), which could corrupt an
arbitrary portion of memory.

This patch fixes up compare_cpu_mode_with_primary to use the macro
arguments, correctly updating __boot_cpu_mode.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@cs.columbia.edu>
---
 arch/arm/kernel/hyp-stub.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 1315c4c..bda76ce 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -56,8 +56,8 @@ ENTRY(__boot_cpu_mode)
 	ldr	\reg3, [\reg2]
 	ldr	\reg1, [\reg2, \reg3]
 	cmp	\mode, \reg1		@ matches primary CPU boot mode?
-	orrne	r7, r7, #BOOT_CPU_MODE_MISMATCH
-	strne	r7, [r5, r6]		@ record what happened and give up
+	orrne	\reg1, \reg1, #BOOT_CPU_MODE_MISMATCH
+	strne	\reg1, [\reg2, \reg3]	@ record what happened and give up
 	.endm
 
 #else	/* ZIMAGE */
-- 
1.8.1.1
