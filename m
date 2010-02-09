From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Tue, 9 Feb 2010 19:07:01 +0200
Subject: [PATCHv3 0/7] Initial Freescale i.MX51 SoC support
In-Reply-To: <cover.1265733173.git.amit.kucheria@canonical.com>
References: <cover.1265733173.git.amit.kucheria@canonical.com>
Message-ID: <20100209170701.GJ3390@matterhorn.verdurent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Feb 09, Amit Kucheria wrote:
> (patchset rebased on top of Sascha's tree and trivial fixes made)
> git://git.pengutronix.de/git/imx/linux-2.6.git mxc-master
> 
> Will you consider merging it now?

And a git tree is available at
git://kernel.ubuntu.com/amitk/mx51-upstream.git mx51-baseport-sascha

> Regards,
> Amit
> 
> This series of patches adds basic support for i.MX5 family to the kernel. This
> is just the bare minimum that brings up the board - sets up the clocks, IO
> with a serial port and timers.
> 
> Features:
> 
>   * Console: Serial console using pre-existing drivers/serial/imx.c
>   * Timer: Timer provided through arch/arm/plat-mxc/time.c
>   * Interrupts: New interrupt controller through arch/arm/plat-mxc/tzic.c
>   * Clocks: Minimal Clock framework to allow board boot up
>   * Defconfigs: mx51_defconfig provided
> 
> Tested on a i.MX51-based Babbage 2.5 board.
> 
> Git:
> 
> repo: git://kernel.ubuntu.com/amitk/mx51-upstream.git mx51-baseport
> 
> Story:
> 
> This is a result of dropping a lot of functionality from the existing
> Freescale codebase that is shipping as part of the Ubuntu ARM enablement. A
> lot of the code was refactored to use facilities that were already available
> upstream in arch/arm/plat-mxc/. The hope is to get this base port into
> mainline and then start working on mainlining the drivers.
> 
> Changelog:
> 
> V1: Initial submission of base port
> 
> V2: - Split core code enabling i.MX51 and the babbage board
>     - Refactor timer code to use version 1 or 2 of timer (patch by Sascha)
>     - Fixes from review of V1
> 
> V3: - Fixes from review of V2
>     - Merge the Driver Strength patch into the Core i.MX5 support
>     - Moved the fec patches out of this series into its own
>     - Merge the Kconfig/Makefiles into Babbage board support
> 
> Amit Kucheria (6):
>   mxc: TrustZone interrupt controller (TZIC) for Freescale i.MX5 family
>   mxc: changes to common plat-mxc code to add support for i.MX5
>   mxc: Core support for Freescale i.MX5 series
>   mxc: Add support for the Babbage board (i.MX5)
>   mxc: Add mx51_defconfig
>   mxc: MAINTAINERS: Add maintainer for mach-mx5
> 
> Sascha Hauer (1):
>   mxc: refactor timer code to use timer versions
> 
>  MAINTAINERS                                  |    6 +
>  arch/arm/Makefile                            |    1 +
>  arch/arm/configs/mx51_defconfig              | 1286 ++++++++++++++++++++++++++
>  arch/arm/mach-mx5/Kconfig                    |   18 +
>  arch/arm/mach-mx5/Makefile                   |    9 +
>  arch/arm/mach-mx5/Makefile.boot              |    3 +
>  arch/arm/mach-mx5/board-mx51_babbage.c       |   98 ++
>  arch/arm/mach-mx5/clock-mx51.c               |  825 +++++++++++++++++
>  arch/arm/mach-mx5/cpu.c                      |   47 +
>  arch/arm/mach-mx5/crm_regs.h                 |  583 ++++++++++++
>  arch/arm/mach-mx5/devices.c                  |   96 ++
>  arch/arm/mach-mx5/devices.h                  |    4 +
>  arch/arm/mach-mx5/mm.c                       |   89 ++
>  arch/arm/plat-mxc/Kconfig                    |   16 +
>  arch/arm/plat-mxc/Makefile                   |    3 +
>  arch/arm/plat-mxc/include/mach/common.h      |    5 +
>  arch/arm/plat-mxc/include/mach/debug-macro.S |    9 +
>  arch/arm/plat-mxc/include/mach/entry-macro.S |   34 +-
>  arch/arm/plat-mxc/include/mach/hardware.h    |    4 +
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h  |  326 +++++++
>  arch/arm/plat-mxc/include/mach/iomux-v3.h    |    8 +-
>  arch/arm/plat-mxc/include/mach/irqs.h        |    9 +-
>  arch/arm/plat-mxc/include/mach/memory.h      |    3 +
>  arch/arm/plat-mxc/include/mach/mx51.h        |  454 +++++++++
>  arch/arm/plat-mxc/include/mach/mxc.h         |   13 +
>  arch/arm/plat-mxc/include/mach/timex.h       |    2 +
>  arch/arm/plat-mxc/time.c                     |   41 +-
>  arch/arm/plat-mxc/tzic.c                     |  172 ++++
>  28 files changed, 4144 insertions(+), 20 deletions(-)
>  create mode 100644 arch/arm/configs/mx51_defconfig
>  create mode 100644 arch/arm/mach-mx5/Kconfig
>  create mode 100644 arch/arm/mach-mx5/Makefile
>  create mode 100644 arch/arm/mach-mx5/Makefile.boot
>  create mode 100644 arch/arm/mach-mx5/board-mx51_babbage.c
>  create mode 100644 arch/arm/mach-mx5/clock-mx51.c
>  create mode 100644 arch/arm/mach-mx5/cpu.c
>  create mode 100644 arch/arm/mach-mx5/crm_regs.h
>  create mode 100644 arch/arm/mach-mx5/devices.c
>  create mode 100644 arch/arm/mach-mx5/devices.h
>  create mode 100644 arch/arm/mach-mx5/mm.c
>  create mode 100644 arch/arm/plat-mxc/include/mach/iomux-mx51.h
>  create mode 100644 arch/arm/plat-mxc/include/mach/mx51.h
>  create mode 100644 arch/arm/plat-mxc/tzic.c
> 

-- 
-------------------------------------------------------------------------
Amit Kucheria,				 Kernel Developer, Verdurent
-------------------------------------------------------------------------
