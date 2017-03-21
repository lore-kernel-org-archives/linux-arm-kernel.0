From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 21 Mar 2017 16:36:00 +0100
Subject: [PATCH v3 00/11] add thermal throttling to Allwinner A33 SoC
Message-ID: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner SoCs all have an ADC that can also act as a touchscreen
controller and a thermal sensor. The first four channels can be used
either for the ADC or the touchscreen and the fifth channel is used for
the thermal sensor. We currently have a driver for the two latter
functions in drivers/input/touchscreen/sun4i-ts.c but we don't have
access to the ADC feature at all. It is meant to replace the current
driver by using MFD and subdrivers for existing bindings.

The Allwinner A33 only has a thermal sensor present in the GPADC. In
addition, there is not an existing DT binding for the GPADC. Thus, we do
not need the sun4i-gpadc MFD driver which was made to keep DT compatibility
and probe subdrivers without the need to add DT subnodes.

This series of patch adds the thermal sensor for the A33 and GPU/CPU
thermal throttling. It also adds the cpu-supply property to the CPU node
needed by the Sinlinx SinA33 and Olinuxino A33 to adapt their CPU regulator
voltage depending on the currently used OPP. The other A33 boards all have
their cpu-supply property set.

This series also fixes the missing operating-points-v2 property in cpu DT
nodes. Finally, it also adds all remaining OPPs which can be found in
Allwinner 3.4 linux and fex files of all A33 boards.

This series of patch is based on this[1] series of patch.

v3:
  - fixed compatible name in DT and in documentation,
  - fixed DT node name and label,
  - added explanations in commit logs,
  - moved frequencies that need overvolting to board DTS instead of A33 DTSI,
  - fixed a typo in if is_enabled condition,
  - removed all patches concerning Olimex Olinuxino (no HW to test on),

[1] https://lkml.org/lkml/2016/12/13/298 : "[PATCH v9] add support for Allwinner
SoCs ADC"

Thanks,
Quentin

Maxime Ripard (1):
  ARM: sun8i: a33: Add devfreq-based GPU cooling

Quentin Schulz (10):
  ARM: sun8i: a33: add operating-points-v2 property to all nodes
  ARM: sun8i: a33: add all operating points
  ARM: dts: sun8i: sina33: add cpu-supply
  Documentation: DT: bindings: mfd: add A33 GPADC binding
  Documentation: DT: bindings: input: touschcreen: remove sun4i
    documentation
  iio: adc: sun4i-gpadc-iio: move code used in MFD probing to new
    function
  iio: adc: sun4i-gpadc-iio: add support for A33 thermal sensor
  ARM: dtsi: sun8i: a33: add thermal sensor
  ARM: dtsi: sun8i: a33: add CPU thermal throttling
  ARM: sun8i: sina33: add highest OPP of CPUs

 .../touchscreen/sun4i.txt => mfd/sun4i-gpadc.txt}  |  21 +++
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   1 +
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  18 +++
 arch/arm/boot/dts/sun8i-a33.dtsi                   | 141 +++++++++++++++++
 drivers/iio/adc/Kconfig                            |   2 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  | 170 +++++++++++++++++----
 include/linux/mfd/sun4i-gpadc.h                    |   4 +
 7 files changed, 324 insertions(+), 33 deletions(-)
 rename Documentation/devicetree/bindings/{input/touchscreen/sun4i.txt => mfd/sun4i-gpadc.txt} (64%)

-- 
2.9.3
