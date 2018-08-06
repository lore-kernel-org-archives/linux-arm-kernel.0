From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Tue,  7 Aug 2018 00:29:06 +0200
Subject: [RFC PATCH v2] mtd: rawnand: ams-delta: Use GPIO API for data I/O
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Message-ID: <20180806222918.12644-1-jmkrzyszt@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the idea suggested by Artem Bityutskiy and Tony Lindgren,
described in commit b027274d2e3a ("mtd: ams-delta: fix
request_mem_region() failure"). Use pure GPIO API as suggested by
Boris Brezillon.


Janusz Krzysztofik (12):
      mtd: rawnand: ams-delta: Assign mtd->dev.parent, not mtd->owner
      mtd: rawnand: ams-delta: Use private structure
      ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
      mtd: rawnand: ams-delta: request data port GPIO resource
      mtd: rawnand: ams-delta: use GPIO API for data read/write
      ARM: OMAP1: ams-delta: drop obsolete NAND resources
      mtd: rawnand: ams-delta: Set port direction once per transfer
      mtd: rawnand: ams-delta: Simplify pointer resolution on read/write
      gpiolib: Identify GPIO descriptor arrays with direct mapping
      gpiolib: Introduce bitmap get/set array API extension
      mtd: rawnand: ams-delta: Use GPIO API bitmap extension
      gpiolib: Add fast processing path to bitmap API functions


Changelog:
v2:
[RFC PATCH v2 00/12] mtd: rawnand: ams-delta: Use GPIO API for data I/O
- renamed from former [RFC PATCH 0/8] mtd: rawnand: ams-delta: Use
  gpio-omap accessors for data I/O
[RFC PATCH v2 01/12] mtd: rawnand: ams-delta: Assign mtd->dev.parent,
			not mtd->owner
- split out from former [RFC PATCH 1/8] on Boris request, thanks.
[RFC PATCH v2 02/12] mtd: rawnand: ams-delta: Use private structure
- remaining part of the former [RFC PATCH 1/8].
[RFC PATCH v2 03/12] ARM: OMAP1: ams-delta: Provide GPIO lookup table
			for NAND data port
- split out from former [RFC PATCH 5/8] on Boris requesst, thanks,
[RFC PATCH v2 04/12] mtd: rawnand: ams-delta: request data port GPIO resource
- remaining part of the former [RFC PATCH 5/8],
[RFC PATCH v2 05/12] mtd: rawnand: ams-delta: use GPIO API for data read/write
- reworked from former [RFC PATCH 8/8] on Boris requesst to use pure
  GPIO API, thanks,
- moved up in front of former [RFC PATCH 3/8] on Boris request, thanks.
[RFC PATCH v2 06/12] ARM: OMAP1: ams-delta: drop obsolete NAND resources
- split out from former [RFC PATCH 8/8].
[RFC PATCH v2 07/12] mtd: rawnand: ams-delta: Set port direction once per
			transfer
- reworked from former [RFC PATCH 3/8] on top of [RFC PATCH v2 05/12].
[RFC PATCH v2 08/12] mtd: rawnand: ams-delta: Simplify pointer resolution
			on read/write
- reworked from former [RFC PATCH 4/8] on top of [RFC PATCH v2 08/12],
- renamed from 'Optimize' to 'Simplify' on Boris request, thanks.
[RFC PATCH v2 09/12] gpiolib: Identify GPIO descriptor arrays with direct
			mapping
- new patch.
[RFC PATCH v2 10/12] gpiolib: Introduce bitmap get/set array API extension
- new patch.
[RFC PATCH v2 11/12] mtd: rawnand: ams-delta: Use GPIO API bitmap extension
- new patch.
[RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap API functions
- new patch.
Removed from the series:
[RFC PATCH 2/8] mtd: rawnand: ams-delta: Write protect device during probe
- postponed on Boris request, thanks.
[RFC PATCH 6/8] gpio: omap: Add get/set_multiple() callbacks
- already applied by Linux in linux-gpio tree, thanks.
[RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data GPIO resource
- most controversial one, no longer needed after switching to GPIO API.


diffstat:
 Documentation/driver-api/gpio/consumer.rst |   36 ++
 arch/arm/mach-omap1/board-ams-delta.c      |   22 -
 drivers/gpio/gpiolib.c                     |  237 +++++++++++++++++++
 drivers/mtd/nand/raw/ams-delta.c           |  350 +++++++++++++++--------------
 include/linux/gpio/consumer.h              |   15 +
 5 files changed, 485 insertions(+), 175 deletions(-)
