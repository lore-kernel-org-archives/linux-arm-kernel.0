From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Nov 2015 15:43:06 -0800
Subject: [PATCH] ASoC: qcom: Specify LE device endianness
Message-ID: <1448062986-19535-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a little endian device, but so far we've been relying on
the regmap mmio bus handling this for us without explicitly
stating that fact. After commit 4a98da2164cf (regmap-mmio: Use
native endianness for read/write, 2015-10-29), the regmap mmio
bus will read/write with the __raw_*() IO accessors, instead of
using the readl/writel() APIs that do proper byte swapping for
little endian devices.

So if we're running on a big endian processor and haven't
specified the endianness explicitly in the regmap config or in
DT, we're going to switch from doing little endian byte swapping
to big endian accesses without byte swapping, leading to some
confusing results. Specify the endianness explicitly so that the
regmap core properly byte swaps the accesses for us.

Cc: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Tyler Baker <tyler.baker@linaro.org>
Cc: Simon Arlott <simon@fire.lp0.eu>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index e5101e0d2d37..00b6c9d039cf 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -355,6 +355,7 @@ static struct regmap_config lpass_cpu_regmap_config = {
 	.readable_reg = lpass_cpu_regmap_readable,
 	.volatile_reg = lpass_cpu_regmap_volatile,
 	.cache_type = REGCACHE_FLAT,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
 int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
