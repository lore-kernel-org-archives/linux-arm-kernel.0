From: andi.shyti@samsung.com (Andi Shyti)
Date: Mon, 27 Jun 2016 19:57:16 +0900
Subject: [PATCH 1/5] spi: do not fail if the CS line is not connected
In-Reply-To: <20160626124843.GP28202@sirena.org.uk>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
 <1466150245-2648-2-git-send-email-andi.shyti@samsung.com>
 <20160617104725.GC26099@sirena.org.uk> <20160617113622.GA10760@jack.zhora.eu>
 <20160617122803.GN26099@sirena.org.uk> <20160619060902.GB424@jack.zhora.eu>
 <CGME20160626124853epcas1p297070a25da8980f1d8d2f025c65cbdab@epcas1p2.samsung.com>
 <20160626124843.GP28202@sirena.org.uk>
Message-ID: <20160627105716.GA7240@samsunx.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> > > > This is true, but there are cases where the CS is not connected
> > > > and this case needs to be treated separately to allow the device
> > > > to work.
> 
> > > In what way?  It is just as easy for a device with no physical chip
> > > select to have a logical chip select of 0 that it does nothing with as
> > > it is for that device to handle any other number.
> 
> > That is indeed my case: the s3c64xx doesn't send anything, unless
> > I manually enable CS (from the next patches I need to write '0'
> > in the CS register). But I need smoething to tell to the
> > device that the CS line is not connected, for example a flag in
> > the DTS.
> 
> I'm sorry but I just don't understand what you're saying here.  You are
> saying that there is no chip select but you need to enable the chip
> select?

yes, sorry, I have to admit that didn't explain myself properly,
but code speaks better than words.

What I meant is that if we do not like num-cs = <0>, the
unlinked CS line can be handled only this way (case of the
s3c64xx driver):



diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 6dbdeb3..62f19b6 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -40,6 +40,9 @@ Optional Board Specific Properties:
 
 - cs-gpios: should specify GPIOs used for chipselects (see spi-bus.txt)
 
+- broken-cs: the CS line is disconnected, therefore the device should not wait
+  for the CS protocol to be established
+
 SPI Controller specific data in SPI slave nodes:
 
 - The spi slave nodes should provide the following information which is required
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 972367d..5e6ad59 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -315,6 +315,9 @@ static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
        struct s3c64xx_spi_driver_data *sdd =
                                        spi_master_get_devdata(spi->master);
 
+       if (sdd->cntrlr_info->broken_cs)
+               return;
+
        if (enable) {
                if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO)) {
                        writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);

[ ... ]

@@ -1015,6 +1020,8 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
                sci->num_cs = temp;
        }
 
+       sci->broken_cs = of_property_read_bool(dev->of_node, "broken-cs");
+
        return sci;
 }
 #else
diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index fb5625b..75793b9 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -38,6 +38,7 @@ struct s3c64xx_spi_csinfo {
 struct s3c64xx_spi_info {
        int src_clk_nr;
        int num_cs;
+       bool broken_cs;
        int (*cfg_gpio)(void);
        dma_filter_fn filter;
        void *dma_tx;



Which is not something I like, because it means adding a new
flag in the dts.

What I want to suggest, instead, is to slightly change the logic
behind the num-cs property: i.e. if "num-cs = <0>", doesn't
necessarily mean that we don't have a CS controller, but, while
we can have as many as we wish, non of them is connected.

Looking around in the spi drivers, apparently I am not the only
one who has this need, as I pointed out in my previous mail.

Thanks a lot,
Andi
