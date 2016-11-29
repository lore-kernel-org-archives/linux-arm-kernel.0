From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 29 Nov 2016 11:18:35 +0100
Subject: [PATCH v7 0/8] drm: sun8i: Add DE2 HDMI video support
Message-ID: <cover.1480414715.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset series adds HDMI video support to the Allwinner
sun8i SoCs which include the display engine 2 (DE2).
The driver contains the code for the A83T and H3 SoCs, and
some H3 boards, but it could be used/extended for other SoCs
(A64, H2, H5) and boards (Banana PIs, Orange PIs).

v7:
	- more explanations about the DE2 in the DT documentation
	- separate patches for DT documentation (Rob Herring)
	- show all properties in DT examples (Rob Herring)
	- use drm_of_component_probe()
	- use the index of the DE 'ports' in the DT as
	  the DE mixer number (no alias needed anymore)
	- change some 'lcd' to 'tcon' in the DT
	- add HDMI module parameter for DVI mode when screen overscan
	  problems
	- fall back to some CEA modes in case of EDID read failure
	- fix some settings (interlace) and simplify code
	- fix bug in start of A83T HDMI
	- fix lack of CLK_PLL_DE definition in the DT include
	  (Icenowy Zheng)
v6:
	- remove audio support (other patchset to come)
	- use DRM modeset data for HDMI configuration
		(thanks to Jernej ??krabec)
	- more meaningfull register names
	- use a mutex for DE I/O protection
	- merge DE and plane into one file
	- don't activate the video hardware when video not started
		(Maxime Ripard)
	- remove 'type = "video" in DT graph ports
		(Rob Herring)
	- change the I/O accesses by #define instead of struct
		(Maxime Ripard, Andr?? Przywara)
	- remove pm functions (Maxime Ripard)
	- set the pll-de/de clocks in the DT (Maxime Ripard)
	- use platform_get_irq instead of irq_of_parse_and_map
		(Maxime Ripard)
	- rename sunxi to sun8i (Maxime Ripard)
	- fix coding style errors (Maxime Ripard)
	- subclass the drm structure in private data (Daniel Vetter)
	- move drm_dev_register at end of init (Daniel Vetter)
v5:
	- add overlay plane
	- add audio support
	- add support for the A83T
	- add back the HDMI driver
	- many bug fixes
v4: 
	- drivers/clk/sunxi/Makefile was missing (Emil Velikov)
v3:
	- add the hardware cursor
	- simplify and fix the DE2 init sequences
	- generation for all SUNXI SoCs (Andre Przywara)
v2:
	- remove the HDMI driver
	- remarks from Chen-Yu Tsai and Russell King
	- DT documentation added

Jean-Francois Moine (8):
  drm: sun8i: Add a basic DRM driver for Allwinner DE2
  drm/sun8i: Add DT bindings documentation of Allwinner DE2
  drm: sun8i: add HDMI video support to A83T and H3
  drm/sunxi: Add DT bindings documentation of Allwinner HDMI
  clk: sunxi-ng: define the PLL DE clock
  ARM: dts: sun8i-h3: add HDMI video nodes
  ARM: dts: sun8i-h3: Add HDMI video to the Banana Pi M2+
  ARM: dts: sun8i-h3: Add HDMI video to the Orange PI 2

 .../devicetree/bindings/display/sunxi/hdmi.txt     |  56 ++
 .../bindings/display/sunxi/sun8i-de2.txt           | 121 +++
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |  12 +
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  12 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  65 ++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/sun8i/Kconfig                      |  26 +
 drivers/gpu/drm/sun8i/Makefile                     |   9 +
 drivers/gpu/drm/sun8i/de2_crtc.c                   | 449 +++++++++++
 drivers/gpu/drm/sun8i/de2_crtc.h                   |  52 ++
 drivers/gpu/drm/sun8i/de2_drv.c                    | 317 ++++++++
 drivers/gpu/drm/sun8i/de2_drv.h                    |  48 ++
 drivers/gpu/drm/sun8i/de2_hdmi.c                   | 440 +++++++++++
 drivers/gpu/drm/sun8i/de2_hdmi.h                   |  51 ++
 drivers/gpu/drm/sun8i/de2_hdmi_io.c                | 842 +++++++++++++++++++++
 drivers/gpu/drm/sun8i/de2_plane.c                  | 734 ++++++++++++++++++
 include/dt-bindings/clock/sun8i-h3-ccu.h           |   1 +
 18 files changed, 3238 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sunxi/hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun8i-de2.txt
 create mode 100644 drivers/gpu/drm/sun8i/Kconfig
 create mode 100644 drivers/gpu/drm/sun8i/Makefile
 create mode 100644 drivers/gpu/drm/sun8i/de2_crtc.c
 create mode 100644 drivers/gpu/drm/sun8i/de2_crtc.h
 create mode 100644 drivers/gpu/drm/sun8i/de2_drv.c
 create mode 100644 drivers/gpu/drm/sun8i/de2_drv.h
 create mode 100644 drivers/gpu/drm/sun8i/de2_hdmi.c
 create mode 100644 drivers/gpu/drm/sun8i/de2_hdmi.h
 create mode 100644 drivers/gpu/drm/sun8i/de2_hdmi_io.c
 create mode 100644 drivers/gpu/drm/sun8i/de2_plane.c

-- 
2.10.2
