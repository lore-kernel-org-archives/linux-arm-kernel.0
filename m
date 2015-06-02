From: bintian.wang@huawei.com (Bintian)
Date: Tue, 2 Jun 2015 11:57:40 +0800
Subject: [PATCH v9 0/6] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <1432950661-23060-1-git-send-email-bintian.wang@huawei.com>
References: <1432950661-23060-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <556D29B4.7@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Mark and other ARM64 DT maintainers,

Could you help ack this version? although Will, Kevin and Tyler have
tested this patch set, I think also need an ack from you.

The clock driver has been merged to linux-next, so I just add the clock
header file to this patch set to avoid compilation error.

Thanks,

Bintian

On 2015/5/30 9:50, Bintian Wang wrote:
> Hi6220 is one mobile solution of Hisilicon, this patchset contains
> initial support for Hi6220 SoC and HiKey development board, which
> supports octal ARM Cortex A53 cores. Initial support is minimal and
> includes just the arch configuration, device tree configuration, the
> clock driver has been picked up by clock maintainers in clk tree.
>
> PSCI is enabled in device tree and there is no problem to boot all the
> octal cores, and the CPU hotplug is also working now, you can download
> and compile the latest firmware based on the following link to run this
> patch set:
> https://github.com/96boards/documentation/wiki/UEFI
>
> Chnages v9:
> * Rebase to linus/master 4.1-rc1
> * Remove the clock driver from this version because the clock maintainers
>    have queued up the clock driver:
>    git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next-hi6220
> * This version also includes clock header file:
>    [PATCH v9 6/6] dt-bindings: Add header file of hi6220 clock driver
>    Although above patch is included in clock driver, I add to this series
>    because the device tree file includes it, there will be compile error
>    without it.
>    At last, we just need to keep one when merged together.
>
> Changes v6~v8:
> This three versions only modified the clock drivers based on the
> Stephen's review advices.
> * clk-hi6220.c:
>    ** Split the clock header file from clock driver
>    ** Delete setting the parents clock of UART1 to HI6220_150M in clock
>       driver, we can do that using assigned-clock in dts when enable
>       UART1 in the future.
> * clkdivider-hi6220.c:
>    ** Reuse some functions exported by clk-divider.c
>    ** Remove "pr_err" and CLK_IS_BASIC flag
>    ** Fix some programing style problems
> * hisilicon/clk.h: remove the "__init" markings on some funcition
>    prototypes.
>
> Changes v5:
> * Rebase to kernel 4.1-rc2
> * Add compatible string "hisilicon,hi6220-pl011" for Hisilicon designed
>    UART
> * clk-hi6220.c: use __initdata for non-const arrays based on the commit
>    692d8328e8c039f9497eb862c6cf835de922c061
>
> Changes v4:
> * Rebase to kernel 4.1-rc1
> * Delete "arm,cortex-a15-gic" from the gic node in dts
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
>    in DT bindings document
> * Enable high speed clock on UART1 mux
> * Other changes based on the discussion in the mailing list:
>    https://lkml.org/lkml/2015/2/5/147
>
> Bintian Wang (6):
>    arm64: Enable Hisilicon ARMv8 SoC family in Kconfig and defconfig
>    arm64: hi6220: Document devicetree bindings for Hisilicon hi6220 SoC
>    clk: hi6220: Document devicetree bindings for hi6220 clock
>    Documentation: DT: PL011: hi6220: add compatible string for Hisilicon
>      designed UART
>    arm64: dts: Add dts files for Hisilicon Hi6220 SoC
>    dt-bindings: Add header file of hi6220 clock driver
>
>   .../bindings/arm/hisilicon/hisilicon.txt           |   87 ++++++++++
>   .../devicetree/bindings/clock/hi6220-clock.txt     |   34 ++++
>   Documentation/devicetree/bindings/serial/pl011.txt |    4 +-
>   arch/arm64/Kconfig                                 |    5 +
>   arch/arm64/boot/dts/Makefile                       |    1 +
>   arch/arm64/boot/dts/hisilicon/Makefile             |    5 +
>   arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   31 ++++
>   arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  172 +++++++++++++++++++
>   arch/arm64/configs/defconfig                       |    1 +
>   include/dt-bindings/clock/hi6220-clock.h           |  173 ++++++++++++++++++++
>   10 files changed, 512 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/hi6220-clock.txt
>   create mode 100644 arch/arm64/boot/dts/hisilicon/Makefile
>   create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>   create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>   create mode 100644 include/dt-bindings/clock/hi6220-clock.h
>
