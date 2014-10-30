From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 30 Oct 2014 11:21:23 +0100
Subject: [PATCH v3 0/5] Berlin BG2 AHCI and SATA PHY
In-Reply-To: <1413882477-27922-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413882477-27922-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1414664488-5911-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is v3 of the catch up with latest Berlin improvements
provided by Antoine - in particular SATA PHY support and AHCI generic
for Berlin BG2.

Marvell BSP code for BG2 suggests more differences between the two
PHY revisions found on BG2 and BG2Q, but the only important one seems
to be the PHY_BASE used in AHCI vendor-specific registers. I also
confirmed that power_off does indeed power off the PHY on BG2, too
(It wasn't very clear in BSP code).

Anyway, I have tested this on BG2-based Sony NSZ-GS7 and attached
SATA HDD is successfully detected and partitions are displayed.

This patch set is based on v3.18-rc1. As usual a branch based on
v3.18-rc1 can be found at

git://git.infradead.org/users/hesselba/linux-berlin.git devel/bg2-sata-v3

Compared to v1, there is only a minor change that removes an unrequired
status = "disabled" property from BG2 SATA node.
Compared to v2, BG2 PHY still uses its own compatible but the driver now
uses of_device_is_compatible instead of of_device_id.data for setting the
base address. This is the outcome of some discussion with Kishon and Felipe,
where we (hopefully) agreed on this approach. It will allow future SoC-
specific PHY setup routines if required.

Patches 1-3 should go through Kishon's PHY tree, I pick up DT patches 4
and 5.

Patch 1 prepares phy-berlin-sata to support different PHY_BASE addresses
by moving the constant to driver private data.

Patches 2 and 3 add a new compatible to driver and DT documentation that
reflects the differences between BG2Q and BG2 SATA PHY.

Patches 4 and 5 finally add DT nodes to both Berlin2 SoC dtsi and Sony
NSZ-GS7 board DT file. SATA plug on NSZ-GS7 is unpopulated but can be
very easily equipped with SATA receptable and some 0402 caps. I decided
to enable SATA by default although not all users may populate it.

Sebastian Hesselbarth (5):
  phy: berlin-sata: Move PHY_BASE into private data struct
  phy: berlin-sata: Add support for BG2 SATA PHY
  phy: berlin-sata: Document BG2 compatible
  ARM: berlin: Add AHCI and SATA PHY nodes to BG2
  ARM: berlin: Enable SATA on Sony NSZ-GS7

 .../devicetree/bindings/phy/berlin-sata-phy.txt    |  4 ++-
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts         |  7 ++++
 arch/arm/boot/dts/berlin2.dtsi                     | 39 ++++++++++++++++++++++
 drivers/phy/phy-berlin-sata.c                      | 29 +++++++++++-----
 4 files changed, 69 insertions(+), 10 deletions(-)

---
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
2.1.1
