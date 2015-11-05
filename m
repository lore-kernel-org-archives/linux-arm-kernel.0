From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Nov 2015 09:34:22 +0100
Subject: [PATCH v3 1/7] spi: imx: Fix DMA transfer
In-Reply-To: <1446388901-6073-2-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1446388901-6073-2-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <20151105083422.GH8526@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 01, 2015 at 03:41:35PM +0100, Anton Bondarenko wrote:
> From: Anton Bondarenko <anton_bondarenko@mentor.com>
> 
> RX DMA tail data handling doesn't work correctly in many cases with
> current implementation. It happens because SPI core was setup
> to generates both RX watermark level and RX DATA TAIL events
> incorrectly. SPI transfer triggering for DMA also done in wrong way.
> 
> SPI client wants to transfer 70 words for example. The old DMA
> implementation setup RX DATA TAIL equal 6 words. In this case
> RX DMA event will be generated after 6 words read from RX FIFO.
> The garbage can be read out from RX FIFO because SPI HW does
> not receive all required words to trigger RX watermark event.
> 
> New implementation change handling of RX data tail. DMA is used to process
> all TX data and only full chunks of RX data with size aligned to FIFO/2.
> Driver is waiting until both TX and RX DMA transaction done and all
> TX data are pushed out. At that moment there is only RX data tail in
> the RX FIFO. This data read out using PIO.

Have you looked at the RX_DMA_LENGTH and RXTDEN fields of the DMA
register? These seem to be for handling the remaining bytes of a DMA
transfer which do not reach the watermark level. From reading the
documentation I haven't really understood how it works though.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
