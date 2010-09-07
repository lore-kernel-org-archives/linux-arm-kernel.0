From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 07 Sep 2010 16:18:53 -0400
Subject: [PATCH 2/2] ARM: mxc: turn off HWCAP_NEON for older versions of imx51
	silicon
In-Reply-To: <1283890733-6548-1-git-send-email-nico@fluxnic.net>
References: <1283890733-6548-1-git-send-email-nico@fluxnic.net>
Message-ID: <1283890733-6548-3-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Amit Kucheria <amit.kucheria@verdurent.com>

Versions of silicon older than TO3 have broken NEON implementation. Turn off
NEON in such cases.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Dave Martin <dave.martin@linaro.org>
Tested-by: Jason Hui <jason.hui@linaro.org>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-mx5/cpu.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
index 2d37785..548c55b 100644
--- a/arch/arm/mach-mx5/cpu.c
+++ b/arch/arm/mach-mx5/cpu.c
@@ -70,6 +70,25 @@ int mx51_revision(void)
 }
 EXPORT_SYMBOL(mx51_revision);
 
+#ifdef CONFIG_NEON
+
+/* All versions of the silicon before Rev. 3 have broken NEON implementations.
+ * Dependent on link order - so the assumption is that vfp_init is called before us
+ */
+static int __init mx51_neon_fixup(void)
+{
+	if (mx51_revision() <  MX51_CHIP_REV_3_0) {
+		if (elf_hwcap & HWCAP_NEON) {
+			elf_hwcap &= ~HWCAP_NEON;
+			pr_info("Turning off NEON support, detected broken NEON implementation\n");
+		}
+	}
+	return 0;
+}
+
+late_initcall(mx51_neon_fixup);
+#endif
+
 static int __init post_cpu_init(void)
 {
 	unsigned int reg;
-- 
1.7.2.2.440.g49ea7
