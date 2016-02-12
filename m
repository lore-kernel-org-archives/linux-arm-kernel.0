From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Feb 2016 09:30:17 -0800
Subject: [PATCH] Revert "ASoC: qcom: Specify LE device endianness"
Message-ID: <1455298217-15744-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 18560a4e3b07438113b50589e78532d95f907029.

The commit that caused us to specify LE device endianness here,
29bb45f25ff3 (regmap-mmio: Use native endianness for read/write,
2015-10-29), has been reverted in mainline so now when we specify
LE it actively breaks big endian kernels because the byte
swapping in regmap-mmio is incorrect. Let's revert this change
because it will 1) fix the big endian kernels and 2) be redundant
to specify LE because that will become the default soon.

Cc: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 00b6c9d039cf..e5101e0d2d37 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -355,7 +355,6 @@ static struct regmap_config lpass_cpu_regmap_config = {
 	.readable_reg = lpass_cpu_regmap_readable,
 	.volatile_reg = lpass_cpu_regmap_volatile,
 	.cache_type = REGCACHE_FLAT,
-	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
 int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
