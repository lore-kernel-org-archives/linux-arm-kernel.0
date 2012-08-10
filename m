From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Aug 2012 07:34:46 +0000
Subject: [PATCH 10/11] spi/s3c64xx: improve error handling
In-Reply-To: <0de501cd76c2$ea07dfd0$be179f70$%kim@samsung.com>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
 <1344437248-20560-11-git-send-email-arnd@arndb.de>
 <0de501cd76c2$ea07dfd0$be179f70$%kim@samsung.com>
Message-ID: <201208100734.47339.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 August 2012, Kukjin Kim wrote:

> BTW for same reason, probably, we need following fix?
> 
>  arch/arm/mach-tegra/tegra2_emc.c             |    4 ++--
>  arch/c6x/kernel/setup.c                      |    2 +-
>  arch/powerpc/kernel/ibmebus.c                |    2 +-
>  arch/powerpc/kernel/pci_of_scan.c            |    2 +-
>  arch/powerpc/kernel/prom.c                   |    2 +-
>  arch/powerpc/kernel/rtas_pci.c               |    2 +-
>  arch/powerpc/kernel/vio.c                    |    2 +-
>  arch/powerpc/platforms/44x/warp.c            |    2 +-
> ...

Actually not. The difference is that only s3c64xx_get_slave_ctrldata
accesses the node pointer outside of the look (after break).
This fails when there are no child nodes at all. In the other
cases, the only use of the node pointer is inside the loop,
where it is guaranteed to be valid.

	Arnd
