From: keescook@chromium.org (Kees Cook)
Date: Tue, 20 Feb 2018 14:46:24 -0800
Subject: [PATCH] arm64: cpufeature: Trim feature reporting and include PAN
 emulation
Message-ID: <20180220224624.GA28218@beast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PAN emulation notification was only happening for non-boot CPUs
if CPU capabilities had already been configured. This seems to be the
wrong place, as it's system-wide and isn't attached to capabilities,
so its reporting didn't normally happen. Instead, report it once from
the boot CPU. Additionally removes the redundant "feature" word from the
"CPU features:" line.

Before (redundant "feature", and missing PAN emulation report):

 SMP: Total of 4 processors activated.
 CPU features: detected feature: 32-bit EL0 Support
 CPU features: detected feature: Kernel page table isolation (KPTI)
 CPU: All CPU(s) started at EL2

After:

 SMP: Total of 4 processors activated.
 CPU features: detected: 32-bit EL0 Support
 CPU features: detected: Kernel page table isolation (KPTI)
 CPU features: emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching
 CPU: All CPU(s) started at EL2

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/cpufeature.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 29b1f873e337..6c799ca58b53 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1333,9 +1333,6 @@ static void verify_local_cpu_capabilities(void)
 
 	if (system_supports_sve())
 		verify_sve_features();
-
-	if (system_uses_ttbr0_pan())
-		pr_info("Emulating Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
 }
 
 void check_local_cpu_capabilities(void)
@@ -1360,7 +1357,7 @@ void check_local_cpu_capabilities(void)
 
 static void __init setup_feature_capabilities(void)
 {
-	update_cpu_capabilities(arm64_features, "detected feature:");
+	update_cpu_capabilities(arm64_features, "detected:");
 	enable_cpu_capabilities(arm64_features);
 }
 
@@ -1394,6 +1391,9 @@ void __init setup_cpu_features(void)
 	if (system_supports_32bit_el0())
 		setup_elf_hwcaps(compat_elf_hwcaps);
 
+	if (system_uses_ttbr0_pan())
+		pr_info("emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
+
 	sve_setup();
 
 	/* Advertise that we have computed the system capabilities */
-- 
2.7.4


-- 
Kees Cook
Pixel Security
