From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 21 Sep 2012 09:54:31 +0200
Subject: [PATCH] spi/imx: set the inactive state of the clock according
 to the clock polarity
In-Reply-To: <505C1913.1090004@de.bosch.com>
References: <1346403311-25080-1-git-send-email-dirk.behme@de.bosch.com>
 <20120831023518.GE7726@r65073-Latitude-D630>
 <505C1913.1090004@de.bosch.com>
Message-ID: <20120921075431.GS5525@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 09:36:51AM +0200, Dirk Behme wrote:
> On 31.08.2012 04:35, Shawn Guo wrote:
> >Copy Uwe ...
Copy our kernel mailing list ...

> Ping ;)
> 
> Any opinions on this?
Assuming it fixes access to a device I'm ok with your patch, but I don't
really feel responsible for the driver (i.e. me not acking shouldn't
have a negative influence on getting the patch in).

> >On Fri, Aug 31, 2012 at 10:55:11AM +0200, Dirk Behme wrote:
> >>From: Knut Wohlrab <knut.wohlrab@de.bosch.com>
> >>
> >>There are SPI devices which need a SPI clock with active low polarity and
> >>high inactive state.
> >>
> >>Add the setting of the inactive state ECSPIx_CONFIGREG:SCLK CTL
> >>according to the clock polarity ECSPIx_CONFIGREG:SCLK POL:
> >>
> >>DT without "spi-cpol" = 0 = clock active high polarity = inactive state low
> >>DT with    "spi-cpol" = 1 = clock active low  polarity = inactive state high
> >>
> >>Signed-off-by: Knut Wohlrab <knut.wohlrab@de.bosch.com>
If you forward a patch you must add your S-o-b.

> >>---
> >>
> >>Question: Are there real world examples for a need of an individual setting of
> >>clock polarity/inactive state?
> >
> >I'm less concerned about that.  We can always patch the driver when
> >the real world example occurs?
yes.

Thanks
Uwe

> >> drivers/spi/spi-imx.c |    6 ++++--
> >> 1 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> >>index e834ff8..d64655b 100644
> >>--- a/drivers/spi/spi-imx.c
> >>+++ b/drivers/spi/spi-imx.c
> >>@@ -197,6 +197,7 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
> >> #define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
> >> #define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
> >> #define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
> >>+#define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs) + 20))
> >> #define MX51_ECSPI_INT		0x10
> >> #define MX51_ECSPI_INT_TEEN		(1 <<  0)
> >>@@ -287,9 +288,10 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
> >> 	if (config->mode & SPI_CPHA)
> >> 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
> >>-	if (config->mode & SPI_CPOL)
> >>+	if (config->mode & SPI_CPOL) {
> >> 		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
> >>-
> >>+		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
> >>+	}
> >> 	if (config->mode & SPI_CS_HIGH)
> >> 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
> >>-- 
> >>1.7.0.4
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
