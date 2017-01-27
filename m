From: florian.vaussard@heig-vd.ch (Florian Vaussard)
Date: Fri, 27 Jan 2017 11:37:27 +0100
Subject: [PATCH v4 0/13] arm64: allwinner: a64: Enable MMC support
In-Reply-To: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
Message-ID: <e4133504-8bc7-a9ac-209d-3d8cba119fed@heig-vd.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 01/26/2017 10:05 AM, Maxime Ripard wrote:
> Hi,
> 
> Here is a new attempt at getting the MMC controllers running, following the
> work done by Andre.
> 
> This has been tested on a board with one SDIO device (a Marvell WiFi chip)
> and a Kingston eMMC with 1.8V IOs.
> 
> For SDIO, the HS DDR mode works just fine. That serie also enables the
> SDR104 mode to work on the devices that are capable of this.
> 
> For the eMMC, HS200 with the voltage switch works. HS400 doesn't at the
> moment, but since it's significantly more complex, and at the same time
> Allwinner recommends to limit its frequency to 100MHz, this doesn't have
> any benefits. If there's any at some point, this can be added later.
> 
> Let me know what you think,
> Maxime
> 

FWIW I tested this series and got decent throughput (190 Mbps in UDP) with a
Marvell SDIO Wifi chip. The board becomes unresponsive between 30 to 60 minutes
of iperf torture, but I strongly suspect a hardware issue underneath. Feel free
to add my Tested-by on the MMC patches if you need it.

Thank you for your work.

Best,
Florian

> Changes from v3:
>   - Reordered the MMC nodes
>   - Added the specification section the first commit log
>   - Supported mmc->actual_rate
>   - Clarified a bit what we (don't) know about DATA0
> 
> Changes from v2:
>   - Enabled SDR104, limited the frequency to 150MHz. 200MHz was too high.
>   - Added more fixes to the gating and frequency rate change sequence
>   - Added one more patch to mask DATA0 when updating the clock that was
>     needed to get SDR104 to run
>   - Added the patches to enable it on a few boards done by Andre
>   - Amended the comments as suggested by Andre.
>   - Added some tags
> 
> Andre Przywara (4):
>   arm64: allwinner: a64: Add MMC nodes
>   arm64: allwinner: pine64: add MMC support
>   arm64: allwinner: a64: add UART1 pin nodes
>   arm64: allwinner: add BananaPi-M64 support
> 
> Maxime Ripard (9):
>   mmc: sunxi: Fix clock frequency change sequence
>   mmc: sunxi: Gate the clock when rate is 0
>   mmc: sunxi: Always set signal delay to 0 for A64
>   mmc: sunxi: Enable the new timings for the A64 MMC controllers
>   mmc: sunxi: Mask DATA0 when updating the clock
>   mmc: sunxi: Add EMMC (MMC2) controller compatible
>   mmc: sunxi: Add more debug informations
>   arm64: allwinner: a64: Add MMC pinctrl nodes
>   arm64: allwinner: a64: Increase the MMC max frequency
> 
>  arch/arm64/boot/dts/allwinner/Makefile                    |   1 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 120 +++++++-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts       |  20 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi             |  77 ++++-
>  drivers/mmc/host/sunxi-mmc.c                              | 114 ++++---
>  5 files changed, 289 insertions(+), 43 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> 
> base-commit: bc34c1af0a280e27eafe3f86b9ad87fe0c9ea715
> 
