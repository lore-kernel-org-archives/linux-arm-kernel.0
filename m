From: davem@davemloft.net (David Miller)
Date: Mon, 04 Jan 2016 21:54:59 -0500 (EST)
Subject: [PATCH] fsl/fman: allow modular build
In-Reply-To: <4109142.02mezJXbJM@wuerfel>
References: <4109142.02mezJXbJM@wuerfel>
Message-ID: <20160104.215459.1264934689312091785.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 01 Jan 2016 14:55:24 +0100

> ARM allmodconfig fails because of the addition of the FMAN driver:
> 
> drivers/built-in.o: In function `dtsec_restart_autoneg':
> binder.c:(.text+0x173328): undefined reference to `mdiobus_read'
> binder.c:(.text+0x173348): undefined reference to `mdiobus_write'
> drivers/built-in.o: In function `dtsec_config':
> binder.c:(.text+0x173d24): undefined reference to `of_phy_find_device'
> drivers/built-in.o: In function `init_phy':
> binder.c:(.text+0x1763b0): undefined reference to `of_phy_connect'
> drivers/built-in.o: In function `stop':
> binder.c:(.text+0x176014): undefined reference to `phy_stop'
> drivers/built-in.o: In function `start':
> binder.c:(.text+0x176078): undefined reference to `phy_start'
> 
> The reason is that the driver uses PHYLIB, but that is a loadable
> module here, and fman itself is built-in.
> 
> This patch makes it possible to configure fman as a module as well
> so we don't change the status of PHYLIB in an allmodconfig kernel,
> and it adds a 'select PHYLIB' statement to ensure that phylib is
> always built-in when fman is.
> 
> The driver uses "builtin_platform_driver(fman_driver);", which means
> it cannot be unloaded, but it's still possible to have it as a loadable
> module that gets loaded once and never removed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5adae51a64b8 ("fsl/fman: Add FMan MURAM support")

Applied, sorry I didn't catch this but nobody else was even attempting
to review that huge patch series so I did the best that I could... :-/
