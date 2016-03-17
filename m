From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 17 Mar 2016 08:59:11 +0100
Subject: [PATCH] spi: imx: only do necessary changes to ECSPIx_CONFIGREG
In-Reply-To: <1458048276-31884-1-git-send-email-dirk.behme@de.bosch.com>
References: <1458048276-31884-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20160317075911.GV30994@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 02:24:36PM +0100, Dirk Behme wrote:
> From: Knut Wohlrab <knut.wohlrab@de.bosch.com>
> 
> If the SPI chip select (CS) for a dedicated channel is done manually by
> the used higher device driver, the CS may be active while writing to
> ECSPIx_CONFIGREG. To prevent unwanted clock edges when selecting
> the clock mode,  only do the necessary changes to the i.MX SPI
> configuration register and leave not selected channels untouched.
> 
> To prevent unwanted clock edges on first use, an empty dummy
> transmission shall be done by the initialization procedure of the device
> driver of this channel. This will set the clock mode to the correct state.

The patch does the right thing, so:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Only the above sentence is not clear to me. By device driver you mean
the SPI slave driver (flash, PMIC), right? Isn't this what
bitbang->setup_transfer(spi, NULL), called from spi_bitbang_setup() already
does? spi_bitbang_setup should be called while adding a new SPI slave
device and the setup_transfer with an empty message should setup the
config register correctly without involing the slave device driver.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
