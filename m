From: flatmax@flatmax.org (Matt Flax)
Date: Sat, 25 Feb 2017 16:03:11 +1100
Subject: [PATCH 0/3] ASoC: Enable a new IC master mode: bcm2835<=>IC<=>cs42xx8
Message-ID: <cover.1487997974.git.flatmax@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set lets the ASoC system specify that an IC between the SoC and codec
is master. This is intended to put both the SoC and Codec into slave modes.

By default un-patched SoC and Codec drivers will return -EINVAL if they aren't
enabled and tested for this mode.

soc-dia.h has the new SND_SOC_DAIFMT_IBM_IFM definition set as :
#define SND_SOC_DAIFMT_IBM_IFM		(5 << 12) /* IC clk & FRM master */

The cs42xx8 codec driver is enabled for this mode and so too is the BCM2835
SoC driver. This forms a chain : bcm2835<=>IC<=>cs42xx8
where the IC is bit and frame master.

Matt Flax (3):
  ASoC : Add an IC bit and frame master mode (SoC and Codec slave).
  ASoC: cs42xx8: allow IC master mode.
  ASoC: bcm2835: Add mutichannel mode in DSP and IC master modes.

 include/sound/soc-dai.h     |  9 ++++++---
 sound/soc/bcm/bcm2835-i2s.c | 21 ++++++++++++++++++++-
 sound/soc/codecs/cs42xx8.c  |  1 +
 3 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.7.4
