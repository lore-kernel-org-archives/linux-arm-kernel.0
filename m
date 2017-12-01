From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:23 +0100
Subject: [PATCH v2 00/27] Improve DE2 support
Message-ID: <20171201060550.10392-1-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current DE2 driver is very basic and uses a lot of magic constants since
there is no documentation and knowledge about it was limited at the time.

With studying BSP source code, deeper knowledge was gained which allows
to improve mainline driver considerably.

At the beginning of this series, some code refactoring is done as well
as adding some checks (patches 1-15).

Further patches add multi-plane support with HW scaling and all possible
RGB formats (patches 16-21).

At last, support for YUV formats is added (patches 22-26).

At the end, I included patch which puts lowest plane before second lowest.
This should help testing VI planes when mixer has configuration 1 VI plane
and 1 or more UI planes (most SoCs except V3s).

This code was developed on H3, but it should work on every SoC if correct
configuration structure is provided.

H3 code can be found here:
https://github.com/jernejsk/linux-1/commits/de2_impr_for_next

Best regards,
Jernej

Changes from v1:
- Split two patches to multiple smaller ones and better explain why those
changes are needed and added fixes tag where appropriate.
- channel parameters represents HW better (layer id -> channel, overlay)
- add kerneldoc to configuration structure
- nicer code style in atomic_check functions
- changed WARN() to DRM_WARN() in csc code
- split common scaler file to separate ui and vi scaler files
- move channel specific code out of mixer code to sun8i_ui_layer.c and
sun8i_vi_layer.c
- defined macros for min and max supported scaler factor for each type
of scaler

Jernej Skrabec (27):
  drm/sun4i: Fix format mask in DE2 driver
  drm/sun4i: Rename DE2 RGB format macros
  drm/sun4i: Remove setting alpha mode in DE2 driver
  drm/sun4i: Fix debug message in DE2
  drm/sun4i: Remove setting default values in DE2 driver
  drm/sun4i: Explain color macro in DE2 driver
  drm/sun4i: Set blending mode for all channels (DE2)
  drm/sun4i: Rename some macros in DE2 driver
  drm/sun4i: Rework enabling plane in DE2 driver
  drm/sun4i: Start using layer id in DE2 driver
  drm/sun4i: Add constraints checking to DE2 driver
  drm/sun4i: Use values calculated by atomic check
  drm/sun4i: Move line width setting in DE2
  drm/sun4i: Move channel size related code in DE2
  drm/sun4i: Move interlace related code in DE2
  drm/sun4i: Add multi plane support to DE2 driver
  drm/sun4i: Add support for all HW supported DE2 RGB formats
  drm/sun4i: Reorganize UI layer code in DE2
  drm/sun4i: Add support for DE2 VI planes
  drm/sun4i: Add scaler configuration to DE2 mixers
  drm/sun4i: Add support for HW scaling to DE2
  drm/sun4i: Add CCSC property to DE2 configuration
  drm/sun4i: Add DE2 CSC library
  drm/sun4i: Add DE2 definitions for YUV formats
  drm/sun4i: Expand DE2 scaler lib with YUV support
  drm/sun4i: Wire in DE2 YUV support
  [DO NOT MERGE]drm/sun4i: Change zpos of bottom VI plane

 drivers/gpu/drm/sun4i/Makefile          |   4 +-
 drivers/gpu/drm/sun4i/sun8i_csc.c       |  93 +++
 drivers/gpu/drm/sun4i/sun8i_csc.h       |  36 ++
 drivers/gpu/drm/sun4i/sun8i_layer.c     | 134 -----
 drivers/gpu/drm/sun4i/sun8i_layer.h     |  36 --
 drivers/gpu/drm/sun4i/sun8i_mixer.c     | 496 +++++++++-------
 drivers/gpu/drm/sun4i/sun8i_mixer.h     | 123 ++--
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c  | 351 ++++++++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h  |  63 +++
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c | 172 ++++++
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h |  49 ++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c  | 389 +++++++++++++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h  |  51 ++
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c | 971 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h |  58 ++
 15 files changed, 2595 insertions(+), 431 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_csc.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_csc.h
 delete mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.c
 delete mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_ui_layer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_ui_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_vi_layer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_vi_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h

-- 
2.15.1
