From: rajeshwari.s@samsung.com (Rajeshwari Shinde)
Date: Wed, 05 Oct 2011 11:01:07 +0530
Subject: [PATCH 1/3] SDHCI: S3C: Use generic clock names for sdhci bus clock
	options
In-Reply-To: <1317792669-19925-1-git-send-email-rajeshwari.s@samsung.com>
References: <1317792669-19925-1-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <1317792669-19925-2-git-send-email-rajeshwari.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the driver to stop depending on the clock names
being passed from the platform and switch over to bus clock lookup
using generic clock names.

Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index b29e734..871cf4f 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -477,14 +477,12 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 
 	for (clks = 0, ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
 		struct clk *clk;
-		char *name = pdata->clocks[ptr];
+		char name[14];
 
-		if (name == NULL)
-			continue;
+		sprintf(name, "mmc_busclk.%d", ptr);
 
 		clk = clk_get(dev, name);
 		if (IS_ERR(clk)) {
-			dev_err(dev, "failed to get clock %s\n", name);
 			continue;
 		}
 
-- 
1.6.6.rc2
