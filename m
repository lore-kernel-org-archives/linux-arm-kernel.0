From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu, 24 Sep 2015 13:39:14 +0200
Subject: [PATCH v2 0/5] ARM: multi_v7_defconfig: Improve rockchip support
Message-ID: <1443094759-28531-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Enable options to provide more complete support for Rockchip boards
including: support for the common PMICs, common RTC chips, I2C, SPI,
PMW, Thermal driver, HDMI video output and USB 2.

In response to V1 there was some direct and indirect discussion about
what policy to use for deciding what to build as a module versus what to
build in. Unfortunately there doesn't seem to be any consensus in this
regard, so for this series i've stuck to the following guideline for doing
things as builtin:
* If it's needed for booting without an initramfs to an NFS root
  filesystem.
* It's needed to prevent potential damage to the SoC

This results in building in various regulators (required by the
network driver), I2C bus (to control said regulators) and the thermal
driver (to prevent thermal damage). While everything else is a module.

Fwiw, I really don't have a strong opinion myself on whether this is a
better guideline then "Built-in only the bare minimum, people can use an
initramfs to load modules as needed" which e.g. Thierry has been
advocating. However it would be nice if we could get some common
guideline from e.g. the arm-soc maintainers as the typical "module or
not" discussion that tends to happen gets rather boring rather quickly:)


Changes in v2:
- Enable all common rockchip regulators, not just ACT8846
- Only enable the USB 2 phy, not the controller as that came in through
  another tree
- Enable USB 2.0 phy as a module as the controller is a module as well
- New patch, enable common RTC drivers

Sjoerd Simons (5):
  ARM: multi_v7_defconfig: Enable common Rockchip devices/busses
  ARM: multi_v7_defconfig: Enable common regulators for rockchip boards
  ARM: multi_v7_defconfig: Enable Rockchip display support
  ARM: multi_v7_defconfig: Enable the Rockchip USB 2.0 phy
  ARM: multi_v7_defconfig: Support RTC devices commonly used on Rockchip
    boards

 arch/arm/configs/multi_v7_defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.5.3
