From: Yuval.Mintz@qlogic.com (Yuval Mintz)
Date: Tue, 23 Feb 2016 18:33:10 +0000
Subject: [PATCH] bnx2x: add a separate GENEVE Kconfig symbol
In-Reply-To: <1456223774-1383513-1-git-send-email-arnd@arndb.de>
References: <1456223774-1383513-1-git-send-email-arnd@arndb.de>
Message-ID: <CO2PR11MB0088CC09F328C0CFE10187BF97A40@CO2PR11MB0088.namprd11.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> When CONFIG_GENEVE is built as a loadable module, and bnx2x is built-in,
> we get this link error:

> drivers/net/built-in.o: In function `bnx2x_open':
> :(.text+0x33322): undefined reference to `geneve_get_rx_port'
> drivers/net/built-in.o: In function `bnx2x_sp_rtnl_task':
> :(.text+0x3e632): undefined reference to `geneve_get_rx_port'

> This avoids the problem by adding a separate Kconfig symbol named
> CONFIG_BNX2X_GENEVE that is only enabled when the code is
> reachable from the driver.

> This is the same trick that BNX2X does for VXLAN support, and
> is similar to how I40E handles both.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 883ce97d25b0 ("bnx2x: Add Geneve inner-RSS support")

Ouch. Thanks for fixing this one; I tried avoiding this solution
since I don't think there's any reason to encumber the config
file with needless options [I.e., what's the gain in the ability to
disable a single offloaded protocol on a single network driver?],
but obviously, I botched the job.

BTW, if you want to handle this exactly like vxlan, you might
consider using `defined(CONFIG_BNX2X_GENEVE)' instead of
`IS_ENABLED(CONFIG_BNX2X_GENEVE)'  [It not a tristate].
But that's truly insignificant.

Acked-By: Yuval Mintz <Yuval.Mintz@qlogic.com>
