From: chris.brandt@renesas.com (Chris Brandt)
Date: Tue,  7 Feb 2017 12:09:26 -0500
Subject: [PATCH v2 0/3] ARM: l2c: add l2c support for RZ/A1
Message-ID: <20170207170929.29525-1-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL310 in the Renesas RZ/A1 SoC (R7S72100) does not have the sideband
signals connected between the CPU and L2C. According the PL310 TRM,
sideband signals are optional.

If a PL310 is added to a system, but the sideband signals are not
connected, some Cortex A9 optimizations cannot be used. In particular,
enabling Full Line Zeros in the CA9 without sidebands connected will
crash the system since the CA9 will expect the L2C to perform operations,
yet the L2C never gets the commands.

This series adds the option to not enable anything in the PL310 that
uses sidebands, and then adds L2C support to the RZ/A1 DT.

v2:
* Added "arm,pl310-no-sideband" to cache-l2x0.c instead of hacking in a
  dummy l2c_write_sec function to keep FLZ from being enabled.


Chris Brandt (3):
  ARM: l2c: add pl310-no-sideband option
  ARM: shmobile: r7s72100: Enable L2 cache
  ARM: dts: r7s72100: add l2 cache

 Documentation/devicetree/bindings/arm/l2c2x0.txt |  2 ++
 arch/arm/boot/dts/r7s72100.dtsi                  | 10 ++++++++++
 arch/arm/mach-shmobile/setup-r7s72100.c          |  2 ++
 arch/arm/mm/cache-l2x0.c                         |  9 +++++++--
 4 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.10.1
