From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 27 May 2015 10:10:26 +0200
Subject: [PATCH] ARM: imx6: gpc: don't register power domain if DT data is
 missing
Message-ID: <1432714226-6333-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the devicetree is too old and does not provide the regulator and clocks
for the power domain, we need to avoid registering the power domain.
Otherwise runtime PM will try to control the domain, which will lead to
machine hangs without the proper DT configuration data.

This restores functionality to the kernel 4.0 level if an old DT is
detected, where the power domain is constantly powered on.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-imx/gpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index bbf015056221..6d0893a3828e 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -449,6 +449,10 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	struct regulator *pu_reg;
 	int ret;
 
+	/* bail out if DT too old and doesn't provide the necessary info */
+	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells"))
+		return 0;
+
 	pu_reg = devm_regulator_get_optional(&pdev->dev, "pu");
 	if (PTR_ERR(pu_reg) == -ENODEV)
 		pu_reg = NULL;
-- 
2.1.4
