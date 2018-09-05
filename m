From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed,  5 Sep 2018 11:57:25 +0200
Subject: [PATCH 00/13] nvmem: rework of the subsystem for non-DT users
Message-ID: <20180905095738.26406-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series contains nvmem framework changes prerequisite for further
development of my previous series[1] that aims at removal of the
platform data struct from at24 EEPROM driver.

First we remove unused APIs and the global cell list. We then switch
to using kref instead of manual user counting. Next we simplify the
provider unregistration by removing the return value from
nvmem_unregister().

Next three patches improve the framework by adding a notifier chain
for future use and fixing the issue with nvmem device names.

Finally we add support for cell definitions, cell lookups and make
DT systems resolve the nvmem cells during provider's registration.

Last patch just uses the SPDX license identifiers.

Tested both DT and non-DT use cases.

[1] https://lkml.org/lkml/2018/8/10/149

Bartosz Golaszewski (13):
  nvmem: remove unused APIs
  nvmem: remove the global cell list
  nvmem: use kref
  nvmem: lpc18xx_eeprom: use devm_nvmem_register()
  nvmem: change the signature of nvmem_unregister()
  nvmem: provide nvmem_dev_name()
  nvmem: remove the name field from struct nvmem_device
  nvmem: add a notifier chain
  nvmem: add support for cell info
  nvmem: resolve cells from DT at registration time
  nvmem: add support for cell lookups from machine code
  Documentation: nvmem: document cell tables and lookup entries
  nvmem: use SPDX license identifiers

 Documentation/nvmem/nvmem.txt  |  30 ++
 MAINTAINERS                    |   1 +
 drivers/nvmem/core.c           | 650 ++++++++++++++++++---------------
 drivers/nvmem/lpc18xx_eeprom.c |   6 +-
 include/linux/nvmem-consumer.h |  50 ++-
 include/linux/nvmem-machine.h  |  56 +++
 include/linux/nvmem-provider.h |  22 +-
 7 files changed, 465 insertions(+), 350 deletions(-)
 create mode 100644 include/linux/nvmem-machine.h

-- 
2.18.0
