From: broonie@kernel.org (Mark Brown)
Date: Sat, 18 Apr 2015 13:09:26 +0100
Subject: [PATCH v3] spi: bitbang: only toggle bitchanges
In-Reply-To: <1428922770-16955-1-git-send-email-m.grzeschik@pengutronix.de>
References: <20150331202306.GX2869@sirena.org.uk>
 <1428922770-16955-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20150418120926.GL26185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 12:59:30PM +0200, Michael Grzeschik wrote:
> The current implementation of bitbang_txrx_be_cpha0 and
> bitbang_txrx_be_cpha1 always call setmosi. That runs into several
> unnecessary calls into the gpiolib when the level of the GPIO actually
> has not to be changed.
> 
> This patch changes the routines to remember the last GPIO level
> and only calls setmosi if an change has to be made. This
> way it improves the transfer throughput.

Do you have any benchmarking or anything showing that this offers a
practical benefit?  Generally a bitbanging system would be using memory
mapped GPIOs for the bus so we're talking about replacing a memory
access with some shifts and logic operations here and while I can
believe that something that runs in cache is going to be an overall win
over going out to a device it's not quite so clear cut as it could be.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150418/1e85d2d5/attachment.sig>
