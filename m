From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Feb 2014 11:46:34 +0000
Subject: [PATCH] arm64: smp: Add a memory barrier before we start secondary
 cores
Message-ID: <1392205594-29186-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Ensure that memory writes will be visible to the newly started core by
inserting a write barrier prior to starting. This adds robustness against
possible incomplete synchronisation of state.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/kernel/smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 9660750f34ba..f5520d8fafab 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -160,6 +160,11 @@ asmlinkage void secondary_start_kernel(void)
 	smp_store_cpu_info(cpu);
 
 	/*
+	 * Ensure memory writes are visible before we start.
+	 */
+	smp_wmb();
+
+	/*
 	 * OK, now it's safe to let the boot CPU continue.  Wait for
 	 * the CPU migration code to notice that the CPU is online
 	 * before we continue.
-- 
1.9.0.rc3
