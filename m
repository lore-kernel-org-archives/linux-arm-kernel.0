From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 12 Aug 2013 15:19:50 +0530
Subject: [PATCH V4 0/4] Add i2s support on smdk5420
Message-ID: <1376300994-1679-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung has different versions of I2S introduced in different
platforms. Each version has some new support added for multichannel,
secondary fifo, s/w reset control, internal mux for rclk src clk and
tdm support. Each newly added change has a quirk. So this patch adds
all the required quirks as driver data and based on compatible string
from dtsi fetches the quirks. This also adds i2s support on exynos5420.

Changes since V3:
	- Addressed review comments by Tomasz Figa related to const qualifier
	  for samsung_i2s_dai_data
	- Removed passing quirks as driver data for non-dt platforms. 
	- Separated out adding i2s nodes and enabling audio support on 5420
	  into different patch set as they are dependent on some of already posted
	  but not yet merged i2c, dwmmc, dma and audss clock controller patches.

Changes since V2:
        - Separated out driver side changes and dts changes in two
          patch sets.
        - Replaced samsung,s3c6410-i2s-v4 with samsung,s3c6410-i2s-multi
          for more clarity as suggested by Tomasz Figa.

Changes since V1:
        - Pass quirks as driver data and fetch the quirks based on
          compatible string from dtsi file as suggested by
          Tomasz Figa and Mark Brown
        - Make the I2S driver more flexible with respect to register
          access as suggested by Tomasz Figa and Mark Brown
        - Add 5420 support in the driver.
        - Modify the dtsi files with the corresponding compatible
          strings and removed the i2s quirks from 5250 dtsi file.
        - Updated the i2s Documentation with relevent changes and
          i2s versioning info.
        - Add i2s nodes on exynos5420.dtsi
        - Enable sound support on smdk5420

This patch set is made based on Mark Brown for-next branch on sound.git.

Padmavathi Venna (4):
  ASoC: Samsung: I2S: Add quirks as driver data in I2S
  ASoC: Samsung: I2S: Modify the I2S driver to support I2S on
    Exynos5420
  ARM: dts: exynos5250: move common i2s properties to exynos5 dtsi
  ARM: dts: Change i2s compatible string on exynos5250

 .../devicetree/bindings/sound/samsung-i2s.txt      |   22 ++--
 arch/arm/boot/dts/exynos5.dtsi                     |   21 +++
 arch/arm/boot/dts/exynos5250.dtsi                  |   17 +---
 include/linux/platform_data/asoc-s3c.h             |    1 +
 sound/soc/samsung/i2s-regs.h                       |   15 ++
 sound/soc/samsung/i2s.c                            |  143 +++++++++++++++-----
 6 files changed, 157 insertions(+), 62 deletions(-)

-- 
1.7.4.4
