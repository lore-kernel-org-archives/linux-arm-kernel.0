From: davem@davemloft.net (David Miller)
Date: Thu, 03 Mar 2016 16:48:34 -0500 (EST)
Subject: [PATCH] net: mellanox: add DEVLINK dependencies
In-Reply-To: <1456911665-1424389-1-git-send-email-arnd@arndb.de>
References: <1456911665-1424389-1-git-send-email-arnd@arndb.de>
Message-ID: <20160303.164834.470402143180960189.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed,  2 Mar 2016 10:40:54 +0100

> The new NET_DEVLINK infrastructure can be a loadable module, but the drivers
> using it might be built-in, which causes link errors like:
> 
> drivers/net/built-in.o: In function `mlx4_load_one':
> :(.text+0x2fbfda): undefined reference to `devlink_port_register'
> :(.text+0x2fc084): undefined reference to `devlink_port_unregister'
> drivers/net/built-in.o: In function `mlxsw_sx_port_remove':
> :(.text+0x33a03a): undefined reference to `devlink_port_type_clear'
> :(.text+0x33a04e): undefined reference to `devlink_port_unregister'
> 
> There are multiple ways to avoid this:
> 
> a) add 'depends on NET_DEVLINK || !NET_DEVLINK' dependencies
>    for each user
> b) use 'select NET_DEVLINK' from each driver that uses it
>    and hide the symbol in Kconfig.
> c) make NET_DEVLINK a 'bool' option so we don't have to
>    list it as a dependency, and rely on the APIs to be
>    stubbed out when it is disabled
> d) use IS_REACHABLE() rather than IS_ENABLED() to check for
>    NET_DEVLINK in include/net/devlink.h
> 
> This implements a variation of approach a) by adding an
> intermediate symbol that drivers can depend on, and changes
> the three drivers using it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 09d4d087cd48 ("mlx4: Implement devlink interface")
> Fixes: c4745500e988 ("mlxsw: Implement devlink interface")

Applied, thanks Arnd.
