From: ben@decadent.org.uk (Ben Hutchings)
Date: Tue, 30 Sep 2014 03:13:42 +0100
Subject: [PATCH v2 0/5] m25p80,spi-nor: Fix module aliases for m25p80; clean
 up chip identification
Message-ID: <1412043222.9388.81.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch in the series restores the module aliases to m25p80, but
it does so by duplicating the list of names.  This should be suitable
for stable, but it isn't viable in the longer term.

The following patches change the spi-nor interface so that this
duplication is no longer necessary.  This includes removing
spi_nor::read_id, but it could be re-added after this with a different
interface, e.g. returning a flash_info structure (which would need to be
defined in spi_nor.h).

v2: Rebase onto l2-mtd/master.
    Put all the flash information into spi-nor.h rather than using an
    elaborate set of macros to validate names in spi-nor.c.

These patches are still untested by me, aside from compiling and
checking that m25p80 has the expected module aliases.

Ben.

Ben Hutchings (5):
  m25p80,spi-nor: Fix module aliases for m25p80
  spi-nor: Remove spi_nor::read_id operation
  spi-nor: Make spi_nor_scan() take a chip type name, not an
    spi_device_id
  spi-nor: Replace struct spi_device_id with struct flash_info
  m25p80,spi-nor: Share the list of supported chip type names again

 drivers/mtd/devices/m25p80.c      |  21 +++-
 drivers/mtd/spi-nor/fsl-quadspi.c |   7 +-
 drivers/mtd/spi-nor/spi-nor.c     | 251 +++++++-------------------------------
 include/linux/mtd/spi-nor.h       | 191 ++++++++++++++++++++++++++---
 4 files changed, 232 insertions(+), 238 deletions(-)


-- 
Ben Hutchings
The two most common things in the universe are hydrogen and stupidity.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/1934326d/attachment.sig>
