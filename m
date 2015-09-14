From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Sep 2015 19:35:53 +0100
Subject: [PATCH 1/5] spi: introduce mmap read support for spi flash devices
In-Reply-To: <CAD6G_RT8Q+Uyp1ZjzHf54Tno1wHm0SmLKEwRAe2gkdp772FD9A@mail.gmail.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-2-git-send-email-vigneshr@ti.com>
 <CAD6G_RT8Q+Uyp1ZjzHf54Tno1wHm0SmLKEwRAe2gkdp772FD9A@mail.gmail.com>
Message-ID: <20150914183553.GE12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 04:55:33PM +0530, Jagan Teki wrote:
> On 4 September 2015 at 13:59, Vignesh R <vigneshr@ti.com> wrote:

> > + * @spi_mtd_mmap_read: some spi-controller hardwares provide memory
> > + *                     mapped interface to communicate with mtd flashes.
> > + *                     For this, spi  controller needs to know flash
> > + *                     memory settings like read command to use, dummy
> > + *                     bytes and address width. Once these settings are
> > + *                     populated in hardware registers, any read
> > + *                     accesses to flash's memory map region(as defined
> > + *                     by SoC) through memcpy or mem-to-mem DMA copy
> > + *                     will be handled by controller hardware. The
> > + *                     hardware will automatically generate spi signals
> > + *                     required to read data from flash and present it
> > + *                     to CPU or DMA. SPI master drivers can use this
> > + *                     callback to implement memory mapped read
> > + *                     interface. Flash driver (like m25p80) requests
> > + *                     memory mapped read via this method. The interface
> > + *                     should  only be used mtd flashes and cannot be
> > + *                     used with other spi devices.

This comment is *way* too verbose - probably you just need up to the
"Once" here.

> > +       int (*spi_mtd_mmap_read)(struct  spi_device *spi,
> > +                                loff_t from, size_t len, size_t *retlen,
> > +                                u_char *buf, u8 read_opcode,
> > +                                u8 addr_width, u8 dummy_bytes);

> This looks un-manageable to know spi core or master knows what are the
> command or opcode used by spi-nor flash and also I think mmap support
> seems to be flash related or any justification this is spi bus
> master/controller feature?

There seem to be a reasonable number of SPI controllers out there which
have as an extension the ability to do memory mapped reads but are
otherwise perfectly normal SPI controllers and which rely on that for
everything except reads.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150914/27e372eb/attachment.sig>
