From: davem@davemloft.net (David Miller)
Date: Mon, 09 Nov 2015 11:36:22 -0500 (EST)
Subject: [PATCH] mvneta: add FIXED_PHY dependency
In-Reply-To: <4225885.EYXTHjRPmX@wuerfel>
References: <4225885.EYXTHjRPmX@wuerfel>
Message-ID: <20151109.113622.1309064405711224118.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 09 Nov 2015 15:08:57 +0100

> The fixed_phy infrastructure is done in a way that is optional,
> by providing 'static inline' helper functions doing nothing in
> include/linux/phy_fixed.h for all its APIs. However, three out
> of the four users (DSA, BCMGENET, and SYSTEMPORT) always
> 'select FIXED_PHY', presumably because they need that.
> MVNETA is the fourth one, and if that is built-in but FIXED_PHY
> is configured as a loadable module, we get a link error:
> 
> drivers/built-in.o: In function `mvneta_fixed_link_update':
> fpga-mgr.c:(.text+0x33ed80): undefined reference to `fixed_phy_update_state'
> 
> Presumably this driver has the same dependency as the others,
> so this patch also uses 'select' to ensure that the fixed-phy
> support is built-in.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 898b2970e2c9 ("mvneta: implement SGMII-based in-band link state signaling")
> ---
> Found using ARM randconfig tests. An alternative here would be
> to use 'depends on FIXED_PHY || FIXED_PHY=n', I picked the 'select'
> approach for consistency.
> 
> Should we perhaps make 'FIXED_PHY' a silent option and remove the
> inline helpers, based on the assumption that a driver that wants these
> will not work without them?

This seems reasonable to fix the problem for the time being, applied.

Thanks Arnd.
