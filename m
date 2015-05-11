From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 May 2015 18:21:26 +0200
Subject: [PATCH v2 04/13] musb: Do not use musb_read[b|w] / _write[b|w]
 wrappers in generic fifo functions
In-Reply-To: <20150511155846.GH19476@saruman.tx.rr.com>
References: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
 <1426878682-14521-5-git-send-email-hdegoede@redhat.com>
 <20150511155846.GH19476@saruman.tx.rr.com>
Message-ID: <23713585.ok6F49RAiY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 May 2015 10:58:46 Felipe Balbi wrote:
> On Fri, Mar 20, 2015 at 08:11:13PM +0100, Hans de Goede wrote:
> > The generic fifo functions already use non wrapped accesses in various
> > cases through the iowrite#_rep functions, and all platforms which override
> > the default musb_read[b|w] / _write[b|w] functions also provide their own
> > fifo access functions, so we can safely drop the unnecessary indirection
> > from the fifo access functions.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/usb/musb/musb_core.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> > index 01ed3a6..016b5b9 100644
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> > @@ -313,7 +313,7 @@ static void musb_default_write_fifo(struct musb_hw_ep *hw_ep, u16 len,
> >                               index += len & ~0x03;
> >                       }
> >                       if (len & 0x02) {
> > -                             musb_writew(fifo, 0, *(u16 *)&src[index]);
> > +                             __raw_writew(*(u16 *)&src[index], fifo);
> 
> not all architectures provide __raw_* accessors, right ?
> 
> 

They do, but you shouldn't use them for MMIO registers normall because of
endianess concerns.

However, FIFOs are special, and I'd assume that the code before this patch
does not work on big-endian systems on which musb_writew is defined
as a little-endian accessor (writew, writew_relaxed, or iowrite16).

The reason is that a FIFO generally exposes bytes in streaming order,
so the first byte in the FIFO has to be copied from a memory buffer
first, while writew would do a byte swap here that is used for MMIO.

This should be reflected in the changelog, and possibly tested with a
big-endian kernel, but the patch looks correct to me.

	Arnd
