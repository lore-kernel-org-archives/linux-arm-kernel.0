From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 May 2018 14:26:54 +0200
Subject: [PATCH 0/4] Switch Versatile Express to use PL111 DRM driver
Message-ID: <20180528122658.3241-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep/Lorenzo,

this series of 4 patches (maybe you have even queued the first
patch) will switch the Versatile Express over to using the
new PL111 DRM driver instead of the old fbdev driver.

There are both DTS updates and defconfig updates. Surely too
late for v4.18 but should be fine for v4.19 (I will likely
remind you if you forget it after v4.18-rc1.) The defconfig
and DTS need to changed in lockstep, but usually the ARM
SoC maintainers want them as two separate pull requests
anyway.

I think this could be quite useful, hopefully enabling things
such as the generic Android and Chromium DRM hwcomposer:
https://memcpy.io/android-enabling-mainline-graphics.html
the improvement will be most drastic on the CA0 Versatile
Express as this has only PL111 graphics on the core tile,
but the fallback PL111 on the motherboard is also working
for all models now.

We are using CMA and CMA DMA buffers with existing DT
bindings to hammer the system down to use the assigned
special memory when we use the PL111 on the motherboard.

Please queue this in your Versatile Express tree.

To complete the transition for PL111 DRM for all ARM reference
designs only Integrator/CP remains because of the special RGBA
5551 mode, but I will fix that too, hopefully also in time for
kernel v4.19.

The QEMU system emulator model for Versatile Express has been
patched to certainly cope with these new changes as well:
https://git.qemu.org/?p=qemu.git;a=commit;h=0b72476810a83de270194b1de65027e4be204779

Linus Walleij (4):
  ARM: dts: Restructure Vexpress motherboard includes
  ARM: dts: Modernize the Vexpress PL111 integration
  ARM: defconfig: Update the vexpress defconfig
  ARM: defconfig: Enable the PL111 DRM driver on vexpress

 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi       | 692 +++++++++---------
 arch/arm/boot/dts/vexpress-v2m.dtsi           | 691 +++++++++--------
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts   |  17 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts    |  19 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts       |  19 +-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts        |  46 +-
 arch/arm/configs/vexpress_defconfig           |  24 +-
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts    |  14 +
 .../boot/dts/arm/rtsm_ve-motherboard.dtsi     |  37 +-
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts |   5 +-
 10 files changed, 773 insertions(+), 791 deletions(-)

-- 
2.17.0
