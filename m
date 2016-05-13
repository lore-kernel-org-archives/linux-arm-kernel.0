From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 13 May 2016 13:03:00 +0100
Subject: [PATCH v3 00/27] ARM: dts: exynos: Add initial support for Odroid
 XU
In-Reply-To: <1462910970-1812-1-git-send-email-krzk@kernel.org>
References: <1462910970-1812-1-git-send-email-krzk@kernel.org>
Message-ID: <5735C274.50504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 10/05/16 21:09, Krzysztof Kozlowski wrote:
> Hi,
>
> Patchset adds necessary clocks, reorganizes existing stuff and finally
> adds Odroid XU support.
>
>
> Changes since v2
> ================
> 1. Got global-ack from Stephen for the clock changes. I think merging
>     everything through arm-soc might be the easiest but:
>     a. In such case I will prepare a tag with clock changes,
>     b. Anyway I will wait for response from Sylwester and Tomasz.
> 2. Applied comments from Javier and added his Reviewed-by.
> 3. Patch 22: added ack from Rob.
> 4. Minor improvements in existing patches.
> 5. Five new patches at the end: 23-27 (not reviewed yet).
>     Some of them could be squashed with existing ones but existing
>     changes got reviews. Although the final Odroid XU DTS works fine but
>     in general this is still work-in-progress so I suspect it will grow.
>     I am releasing it early following Linux concept. :)
>
> Patchset is available at my private repo @github:
> https://github.com/krzk/linux.git for-next/odroid-xu-v3

Since I have one of these gathering dust on my desk, it's really cool to 
see this series, thanks!

I've successfully booted that branch to a filesystem on SD card, but USB 
clearly isn't quite right - the USB 2.0 hub is powered up, but only the 
bottom right port will actually enumerate devices; the ethernet is 
nowhere to be seen. However, if I drop into the bootloader and do a "usb 
start" beforehand, it all keeps working into the kernel. As for the USB 
3.0, though, the ports report over-current conditions shortly after the 
XHCI probe despite having nothing plugged in :(

Robin.

> (previous version is in for-next/odroid-xu-v2 branch, if someone would
> like to compare them)
>
>
> Changes since v1
> ================
> 1. A lot of new patches.
> 2. Removed some TODO notes (eMMC 4.5 so no RCLK pin).
> 3. New clocks, more reorganization.
> 4. New common DTSI: exynos54xx.dtsi. I know, it is getting more
>     and more complicated but this might help removing duplications
>     and keeping everything under control.
>
>
>
> Merging strategy
> ================
> Complicated! The clock dt-bindings and driver changes can go to clock
> tree. However there are three DTS patches in the middle.
> a. This has to go in before adding "fin_pll_new" to clock driver:
>     - [PATCH v2 03/22] ARM: dts: exynos: Add fin_pll node for clock driver
>
> b. This should go in before renaming "fin_pll_new" back to original name:
>     - [PATCH v2 05/22] ARM: dts: exynos: Switch MCT node to a new fin_pll clock
>     - [PATCH v2 06/22] ARM: dts: exynos: Remove old fixed-clock provider on SMDK5410
>
> The order of patches in the patchset is really how it should go in
> to reduce any bisectability glitches.
>
>
> Best regards,
> Krzysztof
>
>
> Krzysztof Kozlowski (27):
>    dt-bindings: clock: Add license and reformat Exynos5410 clock IDs
>    dt-bindings: clock: Add PWM and USB clock IDs to Exynos5410
>    ARM: dts: exynos: Add fin_pll node for clock driver
>    clk: samsung: exynos5410: Provide fin_pll external fixed clock
>    ARM: dts: exynos: Switch MCT node to a new fin_pll clock
>    ARM: dts: exynos: Remove old fixed-clock provider on SMDK5410
>    clk: samsung: exynos5410: Rename fin_pll from temporary to regular
>      name
>    clk: samsung: exynos5410: Add serial3, USB and PWM clocks
>    ARM: dts: exynos: Re-order alphabetically Exynos5420 SD0/SD1 pinctrl
>      nodes
>    ARM: dts: exynos: Use lowercase for Exynos5410 CPU node labels
>    ARM: dts: exynos: Configure Exynos5410 pinctrl for eMMC and SD card
>    ARM: dts: exynos: Split Odroid XU3 LEDs to separate DTSI
>    ARM: dts: exynos: Move common nodes to exynos5.dtsi
>    ARM: dts: exynos: Prepare for inclusion of exynos5.dtsi in
>      exynos5410.dtsi
>    ARM: dts: exynos: Use phandle to get parent node in exynos5250-snow
>    ARM: dts: exynos: Move Exynos5250 and Exynos5420 nodes under soc
>    ARM: dts: exynos: Include common exynos5 in exynos5410.dtsi
>    ARM: dts: exynos: Enable UART3 on Exynos5410
>    ARM: dts: exynos: MCT is not an interrupt controller and extend length
>      of iomap
>    ARM: dts: exynos: Move common Exynos5410/542x/5800 nodes to new DTSI
>    ARM: dts: exynos: Add USB to Exynos5410
>    ARM: dts: exynos: Add initial support for Odroid XU board
>    dt-bindings: clock: Add I2C, HSI2C and RTC clock IDs to Exynos5410
>    clk: samsung: exynos5410: Add I2C, HSI2C and RTC clocks
>    ARM: dts: exynos: Move HSI2C nodes to exynos54xx.dtsi
>    ARM: dts: exynos: Add I2C, PWM and UART pinctrl to Exynos5410
>    ARM: dts: exynos: Add RTC and I2C to Exynos5410
>
>   .../bindings/arm/samsung/samsung-boards.txt        |    1 +
>   arch/arm/boot/dts/Makefile                         |    1 +
>   arch/arm/boot/dts/exynos5.dtsi                     |  215 ++-
>   arch/arm/boot/dts/exynos5250-snow-common.dtsi      |    2 +-
>   arch/arm/boot/dts/exynos5250.dtsi                  | 1701 ++++++++---------
>   arch/arm/boot/dts/exynos5410-odroidxu.dts          |  121 ++
>   arch/arm/boot/dts/exynos5410-pinctrl.dtsi          |  210 +++
>   arch/arm/boot/dts/exynos5410-smdk5410.dts          |   16 +-
>   arch/arm/boot/dts/exynos5410.dtsi                  |  270 +--
>   arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |   12 +-
>   arch/arm/boot/dts/exynos5420.dtsi                  | 1992 +++++++++-----------
>   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |   35 +-
>   arch/arm/boot/dts/exynos5422-odroidxu3.dts         |   35 +-
>   arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi    |   50 +
>   arch/arm/boot/dts/exynos54xx.dtsi                  |  188 ++
>   drivers/clk/samsung/clk-exynos5410.c               |   61 +
>   include/dt-bindings/clock/exynos5410.h             |   73 +-
>   17 files changed, 2758 insertions(+), 2225 deletions(-)
>   create mode 100644 arch/arm/boot/dts/exynos5410-odroidxu.dts
>   create mode 100644 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
>   create mode 100644 arch/arm/boot/dts/exynos54xx.dtsi
>
