From: jiri@resnulli.us (Jiri Pirko)
Date: Wed, 2 Mar 2016 11:10:16 +0100
Subject: [PATCH] net: mellanox: add DEVLINK dependencies
In-Reply-To: <1456911665-1424389-1-git-send-email-arnd@arndb.de>
References: <1456911665-1424389-1-git-send-email-arnd@arndb.de>
Message-ID: <20160302101016.GA2122@nanopsycho.orion>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wed, Mar 02, 2016 at 10:40:54AM CET, arnd at arndb.de wrote:
>The new NET_DEVLINK infrastructure can be a loadable module, but the drivers
>using it might be built-in, which causes link errors like:
>
>drivers/net/built-in.o: In function `mlx4_load_one':
>:(.text+0x2fbfda): undefined reference to `devlink_port_register'
>:(.text+0x2fc084): undefined reference to `devlink_port_unregister'
>drivers/net/built-in.o: In function `mlxsw_sx_port_remove':
>:(.text+0x33a03a): undefined reference to `devlink_port_type_clear'
>:(.text+0x33a04e): undefined reference to `devlink_port_unregister'
>
>There are multiple ways to avoid this:
>
>a) add 'depends on NET_DEVLINK || !NET_DEVLINK' dependencies
>   for each user
>b) use 'select NET_DEVLINK' from each driver that uses it
>   and hide the symbol in Kconfig.
>c) make NET_DEVLINK a 'bool' option so we don't have to
>   list it as a dependency, and rely on the APIs to be
>   stubbed out when it is disabled
>d) use IS_REACHABLE() rather than IS_ENABLED() to check for
>   NET_DEVLINK in include/net/devlink.h
>
>This implements a variation of approach a) by adding an
>intermediate symbol that drivers can depend on, and changes
>the three drivers using it.

Approach a) looks like the best. Thanks for taking care of this.

>
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jiri Pirko <jiri@mellanox.com>
