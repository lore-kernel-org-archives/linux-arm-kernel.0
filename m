From: hramrach@gmail.com (Michal Suchanek)
Date: Tue, 31 May 2016 13:52:20 +0200
Subject: [linux-sunxi] [PATCH 1/5] spi: sunxi: fix transfer timeout
In-Reply-To: <20160530112350.GI29837@sirena.org.uk>
References: <cover.1464130597.git.hramrach@gmail.com>
 <cb90b922caa6ac07c1425d726ea19709ee5284f4.1464130597.git.hramrach@gmail.com>
 <CAGRGNgWDrVHG26umTSHHAxFC3KXjwmpDejBAfKqvuik0_2-Jcw@mail.gmail.com>
 <CAOMqctS0AD6rHGt3wjxxyidee=_5xqby95t5TGuozAA12DdPjQ@mail.gmail.com>
 <CAGRGNgW=UnmwwiREV+nVcws6sk18-4fKz3qf-WKf4LY9-VqBKg@mail.gmail.com>
 <20160530112350.GI29837@sirena.org.uk>
Message-ID: <CAOMqctQqJaKBA++yiniroEcTjWCMD5WT7CpVjTYBmLzGcB2vYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

On 30 May 2016 at 13:23, Mark Brown <broonie@kernel.org> wrote:
> On Fri, May 27, 2016 at 03:10:11PM +1000, Julian Calaby wrote:
>> On Fri, May 27, 2016 at 3:05 PM, Michal Suchanek <hramrach@gmail.com> wrote:
>
>> >> Also, should the changes for the drivers be in two separate patches also?
>
>> > That's basically the same driver with different constants so I guess not.
>
>> Fair enough, I withdraw my comment then.
>
> If it's the same driver with different constants it should really
> actually be the same driver - I did ask this when the drivers were
> originally merged...

There are some slight differences and the constants really are
different for each driver.

You would need a register remap adaptation layer and a few qirks for
each revision of the driver.

It's certainly possible to merge them but I am not sure if that gives
easier to maintain code.

On the other hand, comparing the drivers there is different comment
anout clock calculation arithmetic and the code is the same :S

Thanks

Michal

--- spi-sun4i.c    2016-05-31 13:19:27.076510421 +0200
+++ spi-sun6i.c    2016-05-31 13:26:58.123580382 +0200
@@ -19,65 +19,72 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>

 #include <linux/spi/spi.h>

-#define SUNXI_FIFO_DEPTH            64
+#define SUNXI_FIFO_DEPTH            128

-#define SUNXI_RXDATA_REG            0x00
+#define SUNXI_TXDATA_REG            0x200

-#define SUNXI_TXDATA_REG            0x04
+#define SUNXI_RXDATA_REG            0x300

 #define SUNXI_TFR_CTL_REG            0x08
-#define SUNXI_TFR_CTL_ENABLE            BIT(0)
-#define SUNXI_TFR_CTL_MASTER            BIT(1)
-#define SUNXI_TFR_CTL_CPHA            BIT(2)
-#define SUNXI_TFR_CTL_CPOL            BIT(3)
-#define SUNXI_TFR_CTL_CS_ACTIVE_LOW        BIT(4)
-#define SUNXI_TFR_CTL_LMTF            BIT(6)
-#define SUNXI_TFR_CTL_TF_RST            BIT(8)
-#define SUNXI_TFR_CTL_RF_RST            BIT(9)
-#define SUNXI_TFR_CTL_XCH            BIT(10)
-#define SUNXI_TFR_CTL_CS_MASK            0x3000
-#define SUNXI_TFR_CTL_CS(cs)            (((cs) << 12) & SUNXI_TFR_CTL_CS_MASK)
-#define SUNXI_TFR_CTL_DHB            BIT(15)
-#define SUNXI_TFR_CTL_CS_MANUAL            BIT(16)
-#define SUNXI_TFR_CTL_CS_LEVEL            BIT(17)
-#define SUNXI_TFR_CTL_TP            BIT(18)
+#define SUNXI_TFR_CTL_CPHA            BIT(0)
+#define SUNXI_TFR_CTL_CPOL            BIT(1)
+#define SUNXI_TFR_CTL_SPOL            BIT(2)
+#define SUNXI_TFR_CTL_CS_MASK            0x30
+#define SUNXI_TFR_CTL_CS(cs)            (((cs) << 4) & SUNXI_TFR_CTL_CS_MASK)
+#define SUNXI_TFR_CTL_CS_MANUAL            BIT(6)
+#define SUNXI_TFR_CTL_CS_LEVEL            BIT(7)
+#define SUNXI_TFR_CTL_DHB            BIT(8)
+#define SUNXI_TFR_CTL_FBS            BIT(12)
+#define SUNXI_TFR_CTL_XCH            BIT(31)

-#define SUNXI_INT_CTL_REG            0x0c
-#define SUNXI_INT_CTL_TC            BIT(16)
+#define SUNXI_INT_CTL_REG            0x10
+#define SUNXI_INT_CTL_RF_OVF            BIT(8)
+#define SUNXI_INT_CTL_TC            BIT(12)

-#define SUNXI_INT_STA_REG            0x10
+#define SUNXI_INT_STA_REG            0x14

-#define SUNXI_DMA_CTL_REG            0x14
+#define SUNXI_FIFO_CTL_REG            0x18
+#define SUNXI_FIFO_CTL_RF_RST            BIT(15)
+#define SUNXI_FIFO_CTL_TF_RST            BIT(31)

-#define SUNXI_CLK_CTL_REG            0x1c
+#define SUNXI_CLK_CTL_REG            0x24
 #define SUNXI_CLK_CTL_CDR2_MASK            0xff
 #define SUNXI_CLK_CTL_CDR2(div)            (((div) &
SUNXI_CLK_CTL_CDR2_MASK) << 0)
 #define SUNXI_CLK_CTL_CDR1_MASK            0xf
 #define SUNXI_CLK_CTL_CDR1(div)            (((div) &
SUNXI_CLK_CTL_CDR1_MASK) << 8)
 #define SUNXI_CLK_CTL_DRS            BIT(12)

-#define SUNXI_BURST_CNT_REG            0x20
+#define SUNXI_BURST_CNT_REG            0x30
 #define SUNXI_BURST_CNT(cnt)            ((cnt) & 0xffffff)

-#define SUNXI_XMIT_CNT_REG            0x24
+#define SUNXI_XMIT_CNT_REG            0x34
 #define SUNXI_XMIT_CNT(cnt)            ((cnt) & 0xffffff)

-#define SUNXI_FIFO_STA_REG            0x28
+#define SUNXI_FIFO_STA_REG            0x1c
 #define SUNXI_FIFO_STA_RF_CNT_MASK        0x7f
 #define SUNXI_FIFO_STA_RF_CNT_BITS        0
 #define SUNXI_FIFO_STA_TF_CNT_MASK        0x7f
 #define SUNXI_FIFO_STA_TF_CNT_BITS        16

-#define SUNXI_WAIT_REG                0x18
+#define SUNXI_BURST_CTL_CNT_REG            0x38
+#define SUNXI_BURST_CTL_CNT_STC(cnt)        ((cnt) & 0xffffff)
+
+#define SUNXI_GBL_CTL_REG            0x04
+#define SUNXI_GBL_CTL_BUS_ENABLE        BIT(0)
+#define SUNXI_GBL_CTL_MASTER            BIT(1)
+#define SUNXI_GBL_CTL_TP            BIT(7)
+#define SUNXI_GBL_CTL_RST            BIT(31)

 struct sunxi_spi {
     struct spi_master    *master;
     void __iomem        *base_addr;
     struct clk        *hclk;
     struct clk        *mclk;
+    struct reset_control    *rstc;

     struct completion    done;

@@ -136,37 +143,18 @@
     u32 reg;

     reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
-
     reg &= ~SUNXI_TFR_CTL_CS_MASK;
     reg |= SUNXI_TFR_CTL_CS(spi->chip_select);

-    /* We want to control the chip select manually */
-    reg |= SUNXI_TFR_CTL_CS_MANUAL;
-
     if (enable)
         reg |= SUNXI_TFR_CTL_CS_LEVEL;
     else
         reg &= ~SUNXI_TFR_CTL_CS_LEVEL;

-    /*
-     * Even though this looks irrelevant since we are supposed to
-     * be controlling the chip select manually, this bit also
-     * controls the levels of the chip select for inactive
-     * devices.
-     *
-     * If we don't set it, the chip select level will go low by
-     * default when the device is idle, which is not really
-     * expected in the common case where the chip select is active
-     * low.
-     */
-    if (spi->mode & SPI_CS_HIGH)
-        reg &= ~SUNXI_TFR_CTL_CS_ACTIVE_LOW;
-    else
-        reg |= SUNXI_TFR_CTL_CS_ACTIVE_LOW;
-
     sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG, reg);
 }

+
 static int sunxi_spi_transfer_one(struct spi_master *master,
                   struct spi_device *spi,
                   struct spi_transfer *tfr)
@@ -189,17 +177,16 @@
     /* Clear pending interrupts */
     sunxi_spi_write(sspi, SUNXI_INT_STA_REG, ~0);

-
-    reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
-
     /* Reset FIFOs */
-    sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
-            reg | SUNXI_TFR_CTL_RF_RST | SUNXI_TFR_CTL_TF_RST);
+    sunxi_spi_write(sspi, SUNXI_FIFO_CTL_REG,
+            SUNXI_FIFO_CTL_RF_RST | SUNXI_FIFO_CTL_TF_RST);

     /*
      * Setup the transfer control register: Chip Select,
      * polarities, etc.
      */
+    reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
+
     if (spi->mode & SPI_CPOL)
         reg |= SUNXI_TFR_CTL_CPOL;
     else
@@ -211,10 +198,9 @@
         reg &= ~SUNXI_TFR_CTL_CPHA;

     if (spi->mode & SPI_LSB_FIRST)
-        reg |= SUNXI_TFR_CTL_LMTF;
+        reg |= SUNXI_TFR_CTL_FBS;
     else
-        reg &= ~SUNXI_TFR_CTL_LMTF;
-
+        reg &= ~SUNXI_TFR_CTL_FBS;

     /*
      * If it's a TX only transfer, we don't want to fill the RX
@@ -225,6 +211,9 @@
     else
         reg |= SUNXI_TFR_CTL_DHB;

+    /* We want to control the chip select manually */
+    reg |= SUNXI_TFR_CTL_CS_MANUAL;
+
     sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG, reg);

     /* Ensure that we have a parent clock fast enough */
@@ -239,7 +228,7 @@
      *
      * We have two choices there. Either we can use the clock
      * divide rate 1, which is calculated thanks to this formula:
-     * SPI_CLK = MOD_CLK / (2 ^ (cdr + 1))
+     * SPI_CLK = MOD_CLK / (2 ^ cdr)
      * Or we can use CDR2, which is calculated with the formula:
      * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
      * Wether we use the former or the latter is set through the
@@ -268,6 +257,8 @@
     /* Setup the counters */
     sunxi_spi_write(sspi, SUNXI_BURST_CNT_REG, SUNXI_BURST_CNT(tfr->len));
     sunxi_spi_write(sspi, SUNXI_XMIT_CNT_REG, SUNXI_XMIT_CNT(tx_len));
+    sunxi_spi_write(sspi, SUNXI_BURST_CTL_CNT_REG,
+            SUNXI_BURST_CTL_CNT_STC(tx_len));

     /* Fill the TX FIFO */
     sunxi_spi_fill_fifo(sspi, SUNXI_FIFO_DEPTH);
@@ -327,11 +318,19 @@
         goto err;
     }

-    sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
-            SUNXI_TFR_CTL_ENABLE | SUNXI_TFR_CTL_MASTER | SUNXI_TFR_CTL_TP);
+    ret = reset_control_deassert(sspi->rstc);
+    if (ret) {
+        dev_err(dev, "Couldn't deassert the device from reset\n");
+        goto err2;
+    }
+
+    sunxi_spi_write(sspi, SUNXI_GBL_CTL_REG,
+            SUNXI_GBL_CTL_BUS_ENABLE | SUNXI_GBL_CTL_MASTER |
SUNXI_GBL_CTL_TP);

     return 0;

+err2:
+    clk_disable_unprepare(sspi->mclk);
 err:
     clk_disable_unprepare(sspi->hclk);
 out:
@@ -343,6 +342,7 @@
     struct spi_master *master = dev_get_drvdata(dev);
     struct sunxi_spi *sspi = spi_master_get_devdata(master);

+    reset_control_assert(sspi->rstc);
     clk_disable_unprepare(sspi->mclk);
     clk_disable_unprepare(sspi->hclk);

@@ -411,6 +411,13 @@

     init_completion(&sspi->done);

+    sspi->rstc = devm_reset_control_get(&pdev->dev, NULL);
+    if (IS_ERR(sspi->rstc)) {
+        dev_err(&pdev->dev, "Couldn't get reset controller\n");
+        ret = PTR_ERR(sspi->rstc);
+        goto err_free_master;
+    }
+
     /*
      * This wake-up/shutdown pattern is to be able to have the
      * device woken up, even if runtime_pm is disabled
@@ -449,7 +456,7 @@
 }

 static const struct of_device_id sunxi_spi_match[] = {
-    { .compatible = "allwinner,sun4i-a10-spi", },
+    { .compatible = "allwinner,sun6i-a31-spi", },
     {}
 };
 MODULE_DEVICE_TABLE(of, sunxi_spi_match);
@@ -472,5 +479,5 @@

 MODULE_AUTHOR("Pan Nan <pannan@allwinnertech.com>");
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
-MODULE_DESCRIPTION("Allwinner A1X/A20 SPI controller driver");
+MODULE_DESCRIPTION("Allwinner A31 SPI controller driver");
 MODULE_LICENSE("GPL");
