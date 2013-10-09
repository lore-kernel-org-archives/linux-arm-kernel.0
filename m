From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 9 Oct 2013 19:20:10 +0800
Subject: [PATCH 04/10] mmc: sdhci-esdhc-imx: fix reading cap_1 register value
 for mx6sl
In-Reply-To: <1381317616-1229-1-git-send-email-b29396@freescale.com>
References: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Message-ID: <1381317616-1229-5-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When reading CAP_1 register for mx6sl, ignore bit[0-15] as it stores
CAP_2 register value which is new introduced in mx6sl.

Without this fix, the max clock for mx6sl may not be correct since
it's wrongly calculated by reading CAP_1 register.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2cce244..8721549 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -216,6 +216,10 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 	}
 
 	if (unlikely(reg == SDHCI_CAPABILITIES)) {
+		/* ignore bit[0-15] as it stores cap_2 register val for mx6sl */
+		if (is_imx6sl_usdhc(imx_data))
+			val &= 0xffff0000;
+
 		/* In FSL esdhc IC module, only bit20 is used to indicate the
 		 * ADMA2 capability of esdhc, but this bit is messed up on
 		 * some SOCs (e.g. on MX25, MX35 this bit is set, but they
-- 
1.7.2.rc3
