From: jon.nettleton@gmail.com (Jon Nettleton)
Date: Mon, 15 Jun 2015 18:33:17 +0200
Subject: [BUG?] crypto: caam: little/big endianness on ARM vs PPC
In-Reply-To: <20150615155907.GC7947@pengutronix.de>
References: <20150615155907.GC7947@pengutronix.de>
Message-ID: <CALHpu34FHKTHr-2TZ-6Tmctev3WjBVTKfDbr6TYOJiOt+yDvfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15, 2015 at 5:59 PM, Steffen Trumtrar
<s.trumtrar@pengutronix.de> wrote:
> Hi!
>
> I'm working on CAAM support for the ARM-based i.MX6 SoCs. The current
> drivers/crypto/caam driver only works for PowerPC AFAIK.
> Actually, there isn't that much to do, to get support for the i.MX6 but
> one patch breaks the driver severely:
>
>         commit ef94b1d834aace7101de77c3a7c2631b9ae9c5f6
>         crypto: caam - Add definition of rd/wr_reg64 for little endian platform
>
> This patch adds
>
> +#ifdef __LITTLE_ENDIAN
> +static inline void wr_reg64(u64 __iomem *reg, u64 data)
> +{
> +       wr_reg32((u32 __iomem *)reg + 1, (data & 0xffffffff00000000ull) >> 32);
> +       wr_reg32((u32 __iomem *)reg, data & 0x00000000ffffffffull);
> +}
>
> The wr_reg64 function is only used in one place in the drivers/crypto/caam/jr.c
> driver: to write the dma_addr_t to the register. Without that patch everything
> works fine on ARM (little endian, 32bit), with that patch the driver will write
> 0's into the register that holds the DMA address (the numerically-higher) -> kernel hangs.
> Also, from my understanding, the comment above the defines, stating that you
> have to first write the numerically-lower and then the numerically-higher address
> on 32bit systems doesn't match with the implementation.
>
> What I don't know/understand is if this makes any sense for any PowerPC implementation.
>
> So, the question is, how to fix this? I'd prefer to do it directly in the jr driver
> instead of the ifdef-ery.
>
> Something like
>         if (sizeof(dma_addr_t) == sizeof(u32))
>                 wr_reg32(&jrp->rregs->inpring_base + 1, inpbusaddr);
>         else if (sizeof(dma_addr_t) == sizeof(u64))
>                 wr_reg64(...)
>
> or just go by DT compatible and then remove the inline function definitions.
>
> As far as I can tell, the compatible wouldn't be needed for anything else in the
> jr driver, so maybe that is not optimal. On the other hand the sizeof(..)
> solution would only catch little endian on 32bit and not big endian (?!)
> I however don't know what combinations actually *have* to be caught, as I don't
> know, which exist.
>
> So, what do you think people?

Funny enough I tackled this problem over the weekend as well.  My
approach was to switch the driver over to use the *_relaxed() io
functions and then special case the bits missing from the various
ARCHs.  Basically adding setbits32 and clrbits32 for !PPC
architectures and letting PPC and ARM share a writeq/readq set of
functions.  I left the existing LITTLE_ENDIAN special case until I
could verify if it was needed, or had been tested.

For reference, the patch against 4.1-rc5/6 is attached.

-Jon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-crypto-caam-use-generic-_relaxed-io-functions.patch
Type: application/octet-stream
Size: 14156 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150615/de0b9a37/attachment-0001.obj>
