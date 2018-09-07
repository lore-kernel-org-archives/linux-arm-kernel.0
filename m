From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri,  7 Sep 2018 12:07:34 +0200
Subject: [PATCH v2 00/16] nvmem: rework of the subsystem for non-DT users
Message-ID: <20180907100750.14564-1-brgl@bgdev.pl>
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

Last patches just use the SPDX license identifiers and make the
naming convention for some arguments more consistent.

Tested both DT and non-DT use cases.

[1] https://lkml.org/lkml/2018/8/10/149

v1 -> v2:
- extended the lookup structure with a proper con_id independent from the
  cell name defined in the cell definition table
- added a patch that makes the naming convention for the cell name argument
  in the nvmem_cell_get() family of functions consistent
- there were two users of nvmem_unregister() that still checked the return
  value, now switched to devm_nvmem_register()
- fixed build failures reported by kbuild test robot

Bartosz Golaszewski (16):
  nvmem: remove unused APIs
  nvmem: remove the global cell list
  nvmem: use kref
  nvmem: lpc18xx_eeprom: use devm_nvmem_register()
  nvmem: sunxi_sid: use devm_nvmem_register()
  nvmem: mxs-ocotp: use devm_nvmem_register()
  nvmem: change the signature of nvmem_unregister()
  nvmem: provide nvmem_dev_name()
  nvmem: remove the name field from struct nvmem_device
  nvmem: add a notifier chain
  nvmem: add support for cell info
  nvmem: resolve cells from DT at registration time
  nvmem: add support for cell lookups from machine code
  Documentation: nvmem: document cell tables and lookup entries
  nvmem: use SPDX license identifiers
  nvmem: make the naming of arguments in nvmem_cell_get() consistent

 Documentation/nvmem/nvmem.txt  |  31 ++
 MAINTAINERS                    |   1 +
 drivers/nvmem/core.c           | 676 ++++++++++++++++++---------------
 drivers/nvmem/lpc18xx_eeprom.c |   6 +-
 drivers/nvmem/mxs-ocotp.c      |   4 +-
 drivers/nvmem/sunxi_sid.c      |  20 +-
 include/linux/nvmem-consumer.h |  62 ++-
 include/linux/nvmem-machine.h  |  57 +++
 include/linux/nvmem-provider.h |  27 +-
 9 files changed, 493 insertions(+), 391 deletions(-)
 create mode 100644 include/linux/nvmem-machine.h

-- 
2.18.0
