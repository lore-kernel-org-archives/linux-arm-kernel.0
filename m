From: stefan@agner.ch (Stefan Agner)
Date: Mon, 27 Jun 2016 23:27:52 -0700
Subject: [PATCH v4 0/5] regulator: add Ricoh RN5T567 PMIC support
Message-ID: <20160628062757.24490-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds RN5T567 PMIC support which is used on the 
Toradex Colibri iMX7S/iMX7D modules. The existing RN5T618 is from
the same family, hence this patchset uses the same driver and adds
variant support.

The Colibris currently do not use the PMIC's power off capabilities,
as do the current users of that PMIC driver. Therefore this patchset
also makes the use of the system-power-controller property mandatory
if the power off capabilties are required.

Changes since v3:
- Use RN5T618_REPCNT_REPWRON macro when writing RN5T618_REPCNT register

Changes since v2:
- Elevate restart priority to 192 to make sure PMIC takes presedence
  over SoC level restart capabilities (e.g. watchdog)
- Print a warning if poweroff callback is already assigned
- Reorder of_id and variant assignment
- Lower delay to 1ms and justify why it is required
- Fix DCDC count and a typos in device tree bindings

Changes since v1:
- Removed obsolete include <asm/system_misc.h>

Stefan Agner (5):
  ARM: dts: meson: minix-neo-x8: define PMIC as power controller
  mfd: add Ricoh RN5T567 PMIC support
  regulator: rn5t618: add RN5T567 PMIC support
  mfd: rn5t618: register power off callback optionally
  mfd: rn5t618: register restart handler

 Documentation/devicetree/bindings/mfd/rn5t618.txt | 19 +++---
 arch/arm/boot/dts/meson8-minix-neo-x8.dts         |  1 +
 drivers/mfd/Kconfig                               |  7 ++-
 drivers/mfd/rn5t618.c                             | 70 +++++++++++++++++++----
 drivers/regulator/Kconfig                         |  5 +-
 drivers/regulator/rn5t618-regulator.c             | 40 +++++++++++--
 include/linux/mfd/rn5t618.h                       | 13 +++++
 7 files changed, 126 insertions(+), 29 deletions(-)

-- 
2.8.3
