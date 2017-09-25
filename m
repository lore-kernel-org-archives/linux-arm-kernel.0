From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Mon, 25 Sep 2017 02:02:34 +0200
Subject: [PATCH v3 00/10] Commit 3a03ea763a67 ("dmaengine: sun6i: Add support
 for Allwinner A83T
Message-ID: <439d95d6-1ce0-45e9-a4e4-42bc1f97838b@rwthex-w2-a.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(sun8i) variant") and commit f008db8c00c1 ("dmaengine: sun6i: Add support for
Allwinner H3 (sun8i) variant") added support for the A83T resp. H3, but missed
some differences between the original A31 and A83T/H3.

The first patch adds a callback to the controller config to set the clock
autogating register of different SoC generations, i.e. A31, A23+A83T, H3+later,
and uses it to for the correct clock autogating setting.

The second patch adds a callback for the burst length setting in the channel
config register, which has different field offsets and new burst widths/lengths,
which differs between H3 and earlier generations

The third patch restructures some code required for the fourth patch and adds the
burst lengths to the controller config.

The fourth patch adds the burst widths to the config and adds the handling of the
H3 specific burst widths.

Patch 5 restructures the code to decouple some controller details (e.g. channel
count) from the compatible string/the config.

Patches 6, 7 and 8 introduce and use the "dma-chans" property for the A64. Although
register compatible to the H3, the channel count differs and thus it requires a
new compatible. To avoid introduction of new compatibles for each minor variation,
anything but the register model is moved to devicetree properties. There
is at least one SoC (R40) which can then reuse the A64 compatible, the same
would have worked for A83T+V3s.

Patches 9 and 10 add the DMA controller node to the devicetree and add the DMA
controller reference to the SPI nodes.

This patch series could be called v2, but the patches were split and significantly
restructured, thus listing changes individually is not to meaningful.

Changes in v3:
- Check for callback instead of using a no-op callback
- Drop leading 0 from unit name in DT example
- Omit default values from sun50i_a64_dma_cfg definition
- Drop leading 0 from dma controller unit name

Changes in v2:
- Use callback for autogating instead of variable for different SoC generations
- Use controller specific callback for burst length setting
- Store burst lengths in config instead of device structure
- Store burst widths in config
- Set default number of dma-request if not provided in config or devicetree

Stefan Br?ns (10):
  dmaengine: sun6i: Correct setting of clock autogating register for
    A83T/H3
  dmaengine: sun6i: Correct burst length field offsets for H3
  dmaengine: sun6i: Restructure code to allow extension for new SoCs
  dmaengine: sun6i: Enable additional burst lengths/widths on H3
  dmaengine: sun6i: Move number of pchans/vchans/request to device
    struct
  arm64: allwinner: a64: Add devicetree binding for DMA controller
  dmaengine: sun6i: Retrieve channel count/max request from devicetree
  dmaengine: sun6i: Add support for Allwinner A64 and compatibles
  arm64: allwinner: a64: Add device node for DMA controller
  arm64: allwinner: a64: add dma controller references to spi nodes

 .../devicetree/bindings/dma/sun6i-dma.txt          |  28 ++-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  15 ++
 drivers/dma/sun6i-dma.c                            | 258 ++++++++++++++++-----
 3 files changed, 242 insertions(+), 59 deletions(-)

-- 
2.14.1
