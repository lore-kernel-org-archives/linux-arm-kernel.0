From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Sat, 28 Apr 2018 22:51:37 +0200
Subject: [PATCH 0/5] ASoC: cirrus: Series of fixes for ep93xx-i2s
Message-ID: <20180428205142.31921-1-alexander.sverdlin@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a result of long-running debugging of rarely screwed I2S
stream out of EP9302 chip. Logic analyser shows that the stream is shifted
by one byte (out of 32 bits per sample) which leads to noise intead of
original stream.

DMA is verified to work fine (no underrun). The issue is only reproducible
under high load (CPU or AMBA bus -- not yet clear). This stream corruption
happens at the same time I2S controller reports internal FIFO underrun
(even though according to documentation, it should handle an underrun
gracefully).

First two patches are fixing unrelated issues in I2S driver found during
debugging of the stream shift. Third one is simplification of the driver
to prepare for workaround.

Both controller configuration options for TX FIFO underrun handling were
tested, both do not work reliable. Hence, this ugly watchdog in the last
patch.

The whole series is tested on a board similar to EDB9302 (identical in
sound part).

Alexander Sverdlin (5):
  ASoC: cirrus: i2s: Fix LRCLK configuration
  ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup
  ASoC: cirrus: i2s: Stop enabling I2S2 and I2S3 FIFOs
  ARM: ep93xx: i2s: Add IRQ to platform device resources
  ASoC: cirrus: i2s: IRQ-based stream watchdog

 arch/arm/mach-ep93xx/core.c    |   1 +
 sound/soc/cirrus/Kconfig       |  17 +++++++
 sound/soc/cirrus/edb93xx.c     |   2 +-
 sound/soc/cirrus/ep93xx-i2s.c  | 106 +++++++++++++++++++++++++++++++++--------
 sound/soc/cirrus/snappercl15.c |   2 +-
 5 files changed, 106 insertions(+), 22 deletions(-)

-- 
2.16.2
