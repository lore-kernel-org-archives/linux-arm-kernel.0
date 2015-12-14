From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 14 Dec 2015 09:42:57 +0000
Subject: [PATCH 2/4] nvmem: qfprom: Specify LE device endianness
In-Reply-To: <1450086024-18297-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1450086024-18297-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1450086177-18799-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

The qfprom is a little endian device, but so far we've been
relying on the regmap mmio bus handling this for us without
explicitly stating that fact. After commit 4a98da2164cf
(regmap-mmio: Use native endianness for read/write, 2015-10-29),
the regmap mmio bus will read/write with the __raw_*() IO
accessors, instead of using the readl/writel() APIs that do
proper byte swapping for little endian devices.

So if we're running on a big endian processor and haven't
specified the endianness explicitly in the regmap config or in
DT, we're going to switch from doing little endian byte swapping
to big endian accesses without byte swapping, leading to some
confusing results. Specify the endianness explicitly so that the
regmap core properly byte swaps the accesses for us.

Cc: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Tyler Baker <tyler.baker@linaro.org>
Cc: Simon Arlott <simon@fire.lp0.eu>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index afb67e7..3829e5f 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -21,6 +21,7 @@ static struct regmap_config qfprom_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 8,
 	.reg_stride = 1,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
 static struct nvmem_config econfig = {
-- 
1.9.1
