From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 18 May 2017 18:21:13 +0800
Subject: [PATCH] arm64: cpufeature: check translation granule size based on
 kernel config
Message-ID: <1495102873-10858-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the big.LITTLE system with two clusters, one is CA53 cluster and
another is CA73 cluster. CA53 doesn't support 16KB memory translation
granule size (4.3.21 AArch64 Memory Model Feature Register 0, EL1; ARM
DDI 0500F), but CA73 supports this feature (4.3.27 AArch64 Memory Model
Feature Register 0, EL1; ARM 100048_0002_04_en). As result, the kernel
reports log for "Unexpected variation" as below.

[    0.182113] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
[    0.182118]
[    0.182124] ------------[ cut here ]------------
[    0.182140] WARNING: CPU: 4 PID: 0 at arch/arm64/kernel/cpufeature.c:636 update_cpu_features+0x400/0x408
[    0.182141] Modules linked in:
[    0.182144]
[    0.182149] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 4.11.0-08573-g2935db7 #1
[    0.182151] Hardware name: HiKey960 (DT)
[    0.182154] task: ffff8000bb2c4e00 task.stack: ffff8000bb2dc000
[    0.182156] PC is at update_cpu_features+0x400/0x408
[    0.182158] LR is at update_cpu_features+0x400/0x408
[    0.182161] pc : [<ffff00000808e4a0>] lr : [<ffff00000808e4a0>] pstate: 600001c5
[    0.182161] sp : ffff8000bb2dff70
[    0.182163] x29: ffff8000bb2dff70 x28: 0000000000000000
[    0.182166] x27: 0000000000000000 x26: 0000000000000000
[    0.182168] x25: 0000000000000000 x24: 0000000000000000
[    0.182170] x23: 0000000000000000 x22: ffff000008f9f108
[    0.182173] x21: 0000000000000004 x20: ffff8000bef764d8
[    0.182175] x19: 0000000000000001 x18: 0000000000000000
[    0.182178] x17: 0000000000000000 x16: 0000000000000000
[    0.182180] x15: 0000000000000000 x14: 455f3052464d4d34
[    0.182182] x13: 3641415f44495f53 x12: 5953206e69206e6f
[    0.182184] x11: 6974616972617620 x10: ffff000008fa6ae0
[    0.182187] x9 : 0000000000000000 x8 : ffff000008fa88fc
[    0.182189] x7 : 0000000000000000 x6 : 00000000007e6647
[    0.182192] x5 : 0000000000000000 x4 : 0000000000000000
[    0.182194] x3 : ffffffffffffffff x2 : 00008000b6120000
[    0.182196] x1 : ffff8000bb2c4e00 x0 : 0000000000000022
[    0.182198]
[    0.182203] ---[ end trace e3d886f1604bd987 ]---
[    0.182205] Call trace:
[    0.182208] Exception stack(0xffff8000bb2dfda0 to 0xffff8000bb2dfed0)
[    0.182211] fda0: 0000000000000001 0001000000000000 ffff8000bb2dff70 ffff00000808e4a0
[    0.182214] fdc0: ffff8000bb2dfef0 ffff000008c53880 0000000000000000 0000000000000000
[    0.182215] fde0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.182218] fe00: 0000000000000000 ffff000008c53880 ffff8000bb2dff70 ffff8000bb2dff70
[    0.182220] fe20: ffff8000bb2dff30 00000000ffffffc8 ffff8000bb2dfe60 ffff000008110ac4
[    0.182222] fe40: 0000000000000022 ffff8000bb2c4e00 00008000b6120000 ffffffffffffffff
[    0.182224] fe60: 0000000000000000 0000000000000000 00000000007e6647 0000000000000000
[    0.182227] fe80: ffff000008fa88fc 0000000000000000 ffff000008fa6ae0 6974616972617620
[    0.182229] fea0: 5953206e69206e6f 3641415f44495f53 455f3052464d4d34 0000000000000000
[    0.182230] fec0: 0000000000000000 0000000000000000
[    0.182232] [<ffff00000808e4a0>] update_cpu_features+0x400/0x408
[    0.182236] [<ffff00000808d568>] cpuinfo_store_cpu+0x48/0x50
[    0.182238] [<ffff00000808f070>] secondary_start_kernel+0xa8/0x118
[    0.182242] [<000000000098b1c4>] 0x98b1c4

[...]

This patch is to change the checking CPU feature for memory translation
granule size based on kernel configuration. If kernel configuration has
selected to use one specific memory translation granule size, then we
will do strict sanity checking cross all CPUs. Otherwise we can skip to
check unused features for memory translation granule size if kernel
doesn't use it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 94b8f7f..938ddac 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -117,9 +117,21 @@
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
+#ifdef CONFIG_ARM64_4K_PAGES
 	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN4_SHIFT, 4, ID_AA64MMFR0_TGRAN4_NI),
+#else
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN4_SHIFT, 4, ID_AA64MMFR0_TGRAN4_NI),
+#endif
+#ifdef CONFIG_AARM64_64K_PAGES
 	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN64_SHIFT, 4, ID_AA64MMFR0_TGRAN64_NI),
+#else
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN64_SHIFT, 4, ID_AA64MMFR0_TGRAN64_NI),
+#endif
+#ifdef CONFIG_AARM64_16K_PAGES
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN16_SHIFT, 4, ID_AA64MMFR0_TGRAN16_NI),
+#else
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN16_SHIFT, 4, ID_AA64MMFR0_TGRAN16_NI),
+#endif
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_BIGENDEL0_SHIFT, 4, 0),
 	/* Linux shouldn't care about secure memory */
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64MMFR0_SNSMEM_SHIFT, 4, 0),
-- 
1.9.1
