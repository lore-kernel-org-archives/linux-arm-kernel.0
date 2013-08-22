From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 21 Aug 2013 21:32:03 -0300
Subject: [PATCH] ARM: mach-omap2: gpmc: Fix warning when CONFIG_ARM_LPAE=y
Message-ID: <1377131523-19392-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

When CONFIG_ARM_LPAE=y the following build warning is generated:

arch/arm/mach-omap2/gpmc.c:1495:4: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' [-Wformat]

According to Documentation/printk-formats.txt '%pa' can be used to properly
print 'resource_size_t'.

Reported-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-omap2/gpmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f3fdd6a..ad6da1d 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1491,8 +1491,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	 */
 	ret = gpmc_cs_remap(cs, res.start);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot remap GPMC CS %d to 0x%x\n",
-			cs, res.start);
+		dev_err(&pdev->dev, "cannot remap GPMC CS %d to %pa\n",
+			cs, &res.start);
 		goto err;
 	}
 
-- 
1.8.1.2
