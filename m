From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 27 Jan 2017 17:41:59 +0100
Subject: [PATCH RESEND 0/5] mtd: nand: Rework/cleanup the Atmel NAND driver
Message-ID: <1485535324-28393-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the noise, I forgot to Cc DT maintainers.

This is a complete rewrite of the driver whose main purpose is to
support the new DT representation where the NAND controller node is now
really visible in the DT and appears under the EBI bus. With this new
representation, we can add other devices under the EBI bus without
risking pinmuxing conflicts (the NAND controller is under the EBI
bus logic and as such, share some of its pins with other devices
connected on this bus).

Even though the goal of this rework was not necessarily to add new
features, the new driver has been designed with this in mind. With a
clearer separation between the different blocks and different IP
revisions, adding new functionalities should be easier (we already
have plans to support SMC timing configuration so that we no longer
have to rely on the configuration done by the bootloader/bootstrap).

Also note that we no longer have a custom ->cmdfunc() implementation,
which means we can now benefit from new features added in the core
implementation for free (support for new NAND operations for example).

The last thing that we gain with this rework is support for multi-chips
and multi-dies chips, thanks to the clean NAND controller <-> NAND
devices representation.

This new driver has been tested on several platforms (at91sam9261,
at91sam9g45, at91sam9x5, sama5d3 and sama5d4) to make sure it did not
introduce regressions, and it's worth mentioning that old bindings are
still supported (which partly explain the positive diffstat).

Here is a short description of the different patches:

Patches 1 and 2 are adding new helpers functions respectively to the
gpio and dmaengine subsystems. Note that I can put this code directly
in my driver but I had the impression these would better fit in the
dmaengine and gpio subsystem.
Alexandre, Linus, Vinod, let me know if you think I should keep this
code in my driver.

Patch 3 is the bulk of the work. As said above, it's a complete rewrite
of the existing driver, and patch 4 is documenting the new bindings.

And finally, patch 5 is removing the chip->write_page() whose only user
was the Atmel NAND driver.

Wenyou, Nicolas, Josh, I'd really appreciate if you could review this
series carefully (especially patch 3).

Haarvard, Hans-Christian, I only compile-tested for avr32. Can you test
it on a real platform?

Thanks,

Boris

Boris Brezillon (5):
  gpio: Add the devm_get_index_gpiod_from_child() helper
  dmaengine: Provide a wrapper for memcpy operations
  mtd: nand: Cleanup/rework the atmel_nand driver
  mtd: nand: atmel: Document the new DT bindings
  mtd: nand: Remove unused chip->write_page() hook

 .../devicetree/bindings/mtd/atmel-nand.txt         |  106 +-
 MAINTAINERS                                        |    2 +-
 drivers/gpio/devres.c                              |   30 +-
 drivers/gpio/gpiolib.c                             |    9 +-
 drivers/mtd/nand/Makefile                          |    2 +-
 drivers/mtd/nand/atmel/Makefile                    |    4 +
 drivers/mtd/nand/atmel/nfc.c                       | 2168 +++++++++++++++++
 drivers/mtd/nand/atmel/pmecc.c                     | 1011 ++++++++
 drivers/mtd/nand/atmel/pmecc.h                     |   73 +
 drivers/mtd/nand/atmel_nand.c                      | 2479 --------------------
 drivers/mtd/nand/atmel_nand_ecc.h                  |  163 --
 drivers/mtd/nand/atmel_nand_nfc.h                  |  103 -
 drivers/mtd/nand/nand_base.c                       |   10 +-
 include/linux/dmaengine.h                          |   11 +
 include/linux/gpio/consumer.h                      |   15 +-
 include/linux/mtd/nand.h                           |    4 -
 16 files changed, 3421 insertions(+), 2769 deletions(-)
 create mode 100644 drivers/mtd/nand/atmel/Makefile
 create mode 100644 drivers/mtd/nand/atmel/nfc.c
 create mode 100644 drivers/mtd/nand/atmel/pmecc.c
 create mode 100644 drivers/mtd/nand/atmel/pmecc.h
 delete mode 100644 drivers/mtd/nand/atmel_nand.c
 delete mode 100644 drivers/mtd/nand/atmel_nand_ecc.h
 delete mode 100644 drivers/mtd/nand/atmel_nand_nfc.h

-- 
2.7.4
