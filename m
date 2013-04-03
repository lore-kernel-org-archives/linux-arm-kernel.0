From: marex@denx.de (Marek Vasut)
Date: Wed, 3 Apr 2013 04:27:41 +0200
Subject: [PATCH V2 08/12] spi/mxs: Fix race in setup method
In-Reply-To: <CA+7tXigasUbSRD6hQH66m6XsDkzS9ubLSB24f4akB3pv9xrT=A@mail.gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
 <201304030131.37782.marex@denx.de>
 <CA+7tXigasUbSRD6hQH66m6XsDkzS9ubLSB24f4akB3pv9xrT=A@mail.gmail.com>
Message-ID: <201304030427.41297.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Trent Piepho,

> On Tue, Apr 2, 2013 at 4:31 PM, Marek Vasut <marex@denx.de> wrote:
> >>  static int mxs_spi_setup(struct spi_device *dev)
> >>  {
> >> 
> >> -     int err = 0;
> >> -
> >> 
> >>       if (!dev->bits_per_word)
> >>       
> >>               dev->bits_per_word = 8;
> >>       
> >>       if (dev->mode & ~(SPI_CPOL | SPI_CPHA))
> >>       
> >>               return -EINVAL;
> >> 
> >> -     err = mxs_spi_setup_transfer(dev, NULL);
> >> -     if (err) {
> >> -             dev_err(&dev->dev,
> >> -                     "Failed to setup transfer, error = %d\n", err);
> >> -     }
> >> +     if (dev->bits_per_word != 8)
> >> +             return -EINVAL;
> > 
> > What's this new addition doing here?
> 
> It's not new.

It is new in the context of this patch and it's not described in the commit 
message.

> The only useful thing mxs_spi_setup_transfer() (which
> is no longer called) did in this instance was make that check.
> 
> > btw. I was under the impression the MXS SSP block can handle other
> > word-widths than 8 bit, no ?
> 
> In theory it can,

In practice too ;-)

> however the driver only supports 8-bits and will
> reject anything else.

Then please at least add a comment about this.

Best regards,
Marek Vasut
