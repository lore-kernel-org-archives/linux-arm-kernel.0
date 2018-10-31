From: niklas.cassel@linaro.org (Niklas Cassel)
Date: Wed, 31 Oct 2018 16:08:10 +0100
Subject: [PATCH] net: stmmac: Fix stmmac_mdio_reset() when building stmmac as
 modules
Message-ID: <20181031150810.16665-1-niklas.cassel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building stmmac, it is only possible to select CONFIG_DWMAC_GENERIC,
or any of the glue drivers, when CONFIG_STMMAC_PLATFORM is set.
The only exception is CONFIG_STMMAC_PCI.

When calling of_mdiobus_register(), it will call our ->reset()
callback, which is set to stmmac_mdio_reset().

Most of the code in stmmac_mdio_reset() is protected by a
"#if defined(CONFIG_STMMAC_PLATFORM)", which will evaluate
to false when CONFIG_STMMAC_PLATFORM=m.

Because of this, the phy reset gpio will only be pulled when
stmmac is built as built-in, but not when built as modules.

Fix this by using "#if IS_ENABLED()" instead of "#if defined()".

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index b72ef171477e..bdd351597b55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -243,7 +243,7 @@ static int stmmac_mdio_write(struct mii_bus *bus, int phyaddr, int phyreg,
  */
 int stmmac_mdio_reset(struct mii_bus *bus)
 {
-#if defined(CONFIG_STMMAC_PLATFORM)
+#if IS_ENABLED(CONFIG_STMMAC_PLATFORM)
 	struct net_device *ndev = bus->priv;
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	unsigned int mii_address = priv->hw->mii.addr;
-- 
2.17.2
