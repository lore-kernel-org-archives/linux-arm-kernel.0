From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 04 Aug 2016 15:38:40 +0200
Subject: [PATCH 0/8] ASoC: s3c24xx_uda134x card fixes and cleanups
Message-ID: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series might have a bit of an archaeological aspect, nevertheless
my goal was to have sound working on one of the older S3C24XX SoC
based boards for testing any patches touching the older Samsung
SoC IP block related code.

Together with patches:
  ASoC: samsung: Fix clock handling in S3C24XX_UDA134X card
  ARM: S3C24XX: Add dma_mask assignments for DMA devices
  ARM: S3C24XX: Add missing DMA device for Mini2440 board

this series fixes sound on Micro2440SDK/mini2440 board broken since
the 3.12 kernel release.

I'm not sure how it worked before but currently the uda134x codec
always fails to probe due to uninitialized platform_data, which
is supposed to be set by the ASoC machine driver.

This series addresses the issue by moving all required codec
platform_data to the board file and exposing optional GPIO bitbang
L3 bus ops which are selected by the codec.

ASoC dependency patches:
  ASoC: samsung: Fix clock handling in S3C24XX_UDA134X card

The patch
"ARM: S3C24XX: Specify audio codec platform_data for mini2440 board"
is for arm-soc but it would be good to merge whole series through one
tree to avoid compilation breaks due to unmet dependencies.

Sylwester Nawrocki (8):
  ASoC: L3 bus: Add default gpio ops
  ARM: S3C24XX: Specify audio codec platform_data for mini2440 board
  ASoC: uda134x: Optionally initialize L3 ops to default GPIO ops
  ASoC: s3c24xx_uda134x: Remove unused power() callback
  ASoC: s3c24xx_uda134x: Drop initialization of codec's platform data
  ASoC: samsung: Convert s3c24xx_uda134x to use
    devm_snd_soc_register_card()
  ASoC: samsung: s3c24xx_uda134x: debug/error trace cleanup
  ASoC: s3c244_uda134x: Allocate private data dynamically

 arch/arm/mach-s3c24xx/mach-mini2440.c |  19 ++++
 include/sound/l3.h                    |  15 ++-
 include/sound/s3c24xx_uda134x.h       |   1 -
 sound/soc/codecs/l3.c                 |  71 ++++++++++--
 sound/soc/codecs/uda134x.c            |   7 ++
 sound/soc/samsung/s3c24xx_uda134x.c   | 205 ++++++++++------------------------
 6 files changed, 158 insertions(+), 160 deletions(-)

--
1.9.1
