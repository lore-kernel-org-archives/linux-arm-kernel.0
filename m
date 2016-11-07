From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 07 Nov 2016 16:41:58 +0100
Subject: [PATCH RFC 1/7] dma: pl08x: Add support for the DMA slave map
In-Reply-To: <201611050026.49560.arnd@arndb.de>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <1478276094-19135-3-git-send-email-s.nawrocki@samsung.com>
 <CGME20161104232724epcas3p38fcd78acf5b35aead87273edf8682693@epcas3p3.samsung.com>
 <201611050026.49560.arnd@arndb.de>
Message-ID: <3d10d013-b18c-e10e-b596-d4d0f8b6e973@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2016 12:26 AM, Arnd Bergmann wrote:
> On Friday 04 November 2016, Sylwester Nawrocki wrote:
>> +       } else {
>> +               pl08x->slave.filter.map = pl08x->pd->slave_map;
>> +               pl08x->slave.filter.mapcnt = pl08x->pd->slave_map_len;
>>         }
> 
> I think you miss the setup of the filter function here.

Oops, indeed, there was little chance it could work without that part.

> Filtering by string in this driver is a bit awkward, so I wonder if we
> might want to go one step further here and pass the actual data (i.e. 
> struct pl08x_channel_data) rather than the string here.

Yeah, it didn't look to me terribly elegant too. Then a change as below?

--------------8<-------------------
diff --git a/arch/arm/mach-s3c64xx/pl080.c b/arch/arm/mach-s3c64xx/pl080.c
index 8c88680..556ce74 100644
--- a/arch/arm/mach-s3c64xx/pl080.c
+++ b/arch/arm/mach-s3c64xx/pl080.c
@@ -118,22 +118,22 @@ static void pl08x_put_xfer_signal(const struct
pl08x_channel_data *cd, int ch)
 };

 static const struct dma_slave_map s3c64xx_dma0_slave_map[] = {
-       { "s3c6400-uart.0", "tx", (void *)"uart0_tx" },
-       { "s3c6400-uart.0", "rx", (void *)"uart0_rx" },
-       { "s3c6400-uart.1", "tx", (void *)"uart1_tx" },
-       { "s3c6400-uart.1", "rx", (void *)"uart1_rx" },
-       { "s3c6400-uart.2", "tx", (void *)"uart2_tx" },
-       { "s3c6400-uart.2", "rx", (void *)"uart2_rx" },
-       { "s3c6400-uart.3", "tx", (void *)"uart3_tx" },
-       { "s3c6400-uart.3", "rx", (void *)"uart3_rx" },
-       { "samsung-pcm.0", "tx", (void *)"pcm0_tx" },
-       { "samsung-pcm.0", "rx", (void *)"pcm0_rx" },
-       { "samsung-i2s.0", "tx", (void *)"i2s0_tx" },
-       { "samsung-i2s.0", "rx", (void *)"i2s0_rx" },
-       { "s3c6410-spi.0", "tx", (void *)"spi0_tx" },
-       { "s3c6410-spi.0", "rx", (void *)"spi0_rx" },
-       { "samsung-i2s.2", "tx", (void *)"i2s2_tx" },
-       { "samsung-i2s.2", "rx", (void *)"i2s2_rx" },
+       { "s3c6400-uart.0", "tx", (void *)&s3c64xx_dma0_info[0] },
+       { "s3c6400-uart.0", "rx", (void *)&s3c64xx_dma0_info[1] },
+       { "s3c6400-uart.1", "tx", (void *)&s3c64xx_dma0_info[2] },
+       { "s3c6400-uart.1", "rx", (void *)&s3c64xx_dma0_info[3] },
+       { "s3c6400-uart.2", "tx", (void *)&s3c64xx_dma0_info[4] },
+       { "s3c6400-uart.2", "rx", (void *)&s3c64xx_dma0_info[5] },
+       { "s3c6400-uart.3", "tx", (void *)&s3c64xx_dma0_info[6] },
+       { "s3c6400-uart.3", "rx", (void *)&s3c64xx_dma0_info[7] },
+       { "samsung-pcm.0", "tx", (void *)&s3c64xx_dma0_info[8] },
+       { "samsung-pcm.0", "rx", (void *)&s3c64xx_dma0_info[9] },
+       { "samsung-i2s.0", "tx", (void *)&s3c64xx_dma0_info[10] },
+       { "samsung-i2s.0", "rx", (void *)&s3c64xx_dma0_info[11] },
+       { "s3c6410-spi.0", "tx", (void *)&s3c64xx_dma0_info[12] },
+       { "s3c6410-spi.0", "rx", (void *)&s3c64xx_dma0_info[13] },
+       { "samsung-i2s.2", "tx", (void *)&s3c64xx_dma0_info[14] },
+       { "samsung-i2s.2", "rx", (void *)&s3c64xx_dma0_info[15] },
 };

@@ -229,12 +229,12 @@ static AMBA_AHB_DEVICE(s3c64xx_dma0, "dma-pl080s.0", 0,
 };

 static const struct dma_slave_map s3c64xx_dma1_slave_map[] = {
-       { "samsung-pcm.1", "tx", (void *)"pcm1_tx" },
-       { "samsung-pcm.1", "rx", (void *)"pcm1_rx" },
-       { "samsung-i2s.1", "tx", (void *)"i2s1_tx" },
-       { "samsung-i2s.1", "rx", (void *)"i2s1_rx" },
-       { "s3c6410-spi.1", "tx", (void *)"spi1_tx" },
-       { "s3c6410-spi.1", "rx", (void *)"spi1_rx" },
+       { "samsung-pcm.1", "tx", (void *)&s3c64xx_dma1_info[0] },
+       { "samsung-pcm.1", "rx", (void *)&s3c64xx_dma1_info[1] },
+       { "samsung-i2s.1", "tx", (void *)&s3c64xx_dma1_info[2] },
+       { "samsung-i2s.1", "rx", (void *)&s3c64xx_dma1_info[3] },
+       { "s3c6410-spi.1", "tx", (void *)&s3c64xx_dma1_info[4] },
+       { "s3c6410-spi.1", "rx", (void *)&s3c64xx_dma1_info[5] },
 };

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index d5c75c8..0d1eb2e 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1793,6 +1793,23 @@ bool pl08x_filter_id(struct dma_chan *chan, void *chan_id)
 }
 EXPORT_SYMBOL_GPL(pl08x_filter_id);

+static bool pl08x_filter_fn(struct dma_chan *chan, void *chan_id)
+{
+       struct pl08x_dma_chan *plchan;
+
+       /* Reject channels for devices not bound to this driver */
+       if (chan->device->dev->driver != &pl08x_amba_driver.drv)
+               return false;
+
+       plchan = to_pl08x_chan(chan);
+
+       /* Check that the channel is not taken! */
+       if (plchan->cd == chan_id)
+               return true;
+
+       return false;
+}
+
 /*
  * Just check that the device is there and active
  * TODO: turn this bit on/off depending on the number of physical channels
@@ -2310,6 +2327,7 @@ static int pl08x_probe(struct amba_device *adev, const
struct amba_id *id)
        } else {
                pl08x->slave.filter.map = pl08x->pd->slave_map;
                pl08x->slave.filter.mapcnt = pl08x->pd->slave_map_len;
+               pl08x->slave.filter.fn = pl08x_filter_fn;
        }

        /* By default, AHB1 only.  If dualmaster, from platform */

-------------->8-------------------

-- 
Thanks,
Sylwester
