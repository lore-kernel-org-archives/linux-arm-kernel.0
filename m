From: andre.przywara@arm.com (Andre Przywara)
Date: Sat, 25 Nov 2017 12:01:58 +0000
Subject: [PATCH 0/2] pinctrl: sunxi: Fix H5 MMC access
Message-ID: <20171125120200.23294-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1396007286b1 ("pinctrl: sunxi: Enforce the strict mode by default")
enabled the strict mode for the H5 pin controller driver, so that it denies
multiple requests for a single pin.
However the existing DTs for the Allwinner H5 boards reference the CD pin
for the micro SD card (MMC0) *twice* in their node, so that the driver
stumbles upon the new strict mode and refuses to load:

...
sun50i-h5-pinctrl 1c20800.pinctrl: pin PF6 already requested by 1c0f000.mmc; cannot claim for 1c20800.pinctrl:166
sun50i-h5-pinctrl 1c20800.pinctrl: pin-166 (1c20800.pinctrl:166) status -22
sunxi-mmc: probe of 1c0f000.mmc failed with error -22
...

This prevents booting (from SD cards) on H5 boards.
This can be rather easily fixed by removing the redundant CD pin reference
from the pinctrl-0 property of the MMC0 node, which patch 1/2 actually does.

However this now prevents existing DTs to boot with newer kernels (current
Linus' HEAD, for instance), so we have to disable strict mode for the H5
as well (as we do with other SoCs already, including the H3).

Tested on the OrangePi PC2:
- current 4.15-rc0 boots with fixed DT (patch 1/2), but fails with older DTs
- 4.14 (and older) kernels boot with both older and this fixed DT
- 4.15-rc0 with patch 2/2 applied boots with both older and this fixed DTs

Thanks to Chris Obbard for reporting this.

Cheers,
Andre.

P.S. I was wondering if we should teach the MMC driver to cope with failing
CD pin requests or let it detect the redundancy and avoid the second GPIO
request instead. AFAICT this would allow to enable strict mode for the H5
again?

Andre Przywara (2):
  arm64: dts: allwinner: H5: remove redundant MMC0 card detect pin
  pinctrl: sunxi: Disable strict mode for H5 driver

 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts    | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts         | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts        | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts      | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts | 2 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c                       | 6 ++++--
 6 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.14.1
