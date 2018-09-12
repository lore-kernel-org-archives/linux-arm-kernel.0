From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 12 Sep 2018 09:51:08 +0200
Subject: [PATCH v3 00/21] nvmem: rework of the subsystem for non-DT users
Message-ID: <20180912075129.25185-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series contains nvmem framework changes prerequisite for further
development of my previous series[1] that aims at removal of the
platform data struct from at24 EEPROM driver.

The patches are conceptually split into a couple groups.

First five patches fix issues with existing issues.

Patch 6 switches the nvmem providers to using kref which is necessary
for removal of the return value from nvmem_unregister(). This is an
approach similar to the one used in the clock framework where the
provider is only removed after the last reference to it is dropped.

Patches 7-9 convert last remaining users of nvmem_unregister() who
still check its return value to using devm_nvmem_unregister() and
patch 10 changes its return value from int to void.

Patches 11-14 introduce the most significant changes of this series:
we remove the global cell list, add support for static cell definitions
external to the provider structure, change the way DT lookup works and
allow to associate resources and consumers using lookup tables. The way
nvmem_cell_get() for non-DT users is changed but there are no current
users and it's currently broken anyway (cell being removed after a call
to nvmem_cell_put()).

Patch 15 updates the documentation.

Patch 16 adds support for notifiers to nvmem so that users can
subscribe for events such as device or cell registration or removal.

Patches 17 & 18 add some minor improvements to the codebase.

Last three patches contain fixes to warnings emitted by checkpatch.
It's a good moment to add them if we're already touching a big part
of the subsystem's code.

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

v2 -> v3:
- dropped the patch removing unused APIs and introduced changes on top of
  existing code instead
- fixed nvmem provider reference decreasing in error paths
- added checkpatch fixes
- removed nvmem-machine.h and distributed new definitions among existing
  consumer and provider headers
- reordered patches thematically
- added more patches fixing issues in existing codebase

Bartosz Golaszewski (21):
  nvmem: provide nvmem_dev_name()
  nvmem: remove the name field from struct nvmem_device
  nvmem: use list_for_each_entry_safe in nvmem_device_remove_all_cells()
  nvmem: remove a stray newline
  nvmem: check the return value of nvmem_add_cells()
  nvmem: use kref
  nvmem: lpc18xx_eeprom: use devm_nvmem_register()
  nvmem: sunxi_sid: use devm_nvmem_register()
  nvmem: mxs-ocotp: use devm_nvmem_register()
  nvmem: change the signature of nvmem_unregister()
  nvmem: remove the global cell list
  nvmem: add support for cell info
  nvmem: resolve cells from DT at registration time
  nvmem: add support for cell lookups from machine code
  Documentation: nvmem: document cell tables and lookup entries
  nvmem: add a notifier chain
  nvmem: use SPDX license identifiers
  nvmem: make the naming of arguments in nvmem_cell_get() consistent
  nvmem: use EOPNOTSUPP instead of ENOSYS
  nvmem: fix commenting style
  nvmem: use octal permissions instead of constants

 Documentation/nvmem/nvmem.txt  |  31 ++
 drivers/nvmem/core.c           | 527 ++++++++++++++++++++++-----------
 drivers/nvmem/lpc18xx_eeprom.c |   6 +-
 drivers/nvmem/mxs-ocotp.c      |   4 +-
 drivers/nvmem/sunxi_sid.c      |  20 +-
 include/linux/nvmem-consumer.h | 100 +++++--
 include/linux/nvmem-provider.h |  49 +--
 7 files changed, 497 insertions(+), 240 deletions(-)

-- 
2.18.0
