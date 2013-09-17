From: sourav.poddar@ti.com (Sourav Poddar)
Date: Wed, 18 Sep 2013 01:24:49 +0530
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130917164935.GG14747@book.gsilab.sittig.org>
References: <20130912205644.GW29403@sirena.org.uk>
 <52329AD3.2050608@freescale.com> <20130913102127.GD29403@sirena.org.uk>
 <52366F97.5030402@freescale.com> <20130916101912.GY29403@sirena.org.uk>
 <5236DD17.5090203@freescale.com> <20130916110634.GC29403@sirena.org.uk>
 <5237BB01.3080700@freescale.com> <20130917105142.GO21013@sirena.org.uk>
 <20130917150548.GE14747@book.gsilab.sittig.org>
 <20130917164935.GG14747@book.gsilab.sittig.org>
Message-ID: <5238B389.3090302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Tuesday 17 September 2013 10:19 PM, Gerhard Sittig wrote:
> On Tue, Sep 17, 2013 at 17:05 +0200, Gerhard Sittig wrote:
>> I liked the S25F datasheet that was referenced here recently,
>> it's useful for the discussion that is going on here.  I liked
>> the "Serial Peripheral Interface with Multi-I/O" subtitle, which
>> suggests that SPI gets enhanced while nothing of it is specific
>> to flash chips.  And I liked the sequence diagrams for their
>> overview or introduction nature, which you can compare to the SPI
>> message submission API in the Linux kernel which connects SPI
>> slave drivers and SPI controller drivers.
> noticed that I should have provided the URL so those interested
> need not search in the thread
>
> www.spansion.com/Support/Datasheets/S25FL128S_256S_00.pdf
>
>> The datasheet had "block diagrams" (section 3.16) [ ... ]
>> And the datasheet had "sequence diagrams" (section 4.2.1) [ ... ]
>
> and the relevant design items for the SPI subsystem are:
> - express those "phases" of communicating a flash chip related
>    "command" in terms of SPI message submission data structures
>    (spi_message, spi_transfer)
> - make new SPI master drivers support the optional data rate,
>    multi-line transfer, dummy bit times, etc features _if_ their
>    controller hardware supports them
> - announce support of these optional features such that slave
>    drivers can query them
> - make SPI slave drivers (specifically SPI attached MTD, i.e.
>    m25p80) map their flash access operations to respective SPI
>    transactions, by introducing an appropriate translation helper
>
> and keep all of the "enhanced modes of SPI communication"
> independent from their motivation by and use in flash chip
> drivers
>
> and keep internals of one specific flash chip instruction set out
> of the SPI transport layer
>
Stuffs for using dual/quad lines are already present in the SPI 
framework(3.12-rc1)
Here is the patch[1] that enables quad mode and are more or less use
the ideas you suggested above. The patch is based on 3.12-rc1.

Your board file should define "spi-tx-bus-width" and "spi-rx-bus-width". 
Based on this,
spi->mode will be set in drivers/spi/spi.c. Once this mode is set, we 
can use
this in our m25p80 driver to enable quad mode and to set the mtd read 
pointer to
quad read.

Next point is the communication between the mtd layer and the qspi 
driver layer about
the read command (Normal/dual/quad) to use. For this, there is already a 
field added in
spi_transfer(tx_nbits/rx_nbits). We can set this field to 1, 2 and 4 
etc.. for normal, dual
and quad read.

[1]:

 From bd285ebf55a48d16675b92be0f101be7642f6fb2 Mon Sep 17 00:00:00 2001
From: Sourav Poddar <sourav.poddar@ti.com>
Date: Wed, 7 Aug 2013 11:15:41 +0530
Subject: [PATCH] drivers: mtd: devices: Add quad read support.

Some flash also support quad read mode.
Adding support for adding quad mode in m25p80.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
  drivers/mtd/devices/m25p80.c |   87 
++++++++++++++++++++++++++++++++++++++----
  1 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 26b14f9..fb9058d 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -41,6 +41,7 @@
  #define    OPCODE_WRSR        0x01    /* Write status register 1 byte */
  #define    OPCODE_NORM_READ    0x03    /* Read data bytes (low 
frequency) */
  #define    OPCODE_FAST_READ    0x0b    /* Read data bytes (high 
frequency) */
+#define OPCODE_QUAD_READ    0x6b    /* QUAD READ */
  #define    OPCODE_PP        0x02    /* Page program (up to 256 bytes) */
  #define    OPCODE_BE_4K        0x20    /* Erase 4KiB block */
  #define    OPCODE_BE_4K_PMC    0xd7    /* Erase 4KiB block on PMC chips */
@@ -95,6 +96,7 @@ struct m25p {
      u8            program_opcode;
      u8            *command;
      bool            fast_read;
+    bool            quad_read;
  };

  static inline struct m25p *mtd_to_m25p(struct mtd_info *mtd)
@@ -336,6 +338,67 @@ static int m25p80_erase(struct mtd_info *mtd, 
struct erase_info *instr)
      return 0;
  }

+static int quad_enable(struct m25p *flash)
+{
+    u8 cmd[3];
+    cmd[0] = OPCODE_WRSR;
+    cmd[1] = 0x00;
+    cmd[2] = 0x02;
+
+    write_enable(flash);
+
+    spi_write(flash->spi, &cmd, 3);
+
+    if (wait_till_ready(flash))
+        return 1;
+
+    return 0;
+}
+
+static int m25p80_quad_read(struct mtd_info *mtd, loff_t from, size_t len,
+    size_t *retlen, u_char *buf)
+{
+    struct m25p *flash = mtd_to_m25p(mtd);
+    struct spi_transfer t[2];
+    struct spi_message m;
+    uint8_t opcode;
+
+    pr_debug("%s: %s from 0x%08x, len %zd\n", dev_name(&flash->spi->dev),
+            __func__, (u32)from, len);
+
+    spi_message_init(&m);
+    memset(t, 0, (sizeof t));
+
+    t[0].tx_buf = flash->command;
+    t[0].len = from;
+    spi_message_add_tail(&t[0], &m);
+
+    t[1].rx_nbits = SPI_NBITS_QUAD;
+    t[1].rx_buf = buf;
+    t[1].len = len;
+    spi_message_add_tail(&t[1], &m);
+
+    mutex_lock(&flash->lock);
+
+    /* Wait till previous write/erase is done. */
+    if (wait_till_ready(flash)) {
+        mutex_unlock(&flash->lock);
+        return 1;
+    }
+
+    opcode = OPCODE_QUAD_READ;
+    flash->command[0] = opcode;
+    m25p_addr2cmd(flash, from, flash->command);
+
+    spi_sync(flash->spi, &m);
+
+    *retlen = len;
+
+    mutex_unlock(&flash->lock);
+
+    return 0;
+}
+
  /*
   * Read an address range from the flash chip.  The address range
   * may be any size provided it is within the physical boundaries.
@@ -979,15 +1042,9 @@ static int m25p_probe(struct spi_device *spi)
          }
      }

-    flash = kzalloc(sizeof *flash, GFP_KERNEL);
+    flash = devm_kzalloc(&spi->dev, sizeof *flash, GFP_KERNEL);
      if (!flash)
          return -ENOMEM;
-    flash->command = kmalloc(MAX_CMD_SIZE + (flash->fast_read ? 1 : 0),
-                    GFP_KERNEL);
-    if (!flash->command) {
-        kfree(flash);
-        return -ENOMEM;
-    }

      flash->spi = spi;
      mutex_init(&flash->lock);
@@ -1015,7 +1072,14 @@ static int m25p_probe(struct spi_device *spi)
      flash->mtd.flags = MTD_CAP_NORFLASH;
      flash->mtd.size = info->sector_size * info->n_sectors;
      flash->mtd._erase = m25p80_erase;
-    flash->mtd._read = m25p80_read;
+
+    flash->quad_read = false;
+    if (spi->mode && SPI_RX_QUAD) {
+        quad_enable(flash);
+        flash->mtd._read = m25p80_quad_read;
+        flash->quad_read = true;
+    } else
+        flash->mtd._read = m25p80_read;

      /* flash protection support for STmicro chips */
      if (JEDEC_MFR(info->jedec_id) == CFI_MFR_ST) {
@@ -1067,6 +1131,13 @@ static int m25p_probe(struct spi_device *spi)

      flash->program_opcode = OPCODE_PP;

+    flash->command = kmalloc(MAX_CMD_SIZE + (flash->fast_read ? 1 :
+                (flash->quad_read ? 1 : 0)), GFP_KERNEL);
+    if (!flash->command) {
+        kfree(flash);
+        return -ENOMEM;
+    }
+
      if (info->addr_width)
          flash->addr_width = info->addr_width;
      else if (flash->mtd.size > 0x1000000) {
-- 
1.7.1


> virtually yours
> Gerhard Sittig
