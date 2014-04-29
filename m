From: kaixu.xia@linaro.org (Xia Kaixu)
Date: Tue, 29 Apr 2014 19:18:25 +0800
Subject: [PATCH 04/15] ASoC: samsung-idma: avoid 64-bit division
In-Reply-To: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
Message-ID: <1398770316-19715-5-git-send-email-kaixu.xia@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

dma_addr_t may be 64 bit wide, which causes a build failure
when doing a division on it. Here it is safe to cast to an
u32 type, which avoids the problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: alsa-devel at alsa-project.org
---
 sound/soc/samsung/idma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index 3d5cf15..e9891b4 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -274,7 +274,7 @@ static irqreturn_t iis_irq(int irqno, void *dev_id)
 
 		addr = readl(idma.regs + I2SLVL0ADDR) - idma.lp_tx_addr;
 		addr += prtd->periodsz;
-		addr %= (prtd->end - prtd->start);
+		addr %= (u32)(prtd->end - prtd->start);
 		addr += idma.lp_tx_addr;
 
 		writel(addr, idma.regs + I2SLVL0ADDR);
-- 
1.7.9.5
