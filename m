From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 10 Sep 2014 11:07:03 +0200
Subject: [PATCH v8 2/5] ARM: imx6: gpc: Add PU power domain for GPU/VPU
In-Reply-To: <20140910034918.GA28759@Robin-OptiPlex-780>
References: <1410267915-18126-1-git-send-email-p.zabel@pengutronix.de>
 <1410267915-18126-3-git-send-email-p.zabel@pengutronix.de>
 <20140910034918.GA28759@Robin-OptiPlex-780>
Message-ID: <1410340023.4508.4.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Am Mittwoch, den 10.09.2014, 11:49 +0800 schrieb Robin Gong:
> Hi Philipp,
>   Thanks for your great job, power domain make things clear. But looks your
> patch depend on 'PU regulator', if there is no PU regulator passed down from
> dts, we'll never implement your way for PGC. On i.mx6sx, there is no internal
> PU regulator, so I suggest you consider this case. 

thank you for the hint. Would making the PU regulator optional be enough
to make this work on i.MX6SX?

regards
Philipp

---8<---
From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] ARM: imx6: gpc: Make PU regulator optional

On i.MX6SX there is no internal PU regulator, make it optional.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/gpc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index cdf8a06..b36703d 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -186,7 +186,8 @@ static int imx6q_pm_pu_power_off(struct generic_pm_domain *genpd)
 	/* Wait ISO + ISO2SW IPG clock cycles */
 	ndelay((iso + iso2sw) * 1000 / 66);
 
-	regulator_disable(pu->reg);
+	if (pu->reg)
+		regulator_disable(pu->reg);
 
 	return 0;
 }
@@ -197,8 +198,9 @@ static int imx6q_pm_pu_power_on(struct generic_pm_domain *genpd)
 	int i, ret, sw, sw2iso;
 	u32 val;
 
-	ret = regulator_enable(pu->reg);
-	if (ret) {
+	if (pu->reg)
+		ret = regulator_enable(pu->reg);
+	if (pu->reg && ret) {
 		pr_err("%s: failed to enable regulator: %d\n", __func__, ret);
 		return ret;
 	}
@@ -309,7 +311,9 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	struct regulator *pu_reg;
 	int ret;
 
-	pu_reg = devm_regulator_get(&pdev->dev, "pu");
+	pu_reg = devm_regulator_get_optional(&pdev->dev, "pu");
+	if (PTR_ERR(pu_reg) == -ENODEV)
+		pu_reg = NULL;
 	if (IS_ERR(pu_reg)) {
 		ret = PTR_ERR(pu_reg);
 		dev_err(&pdev->dev, "failed to get pu regulator: %d\n", ret);
@@ -317,8 +321,9 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	}
 
 	/* The regulator is initially enabled */
-	ret = regulator_enable(pu_reg);
-	if (ret < 0) {
+	if (pu_reg)
+		ret = regulator_enable(pu_reg);
+	if (pu_reg && ret < 0) {
 		dev_err(&pdev->dev, "failed to enable pu regulator: %d\n", ret);
 		return ret;
 	}
-- 
2.1.0
