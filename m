From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 May 2018 03:14:17 +0800
Subject: [PATCH RESEND net-next v2 0/8] net: stmmac: dwmac-sun8i: Support R40
Message-ID: <20180513191425.9801-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend of the patches for net-next split out from my R40
Ethernet support v2 series, as requested by David Miller. The arm-soc
bits will follow, once I rework the A64 system controller compatible.

Patches 1, 2, and 3 clean up the dwmac-sun8i binding.

Patch 4 adds device tree binding for Allwinner R40's Ethernet
controller.

Patch 5 converts regmap access of the syscon region in the dwmac-sun8i
driver to regmap_field, in anticipation of different field widths on
the R40.

Patch 6 introduces custom plumbing in the dwmac-sun8i driver to fetch
a regmap from another device, by looking up said device via a phandle,
then getting the regmap associated with that device.

Patch 7 adds support for different or absent TX/RX delay chain ranges
to the dwmac-sun8i driver.

Patch 8 adds support for the R40's ethernet controller.


Excerpt from original cover letter:

Changes since v1:

  - Default to fetching regmap from device pointed to by syscon phandle,
    and falling back to syscon API if that fails.

  - Dropped .syscon_from_dev field in device data as a result of the
    previous change.

  - Added a large comment block explaining the first change.

  - Simplified description of syscon property in sun8i-dwmac binding.

  - Regmap now only exposes the EMAC/GMAC register, but retains the
    offset within its address space.

  - Added patches for A64, which reuse the same sun8i-dwmac changes.

This series adds support for the DWMAC based Ethernet controller found
on the Allwinner R40 SoC. The controller is either a DWMAC clone or
DWMAC core with its registers rearranged. This is already supported by
the dwmac-sun8i driver. The glue layer control registers, unlike other
sun8i family SoCs, is not in the system controller region, but in the
clock control unit, like with the older A20 and A31 SoCs.

While we reuse the bindings for dwmac-sun8i using a syscon phandle
reference, we need some custom plumbing for the clock driver to export
a regmap that only allows access to the GMAC register to the dwmac-sun8i
driver. An alternative would be to allow drivers to register custom
syscon devices with their own regmap and locking.


Please have a look.

Regards
ChenYu

Chen-Yu Tsai (8):
  dt-bindings: net: dwmac-sun8i: Clean up clock delay chain descriptions
  dt-bindings: net: dwmac-sun8i: Sort syscon compatibles by alphabetical
    order
  dt-bindings: net: dwmac-sun8i: simplify description of syscon property
  dt-bindings: net: dwmac-sun8i: Add binding for GMAC on Allwinner R40
    SoC
  net: stmmac: dwmac-sun8i: Use regmap_field for syscon register access
  net: stmmac: dwmac-sun8i: Allow getting syscon regmap from external
    device
  net: stmmac: dwmac-sun8i: Support different ranges for TX/RX delay
    chains
  net: stmmac: dwmac-sun8i: Add support for GMAC on Allwinner R40 SoC

 .../devicetree/bindings/net/dwmac-sun8i.txt   |  21 +--
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 139 +++++++++++++++---
 2 files changed, 130 insertions(+), 30 deletions(-)

-- 
2.17.0
