From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 5 May 2015 16:46:19 -0700
Subject: [PATCH v4 0/5] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <CANMBJr7KTcMRNv7PrKHcJJ3hCNUQAtFrMROQq4q4+_07=QxcaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 May 2015 at 05:06, Bintian Wang <bintian.wang@huawei.com> wrote:
> Hi6220 is one mobile solution of Hisilicon, this patchset contains
> initial support for Hi6220 SoC and HiKey development board, which
> supports octal ARM Cortex A53 cores. Initial support is minimal and
> includes just the arch configuration, clock driver, device tree
> configuration.
>
> PSCI is enabled in device tree and there is no problem to boot all the
> octal cores, and the CPU hotplug is also working now, you can download
> and compile the latest firmware based on the following link to run this
> patch set:
> https://github.com/96boards/documentation/wiki/UEFI
>
> Changes v4:
> * Rebase to kernel 4.1-rc1
> * Delete "arm,cortex-a15-gic" from the gic node in dts

Tested by: Tyler Baker <tyler.baker@linaro.org>

Built and booted all v4 patches in this series ontop a v4.1-rc1 based
tree. Tested with the UEFI load mentioned above, booting to a minimal
ramdisk userspace[0]. Confirmed all 8 CPUs were activated.

>
> Changes v3:
> * Verified the CPU hotplug based on the new released firmware
> * Redefined the compatible strings of four system controllers in dts
> * Setting COMMON_CLK_HI6220 to a bool symbol
> * Keep CONFGI_ARCH_HISI sorted alphabetically
>
> Changes v2:
> * Split the DT bindings documents into earlier patches
> * Change SMP enable method from spin-table to PSCI in device tree
> * Remove "clock-frequency" from armv8-timer device node in device tree
> * Add more description about Hisilicon designed system controllers
>   in DT bindings document
> * Enable high speed clock on UART1 mux
> * Other changes based on the discussion in the mailing list:
>   https://lkml.org/lkml/2015/2/5/147
>
> Bintian Wang (5):
>   arm64: Enable Hisilicon ARMv8 SoC family in Kconfig and defconfig
>   arm64: hi6220: Document devicetree bindings for Hisilicon hi6220 SoC
>   clk: hi6220: Document devicetree bindings for hi6220 clock
>   clk: hi6220: Clock driver support for Hisilicon hi6220 SoC
>   arm64: dts: Add dts files for Hisilicon Hi6220 SoC
>
>  .../bindings/arm/hisilicon/hisilicon.txt           |  87 ++++++
>  .../devicetree/bindings/clock/hi6220-clock.txt     |  34 +++
>  arch/arm64/Kconfig                                 |   5 +
>  arch/arm64/boot/dts/Makefile                       |   1 +
>  arch/arm64/boot/dts/hisilicon/Makefile             |   5 +
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |  31 +++
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 172 ++++++++++++
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/clk/Kconfig                                |   2 +
>  drivers/clk/Makefile                               |   4 +-
>  drivers/clk/hisilicon/Kconfig                      |   6 +
>  drivers/clk/hisilicon/Makefile                     |   3 +-
>  drivers/clk/hisilicon/clk-hi6220.c                 | 292 +++++++++++++++++++++
>  drivers/clk/hisilicon/clk.c                        |  29 ++
>  drivers/clk/hisilicon/clk.h                        |  17 ++
>  drivers/clk/hisilicon/clkdivider-hi6220.c          | 273 +++++++++++++++++++
>  include/dt-bindings/clock/hi6220-clock.h           | 173 ++++++++++++
>  17 files changed, 1131 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/hi6220-clock.txt
>  create mode 100644 arch/arm64/boot/dts/hisilicon/Makefile
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>  create mode 100644 drivers/clk/hisilicon/Kconfig
>  create mode 100644 drivers/clk/hisilicon/clk-hi6220.c
>  create mode 100644 drivers/clk/hisilicon/clkdivider-hi6220.c
>  create mode 100644 include/dt-bindings/clock/hi6220-clock.h
>
> --
> 1.9.1
>

Cheers,

Tyler

[0] http://kernelci.org/boot/hi6220-hikey/job/testing/kernel/v4.1-rc1-5-gf609561/defconfig/defconfig/lab/lab-tbaker/?_id=5549541559b51417e999c5cd
