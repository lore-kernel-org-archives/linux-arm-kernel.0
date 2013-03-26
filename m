From: achew@nvidia.com (Andrew Chew)
Date: Mon, 25 Mar 2013 18:21:44 -0700
Subject: [PATCH V5 0/9] Add mandatory regulator for all users of pwm-backlight.
Message-ID: <1364260913-25490-1-git-send-email-achew@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many backlights are enabled via GPIO.  We can generalize the GPIO to a
fixed regulator.

The power regulator needs to be mandatory because there was no good way
to determine the difference between opting out of the regulator, and probe
deferral.

This series of patches is intended to add a dummy regulator (or a GPIO
regulator) for all users of the pwm-backlight.

The last patch in the series will always be the pwm-backlight change to add
this mandatory regulator.  Patches following up to that patch add the
mandatory regulator on a per mach family basis.  Once all users of
pwm-backlight have been patched, this series can be applied in order to
maintain bisectability.

All I did in every case was to provide a dummy fixed regulator to
pwm-backlight.  If your platform actually uses a regulator (or a GPIO)
to power the backlight, please either let me know so that I can make
the modifications and give you something back to test.  Or (better yet),
provide me with a tested, alternate patch that I can fold into this patch
series.

I made sure that where there was a defconfig for an affected board, that it
builds.  I did not test-build the unicore patch.

V5:
Changed the name of the supply from "enable" to "power".  Renamed corresponding
regulator dt nodes and regulators in board setup files.  Backlight regulator
nodes renamed to something less generic.

mach-mxs: Moved backlight power regulator into top-level regulators node.
mach-vt8500: Made the backlight power regulator controlled via <&gpio 0 7 0>.
mach-tegra: Moved the backlight power regulator to tegra20-tamonten.dtsi.

V3 and earlier versions of this series only had the OMAP patch, which I
used for ironing out some early, obvious stuff.  V4 and later is the complete
patch set.

Andrew Chew (9):
  ARM: OMAP: board-4430sdp: Provide regulator to pwm-backlight
  ARM: S3C24XX: Provide regulator to pwm-backlight
  ARM: pxa: Provide regulator to pwm-backlight
  ARM: EXYNOS: Provide regulator to pwm-backlight
  unicore32: Provide regulator to pwm-backlight
  ARM: mxs: Provide regulator to pwm-backlight
  ARM: vt8500: Provide regulator to pwm-backlight
  ARM: tegra: Provide regulator to pwm-backlight
  pwm_bl: Add mandatory backlight enable regulator

 .../bindings/video/backlight/pwm-backlight.txt     | 14 +++++
 arch/arm/boot/dts/imx23-evk.dts                    |  6 +++
 arch/arm/boot/dts/imx28-apf28dev.dts               |  6 +++
 arch/arm/boot/dts/imx28-cfa10049.dts               |  6 +++
 arch/arm/boot/dts/imx28-evk.dts                    |  6 +++
 arch/arm/boot/dts/imx28-tx28.dts                   |  6 +++
 arch/arm/boot/dts/tegra20-medcom-wide.dts          |  6 +++
 arch/arm/boot/dts/wm8850-w70v2.dts                 |  6 +++
 arch/arm/mach-exynos/mach-nuri.c                   |  7 +++
 arch/arm/mach-omap2/board-4430sdp.c                |  6 +++
 arch/arm/mach-pxa/cm-x300.c                        |  7 +++
 arch/arm/mach-pxa/colibri-pxa270-income.c          |  8 +++
 arch/arm/mach-pxa/ezx.c                            |  9 ++++
 arch/arm/mach-pxa/hx4700.c                         |  8 +++
 arch/arm/mach-pxa/lpd270.c                         |  9 ++++
 arch/arm/mach-pxa/magician.c                       |  8 +++
 arch/arm/mach-pxa/mainstone.c                      | 13 ++++-
 arch/arm/mach-pxa/mioa701.c                        |  8 +++
 arch/arm/mach-pxa/palm27x.c                        |  8 +++
 arch/arm/mach-pxa/palmtc.c                         |  8 +++
 arch/arm/mach-pxa/palmte2.c                        |  9 ++++
 arch/arm/mach-pxa/pcm990-baseboard.c               |  8 +++
 arch/arm/mach-pxa/raumfeld.c                       |  6 +++
 arch/arm/mach-pxa/tavorevb.c                       | 11 ++++
 arch/arm/mach-pxa/viper.c                          |  8 +++
 arch/arm/mach-pxa/z2.c                             | 10 ++++
 arch/arm/mach-pxa/zylonite.c                       |  7 +++
 arch/arm/mach-s3c24xx/mach-h1940.c                 |  8 +++
 arch/arm/mach-s3c24xx/mach-rx1950.c                |  9 ++++
 arch/arm/plat-samsung/dev-backlight.c              |  9 ++++
 arch/unicore32/kernel/puv3-nb0916.c                |  9 ++++
 drivers/video/backlight/pwm_bl.c                   | 59 ++++++++++++++++++----
 32 files changed, 297 insertions(+), 11 deletions(-)

-- 
1.8.1.5
