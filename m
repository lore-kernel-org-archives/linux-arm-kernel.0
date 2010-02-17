From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 17 Feb 2010 19:26:00 +0100
Subject: PL-330 DMA driver
In-Reply-To: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
References: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
Message-ID: <63386a3d1002171026h51f34d4buc9ba0293ea08c004@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/2/17 jassi brar <jassisinghbrar@gmail.com>:

> Could maintainers please suggest what is the best place for the PL330
> controller driver?

drivers/dma/amba-pl033.c would be my bet.

I have patches to support MMCI (PL180/PL181) using the generic DMA
engine pending, I will attempt to submit patches for spi/amba-pl022.c and
serial/amba-pl011.c when I get the time.

In drivers/dma/coh901318.c we found that implementing a generic
DMA engine over some random custom DMA controller is actually
quite straight forward. If you're making it custom I think seriously
you're doing something wrong.

The key to making the DMA controller wholly abstract is to configure
the driver with platform data containing information on how to
set up/tear down/refill/etc any DMA channel on the system, so
the DMA engine knows all about all channels, and the driver
using it just knows that it's requesting some rx or tx channel with
some platform filter (all from platform data).

This way replacing the DMA enginge, as in resynthesize your SoC
with some totally different DMA controller, and the driver using it
still works.

There may be DMA controllers so esoteric that they cannot be
handled by DMA engine, what do I know, I haven't seen one
yet.

Linus Walleij
