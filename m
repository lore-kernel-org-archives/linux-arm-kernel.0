From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Sep 2013 11:06:06 +0100
Subject: Clock framework deadlock with external SPI clockchip
In-Reply-To: <20130903232229.10934.60438@quantum>
References: <52209D1D.3080102@metafoo.de> <20130903232229.10934.60438@quantum>
Message-ID: <20130904100606.GU3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 04:22:29PM -0700, Mike Turquette wrote:
> Quoting Lars-Peter Clausen (2013-08-30 06:24:45)

> > === Clock chip driver ===        === SPI master driver ===
> >  clk_prepare_lock()
> >  spi_sync()
> >    wait_for_completion(X)

> Is there a synchronous equivalent to spi_sync()?

spi_sync() is synchronous?  Obviously everything is asynchronous up to
that point but the only way the driver can tell if the I/O completed is
using spi_sync() or the equivalent thereof.

If you're asking if there is a way of doing SPI I/O that isn't multi
threaded then there isn't, in order to keep pushing transfers into the
SPI controller to saturate the bus we have a high priority task to push
more data in.  SPI buses can be quite high bandwidth in some
applications.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130904/e2ce5315/attachment-0001.sig>
