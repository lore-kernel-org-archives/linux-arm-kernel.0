From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 22 Dec 2011 21:34:25 +0200
Subject: [PATCH v3 0/9] OMAP4: ASoC: Support for PandaBoard family
Message-ID: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following series will add ASoC support for PandaBoards.
PandaBoards have different audio routings compared to SDP4430/Blaze boards, but
the differences not that big to justify a new ASoC machine driver.

This series is based on the first three patch from the v1 sereis (those, which
has been applied by Liam).

Changes since v2:
- Remove direct board dependency for the ASoC machine driver (replaced by
  ARCH_OMAP4)
- mach-omap2/board-omap4panda: Generic board revision handling function instead
  of dedicated for audio.
- Macro twl6040_disconnect_pin replaced with a function

Changes since v1:
As suggested by Mark the platform data, machine driver has been converted to
process feature flags instead of Board IDs.
- The ASoC machine driver registers all DAPM widgets. Based on the received
  configuration it will disable the unused paths
- PCM for dmic is only created, if the board has digital mic conencted
- Jack functionality will be only used on boards supporting it
- Sound card name for SDP4430 has net been changed

Regards,
Peter
---
Peter Ujfalusi (9):
  include: platform_data: Platform data header for OMAP4 ASoC audio
  OMAP4: 4430sdp: Register platform device for OMAP4 audio
  ASoC: omap-abe-twl6040: Convert to platform deriver
  ASoC: twl6040: Convert MICBIAS to SUPPLY widget
  ASoC: omap-abe-twl6040: Add complete DAPM routing
  ASoC: omap-abe-twl6040: DAI link selection based on platform data
  ASoC: omap-abe-twl6040: Configure card according to platform data
  OMAP4: omap4panda: Enable audio support
  ASoC: Kconfig: OMAP4: Enable support for PandaBoards

 arch/arm/mach-omap2/board-4430sdp.c            |   27 ++++
 arch/arm/mach-omap2/board-omap4panda.c         |   57 ++++++++-
 include/linux/platform_data/omap-abe-twl6040.h |   48 +++++++
 sound/soc/codecs/twl6040.c                     |   16 +-
 sound/soc/omap/Kconfig                         |    4 +-
 sound/soc/omap/omap-abe-twl6040.c              |  181 ++++++++++++++++--------
 6 files changed, 263 insertions(+), 70 deletions(-)
 create mode 100644 include/linux/platform_data/omap-abe-twl6040.h

-- 
1.7.8.1
