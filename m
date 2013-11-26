From: stefan@agner.ch (Stefan Agner)
Date: Wed, 27 Nov 2013 00:45:42 +0100
Subject: [PATCH 0/3] regulator: tps6586x: add version detection and voltage
 tables
Message-ID: <cover.1385508112.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds version detection for the tps6586x mfd family. This is
required because some regulator versions use different voltage tables. The
regulator driver now uses the right voltage table according to the
version.

The required voltage for the SM2 converter on the Colibri T20 is 1.8V,
however, the device tree states 3.7V right now. Newer versions (>=V1.2) of
the Colibri T20 module use the TPS658643, whereas old ones (<V1.2) use the
TPS658623. Both of them have a different voltage table for SM2. The
current device tree contains a voltage which results in 1.8V for the older
TPS658623. Since the regulator driver has correct voltage tables for both
regulator versions now, we can request the correct 1.8V from the device
tree.

Tested on Colibri T20 V1.1 and V1.2.

Stefan Agner (3):
  mfd: tps6586x: add version detection
  regulator: tps6586x: add voltage table for tps658643
  ARM: tegra: set SM2 voltage correct

 arch/arm/boot/dts/tegra20-colibri-512.dtsi |  4 +-
 drivers/mfd/tps6586x.c                     | 41 +++++++++++--
 drivers/regulator/tps6586x-regulator.c     | 97 ++++++++++++++++++++----------
 include/linux/mfd/tps6586x.h               |  9 +++
 4 files changed, 110 insertions(+), 41 deletions(-)

-- 
1.8.4.2
