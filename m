From: liuj97@gmail.com (Jiang Liu)
Date: Fri, 27 Sep 2013 16:04:44 +0800
Subject: [RFT PATCH v1 4/7] arm64: provide boot option "eagerfpu" to control
 FPSIMD restore policy
In-Reply-To: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
References: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
Message-ID: <1380269087-8520-5-git-send-email-liuj97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@huawei.com>

Provide tristate kernel boot option "eagerfpu" to control FPSIMD state
save and restore policy. It adopts the same scematics as x86.

The lazy FPSIMD restore policy needs to configured before any thread
makes use of FPSIMD registers, so change fpsimd_init() as arch_initcall.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
---
 Documentation/kernel-parameters.txt |  5 +++--
 arch/arm64/kernel/fpsimd.c          | 19 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 539a236..236e342 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2020,11 +2020,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			and restore using xsave. The kernel will fallback to
 			enabling legacy floating-point and sse state.
 
-	eagerfpu=	[X86]
+	eagerfpu=	[X86,ARM64]
 			on	enable eager fpu restore
 			off	disable eager fpu restore
 			auto	selects the default scheme, which automatically
-				enables eagerfpu restore for xsaveopt.
+				enables eagerfpu restore for xsaveopt on x86
+				and disables eager fpu restore on ARM64.
 
 	nohlt		[BUGS=ARM,SH] Tells the kernel that the sleep(SH) or
 			wfi(ARM) instruction doesn't work correctly and not to
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 2208ba3..c14f5e9 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -256,6 +256,20 @@ EXPORT_SYMBOL(kernel_neon_end);
 
 #endif /* CONFIG_KERNEL_MODE_NEON */
 
+static enum { AUTO, ENABLE, DISABLE } eagerfpu = AUTO;
+
+static int __init eager_fpu_setup(char *s)
+{
+	if (!strcmp(s, "on"))
+		eagerfpu = ENABLE;
+	else if (!strcmp(s, "off"))
+		eagerfpu = DISABLE;
+	else if (!strcmp(s, "auto"))
+		eagerfpu = AUTO;
+	return 1;
+}
+__setup("eagerfpu=", eager_fpu_setup);
+
 /*
  * FP/SIMD support code initialisation.
  */
@@ -274,6 +288,9 @@ static int __init fpsimd_init(void)
 	else
 		elf_hwcap |= HWCAP_ASIMD;
 
+	if (eagerfpu == DISABLE || eagerfpu == AUTO)
+		static_key_slow_inc(&fpsimd_lazy_mode);
+
 	return 0;
 }
-late_initcall(fpsimd_init);
+arch_initcall(fpsimd_init);
-- 
1.8.1.2
