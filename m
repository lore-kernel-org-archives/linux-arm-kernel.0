From: horms@verge.net.au (Simon Horman)
Date: Sun, 30 Dec 2012 09:12:02 +0900
Subject: [PATCH v4 00/81] SH pin control and GPIO rework
In-Reply-To: <1356735303-29474-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1356735303-29474-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20121230001202.GF17416@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ CC: linux-arm-kernel, Olof Johansson, Arnd Bergmann ]

On Fri, Dec 28, 2012 at 11:53:42PM +0100, Laurent Pinchart wrote:
> Hi everybody,
> 
> Here's the fourth version of the SH pin control and GPIO rework patches. The
> patches have been rebased on top of v3.8-rc1 but are otherwise unchanged.
> 
> The series starts with the same additional platform-specific fixes as v3
> (patches 4 to 7), I would appreciate if someone could review them carefully.
> 
> You can get the series from my git tree at
>  
>         git://linuxtv.org/pinchartl/fbdev.git pinmux
> 
> I would like to push this set to v3.9 independently of the later rework and
> OF-related sets. Simon, can you take it in your tree ?

Sure.

One inconvenience of my tree is that it goes via the arm-soc tree
and as such things need to be split out into branches. I believe in
the case of this series the patches will need to be split across soc,
board and pfc branches. The branches may be based on each other.

Do you think the following scheme might work:

Patches 1 - 7: sh-soc
Patches 8 - 21: pfc, based on sh-soc
Patches 22 - 29: soc (ARM SoC), based on pfc
Patches 30 - 42: sh-soc2, based on pfc
Patches 43 - 50: pfc2, based on a merge of soc and sh-soc2
Patches 51 - 54: soc2 (ARM SoC), based on pfc2
Patches 55 - 66: pfc3, based on soc2
Patches 67 - 78: sh-soc3, based on pfc3
Patches 79 - 81: pfc4, based on sh-soc3

An alternative is to place all the changes in a single branch
as they form a logical set of changes. Anrd, Olof, do you have any opinions
on the best way forward?

> 
> Changes since v3:
> 
> - Rebased on top ov v3.8-rc1
> 
> Changes since v2:
> 
> - Update to latest mainline tree master branch
> - Rename marks to match GPIO names
> - Fix GPIOs data for sh7757, sh7786 and shx3 platforms
> - Remove __devinit/__devexit
> - Use devm_* managed memory allocation and mapping functions
> - Use the sh_pfc_ prefix for structures and functions
> - Update module authors
> - Drop OF support and related DT patches
> 
> Changes since v1:
> 
> - Split SoC changes in one patch per SoC to make backporting easier
> - Dropped SH7267 and SH7277 changes as support for those SoCs will be removed
>   from the kernel
> - Removed the sh_pfc_register() function on ARM
> - Added OF support for PFC instantiation and GPIO bindings
> - Added PFC DT nodes for the Mackerel and KZM9G boards
> - Added GPIO LEDs DT nodes for the KZM9G board
> 
> Laurent Pinchart (81):
>   sh: sh7264: Rename CRX0CRX1 mark to match GPIO names
>   sh: sh7269: Rename CRX0CRX1(CRX2) marks to match GPIO names
>   sh: sh7723: Rename GPIO_FN_SIUOSPD to GPIO_FN_SIUAOSPD
>   sh: sh7757: Fix GPIO_FN_ET0_MDIO and GPIO_FN_ET1_MDIO GPIO entries
>   sh: sh7786: Fix port E, G and J GPIOs
>   sh: sh7786: Fix last GPIO index
>   sh: shx3: Fix last GPIO index
>   sh-pfc: Remove all use of __devinit/__devexit
>   sh-pfc: Split platform data from the sh_pfc structure
>   sh-pfc: Move private definitions and declarations to private header
>   sh-pfc: Merge PFC core and pinctrl
>   sh-pfc: Merge PFC core and gpio
>   sh-pfc: Move platform device and driver to the core
>   sh-pfc: Use devm_kzalloc()
>   sh-pfc: Use devm_ioremap_nocache()
>   sh-pfc: Let the compiler decide whether to inline functions
>   sh-pfc: Remove check for impossible error condition
>   sh-pfc: Sort headers alphabetically
>   sh-pfc: Use sh_pfc_ namespace prefix through the whole driver
>   sh-pfc: Split platform device and platform driver registration
>   sh-pfc: Support passing resources through platform device
>   ARM: shmobile: Select PINCTRL
>   ARM: shmobile: r8a7740: Register PFC platform device
>   ARM: shmobile: r8a7779: Register PFC platform device
>   ARM: shmobile: sh7372: Register PFC platform device
>   ARM: shmobile: sh73a0: Register PFC platform device
>   ARM: shmobile: r8a7740: Add pin control resources
>   ARM: shmobile: sh7372: Add pin control resources
>   ARM: shmobile: sh73a0: Add pin control resources
>   sh: Add PFC platform device registration helper function
>   sh: sh7203: Register PFC platform device
>   sh: sh7264: Register PFC platform device
>   sh: sh7269: Register PFC platform device
>   sh: sh7720: Register PFC platform device
>   sh: sh7722: Register PFC platform device
>   sh: sh7723: Register PFC platform device
>   sh: sh7724: Register PFC platform device
>   sh: sh7734: Register PFC platform device
>   sh: sh7757: Register PFC platform device
>   sh: sh7785: Register PFC platform device
>   sh: sh7786: Register PFC platform device
>   sh: shx3: Register PFC platform device
>   sh-pfc: Remove platform device registration
>   sh-pfc: Remove unused resource and num_resources platform data fields
>   sh-pfc: Move driver from drivers/sh/ to drivers/pinctrl/
>   sh-pfc: Support pinmux info in driver data instead of platform data
>   sh-pfc: Add r8a7740 pinmux support
>   sh-pfc: Add r8a7779 pinmux support
>   sh-pfc: Add sh7372 pinmux support
>   sh-pfc: Add sh73a0 pinmux support
>   ARM: shmobile: r8a7740: Use driver-provided pinmux info
>   ARM: shmobile: r8a7779: Use driver-provided pinmux info
>   ARM: shmobile: sh7372: Use driver-provided pinmux info
>   ARM: shmobile: sh73a0: Use driver-provided pinmux info
>   sh-pfc: Add sh7203 pinmux support
>   sh-pfc: Add sh7264 pinmux support
>   sh-pfc: Add sh7269 pinmux support
>   sh-pfc: Add sh7720 pinmux support
>   sh-pfc: Add sh7722 pinmux support
>   sh-pfc: Add sh7723 pinmux support
>   sh-pfc: Add sh7724 pinmux support
>   sh-pfc: Add sh7734 pinmux support
>   sh-pfc: Add sh7757 pinmux support
>   sh-pfc: Add sh7785 pinmux support
>   sh-pfc: Add sh7786 pinmux support
>   sh-pfc: Add shx3 pinmux support
>   sh: sh7203: pinmux: Use driver-provided pinmux info
>   sh: sh7264: pinmux: Use driver-provided pinmux info
>   sh: sh7269: pinmux: Use driver-provided pinmux info
>   sh: sh7720: pinmux: Use driver-provided pinmux info
>   sh: sh7722: pinmux: Use driver-provided pinmux info
>   sh: sh7723: pinmux: Use driver-provided pinmux info
>   sh: sh7724: pinmux: Use driver-provided pinmux info
>   sh: sh7734: pinmux: Use driver-provided pinmux info
>   sh: sh7757: pinmux: Use driver-provided pinmux info
>   sh: sh7785: pinmux: Use driver-provided pinmux info
>   sh: sh7786: pinmux: Use driver-provided pinmux info
>   sh: shx3: pinmux: Use driver-provided pinmux info
>   sh: Remove unused sh_pfc_register_info() function
>   sh-pfc: Remove pinmux_info definition
>   sh-pfc: Move sh_pfc.h from include/linux/ to driver directory
> 
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/mach-shmobile/Makefile                    |    8 -
>  arch/arm/mach-shmobile/setup-r8a7740.c             |   26 +
>  arch/arm/mach-shmobile/setup-r8a7779.c             |   25 +
>  arch/arm/mach-shmobile/setup-sh7372.c              |   26 +
>  arch/arm/mach-shmobile/setup-sh73a0.c              |   25 +
>  arch/sh/Kconfig                                    |   12 +
>  arch/sh/include/asm/gpio.h                         |    2 +-
>  arch/sh/include/cpu-common/cpu/pfc.h               |   26 +
>  arch/sh/include/cpu-sh4/cpu/sh7723.h               |    2 +-
>  arch/sh/include/cpu-sh4/cpu/sh7786.h               |    8 +-
>  arch/sh/kernel/cpu/Makefile                        |    2 +-
>  arch/sh/kernel/cpu/pfc.c                           |   33 +
>  arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c            | 1582 +-----------
>  arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c            | 2121 +---------------
>  arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c            | 2823 +-------------------
>  arch/sh/kernel/cpu/sh3/pinmux-sh7720.c             | 1226 +---------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c            | 1778 +------------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c            | 1893 +-------------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c            | 2210 +---------------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c            | 2470 +-----------------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c            | 2267 +----------------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c            | 1294 +---------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c            |  822 +------
>  arch/sh/kernel/cpu/sh4a/pinmux-shx3.c              |  573 +----
>  drivers/pinctrl/Kconfig                            |    2 +-
>  drivers/pinctrl/Makefile                           |    2 +
>  drivers/pinctrl/sh-pfc/Kconfig                     |  116 +
>  drivers/pinctrl/sh-pfc/Makefile                    |   21 +
>  drivers/{sh/pfc => pinctrl/sh-pfc}/core.c          |  355 ++-
>  drivers/pinctrl/sh-pfc/core.h                      |   72 +
>  drivers/{sh/pfc => pinctrl/sh-pfc}/gpio.c          |  114 +-
>  .../pinctrl/sh-pfc}/pfc-r8a7740.c                  |   11 +-
>  .../pinctrl/sh-pfc}/pfc-r8a7779.c                  |   29 +-
>  drivers/pinctrl/sh-pfc/pfc-sh7203.c                | 1592 +++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7264.c                | 2131 +++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7269.c                | 2834 ++++++++++++++++++++
>  .../pinctrl/sh-pfc}/pfc-sh7372.c                   |   11 +-
>  .../pinctrl/sh-pfc}/pfc-sh73a0.c                   |   11 +-
>  drivers/pinctrl/sh-pfc/pfc-sh7720.c                | 1236 +++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7722.c                | 1779 ++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7723.c                | 1903 +++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7724.c                | 2225 +++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7734.c                | 2475 +++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7757.c                | 2282 ++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7785.c                | 1304 +++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7786.c                |  837 ++++++
>  drivers/pinctrl/sh-pfc/pfc-shx3.c                  |  582 ++++
>  drivers/{sh/pfc => pinctrl/sh-pfc}/pinctrl.c       |  170 +-
>  {include/linux => drivers/pinctrl/sh-pfc}/sh_pfc.h |   43 +-
>  drivers/sh/Kconfig                                 |    1 -
>  drivers/sh/Makefile                                |    1 -
>  drivers/sh/pfc/Kconfig                             |   26 -
>  drivers/sh/pfc/Makefile                            |    3 -
>  54 files changed, 21899 insertions(+), 21524 deletions(-)
>  create mode 100644 arch/sh/include/cpu-common/cpu/pfc.h
>  create mode 100644 arch/sh/kernel/cpu/pfc.c
>  create mode 100644 drivers/pinctrl/sh-pfc/Kconfig
>  create mode 100644 drivers/pinctrl/sh-pfc/Makefile
>  rename drivers/{sh/pfc => pinctrl/sh-pfc}/core.c (50%)
>  create mode 100644 drivers/pinctrl/sh-pfc/core.h
>  rename drivers/{sh/pfc => pinctrl/sh-pfc}/gpio.c (57%)
>  rename {arch/arm/mach-shmobile => drivers/pinctrl/sh-pfc}/pfc-r8a7740.c (99%)
>  rename {arch/arm/mach-shmobile => drivers/pinctrl/sh-pfc}/pfc-r8a7779.c (99%)
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7203.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7264.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7269.c
>  rename {arch/arm/mach-shmobile => drivers/pinctrl/sh-pfc}/pfc-sh7372.c (99%)
>  rename {arch/arm/mach-shmobile => drivers/pinctrl/sh-pfc}/pfc-sh73a0.c (99%)
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7720.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7722.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7723.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7724.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7734.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7757.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7785.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7786.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-shx3.c
>  rename drivers/{sh/pfc => pinctrl/sh-pfc}/pinctrl.c (73%)
>  rename {include/linux => drivers/pinctrl/sh-pfc}/sh_pfc.h (83%)
>  delete mode 100644 drivers/sh/pfc/Kconfig
>  delete mode 100644 drivers/sh/pfc/Makefile
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
