From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 17 Jun 2017 22:07:37 +0800
Subject: [PATCH 4/4] net-next: stmmac: dwmac-sun8i: add support for V3s EMAC
In-Reply-To: <20170617140737.41951-1-icenowy@aosc.io>
References: <20170617140737.41951-1-icenowy@aosc.io>
Message-ID: <20170617140737.41951-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s SoC has an Ethernet MAC and an internal PHY like the ones
in H3 SoC, however the MAC has no external *MII interfaces available at
GPIOs, thus only MII connection to internal PHY is supported.

Add this variant of EMAC to dwmac-sun8i driver.

The default value of the syscon EMAC-related register seems to have
changed from H3, but it seems to be a harmless change.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c     | 8 ++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 61ce3b54f0c6..fffd6d5fc907 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -81,6 +81,12 @@ static const struct emac_variant emac_variant_h3 = {
 	.support_rgmii = true
 };
 
+static const struct emac_variant emac_variant_v3s = {
+	.default_syscon_value = 0x38000,
+	.internal_phy = PHY_INTERFACE_MODE_MII,
+	.support_mii = true
+};
+
 static const struct emac_variant emac_variant_a83t = {
 	.default_syscon_value = 0,
 	.internal_phy = 0,
@@ -975,6 +981,8 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 static const struct of_device_id sun8i_dwmac_match[] = {
 	{ .compatible = "allwinner,sun8i-h3-emac",
 		.data = &emac_variant_h3 },
+	{ .compatible = "allwinner,sun8i-v3s-emac",
+		.data = &emac_variant_v3s },
 	{ .compatible = "allwinner,sun8i-a83t-emac",
 		.data = &emac_variant_a83t },
 	{ .compatible = "allwinner,sun50i-a64-emac",
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3840529344ed..a366b3747eeb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -313,6 +313,7 @@ static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
 		{ .compatible = "snps,dwc-qos-ethernet-4.10" },
 		{ .compatible = "allwinner,sun8i-a83t-emac" },
 		{ .compatible = "allwinner,sun8i-h3-emac" },
+		{ .compatible = "allwinner,sun8i-v3s-emac" },
 		{ .compatible = "allwinner,sun50i-a64-emac" },
 	};
 
-- 
2.13.0
