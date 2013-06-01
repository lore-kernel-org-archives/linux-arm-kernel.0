From: broonie@kernel.org (Mark Brown)
Date: Sat, 1 Jun 2013 20:27:26 +0100
Subject: [PATCH 05/11] spi: omap2-mcspi: enhance pinctrl support
In-Reply-To: <1369995191-20855-6-git-send-email-gururaja.hebbar@ti.com>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
 <1369995191-20855-6-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20130601192726.GS16790@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 03:43:05PM +0530, Hebbar Gururaja wrote:
> Amend the spi omap controller to optionally take a pin control
> handle and set the state of the pins to:
> 
> - "default" on boot, resume and before performing an spi transfer
> - "idle" after initial default, after resume default, and after each
> spi xfer
> - "sleep" on suspend()

Looking at this code I can't really see what's OMAP-specific about it -
exactly the same flow should apply to pretty much any SPI controller,
especially given that the code will happily ignore missing states.
We're just setting the idle state when not actively transferring data
which seems sensible and generic.

This suggests to me that we should be adding this code into the core,
probably joined up with the transfer_one_message stuff, so that any
hardware which has an idle state will be able to get the benefit.  Can
anyone think of a reason why we shouldn't do that?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130601/7602bb88/attachment.sig>
