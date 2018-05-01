From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 2 May 2018 00:33:45 +0800
Subject: [PATCH net-next v2 00/15] ARM: sun8i: r40: Add Ethernet support
In-Reply-To: <20180501161227.2110-1-wens@csie.org>
References: <20180501161227.2110-1-wens@csie.org>
Message-ID: <CAGb2v67HFb6eLBS4_9s_wJ5uWFeQdUtwn_NMJnm59UUDFBDJUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2018 at 12:12 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi everyone,
>
> This is v2 of my R40 Ethernet support series.
>
> Changes since v1:
>
>   - Default to fetching regmap from device pointed to by syscon phandle,
>     and falling back to syscon API if that fails.
>
>   - Dropped .syscon_from_dev field in device data as a result of the
>     previous change.
>
>   - Added a large comment block explaining the first change.
>
>   - Simplified description of syscon property in sun8i-dwmac binding.
>
>   - Regmap now only exposes the EMAC/GMAC register, but retains the
>     offset within its address space.
>
>   - Added patches for A64, which reuse the same sun8i-dwmac changes.
>
> This series adds support for the DWMAC based Ethernet controller found
> on the Allwinner R40 SoC. The controller is either a DWMAC clone or
> DWMAC core with its registers rearranged. This is already supported by
> the dwmac-sun8i driver. The glue layer control registers, unlike other
> sun8i family SoCs, is not in the system controller region, but in the
> clock control unit, like with the older A20 and A31 SoCs.
>
> While we reuse the bindings for dwmac-sun8i using a syscon phandle
> reference, we need some custom plumbing for the clock driver to export
> a regmap that only allows access to the GMAC register to the dwmac-sun8i
> driver. An alternative would be to allow drivers to register custom
> syscon devices with their own regmap and locking.
>
> Patch 1 converts the CLK_OF_DECLARE style clock driver to a platform
> one, so the regmap introduced later has a struct device to tie to.
>
> Patch 2 adds a regmap that is exported by the clock driver for the
> dwmac-sun8i driver to use.
>
> Patches 3, 4, and 5 clean up the dwmac-sun8i binding.
>
> Patch 6 adds device tree binding for Allwinner R40's Ethernet
> controller.
>
> Patch 7 converts regmap access of the syscon region in the dwmac-sun8i
> driver to regmap_field, in anticipation of different field widths on
> the R40.
>
> Patch 8 introduces custom plumbing in the dwmac-sun8i driver to fetch
> a regmap from another device, by looking up said device via a phandle,
> then getting the regmap associated with that device.
>
> Patch 9 adds support for different or absent TX/RX delay chain ranges
> to the dwmac-sun8i driver.
>
> Patch 10 adds support for the R40's ethernet controller.

I should've mentioned that patches 3 ~ 10, and only these, should go
through net-next. sunxi will handle the remaining clk, device tree, and
soc driver patches.

Thanks
ChenYu

> Patch 11 cleans up the Bananapi M2 Ultra device tree file.
>
> Patch 12 adds a GMAC device node and RGMII mode pinmux setting for the
> R40.
>
> Patch 13 enables Ethernet on the Bananapi M2 Ultra.
>
> Patches 14 and 15 are for the A64. They convert the existing syscon
> device to an SRAM controller device that exports a regmap. The needed
> driver changes are in patch 14, and the device tree changes are in
> patch 15.
>
>
> Please have a look.
>
> Regards
> ChenYu
>
> Chen-Yu Tsai (11):
>   dt-bindings: net: dwmac-sun8i: Clean up clock delay chain descriptions
>   dt-bindings: net: dwmac-sun8i: Sort syscon compatibles by alphabetical
>     order
>   dt-bindings: net: dwmac-sun8i: simplify description of syscon property
>   dt-bindings: net: dwmac-sun8i: Add binding for GMAC on Allwinner R40
>     SoC
>   net: stmmac: dwmac-sun8i: Use regmap_field for syscon register access
>   net: stmmac: dwmac-sun8i: Allow getting syscon regmap from external
>     device
>   net: stmmac: dwmac-sun8i: Support different ranges for TX/RX delay
>     chains
>   net: stmmac: dwmac-sun8i: Add support for GMAC on Allwinner R40 SoC
>   ARM: dts: sun8i: r40: bananapi-m2-ultra: Sort device node dereferences
>   ARM: dts: sun8i: r40: Add device node and RGMII pinmux node for GMAC
>   ARM: dts: sun8i: r40: bananapi-m2-ultra: Enable GMAC ethernet
>     controller
>
> Icenowy Zheng (4):
>   clk: sunxi-ng: r40: rewrite init code to a platform driver
>   clk: sunxi-ng: r40: export a regmap to access the GMAC register
>   soc: sunxi: export a regmap for EMAC clock reg on A64
>   arm64: dts: allwinner: a64: add SRAM controller device tree node
>
>  .../devicetree/bindings/net/dwmac-sun8i.txt   |  21 +--
>  .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  99 ++++++++-----
>  arch/arm/boot/dts/sun8i-r40.dtsi              |  34 +++++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  23 ++-
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.c          |  72 +++++++--
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 139 +++++++++++++++---
>  drivers/soc/sunxi/sunxi_sram.c                |  57 ++++++-
>  7 files changed, 364 insertions(+), 81 deletions(-)
>
> --
> 2.17.0
>
