From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 16 Jul 2018 16:41:43 +0200
Subject: [PATCH v3 00/23] Add multi-channel support to Armada thermal driver
Message-ID: <20180716144206.30985-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only capability of the Armada thermal driver is currently just to
read one sensor (the default one) per AP and one per CP. Actually,
there is one sensor per core in the AP806 plus one sensor in the
thermal IP itself. The CP110 just features one thermal sensor in its
own thermal IP.

This series first improves the readability of this driver, then adds
support for multi-channel thermal IPs. The bindings and the
device-trees are updated accordingly.

Thank you,
Miqu?l


Changes since v3:
=================
- Removed the mention about the overheat interrupt in the commit log of
  "dt-bindings: thermal: armada: add reference to new bindings". This
  interrupt will be added in another series.

Changes since v2:
=================
* Fixed typos in "thermal: armada: convert driver to syscon  register
  accesses" commit log.
* Added Rob's RB tags after changing the node names both in the
  Documentation and in the DT files this way:
  s/xx_thermal: xx_thermal at yy/xx_thermal: thermal-sensor at yy/
* Dropped the patch that renamed labels in the Documentation on Rob's
  notice.
* Uniformized the type of temperature variables to 'int' as suggested in
  a previous commit from Sascha Hauer:
  17e8351a7739 ("thermal: consistently use int for temperatures")

Changes since v1:
=================
* Added register ranges in the thermal nodes.
* Added these ranges in the documentation also.
* In the bindings, used the "Must be one of" formula before listing the
  compatibles.
* Removed the overheat interrupt support that depends on another
  series. This work is independent.
* Rebased on top of v4.18-rc1.


Miquel Raynal (23):
  thermal: armada: add a function that sanitizes the thermal zone name
  thermal: armada: remove useless register accesses
  thermal: armada: remove misleading comments
  thermal: armada: rename the initialization routine
  thermal: armada: dissociate a380 and cp110 ->init() hooks
  thermal: armada: average over samples to avoid glitches
  thermal: armada: convert driver to syscon register accesses
  thermal: armada: use the resource managed registration helper
    alternative
  thermal: armada: add multi-channel sensors support
  thermal: armada: remove sensors validity from the IP initialization
  thermal: armada: move validity check out of the read function
  thermal: armada: get rid of the ->is_valid() pointer
  dt-bindings: cp110: rename cp110 syscon file
  dt-bindings: ap806: prepare the syscon file to list other syscons
    nodes
  dt-bindings: cp110: prepare the syscon file to list other syscons
    nodes
  dt-bindings: ap806: add the thermal node in the syscon file
  dt-bindings: cp110: update documentation since DT de-duplication
  dt-bindings: cp110: add the thermal node in the syscon file
  dt-bindings: thermal: armada: add reference to new bindings
  arm64: dts: marvell: move AP806/CP110 thermal nodes into a new syscon
  arm64: dts: marvell: add thermal-zone node in ap806 DTSI file
  arm64: dts: marvell: add macro to make distinction between node names
  arm64: dts: marvell: add thermal-zone node in cp110 DTSI file

 .../arm/marvell/ap806-system-controller.txt        |  48 +-
 ...controller0.txt => cp110-system-controller.txt} |  61 ++-
 .../devicetree/bindings/thermal/armada-thermal.txt |   5 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  74 ++-
 arch/arm64/boot/dts/marvell/armada-common.dtsi     |   1 +
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |  37 +-
 drivers/thermal/armada_thermal.c                   | 534 ++++++++++++++++-----
 7 files changed, 606 insertions(+), 154 deletions(-)
 rename Documentation/devicetree/bindings/arm/marvell/{cp110-system-controller0.txt => cp110-system-controller.txt} (85%)

-- 
2.14.1
