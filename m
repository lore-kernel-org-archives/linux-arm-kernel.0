From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Mon, 18 Dec 2017 15:36:31 +0100
Subject: [PATCH v4 00/12] Armada thermal: improvements and A7K/A8K SoCs support
Message-ID: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series takes over Baruch's series by integrating his patches about
supporting thermal on Armada 7K and 8K SoCs within a larger series with
several improvements on the armada_thermal.c driver.

For now, Armada 380 and CP110 compatibles share the same initialization
routine but this will probably change in the near future when adding
support for overheat interrupts.

DT bindings documentation is updated to match existing code.

Armada AP806 and CP110 DT are also updated with thermal nodes.

Thank you,
Miqu?l


Changes since v3:
  - Added Gregory's Reviewed-by tags
  - Detailed what I have changed over Baruch's series in the commit logs
  - Removed the list of every supported SoC, used "Marvell EBU Armada
  SoCs" instead as suggested by Thomas (unless for the Kconfig
  description, where having the list is useful).
  - Changed the comment about the Armada 380 reset section in the
  armada380_init() callback.
  - Removed the freshly introduced marvell,thermal-zone-name property in
  favor of the use of dev_name(dev) to name the thermal zone.
  - Introduced the needs_control0 capability and removed checks in the
  init routines (probe will fail if the bindings used are not
  appropriate).
  - Changed coefficients type to s64 to handle signed values, as well as
  some local variables around in the get_temp() callback
  - Used a do_div() instead of the traditionnal "/" to handle 64-bit
  values.
  - Split the patch renaiming the registers to do the "status" renaiming
  aside.


Baruch Siach (4):
  dt-bindings: thermal: Describe Armada AP806 and CP110
  thermal: armada: Use msleep for long delays
  thermal: armada: Add support for Armada AP806
  thermal: armada: Add support for Armada CP110

Miquel Raynal (8):
  thermal: armada: Simplify the check of the validity bit
  thermal: armada: Clarify control registers accesses
  thermal: armada: Use real status register name
  thermal: armada: Update Kconfig and module description
  thermal: armada: Change sensors trim default value
  thermal: armada: Wait sensors validity before exiting the init
    callback
  thermal: armada: Give meaningful names to the thermal zones
  ARM64: dts: marvell: Add thermal support for A7K/A8K

 .../devicetree/bindings/thermal/armada-thermal.txt |  24 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   6 +
 .../boot/dts/marvell/armada-cp110-master.dtsi      |   6 +
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |   6 +
 drivers/thermal/Kconfig                            |   4 +-
 drivers/thermal/armada_thermal.c                   | 252 +++++++++++++++------
 6 files changed, 226 insertions(+), 72 deletions(-)

-- 
2.11.0
