From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Sep 2012 09:53:46 +0800
Subject: [PATCH v2 0/9] Add device tree support for on-chip SRAM
In-Reply-To: <1346405224-20399-1-git-send-email-p.zabel@pengutronix.de>
References: <1346405224-20399-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20120903015343.GB2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I do not understand the point of introducing those imx patches, 1 ~ 4
and 7, 8.  They are all unnecessary churns to me.  IMO, 4 patches are
enough.

 * genalloc: add a global pool list, allow to find pools by phys address
 * misc: Generic on-chip SRAM allocation driver
 * ARM i.MX: remove IRAM_ALLOC facility
 * ARM: dts: add sram for imx53 and imx6q

Regards,
Shawn

On Fri, Aug 31, 2012 at 11:26:55AM +0200, Philipp Zabel wrote:
> These patches add support to configure on-chip SRAM via device-tree
> node and to obtain the resulting genalloc pool from a phandle pointing
> at the node.
> This allows drivers to allocate SRAM with the genalloc API without
> hard-coding the genalloc pool address.
> 
> The on-chip SRAM on i.MX53 and i.MX6q is registered via device tree and
> changed to use the simple generic SRAM driver:
> 
> 		ocram: ocram at 00900000 {
> 			compatible = "fsl,imx-ocram", "sram";
> 			reg = <0x00900000 0x3f000>;
>  		};
> 
> A driver that needs to allocate SRAM buffers, like the video processing
> unit on i.MX53, can retrieve the genalloc pool from a phandle in the
> device tree using of_get_named_gen_pool(node, "iram", 0) from patch 5:
> 
> 		vpu at 63ff4000 {
> 			/* ... */
> 			iram = <&ocram>;
>  		};
> 
> Changes since v1:
>  - Added a generic SRAM driver in drivers/misc that does nothing but
>    request/ioremap its given memory region and serve it via the genalloc
>    API.
>  - Renamed the i.MX device tree nodes from "iram" to "ocram".
> 
> regards
> Philipp
> 
> ---
>  arch/arm/boot/dts/imx53.dtsi          |    5 ++
>  arch/arm/boot/dts/imx6q.dtsi          |    5 ++
>  arch/arm/plat-mxc/Kconfig             |    4 --
>  arch/arm/plat-mxc/Makefile            |    1 -
>  arch/arm/plat-mxc/include/mach/iram.h |   41 -------------
>  arch/arm/plat-mxc/iram_alloc.c        |   73 -----------------------
>  drivers/misc/Kconfig                  |    8 +++
>  drivers/misc/Makefile                 |    1 +
>  drivers/misc/sram.c                   |  105 +++++++++++++++++++++++++++++++++
>  include/linux/genalloc.h              |   14 +++++
>  lib/genalloc.c                        |   77 ++++++++++++++++++++++++
>  11 files changed, 215 insertions(+), 119 deletions(-)
> 
