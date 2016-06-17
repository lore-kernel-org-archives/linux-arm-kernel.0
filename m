From: broonie@kernel.org (Mark Brown)
Date: Fri, 17 Jun 2016 13:28:03 +0100
Subject: [PATCH 1/5] spi: do not fail if the CS line is not connected
In-Reply-To: <20160617113622.GA10760@jack.zhora.eu>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
 <1466150245-2648-2-git-send-email-andi.shyti@samsung.com>
 <20160617104725.GC26099@sirena.org.uk>
 <20160617113622.GA10760@jack.zhora.eu>
Message-ID: <20160617122803.GN26099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 08:36:22PM +0900, Andi Shyti wrote:

> > > In this case do not fail and defer to the SPI device drivers the
> > > responsibility to check whether the num-cs is '0'.

> > A SPI controller always has one chip seelct, it may not be controllable
> > but it's at least logically present.

> This is true, but there are cases where the CS is not connected
> and this case needs to be treated separately to allow the device
> to work.

In what way?  It is just as easy for a device with no physical chip
select to have a logical chip select of 0 that it does nothing with as
it is for that device to handle any other number.

> This is the case of:

> ./drivers/spi/spi-mpc52xx-psc.c:391: master->num_chipselect = 255;
> ./drivers/spi/spi-oc-tiny.c:256:        master->num_chipselect = 255;

> ./drivers/spi/spi-pxa2xx-pci.c:64:              .num_chipselect = -1,
> ./drivers/spi/spi-bcm2835aux.c:436:     master->num_chipselect = -1;

These need fixing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160617/04fd2797/attachment.sig>
