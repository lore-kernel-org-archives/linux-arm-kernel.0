From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 16 Oct 2018 15:57:40 +0000
Subject: [PATCH v3 0/4] Port mxs-dcp to imx6ull and imx6sll
Message-ID: <cover.1539705285.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DCP block is present on 6sll and 6ull but not enabled. The hardware is
mostly compatible with 6sl, the only important difference is that explicit
clock enabling is required.

There were several issues with the functionality of this driver (it didn't
even probe properly) but they are fixed in cryptodev/master by this series:
    https://lore.kernel.org/patchwork/cover/994874/

---
Changes since v2:
 * Rename 6ull dcp node to crypto@*
 * Use clk_prepare_enable on probe
 * Fix not unpreparing on remove
 * Realign dcp_clk struct member with rest of attributes (using tabs)
 * Link to v2: https://lore.kernel.org/patchwork/cover/999795/

Changes since v1:
 * Add devicetree maintainers for dt-bindings
 * Add a patch enabling in imx_v6_v7_defconfig. Since tcrypt now passes this
shouldn't cause any issues
 * Link to v1: https://lore.kernel.org/patchwork/cover/994893/

Leonard Crestez (4):
  dt-bindings: crypto: Mention clocks for mxs-dcp
  crypto: mxs-dcp - Add support for dcp clk
  ARM: dts: imx6ull: Add dcp node
  ARM: imx_v6_v7_defconfig: Enable CRYPTO_DEV_MXS_DCP

 .../devicetree/bindings/crypto/fsl-dcp.txt        |  2 ++
 arch/arm/boot/dts/imx6ull.dtsi                    | 10 ++++++++++
 arch/arm/configs/imx_v6_v7_defconfig              |  1 +
 drivers/crypto/mxs-dcp.c                          | 15 +++++++++++++++
 4 files changed, 28 insertions(+)

-- 
2.17.1
