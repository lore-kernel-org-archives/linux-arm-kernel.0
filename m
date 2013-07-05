From: wangyuhang2014@gmail.com (yuhang wang)
Date: Fri, 5 Jul 2013 18:24:40 +0800
Subject: SPI: DUAL/QUAD support
In-Reply-To: <51D69197.7060802@ti.com>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
 <20130704130017.GA25997@sig21.net>
 <OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
 <20130704154927.GE27646@sirena.org.uk>
 <OFAD729A05.8C915625-ONC1257B9E.00576B25-C1257B9E.0058477D@rohde-schwarz.com>
 <CAHSAbzOg+uHndydSC43moF7pijc67pqzB2rPnY69ynXHEzw79g@mail.gmail.com>
 <51D67851.8020402@ti.com>
 <CAHSAbzNvMo_oeaqtzO8-xDm-L-f8wVccVqfuVqbR=OwqWJhVwg@mail.gmail.com>
 <51D689F3.3070605@ti.com>
 <CAHSAbzM1PGoMXFNOmB7guDsVWYnRoRy89-bufHYpPz5+odnd8w@mail.gmail.com>
 <51D68D14.7090606@ti.com>
 <CAHSAbzMfvfdDtTh=3zeBni4fNMAHEMdTJLJU-Oc13HJUqCUj0A@mail.gmail.com>
 <51D69197.7060802@ti.com>
Message-ID: <CAHSAbzP1-RVot+hhtY_DcBK=u5n2234eb9WOKLESwvUNax7+pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/5 Sourav Poddar <sourav.poddar@ti.com>:
> On Friday 05 July 2013 02:47 PM, yuhang wang wrote:
>>
>> 2013/7/5 Sourav Poddar<sourav.poddar@ti.com>:
>>>
>>> On Friday 05 July 2013 02:37 PM, yuhang wang wrote:
>>>>>
>>>>>                       if (!quad_mode)
>>>>>                               dra7xxx_writel(qspi, qspi->cmd |
>>>>> QSPI_RD_SNGL,
>>>>>                                               QSPI_SPI_CMD_REG);
>>>>>                       else
>>>>>                               dra7xxx_writel(qspi, qspi->cmd |
>>>>> QSPI_RD_QUAD,
>>>>>                                               QSPI_SPI_CMD_REG);
>>>>>                    .......
>>>>>                   }
>>>>
>>>> So what do you based on to set variable quad_mode.
>>>
>>> Best way should be to check for flash device id and manufacture data.
>>> Based
>>> on which you
>>> can decide whether your flash supports quad bits or not.
>>
>> Perhaps I did not said it clearly. Your flash supports quad and you
>> set it into quad
>> mode. But how can your controller driver notice that. In other word,
>> In which way
>> provide this information from flash to spi controller.
>
> Perhaps, I understood you initial patch wrong. :(
> Yes, this is little confusing, and I am trying to figure out that.
> As of now, I have tested it with some extern variable, though
> we need to see how it can be done cleanly.
> I am trying to see if your patch can be used in some way now.
>

Got it. In fact the kernel version I am working in is 3.0.77.
And I modified m25p80.c in Ver 3.0.90 to fit to the dual and quad.
But the driver is not general because I don't find any standard for
serial-flash. Also to the member name, just as Mark said, the
meaning is not suitable enough. Finally, do not support device tree.

2 Questions here:
1.In m25p80.c probe, the kmalloc below I feel very strange.
      flash->command = kmalloc(MAX_CMD_SIZE + (flash->fast_read ? 1 : 0),
                                      GFP_KERNEL);

 (flash->fast_read ? 1 : 0) must be 0! So why do it like that.

2.Is that any need to add wait_till_ready in the erase function to wait for the
  end of erase. But it will really take a long time.

Signed-off-by: wangyuhang <wangyuhang2014@gmail.com>
---
 drivers/mtd/devices/m25p80.c |   93 ++++++++++++++++++++++++++++++++----------
 drivers/spi/spi.c            |    2 +
 include/linux/spi/spi.h      |    8 ++++
 3 files changed, 82 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 5b6b072..267c8af 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -47,6 +47,10 @@
 #define        OPCODE_CHIP_ERASE       0xc7    /* Erase whole flash chip */
 #define        OPCODE_SE               0xd8    /* Sector erase
(usually 64KiB) */
 #define        OPCODE_RDID             0x9f    /* Read JEDEC ID */
+#define        OPCODE_DOR              0x3B    /* Dual Output Read */
+#define        OPCODE_QOR              0x6B    /* Quad Output Read */
+#define        OPCODE_QPP              0x32    /* Quad Page Programming */
+#define        OPCODE_QEN              0x02 /* Quad Mode Enable Flag */

 /* Used for SST flashes only. */
 #define        OPCODE_BP               0x02    /* Byte program */
@@ -73,6 +77,14 @@
 #define        MAX_READY_WAIT_JIFFIES  (40 * HZ)       /* M25P16
specs 40s max chip erase */
 #define        MAX_CMD_SIZE            5

+#ifdef CONFIG_M25PXX_USE_FAST_READ
+#define OPCODE_READ    OPCODE_FAST_READ
+#define FAST_READ_DUMMY_BYTE 1
+#else
+#define OPCODE_READ    OPCODE_NORM_READ
+#define FAST_READ_DUMMY_BYTE 0
+#endif
+
 #define JEDEC_MFR(_jedec_id)   ((_jedec_id) >> 16)

 /****************************************************************************/
@@ -85,7 +97,9 @@ struct m25p {
        u16                     addr_width;
        u8                      erase_opcode;
        u8                      *command;
-       bool                    fast_read;
+       u8                      read_opcode;
+       u8                      read_dummy;
+       u8                      write_opcode;
 };

 static inline struct m25p *mtd_to_m25p(struct mtd_info *mtd)
@@ -94,6 +108,18 @@ static inline struct m25p *mtd_to_m25p(struct mtd_info *mtd)
 }

 /****************************************************************************/
+/*
+ * Write configuration register 2 byte
+ * Returns negative if error occurred.
+ */
+static int write_cr(struct m25p *flash, u16 val)
+{
+       flash->command[0] = OPCODE_WRSR;
+       flash->command[1] = val >> 8;
+       flash->command[2] = val;
+
+       return spi_write(flash->spi, flash->command, 3);
+}

 /*
  * Internal helper functions
@@ -336,7 +362,6 @@ static int m25p80_read(struct mtd_info *mtd,
loff_t from, size_t len,
        struct m25p *flash = mtd_to_m25p(mtd);
        struct spi_transfer t[2];
        struct spi_message m;
-       uint8_t opcode;

        pr_debug("%s: %s from 0x%08x, len %zd\n", dev_name(&flash->spi->dev),
                        __func__, (u32)from, len);
@@ -349,11 +374,12 @@ static int m25p80_read(struct mtd_info *mtd,
loff_t from, size_t len,
         * Should add 1 byte DUMMY_BYTE.
         */
        t[0].tx_buf = flash->command;
-       t[0].len = m25p_cmdsz(flash) + (flash->fast_read ? 1 : 0);
+       t[0].len = m25p_cmdsz(flash) + flash->read_dummy;
        spi_message_add_tail(&t[0], &m);

        t[1].rx_buf = buf;
        t[1].len = len;
+       t[1].bitwidth = flash->spi->rx_bitwidth;
        spi_message_add_tail(&t[1], &m);

        mutex_lock(&flash->lock);
@@ -370,15 +396,13 @@ static int m25p80_read(struct mtd_info *mtd,
loff_t from, size_t len,
         * supports that opcode.
         */

-       /* Set up the write data buffer. */
-       opcode = flash->fast_read ? OPCODE_FAST_READ : OPCODE_NORM_READ;
-       flash->command[0] = opcode;
+       /* Set up opcode in read buffer */
+       flash->command[0] = flash->read_opcode;
        m25p_addr2cmd(flash, from, flash->command);

        spi_sync(flash->spi, &m);

-       *retlen = m.actual_length - m25p_cmdsz(flash) -
-                       (flash->fast_read ? 1 : 0);
+       *retlen = m.actual_length - m25p_cmdsz(flash) - flash->read_dummy;

        mutex_unlock(&flash->lock);

@@ -409,6 +433,7 @@ static int m25p80_write(struct mtd_info *mtd,
loff_t to, size_t len,
        spi_message_add_tail(&t[0], &m);

        t[1].tx_buf = buf;
+       t[1].bitwidth = flash->spi->tx_bitwidth;
        spi_message_add_tail(&t[1], &m);

        mutex_lock(&flash->lock);
@@ -422,7 +447,7 @@ static int m25p80_write(struct mtd_info *mtd,
loff_t to, size_t len,
        write_enable(flash);

        /* Set up the opcode in the write buffer. */
-       flash->command[0] = OPCODE_PP;
+       flash->command[0] = flash->write_opcode;
        m25p_addr2cmd(flash, to, flash->command);

        page_offset = to & (flash->page_size - 1);
@@ -958,8 +983,7 @@ static int m25p_probe(struct spi_device *spi)
        flash = kzalloc(sizeof *flash, GFP_KERNEL);
        if (!flash)
                return -ENOMEM;
-       flash->command = kmalloc(MAX_CMD_SIZE + (flash->fast_read ? 1 : 0),
-                                       GFP_KERNEL);
+       flash->command = kmalloc(MAX_CMD_SIZE + FAST_READ_DUMMY_BYTE,
GFP_KERNEL);
        if (!flash->command) {
                kfree(flash);
                return -ENOMEM;
@@ -1022,16 +1046,6 @@ static int m25p_probe(struct spi_device *spi)
        flash->page_size = info->page_size;
        flash->mtd.writebufsize = flash->page_size;

-       flash->fast_read = false;
-#ifdef CONFIG_OF
-       if (np && of_property_read_bool(np, "m25p,fast-read"))
-               flash->fast_read = true;
-#endif
-
-#ifdef CONFIG_M25PXX_USE_FAST_READ
-       flash->fast_read = true;
-#endif
-
        if (info->addr_width)
                flash->addr_width = info->addr_width;
        else {
@@ -1063,6 +1077,43 @@ static int m25p_probe(struct spi_device *spi)
                                flash->mtd.eraseregions[i].erasesize / 1024,
                                flash->mtd.eraseregions[i].numblocks);

+       if ((flash->spi->rx_bitwidth == SPI_BITWIDTH_QUAD) ||
+               (flash->spi->tx_bitwidth == SPI_BITWIDTH_QUAD)) {
+               write_enable(flash);
+               write_cr(flash, OPCODE_QEN);
+       }
+
+       switch (flash->spi->rx_bitwidth) {
+       case SPI_BITWIDTH_SINGLE:
+               flash->read_opcode = OPCODE_READ;
+               flash->read_dummy = FAST_READ_DUMMY_BYTE;
+               break;
+       case SPI_BITWIDTH_DUAL:
+               flash->read_opcode = OPCODE_DOR;
+               flash->read_dummy = 1;
+               break;
+       case SPI_BITWIDTH_QUAD:
+               flash->read_opcode = OPCODE_QOR;
+               flash->read_dummy = 1;
+               break;
+       default:
+               dev_err(&spi->dev, "invalid rx_bitwidth %d\n",
+                       flash->spi->rx_bitwidth);
+               return -EINVAL;
+       }
+
+       switch (flash->spi->tx_bitwidth) {
+       case SPI_BITWIDTH_SINGLE:
+               flash->write_opcode = OPCODE_PP;
+               break;
+       case SPI_BITWIDTH_QUAD:
+               flash->write_opcode = OPCODE_QPP;
+               break;
+       default:
+               dev_err(&spi->dev, "invalid tx_bitwidth %d\n",
+                       flash->spi->tx_bitwidth);
+               return -EINVAL;
+       }

        /* partitions should match sector boundaries; and it may be good to
         * use readonly partitions for writeprotected sectors (BP2..BP0).
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 004b10f..cd99022 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -452,6 +452,8 @@ struct spi_device *spi_new_device(struct spi_master *master,
        proxy->irq = chip->irq;
        strlcpy(proxy->modalias, chip->modalias, sizeof(proxy->modalias));
        proxy->dev.platform_data = (void *) chip->platform_data;
+       proxy->rx_bitwidth = chip->rx_bitwidth;
+       proxy->tx_bitwidth = chip->tx_bitwidth;
        proxy->controller_data = chip->controller_data;
        proxy->controller_state = NULL;

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 38c2b92..ddcf308 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -93,6 +93,8 @@ struct spi_device {
        void                    *controller_data;
        char                    modalias[SPI_NAME_SIZE];
        int                     cs_gpio;        /* chip select gpio */
+       u8                      rx_bitwidth;
+       u8                      tx_bitwidth;

        /*
         * likely need more hooks for more protocol options affecting how
@@ -511,6 +513,10 @@ struct spi_transfer {
        dma_addr_t      rx_dma;

        unsigned        cs_change:1;
+       u8              bitwidth;
+#define        SPI_BITWIDTH_SINGLE     0x01; /* 1bit transfer */
+#define        SPI_BITWIDTH_DUAL       0x02; /* 2bits transfer */
+#define        SPI_BITWIDTH_QUAD       0x03; /* 4bits transfer */
        u8              bits_per_word;
        u16             delay_usecs;
        u32             speed_hz;
@@ -859,6 +865,8 @@ struct spi_board_info {
         * where the default of SPI_CS_HIGH = 0 is wrong.
         */
        u8              mode;
+       u8              rx_bitwidth;
+       u8              tx_bitwidth;

        /* ... may need additional spi_device chip config data here.
         * avoid stuff protocol drivers can set; but include stuff
