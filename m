From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 Jun 2018 15:24:07 -0500
Subject: [PATCH 0/4] ARM: Provide workaround setup bits for CVE-2017-5715
 (A8/A15)
Message-ID: <20180612202411.29798-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a follow on from https://marc.info/?l=u-boot&m=151691688828176&w=2 (RFC)

NOTE:
* As per ARM recommendations[2], and discussions in list[1] ARM
  Cortex-A9/12/17 do not need additional steps in u-boot to enable the
  OS level workarounds.
* This itself is'nt a complete solution and is based on recommendation
  This from Arm[2] for variant 2 CVE-2017-5715 -> Kernel changes can be seen on
  linux next (next-20180612) or on linux master (upcoming v4.18-rc1 tag).
* I think it is necessary on older SoCs without firmware support
  (such as older OMAPs and AM*) to have kernel support mirroring what we do in
  u-boot to support additional cores AND/OR low power states where contexts are
  lost (assuming ACR states are'nt saved). just my 2 cents.

Few of the tests (with linux next-20180612):
AM571-IDK: https://pastebin.ubuntu.com/p/sr5X6sN3Tr/ (single core A15)
OMAP5-uEVM: https://pastebin.ubuntu.com/p/9yDM22bJ6n/ (dual core A15)
OMAP3-beagle-xm: https://pastebin.ubuntu.com/p/9DfDkpyxym/ (Single A8)
AM335x-Beaglebone-black: https://pastebin.ubuntu.com/p/DczT9jPMwb/ (Single A8)

Nishanth Menon (4):
  ARM: Introduce ability to enable ACR::IBE on Cortex-A8 for
    CVE-2017-5715
  ARM: Introduce ability to enable invalidate of BTB with ICIALLU on
    Cortex-A15 for CVE-2017-5715
  ARM: mach-omap2: omap5/dra7: Enable ACTLR[0] (Enable invalidates of
    BTB) to facilitate CVE_2017-5715 WA in OS
  ARM: mach-omap2: omap3/am335x: Enable ACR::IBE on Cortex-A8 SoCs for
    CVE-2017-5715

 arch/arm/Kconfig            |  9 +++++++++
 arch/arm/cpu/armv7/start.S  | 15 +++++++++++++--
 arch/arm/mach-omap2/Kconfig |  3 +++
 3 files changed, 25 insertions(+), 2 deletions(-)

[1] https://marc.info/?t=151639906500002&r=1&w=2
[2] https://developer.arm.com/support/security-update
[3] https://marc.info/?t=151543790400007&r=1&w=2 and the latest in:
	https://marc.info/?l=linux-arm-kernel&m=151689379521082&w=2
[4]
	https://github.com/ARM-software/arm-trusted-firmware/wiki/ARM-Trusted-Firmware-Security-Advisory-TFV-6
	https://www.op-tee.org/security-advisories/
	https://www.linaro.org/blog/meltdown-spectre/
-- 
2.15.1
