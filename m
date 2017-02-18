From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Sat, 18 Feb 2017 20:45:01 +0100 (CET)
Subject: [PATCH 0/2] mfd: axp20x: Restore master mode support on AXP806
Message-ID: <cover.1487428238.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP806 (and very similar AXP808) PMICs can be wired to either master
mode or slave mode on a board-by-board basis. A register on the PMIC needs
to be set accordingly for the PMIC to respond to other register accesses.
The "xpowers,master-mode" property introduced in this patch series lets a
board's device tree specify the correct operating mode to use.

Known boards with the Allwinner A80 SoC include an AXP806 or AXP808.
The AXP806 support used to rely on the vendor boot loader to set the
operating mode, but nowadays, mainline U-Boot (since V2016.11) is usable
on boards using the A80 SoC, but doesn't yet have any support for the
AXP806 PMIC. So for kernel 4.11, a patch went in to always set the
AXP806 to slave mode to keep those two boards working (see below). That,
however, broke support for boards where the PMIC is wired for master mode.

There are so far three boards using the AXP806 PMIC support:
- Merrii A80 Optimus and Cubieboard4 developer boards with an AXP809
  paired with an AXP806 in slave mode. A device tree for each of these
  boards have been in the tree for a while now.
- Sunchip CX-A99 which uses just an AXP808 in master mode. An
  out-of-tree device tree works with the 4.9.9 and 4.10-rc7 kernels.
  A device tree will be submitted along with support for *-supply
  properties taking a regulator list.

The default needs to be slave mode for compatibility with the two boards'
device trees that are using the "xpowers,axp806" compatible since kernel
4.9 when the AXP806 support was added.

Patch 1 adds the "xpowers,master-mode" property to the AXP806 binding.
Patch 2 adds support for it to the axp20x driver.

Rask Ingemann Lambertsen (2):
  dts: mfd: axp20x: Add xpowers,master-mode property for AXP806 PMICs
  mfd: axp20x: Add support for dts property "xpowers,master-mode"

 Documentation/devicetree/bindings/mfd/axp20x.txt |  3 +++
 drivers/mfd/axp20x.c                             | 21 +++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.10.2
