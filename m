From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 20 Jul 2010 01:53:41 +0200
Subject: [spi-devel-general] [PATCH 2/2] SPI: make the moved loopback test
	work
In-Reply-To: <377310.49674.qm@web180311.mail.gq1.yahoo.com>
References: <AANLkTikfwTxZ4iMaveddXLd1Z2phF0hVi_yG7A2wUNCo@mail.gmail.com>
	<377310.49674.qm@web180311.mail.gq1.yahoo.com>
Message-ID: <AANLkTinm_bvpcQogsTgVy5ZX1MFajVvDxBtVJ056sTyq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/19 David Brownell <david-b@pacbell.net>:

> A dedicated loopback test is the wrong model,
> given that SPI_LOOP exists. ?And is even used
> in the sample userspace code ...

Hm looking over and grepping everywhere about this gives
me no clues as to how an in-kernel SPI loopback test could
use spi->mode |= SPI_LOOP. It can be set, and then it expects
the hardware to set the corresponding bit.

No matter how much I look at it, it seems like all use of this
require you to first register *some* device, whether real or
not, then you may play with it from kernelspace or userspace
alike.

So for a generic loopback in-kernel test I would need
something like:

loop over all masters
  for each master
    if it supports SPI_LOOP
      look for devices on master - make sure first device is a
      loopback dummy
      locate loopback dummy
      perform loopback test on the dummy

This means I still would have to register some dummychip
on the devices that should be able to run the test.

Anton, any hints on this, execept that you added it for
spidev?

I'll try to dream some use model up otherwise.

Yours,
Linus Walleij
