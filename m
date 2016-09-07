From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  7 Sep 2016 17:34:29 +0200
Subject: [PATCH v3 0/8] scpi: Add support for legacy SCPI protocol
Message-ID: <1473262477-18045-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset aims to support the legacy SCPI firmware implementation that was
delivered as early technology preview for the JUNO platform.

Finally a stable, maintained and public implementation for the SCPI protocol
has been upstreamed part of the JUNO support and it is the recommended way
of implementing SCP communication on ARMv8 platforms.

The Amlogic GXBB platform is using this legacy protocol, as the RK3368 & RK3399
platforms. This patchset will only add support for Amlogic GXBB SoC.

This patchset add support for the legacy protocol in the arm_scpi.c file,
avoiding code duplication.

Last RFC discution tread can be found at : https://lkml.org/lkml/2016/8/9/210

Changes since v2 at : http://lkml.kernel.org/r/1471952816-30877-1-git-send-email-narmstrong at baylibre.com
 - Added command indirection table and use it in each commands
 - Added bitmap for high priority commands
 - Cleaned up legacy tx_prepare/handle_message to align to standard functions
 - Dropped legacy_scpi_ops

Changes since v1 at : http://lkml.kernel.org/r/1471515066-3626-1-git-send-email-narmstrong at baylibre.com
 - Dropped vendor_send_message and rockchip vendor mechanism patches
 - Merged alternate functions into main functions using is_legacy boolean
 - Added DT match table to set is_legacy to true
 - Kept alternate scpi_ops structure for legacy

Neil Armstrong (8):
  scpi: Add cmd indirection table to prepare for legacy commands
  scpi: Add alternative legacy structures, functions and macros
  scpi: Do not fail if get_capabilities is not implemented
  scpi: Add support for Legacy match table for Amlogic GXBB SoC
  scpi: grow MAX_DVFS_OPPS to 16 entries
  dt-bindings: Add support for Amlogic GXBB SCPI Interface
  ARM64: dts: meson-gxbb: Add SRAM node
  ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes

 Documentation/devicetree/bindings/arm/arm,scpi.txt |   8 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  45 +++
 drivers/firmware/arm_scpi.c                        | 378 +++++++++++++++++++--
 3 files changed, 402 insertions(+), 29 deletions(-)

-- 
1.9.1
