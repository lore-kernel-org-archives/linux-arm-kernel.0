From: rabin@rab.in (Rabin Vincent)
Date: Thu, 14 Jan 2010 01:17:37 +0530
Subject: [PATCH] Revert "[ARM] disable NX support for OABI-supporting kernels"
Message-ID: <1263412057-13944-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 14f0aa359365e8a93a77b71e3b840274b9b4dcb1.

That commit was needed earlier because system call restarting for OABI
(compat) required an executable stack and thus had problems with NX.
Since ab72b00734ae4d0b ("ARM: Fix signal restart issues with NX and OABI
compat") has reworked the code to not require an executable stack
anymore, we can re-enable NX support for kernels with OABI (compat)
support.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/elf.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index 950391f..d4a0da1 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -78,15 +78,6 @@ int arm_elf_read_implies_exec(const struct elf32_hdr *x, int executable_stack)
 		return 1;
 	if (cpu_architecture() < CPU_ARCH_ARMv6)
 		return 1;
-#if !defined(CONFIG_AEABI) || defined(CONFIG_OABI_COMPAT)
-	/*
-	 * If we have support for OABI programs, we can never allow NX
-	 * support - our signal syscall restart mechanism relies upon
-	 * being able to execute code placed on the user stack.
-	 */
-	return 1;
-#else
 	return 0;
-#endif
 }
 EXPORT_SYMBOL(arm_elf_read_implies_exec);
-- 
1.6.5
