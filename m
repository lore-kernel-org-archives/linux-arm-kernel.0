From: oss@buserror.net (Scott Wood)
Date: Fri,  9 Sep 2016 20:03:33 -0500
Subject: [PATCH v5 5/5] arm64: arch_timer: Add command line parameter for
 A-008585
In-Reply-To: <1473469413-11019-1-git-send-email-oss@buserror.net>
References: <1473469413-11019-1-git-send-email-oss@buserror.net>
Message-ID: <1473469413-11019-5-git-send-email-oss@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows KVM users to enable the workaround until a mechanism
is implemented to automatically communicate this information.

Signed-off-by: Scott Wood <oss@buserror.net>
---
 Documentation/kernel-parameters.txt  |  9 +++++++++
 drivers/clocksource/arm_arch_timer.c | 20 +++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index a4f4d69..25037de 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -698,6 +698,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			loops can be debugged more effectively on production
 			systems.
 
+	clocksource.arm_arch_timer.fsl-a008585=
+			[ARM64]
+			Format: <bool>
+			Enable/disable the workaround of Freescale/NXP
+			erratum A-008585.  This can be useful for KVM
+			guests, if the guest device tree doesn't show the
+			erratum.  If unspecified, the workaround is
+			enabled based on the device tree.
+
 	clearcpuid=BITNUM [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 36d4ee1..e70e530 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -98,6 +98,22 @@ early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
 DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
 EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
 
+static int fsl_a008585_enable = -1;
+
+static int __init early_fsl_a008585_cfg(char *buf)
+{
+	int ret;
+	bool val;
+
+	ret = strtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	fsl_a008585_enable = val;
+	return 0;
+}
+early_param("clocksource.arm_arch_timer.fsl-a008585", early_fsl_a008585_cfg);
+
 /*
  * __always_inline is used to ensure that func() is not an actual function
  * pointer, which would result in the register accesses potentially being too
@@ -895,7 +911,9 @@ static int __init arch_timer_of_init(struct device_node *np)
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 
 #ifdef CONFIG_FSL_ERRATUM_A008585
-	if (of_property_read_bool(np, "fsl,erratum-a008585"))
+	if (fsl_a008585_enable < 0)
+		fsl_a008585_enable = of_property_read_bool(np, "fsl,erratum-a008585");
+	if (fsl_a008585_enable)
 		static_branch_enable(&arch_timer_read_ool_enabled);
 #endif
 
-- 
2.7.4
