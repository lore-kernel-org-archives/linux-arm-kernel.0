From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 12:54:07 +0800
Subject: [PATCH 2/9] ARM: mxc: ahci: convert to clk_prepare/clk_unprepare
In-Reply-To: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
References: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1320900854-13031-2-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/devices/platform-ahci-imx.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-ahci-imx.c b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
index d8a56ae..7bf3360 100644
--- a/arch/arm/plat-mxc/devices/platform-ahci-imx.c
+++ b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
@@ -60,10 +60,15 @@ static int imx_sata_init(struct device *dev, void __iomem *addr)
 		dev_err(dev, "no sata clock.\n");
 		return PTR_ERR(sata_clk);
 	}
+	ret = clk_prepare(sata_clk);
+	if (ret) {
+		dev_err(dev, "can't prepare sata clock.\n");
+		goto put_sata_clk;
+	}
 	ret = clk_enable(sata_clk);
 	if (ret) {
 		dev_err(dev, "can't enable sata clock.\n");
-		goto put_sata_clk;
+		goto unprepare_sata_clk;
 	}
 
 	/* Get the AHCI SATA PHY CLK */
@@ -73,10 +78,15 @@ static int imx_sata_init(struct device *dev, void __iomem *addr)
 		ret = PTR_ERR(sata_ref_clk);
 		goto release_sata_clk;
 	}
+	ret = clk_prepare(sata_ref_clk);
+	if (ret) {
+		dev_err(dev, "can't prepare sata ref clock.\n");
+		goto put_sata_ref_clk;
+	}
 	ret = clk_enable(sata_ref_clk);
 	if (ret) {
 		dev_err(dev, "can't enable sata ref clock.\n");
-		goto put_sata_ref_clk;
+		goto unprepare_sata_ref_clk;
 	}
 
 	/* Get the AHB clock rate, and configure the TIMER1MS reg later */
@@ -105,10 +115,14 @@ static int imx_sata_init(struct device *dev, void __iomem *addr)
 
 release_sata_ref_clk:
 	clk_disable(sata_ref_clk);
+unprepare_sata_ref_clk:
+	clk_unprepare(sata_ref_clk);
 put_sata_ref_clk:
 	clk_put(sata_ref_clk);
 release_sata_clk:
 	clk_disable(sata_clk);
+unprepare_sata_clk:
+	clk_unprepare(sata_clk);
 put_sata_clk:
 	clk_put(sata_clk);
 
@@ -118,9 +132,11 @@ put_sata_clk:
 static void imx_sata_exit(struct device *dev)
 {
 	clk_disable(sata_ref_clk);
+	clk_unprepare(sata_ref_clk);
 	clk_put(sata_ref_clk);
 
 	clk_disable(sata_clk);
+	clk_unprepare(sata_clk);
 	clk_put(sata_clk);
 
 }
-- 
1.7.5.4
