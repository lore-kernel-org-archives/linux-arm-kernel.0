From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 29 Nov 2017 15:39:49 -0800
Subject: [PATCH] arm64: Inform user if software PAN is in use
Message-ID: <20171129233949.1284-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It isn't entirely obvious if we're using software PAN because we
don't say anything about it in the boot log. But if we're using
hardware PAN we'll print a nice CPU feature message indicating
it. Add a print for software PAN too so we know if it's being
used or not.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/kernel/cpufeature.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 21e2c95d24e7..c6f8da17146b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1189,6 +1189,9 @@ void __init setup_cpu_features(void)
 	if (system_supports_32bit_el0())
 		setup_elf_hwcaps(compat_elf_hwcaps);
 
+	if (system_uses_ttbr0_pan())
+		pr_info("Emulating Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
+
 	/* Advertise that we have computed the system capabilities */
 	set_sys_caps_initialised();
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
