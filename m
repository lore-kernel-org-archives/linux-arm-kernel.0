From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 18 Oct 2013 19:48:44 +0800
Subject: [PATCH v3 2/8] mmc: sdhci-esdhc-imx: fix reading cap_1 register value
 for mx6sl
In-Reply-To: <1382096930-7964-1-git-send-email-b29396@freescale.com>
References: <1382096930-7964-1-git-send-email-b29396@freescale.com>
Message-ID: <1382096930-7964-3-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When reading CAP_1 register for mx6sl, ignore bit[0-15] as it stores
CAP_2 register value which is new introduced in mx6sl.

Without this fix, the max clock for mx6sl may not be correct since
it's wrongly calculated by reading CAP_1 register.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 3b9c94f..1652e18 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -226,6 +226,10 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 	}
 
 	if (unlikely(reg == SDHCI_CAPABILITIES)) {
+		/* ignore bit[0-15] as it stores cap_1 register val for mx6sl */
+		if (imx_data->socdata->flags & ESDHC_FLAG_HAVE_CAP1)
+			val &= 0xffff0000;
+
 		/* In FSL esdhc IC module, only bit20 is used to indicate the
 		 * ADMA2 capability of esdhc, but this bit is messed up on
 		 * some SOCs (e.g. on MX25, MX35 this bit is set, but they
-- 
1.7.2.rc3
