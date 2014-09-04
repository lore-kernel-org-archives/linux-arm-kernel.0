From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Sep 2014 11:33:38 +0200
Subject: [PATCH v5 1/4] ethernet: arc: Add support for Rockchip SoC layer
 device tree bindings
In-Reply-To: <20140903211220.GA16962@gmail.com>
References: <1409763165-16461-1-git-send-email-romain.perier@gmail.com>
 <20140903211220.GA16962@gmail.com>
Message-ID: <3809311.80Auz8fbHu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 23:12:20 Beniamino Galvani wrote:
> There is also the following build warning due to the emac dependency
> on REGULATOR which in principle seems correct, but looking at other
> drivers I wonder why they use the regulator APIs but don't have the
> same dependency.
> 
> drivers/regulator/Kconfig:1:error: recursive dependency detected!
> drivers/regulator/Kconfig:1:       symbol REGULATOR is selected by MDIO_SUN4I
> drivers/net/phy/Kconfig:159:       symbol MDIO_SUN4I depends on PHYLIB
> drivers/net/phy/Kconfig:5:         symbol PHYLIB is selected by ARC_EMAC_CORE
> drivers/net/ethernet/arc/Kconfig:20:      symbol ARC_EMAC_CORE is selected by EMAC_ROCKCHIP
> drivers/net/ethernet/arc/Kconfig:35:      symbol EMAC_ROCKCHIP depends on REGULATOR

This is a recurring problem: 

driver a depends on x and selects y
driver b depends on y and selects x

Maybe we should teach Kconfig to not worry about it when x and y are
both user-selectable as well.

However, a nicer solution would be if we could agree for each symbol
on who is supposed to 'select' or 'depends on' it. In particular,
we are inconsistent about CONFIG_REGULATOR:

MDIO_SUN4I probably should not 'select' it but instead 'depends on'
this symbol if anything. It would be nice if someone could submit
a patch to that effect. EMAC_ROCKCHIP could also drop the dependency
on REGULATOR: you can still build the driver without that subsystem
being enabled, but then all the regulators have to be set up by
the boot loader.

There isn't much we can do about the PHYLIB dependency, unless we
turn it into a silent symbol that gets selected by all phy drivers,
or we change all network drivers that currently 'select' it to
'depends on'. I don't really want to get involved in that discussion ;-)

	Arnd
