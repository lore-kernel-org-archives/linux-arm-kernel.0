From: davem@davemloft.net (David Miller)
Date: Wed, 31 Oct 2018 18:36:28 -0700 (PDT)
Subject: [PATCH] net: stmmac: Fix stmmac_mdio_reset() when building
 stmmac as modules
In-Reply-To: <20181031150810.16665-1-niklas.cassel@linaro.org>
References: <20181031150810.16665-1-niklas.cassel@linaro.org>
Message-ID: <20181031.183628.2259691990575006225.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas Cassel <niklas.cassel@linaro.org>
Date: Wed, 31 Oct 2018 16:08:10 +0100

> When building stmmac, it is only possible to select CONFIG_DWMAC_GENERIC,
> or any of the glue drivers, when CONFIG_STMMAC_PLATFORM is set.
> The only exception is CONFIG_STMMAC_PCI.
> 
> When calling of_mdiobus_register(), it will call our ->reset()
> callback, which is set to stmmac_mdio_reset().
> 
> Most of the code in stmmac_mdio_reset() is protected by a
> "#if defined(CONFIG_STMMAC_PLATFORM)", which will evaluate
> to false when CONFIG_STMMAC_PLATFORM=m.
> 
> Because of this, the phy reset gpio will only be pulled when
> stmmac is built as built-in, but not when built as modules.
> 
> Fix this by using "#if IS_ENABLED()" instead of "#if defined()".
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Applied and queued up for -stable, thanks.
