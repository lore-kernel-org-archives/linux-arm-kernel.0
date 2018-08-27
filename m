From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Mon, 27 Aug 2018 13:26:41 +0300
Subject: [RESEND PATCH v2 0/3] add support to non-uniform SFDP SPI NOR flash
 memories
Message-ID: <20180827102644.7323-1-tudor.ambarus@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rebased on spi-nor/next.

Backward compatibility test done on mx25l3273fm2i-08g.
Non-uniform erase test done on sst26vf064b-104i/sn.

Note that in order to do the non-uniform test you'll have to force the
spi_nor_has_uniform_erase() to return false, because the erase map is
tuned to come back to the uniform case. Also, for the SST flashes, you'll
have to unlock the global protection (see https://www.spinics.net/lists/arm-kernel/msg666350.html).

Changes in v2:
- add JESD216B SFDP optional parsers: Sector Map Parameter Table parser and
  4-byte Address Instruction Table parser (patch 2/3 and patch 3/3).

- save the Erase Types from bfpt to determine the Erase Type sizes. Sort all
  the map's Erase Types in ascending order with the smallest erase size being
  the first member in the erase_type array. Sort in the same way the Erase Type
  mask in regions in order to have a 1-to-1 correspondence with the Erase
  Types defined in the map. We sort the Erase Type by size, at init, in order to
  speed up the process of finding the best erase command at run-time.

- remove setting of mtd->erasesize and nor->erase_opcode when parsing the Basic
  Flash Parameter Table. mtd->erasesize was set to the maximum supported Erase
  Type size, without verifying if that Erase Type can erase the entire flash.
  mtd->erasesize is now set just in spi_nor_select_erase(), after we find which
  Erase Types are supported in the uniform case.

- spi_nor_select_erase(): pass directly info->sector_size instead of the whole
  flash_info structure in order to simplify the code.

- fix condition on finding erase regions:
  while (addr < region_start || addr >= region_end) {
- fix the list command adding: list_add_tail() instead of list_add()
- write_enable(nor); before erasing the sectors
- As Boris suggested, remove likely() because it doesn't make any difference
  given the time it takes to actually erase the block.
- bool return value for spi_nor_has_uniform_erase().

Changes in v1 or what I've done on top of Cyrille's work (https://lkml.org/lkml/2017/4/15/70):
- minimize the amount of erase() calls by using the best sequence of erase
  type commands depending on alignment.
- build the list of best fitted erase commands to be executed once we
  validate that the erase can be performed.
- add improvements on how the erase map is handled. The regions are
  consecutive in the address space, walk through the regions incrementally.
- speed up finding the best erase type command. Order erase types by
  size, iterate them from the biggest to the smallest and stop when best
  fitted command is found.
- determine at init if there are erase types that can erase the entire
  memory
- fix support for overlaid regions.


Cyrille Pitchen (1):
  mtd: spi-nor: parse SFDP 4-byte Address Instruction Table

Tudor Ambarus (2):
  mtd: spi-nor: add support to non-uniform SFDP SPI NOR flash memories
  mtd: spi-nor: parse SFDP Sector Map Parameter Table

 drivers/mtd/spi-nor/spi-nor.c | 892 +++++++++++++++++++++++++++++++++++++++---
 include/linux/mtd/spi-nor.h   | 120 ++++++
 2 files changed, 954 insertions(+), 58 deletions(-)

-- 
2.9.4
