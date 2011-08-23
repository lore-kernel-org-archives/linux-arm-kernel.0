From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Tue, 23 Aug 2011 21:11:19 +0530
Subject: [RFC/PATCH v2 00/13] dt: omap: dt binding with omap_device and
	support for i2c1
In-Reply-To: <1314074021-25186-1-git-send-email-manjugk@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
Message-ID: <20110823154119.GE32698@manju-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 10:03:28AM +0500, G, Manjunath Kondaiah wrote:
> 
> Patch series reworked from:
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/61674
> Also added support for i2c1 controller on omap4 based panda
> board.
> 
> Baseline:
> =========
> git://git.secretlab.ca/git/linux-2.6.git
> Branch: devicetree/test
> The above branch is rebased with v3.1-rc2 mainline.
> +
> pdev decoupling patches from kevin hilman
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg53534.html
> 
> The patch series is also available at:
> https://gitorious.org/devicetree/dt_omap/commits/devicetree/dt_rfcv2
> 
> Testing:
> ========
> Build : dt and not dt build for omap2plus_defconfig
> Boot: OMAP3530 Beagle Board and OMAP4430 Panda board

Correction: This series will support only i2c1 controller and it will not
handle i2c1 child devices such as twlxxxx pmic. Due to which, twl read/write's
might fail during boot.

I am facing issues in getting platform_data in i2c child device probe function.
The issue is reported to grant in patch 08/13 of this series.

-M

> 
> Limitation:
> ===========
> The current implementation of omap-device build through
> device tree supports only single instance of hwmod and 
> multiple instances are not supported.
> 
> G, Manjunath Kondaiah (13):
>   OMAP: omap_device: Add device tree node pointer
>   dt: Add pd_size to AUXDATA structure
>   dt: omap3: add soc file for handling i2c controllers
>   dt: omap3: beagle board: set clock freq for i2c devices
>   dt: omap3: add generic board file for dt support
>   dt: omap3: add omap-device compatible property
>   dt: omap: create platform bus for omap devices
>   dt: omap: i2c: add dt support for i2c1 controller
>   dt: omap4: add soc file for handling i2c controllers
>   dt: omap4: panda board: set clock freq for i2c devices
>   dt: omap4: add generic board file for dt support
>   dt: omap4: enable dt support for i2c1 controller
>   dt: omap: i2c: dt usage model documentation
> 
>  Documentation/devicetree/bindings/i2c/omap-i2c.txt |   57 +++++++++++++
>  arch/arm/boot/dts/omap3-beagle-nunchuck.dts        |   13 +---
>  arch/arm/boot/dts/omap3-beagle.dts                 |   18 ++++-
>  arch/arm/boot/dts/omap3.dtsi                       |   62 ++++++++++++++
>  arch/arm/boot/dts/omap4-panda.dts                  |   25 ++++--
>  arch/arm/boot/dts/omap4.dtsi                       |   68 ++++++++++++++++
>  arch/arm/mach-omap2/Kconfig                        |   22 +++++
>  arch/arm/mach-omap2/Makefile                       |    2 +
>  arch/arm/mach-omap2/board-omap3-dt.c               |   84 ++++++++++++++++++++
>  arch/arm/mach-omap2/board-omap3beagle.c            |   13 ---
>  arch/arm/mach-omap2/board-omap4-dt.c               |   75 +++++++++++++++++
>  arch/arm/mach-omap2/board-omap4panda.c             |    6 --
>  arch/arm/mach-omap2/devices.c                      |    2 +-
>  arch/arm/mach-omap2/mcbsp.c                        |    2 +-
>  arch/arm/plat-omap/include/plat/omap_device.h      |   11 +++-
>  arch/arm/plat-omap/omap_device.c                   |   46 ++++++++++-
>  drivers/i2c/busses/i2c-omap.c                      |   23 +++++-
>  drivers/of/platform.c                              |   41 ++++++++++
>  include/linux/of_platform.h                        |    5 +
>  19 files changed, 526 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/omap-i2c.txt
>  create mode 100644 arch/arm/boot/dts/omap3.dtsi
>  create mode 100644 arch/arm/boot/dts/omap4.dtsi
>  create mode 100644 arch/arm/mach-omap2/board-omap3-dt.c
>  create mode 100644 arch/arm/mach-omap2/board-omap4-dt.c
> 
> -- 
> 1.7.4.1
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
