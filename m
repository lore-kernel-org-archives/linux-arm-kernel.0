From: will.deacon@arm.com (Will Deacon)
Date: Mon,  3 Dec 2012 17:56:41 +0000
Subject: [PATCH 1/3] ARM: nommu: allow unaligned accesses on ARMv6+ processors
Message-ID: <1354557403-20386-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 8428e84d ("ARM: 7150/1: Allow kernel unaligned accesses on ARMv6+
processors") unconditionally clears SCTLR.A for ARMv6+ processors, since
newer toolchains assume that unaligned memory accesses will not fault
for these cores.

This patch adds the corresponding change for nommu kernel builds.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Identical to Armando's recent patch but included here for completeness.

 arch/arm/kernel/head-nommu.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 278cfc1..2c228a0 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -68,7 +68,7 @@ __after_proc_init:
 	 * CP15 system control register value returned in r0 from
 	 * the CPU init function.
 	 */
-#ifdef CONFIG_ALIGNMENT_TRAP
+#if defined(CONFIG_ALIGNMENT_TRAP) && __LINUX_ARM_ARCH__ < 6
 	orr	r0, r0, #CR_A
 #else
 	bic	r0, r0, #CR_A
-- 
1.8.0
