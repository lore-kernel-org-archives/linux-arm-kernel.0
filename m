From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Mon, 27 Nov 2017 21:57:33 +0100
Subject: [PATCH 00/17] Improve DE2 support
Message-ID: <20171127205750.19277-1-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current DE2 driver is very basic and uses a lot of magic constants since
there is no documentation and knowledge about it was limited at the time.

With studying BSP source code, deeper knowledge was gained which allows
to improve mainline driver considerably.

At the beginning of this series, some code refactoring is done as well
as adding some checks (patches 1-5).

Further patches add multi-plane support with HW scaling and all possible
RGB formats (patches 6-11).

At last, support for YUV formats is added (patches 12-16).

At the end, I included patch which puts lowest plane before second lowest.
This should help testing VI planes when mixer has configuration 1 VI plane
and 1 on more UI planes (most SoCs except V3s).

This code was developed on H3, but it should work on every SoC if correct
configuration structure is provided.

H3 code can be found here:
https://github.com/jernejsk/linux-1/commits/de2_impr_for_next

Best regards,
Jernej

Jernej Skrabec (17):
  drm/sun4i: Refactor DE2 code
  drm/sun4i: Start using layer id in DE2 driver
  drm/sun4i: Add constraints checking to DE2 driver
  drm/sun4i: Use values calculated by atomic check
  drm/sun4i: Reorder some code in DE2
  drm/sun4i: Add multi plane support to DE2 driver
  drm/sun4i: Add support for all HW supported DE2 RGB formats
  drm/sun4i: Add support for DE2 VI planes
  drm/sun4i: Add scaler library for DE2
  drm/sun4i: Add scaler configuration to DE2 mixers
  drm/sun4i: Wire in DE2 scaler support
  drm/sun4i: Add CCSC property to DE2 configuration
  drm/sun4i: Add DE2 CSC library
  drm/sun4i: Add DE2 definitions for YUV formats
  drm/sun4i: Expand DE2 scaler lib with YUV support
  drm/sun4i: Wire in DE2 YUV support
  [DO NOT MERGE]drm/sun4i: Change zpos of bottom VI plane

 drivers/gpu/drm/sun4i/Makefile       |    2 +-
 drivers/gpu/drm/sun4i/sun8i_csc.c    |   90 +++
 drivers/gpu/drm/sun4i/sun8i_csc.h    |   36 ++
 drivers/gpu/drm/sun4i/sun8i_layer.c  |  176 +++++-
 drivers/gpu/drm/sun4i/sun8i_mixer.c  |  679 +++++++++++++++++----
 drivers/gpu/drm/sun4i/sun8i_mixer.h  |  108 +++-
 drivers/gpu/drm/sun4i/sun8i_scaler.c | 1103 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_scaler.h |   79 +++
 8 files changed, 2096 insertions(+), 177 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_csc.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_csc.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_scaler.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_scaler.h

-- 
2.15.0
