From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 May 2018 03:14:23 +0800
Subject: [PATCH RESEND net-next v2 6/8] net: stmmac: dwmac-sun8i: Allow
 getting syscon regmap from external device
In-Reply-To: <20180513191425.9801-1-wens@csie.org>
References: <20180513191425.9801-1-wens@csie.org>
Message-ID: <20180513191425.9801-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Allwinner R40 SoC, the "GMAC clock" register is in the CCU
address space. Using a standard syscon to access it provides no
coordination with the CCU driver for register access. Neither does
it prevent this and other drivers from accessing other, maybe critical,
clock control registers. On other SoCs, the register is in the "system
control" address space, which might also contain controls for mapping
SRAM to devices or the CPU. This hardware has the same issues.

Instead, for these types of setups, we let the device containing the
control register create a regmap tied to it. We can then get the device
from the existing syscon phandle, and retrieve the regmap with
dev_get_regmap().

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 50 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index bbc051474806..79e104a20e20 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -983,6 +983,34 @@ static struct mac_device_info *sun8i_dwmac_setup(void *ppriv)
 	return mac;
 }
 
+static struct regmap *sun8i_dwmac_get_syscon_from_dev(struct device_node *node)
+{
+	struct device_node *syscon_node;
+	struct platform_device *syscon_pdev;
+	struct regmap *regmap = NULL;
+
+	syscon_node = of_parse_phandle(node, "syscon", 0);
+	if (!syscon_node)
+		return ERR_PTR(-ENODEV);
+
+	syscon_pdev = of_find_device_by_node(syscon_node);
+	if (!syscon_pdev) {
+		/* platform device might not be probed yet */
+		regmap = ERR_PTR(-EPROBE_DEFER);
+		goto out_put_node;
+	}
+
+	/* If no regmap is found then the other device driver is at fault */
+	regmap = dev_get_regmap(&syscon_pdev->dev, NULL);
+	if (!regmap)
+		regmap = ERR_PTR(-EINVAL);
+
+	platform_device_put(syscon_pdev);
+out_put_node:
+	of_node_put(syscon_node);
+	return regmap;
+}
+
 static int sun8i_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -1027,7 +1055,27 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 		gmac->regulator = NULL;
 	}
 
-	regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "syscon");
+	/* The "GMAC clock control" register might be located in the
+	 * CCU address range (on the R40), or the system control address
+	 * range (on most other sun8i and later SoCs).
+	 *
+	 * The former controls most if not all clocks in the SoC. The
+	 * latter has an SoC identification register, and on some SoCs,
+	 * controls to map device specific SRAM to either the intended
+	 * peripheral, or the CPU address space.
+	 *
+	 * In either case, there should be a coordinated and restricted
+	 * method of accessing the register needed here. This is done by
+	 * having the device export a custom regmap, instead of a generic
+	 * syscon, which grants all access to all registers.
+	 *
+	 * To support old device trees, we fall back to using the syscon
+	 * interface if possible.
+	 */
+	regmap = sun8i_dwmac_get_syscon_from_dev(pdev->dev.of_node);
+	if (IS_ERR(regmap))
+		regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							 "syscon");
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
 		dev_err(&pdev->dev, "Unable to map syscon: %d\n", ret);
-- 
2.17.0
