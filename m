From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 22 Feb 2017 10:09:48 +0900
Subject: [PATCH v10 0/3] Add support for the S6E3HA2 panel on TM2 board
In-Reply-To: <CGME20170220071000epcas1p38e002e5064bdf4c3b1b4886207dcaaf4@epcas1p3.samsung.com>
References: <CGME20170220071000epcas1p38e002e5064bdf4c3b1b4886207dcaaf4@epcas1p3.samsung.com>
Message-ID: <50768133-aabc-6050-c9b2-8898bb8046a6@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thierry,

I understand that your opinion is:
It is better to handle the error every time it is input to the
register, rather than error handling at once in the struct using
error. This not only makes the code easier to maintain, but also
reduces unnecessary computation.

So I modified the panel driver to code-by-code error handling.
If this is not your opinion, could you tell me what your opinion?

Best Regards,
Hoegeun


Changes for V10:
- Fixed code-by-code error handling.

Changes for V9:
- Fixed the te-gpio to optional in bindings

Changes for V8:
- Applied below two patches: (drm/exynos)
   : drm/exynos: mic: Add mode_set callback function
   : drm/exynos: mic: Fix parse_dt function
- The dt-binding patch and driver patch were divided.
- Rebase these patches on samsung SoC tree[1] and tm2 touckey patch[2].

Change for V7:
- Fixed the mode_set callback function of mic device driver.
   because the mic register is initialized when entering suspend
   mode, so should set the reg value whenever pre_enable is
   called.

Changes for V6:
- Fixed the parse_dt function of dsi device driver.
- Removed OF graph of panel in DT and DT binding document.
- Fixed the s6e3ha2 panel device driver.
   - Fixed from number size to ARRAY_SIZE().
   - Fixed error handling in mipi_dsi_dcs_* functions.
   - Fixed the clock of display_mode.
   - Removed unnecessary casting and error log.

Change for V5:
- The V5 has only one fix in V4 below.
- Removed the enable check of the mic driver in mode_set
   callback, because mode_set should be performed every time.

Changes for V4:
- Removed display-timings in devicetree, the display-timings has
   been fixed to be provided by the device driver.
- Added the mode_set callback function into exynos_drm_mic,
   because the exynos_drm_mic driver can not parse a videomode
   struct by removing the display-timings from the devicetree.

Changes for V3:
- In the DT binding document, made it clearly that the panel is a
   child node of dsi.
- Fix reset-gpio active from high to low.
- Is the OF graph saying related to patch2?
   Althogh the panel is a child of dsi, I think OF graph necessary.
   because if a remote-endpoint is not specified, the dsi also
   panel is not probed.
- The display-timings has been fixed to be provided by the device
   driver. however, I think display-timings is necessary in dts.
   because if dts does not have display-timings, dsi will not load.

Changes for V2:
- Fixed the samsung,s6e3ha2.txt DT document.
   - Added active high or low after the description of the GPIOs.
   - Removed the reg and added a description of the virtual
     channel number of a DSI peripheral.

Depends on:
[1] https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/ 
(for-next branch)
[2] https://patchwork.kernel.org/patch/9504131/
     - ("arm64: dts: exynos: Add tm2 touchkey node")

Hoegeun Kwon (2):
   dt-bindings: Add support for samsung s6e3ha2 panel binding
   drm/panel: Add support for S6E3HA2 panel driver on TM2 board

Hyungwon Hwang (1):
   arm64: dts: exynos: Add support for S6E3HA2 panel device on TM2 board

  .../bindings/display/panel/samsung,s6e3ha2.txt     |  28 +
  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |  12 +
  drivers/gpu/drm/panel/Kconfig                      |   6 +
  drivers/gpu/drm/panel/Makefile                     |   1 +
  drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      | 739 
+++++++++++++++++++++
  5 files changed, 786 insertions(+)
  create mode 100644 
Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
  create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c

-- 
1.9.1
