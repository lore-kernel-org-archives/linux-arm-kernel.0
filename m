From: wangyuhang2014@gmail.com (=?GB2312?B?zfXT7rq9?=)
Date: Thu, 4 Jul 2013 15:07:31 +0800
Subject: SPI : DUAL/QUAD support
Message-ID: <CAHSAbzMGqQgCLL9ymQ6qSeJRybv2jJfm-sbzZVgayVyKYgufLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Now some SPI controllers and Slave Devices have supported
DUAL and QUAD transfer mode. But SPI controller driver in kernel
has no member to deliver this information from Slave to Master.
So in my opinion, adding transfer mode members to deal with the problem.

In my SPI system, slave device is a Nor-Flash chip(s25fl129p) which
use m25p80 driver. My patch below aims to make spi controller know
the way that the slave want.

Firstly user provides the SPI slave information into spi_board_info,
including tx_bitwidth and rx_bitwidth. When the SPI slave is registered,
information in spi_board_info is delivered to spi_device. Then SPI slave
driver will add the transfer mode information into the spi_tranfer package
and send it out to SPI controller driver. SPI controller driver will
analyse the transfer package and set the certain transfer mode to
its register.

This patch do not support device tree....


Signed-off-by: wangyuhang <wangyuhang2014@gmail.com>
---
 drivers/mtd/devices/m25p80.c |    2 ++
 drivers/spi/spi.c            |    2 ++
 include/linux/spi/spi.h      |    8 ++++++++
 3 files changed, 12 insertions(+)

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
Jay
