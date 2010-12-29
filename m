From: gerg@snapgear.com (Greg Ungerer)
Date: Wed, 29 Dec 2010 15:26:09 +1000
Subject: [PATCH 00/10] net/fec: add dual fec support for i.MX28
In-Reply-To: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <4D1AC671.8090901@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Shawn,

On 29/12/10 00:55, Shawn Guo wrote:
> This patch series is to add dual fec support for mx28, which is
> a mxs-based soc. Some code changes related to the following commits
> are also made in this patch set for some reasons.
>
>    e6b043d512fa8d9a3801bf5d72bfa3b8fc3b3cc8
>    netdev/fec.c: add phylib supporting to enable carrier detection (v2)
>
>    e3fe8558c7fc182972c3d947d88744482111f304
>    net/fec: fix pm to survive to suspend/resume
>
> Also I do not understand one line change made in commit below.
>
>    commit 6fcc040f02d281c7e9563127358a77ce2bbfe284
>    net: allow FEC driver to use fixed PHY support
>
> -	snprintf(fep->mii_bus->id, MII_BUS_ID_SIZE, "%x", pdev->id);
> +	snprintf(fep->mii_bus->id, MII_BUS_ID_SIZE, "%x", pdev->id + 1);
>
> Can someone help me understand if it's really needed?  The patch
> set can work with this change, and I'm just curious.

It is needed, at least in my case. I can't recall exactly why
right at the moment though. It was either that 0 didn't work with
the fixed phy setup, or it there ended up being a a duplicate
id. I'll need to check on that board/setup again.

Regards
Greg


> It's been tested on mx28 evk and mx51 babbage. For mx28, it has
> to work against the following patch set, which has not got
> merged yet.
>
>   [PATCH v8 00/15] ARM: mxs: Add initial support for MX23 and MX28
>
> Thanks for review.
>
> Regards,
> Shawn
>
> Shawn Guo (10):
>   arch/arm/mach-mxs/Makefile                      |    2 +-
>   arch/arm/mach-mxs/clock-mx28.c                  |    7 +-
>   arch/arm/mach-mxs/devices/platform-fec.c        |    2 +-
>   arch/arm/mach-mxs/include/mach/common.h         |    1 +
>   arch/arm/mach-mxs/include/mach/devices-common.h |    2 +-
>   arch/arm/mach-mxs/mach-mx28evk.c                |   59 ++++++-
>   arch/arm/mach-mxs/ocotp.c                       |   52 ++++++
>   arch/arm/mach-mxs/pm.c                          |   44 +++++
>   drivers/net/Kconfig                             |    7 +-
>   drivers/net/fec.c                               |  220 +++++++++++++++++------
>   drivers/net/fec.h                               |    5 +-
>   include/linux/fec.h                             |    2 +
>   12 files changed, 335 insertions(+), 68 deletions(-)
>
>   [PATCH 01/10] net/fec: fix MMFR_OP type in fec_enet_mdio_write
>   [PATCH 02/10] net/fec: remove the use of "index" which is legacy
>   [PATCH 03/10] net/fec: add mac field into platform data and consolidate fec_get_mac
>   [PATCH 04/10] net/fec: improve pm for better suspend/resume
>   [PATCH 05/10] net/fec: add dual fec support for mx28
>   [PATCH 06/10] ARM: mx28: update clocks for dual fec support
>   [PATCH 07/10] ARM: mx28: add the second fec device registration
>   [PATCH 08/10] ARM: mxs: add ocotp read function
>   [PATCH 09/10] ARM: mx28: read fec mac address from ocotp
>   [PATCH 10/10] ARM: mxs: add initial pm support
>
>


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
