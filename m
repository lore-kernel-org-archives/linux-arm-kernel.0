From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jun 2017 22:39:34 +0200
Subject: [GIT PULL] sun4i-drm changes for 4.13
Message-ID: <20170614203934.hf5ilhmovuuhhk2r@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Here is the pull request for the sun4i-drm driver for 4.13.

Thanks!
Maxime

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drm-for-4.13

for you to fetch changes up to 110d33dd428ea49b9482bcb780fb096dfb4dcd3e:

  drm/sun4i: Add compatible for the A10s pipeline (2017-06-01 09:50:01 +0200)

----------------------------------------------------------------
sun4i-drm changes for 4.13

An unusually big pull request for this merge window, with three notable
features:
  - V3s display engine support. This is especially notable because it uses
    a different display engine used on the newer Allwinner SoCs (H3, A64
    and the likes) that will be quite easily supported now.
  - HDMI support for the old Allwinner SoCs. This is enabled only on the
    A10s for now, but should be really easy to extend to deal with A10, A20
    and A31
  - Preliminary work to deal with dual-pipeline SoCs (A10, A20, A31, H3,
    etc.). It currently ignores the second pipeline, but we can use the
    dual-pipelines bindings. This will be useful to enable the display
    pipeline while we work on the dual-pipeline.

----------------------------------------------------------------
Chen-Yu Tsai (9):
      dt-bindings: display: sun4i: Add component endpoint ID numbering scheme
      drm/sun4i: Use lists to track registered display backends and TCONs
      drm/sun4i: backend: Drop trailing 0 from backend in error message
      drm/sun4i: backend: Fetch backend ID from device tree
      drm/sun4i: backend: Save pointer to device tree node
      drm/sun4i: tcon: Find matching display backend by device node matching
      drm/sun4i: tcon: Copy ID from associated backend
      drm/sun4i: Set TCON clock inside sun4i_tconX_mode_set
      drm/sun4i: backend: Clarify sun4i_backend_layer_enable debug message

Icenowy Zheng (7):
      dt-bindings: add bindings for DE2 on V3s SoC
      drm/sun4i: return only planes for layers created
      drm/sun4i: abstract a engine type
      drm/sun4i: add a Kconfig option for sun4i-backend
      drm/sun4i: add support for Allwinner DE2 mixers
      drm/sun4i: Add compatible string for V3s display engine
      drm/sun4i: tcon: add support for V3s TCON

Maxime Ripard (11):
      drm/sun4i: tcon: Add channel debug
      drm/sun4i: tcon: Move the muxing out of the mode set function
      drm/sun4i: tcon: Switch mux on only for composite
      drm/sun4i: tcon: Fix tcon channel 1 backporch calculation
      drm/sun4i: tcon: Change vertical total size computation inconsistency
      drm/sun4i: tcon: multiply the vtotal when not in interlace
      drm/sun4i: Ignore the generic connectors for components
      dt-bindings: display: sun4i: Add HDMI display bindings
      dt-bindings: display: sun4i: Add allwinner,tcon-channel property
      drm/sun4i: Add HDMI support
      drm/sun4i: Add compatible for the A10s pipeline

 .../bindings/display/sunxi/sun4i-drm.txt           | 127 +++++-
 drivers/gpu/drm/sun4i/Kconfig                      |  28 ++
 drivers/gpu/drm/sun4i/Makefile                     |  14 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              | 122 +++--
 drivers/gpu/drm/sun4i/sun4i_backend.h              |  15 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |  32 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.h                 |   5 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  19 +-
 drivers/gpu/drm/sun4i/sun4i_drv.h                  |   5 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi.h                 | 157 +++++++
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c         | 127 ++++++
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             | 501 +++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c        | 225 +++++++++
 drivers/gpu/drm/sun4i/sun4i_layer.c                |  21 +-
 drivers/gpu/drm/sun4i/sun4i_layer.h                |   6 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |   3 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 | 142 +++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |  10 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |  12 +-
 drivers/gpu/drm/sun4i/sun8i_layer.c                | 134 ++++++
 drivers/gpu/drm/sun4i/sun8i_layer.h                |  36 ++
 drivers/gpu/drm/sun4i/sun8i_mixer.c                | 414 +++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h                | 137 ++++++
 drivers/gpu/drm/sun4i/sunxi_engine.h               |  98 ++++
 24 files changed, 2285 insertions(+), 105 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.h
 create mode 100644 drivers/gpu/drm/sun4i/sunxi_engine.h

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170614/f28bb9ea/attachment.sig>
