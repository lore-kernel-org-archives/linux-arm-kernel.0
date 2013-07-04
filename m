From: wangyuhang2014@gmail.com (yuhang wang)
Date: Thu, 4 Jul 2013 19:36:48 +0800
Subject: SPI: DUAL/QUAD support
Message-ID: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for your reply.
I have added the kerneldoc into the patch below to explain the "DUAL"
and "QUAD" modes.
Hope for your suggestions.

Documentation/spi/spi-dual_quad |  102 +++++++++++++++++++++++++++++++++++++++
 drivers/mtd/devices/m25p80.c    |    2 +
 drivers/spi/spi.c               |    2 +
 include/linux/spi/spi.h         |    8 +++
 4 files changed, 114 insertions(+)
 create mode 100644 Documentation/spi/spi-dual_quad

diff --git a/Documentation/spi/spi-dual_quad b/Documentation/spi/spi-dual_quad
new file mode 100644
index 0000000..06a2f9e
--- /dev/null
+++ b/Documentation/spi/spi-dual_quad
@@ -0,0 +1,102 @@
+spi-dual_quad: make spi support DUAL/QUAD
+============================================
+
+Description
+----------------------
+DUAL/QUAD means spi can transfer in 2bits/4bits at the same time.
+These spi controllers provide 8 data lines(4-tx and 4-rx). User can
+choose tranfer mode(SINGLE/DUAL/QUAD) by setting the certain register.
+Though SPI is a serial interface, some spi controllers can support
+transmitting and receiving in DUAL and QUAD modes aimed to improve
+the performance. Also as spi slave lots of flashes do support this attribute,
+such as serial-norflash in spansion company.
+
+Serial-flash such as s25fl129p in spansion company.
+In common way, the flash has two data pins(IO0,IO1) supporting SINGLE/DUAL.
+The flash also can work in QUAD mode, there are still other two
pins(HOLD,W#)which
+in other usage will be regarded as data pins.
+
+The members added below is used to provide the transfer information from slave
+to master. Thus spi controller driver can distinguish the transfer mode(SINGLE
+/DUAL/QUAD) and set the certain controlling register.
+
+
+Members added
+----------------------
+struct spi_device {
++       u8     rx_bitwidth;
++       u8     tx_bitwidth;
+}
+
+struct spi_transfer {
++       u8     bitwidth;
++#define        SPI_BITWIDTH_SINGLE     0x01; /* 1bit transfer */
++#define        SPI_BITWIDTH_DUAL       0x02; /* 2bits transfer */
++#define        SPI_BITWIDTH_QUAD       0x03; /* 4bits transfer */
+}
+
+struct spi_board_info {
++       u8     rx_bitwidth;
++       u8     tx_bitwidth;
+}
+
+
+How to use the added members
+----------------------
+
+DECLARE SLAVE DEVICES
+
+Normally your arch/.../mach-*/board-*.c files would provide a small table
+listing the SPI devices on each board.  Details refered to "spi-summary".
+At the same time, if your slave device support DUAL/QUAD transfer, you can
+set as below:
+
+       static struct spi_board_info spi_board_info[] __initdata = {
+       {
+               .modalias       = "xxxxx",
+               .......
+               .chip_select    = 0,
+               .rx_bitwidth = SPI_BITWIDTH_DUAL,
+               .tx_bitwidth = SPI_BITWIDTH_QUAD,
+       },
+       };
+
+ORGANISE SPI PACKAGE
+
+When your slave is registered by:
+
+       spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+
+rx_bitwidth and tx_bitwidth members will be delivered into "struct spi_device".
+Thus the flash driver can notice the tranfer mode that user has appointed.
+Flash driver receives the data from the uplayer and organise the spi_transfer
+package as below:
+
+       ......
+       struct spi_transfer t[2];
+       struct spi_message m;
+       spi_message_init(&m);
+       memset(t, 0, (sizeof t));
+       ......
+       t[0].rx_buf = buf;
+       t[0].len = len;
+       t[0].bitwidth = spi->rx_bitwidth/spi->tx_bitwidth;
+       spi_message_add_tail(&t[0], &m);
+       ......
+       spi_sync(spi, &m);
+       ......
+
+finally, spi controller driver will deal with the spi_tranfer package.
+Controller driver will pick the bitwidth member out due to which set
the transfer
+mode register.
+
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 5b6b072..1411678 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -354,6 +354,7 @@ static int m25p80_read(struct mtd_info *mtd,
loff_t from, size_t len,

        t[1].rx_buf = buf;
        t[1].len = len;
+       t[1].bitwidth = flash->spi->rx_bitwidth;
        spi_message_add_tail(&t[1], &m);

        mutex_lock(&flash->lock);
@@ -409,6 +410,7 @@ static int m25p80_write(struct mtd_info *mtd,
loff_t to, size_t len,
        spi_message_add_tail(&t[0], &m);

        t[1].tx_buf = buf;
+       t[1].bitwidth = flash->spi->tx_bitwidth;
        spi_message_add_tail(&t[1], &m);

        mutex_lock(&flash->lock);
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

--
1.7.9.5

Best regards
