From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Nov 2014 15:11:40 +0000
Subject: [PATCH 2/3] spi: meson: Add support for Amlogic Meson SPIFC
In-Reply-To: <20141109225650.GA27950@gmail.com>
References: <1415525113-25598-1-git-send-email-b.galvani@gmail.com>
 <1415525113-25598-3-git-send-email-b.galvani@gmail.com>
 <20141109101712.GM2722@sirena.org.uk>
 <20141109225650.GA27950@gmail.com>
Message-ID: <20141110151140.GA3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 09, 2014 at 11:56:50PM +0100, Beniamino Galvani wrote:
> On Sun, Nov 09, 2014 at 10:17:12AM +0000, Mark Brown wrote:

> > This will busy wait for up to a second, that seems like a long time to
> > busy wait.  We also appear to be using this for the entire duration of
> > the transfer which could be a fairly long time even during normal
> > operation if doing a large transfer such as a firmware download, or if
> > the bus speed is low.

> Yes, probably the timeout value is too long since the maximum length
> of a basic transfer is 64 bytes. Can you suggest a reasonable value?

10ms?  It depends somewhat 

> > > +	while (done < xfer->len && !ret) {
> > > +		len = min_t(int, xfer->len - done, SPIFC_BUFFER_SIZE);
> > > +		ret = meson_spifc_txrx(spifc, xfer, done, len,
> > > +				       last_xfer, done + len >= xfer->len);
> > > +		done += len;
> > > +	}

> > I noticed that the handling of /CS was done in the spifc_txrx() function
> > - will this do the right thing if the transfer needs to be split for the
> > buffer size?

> It should. When the transfer gets split, CS is kept active for all the
> chunks and the value of CS after that depends on the value of
> cs_change.

Can you be more specific about how that works?  I'm just not seeing the
code that handles this.

> > > +	if (!ret && xfer->delay_usecs)
> > > +		udelay(xfer->delay_usecs);

> > The core will do this for you if you implement this as transfer_one().

> Please correct me if I'm wrong, but I think that transfer_one() can't
> be used in this case. The hardware doesn't support direct manipulation
> of CS and allows only to specify if CS must be kept active after the
> current transfer. So I need to know for each transfer if it's the last
> and this can be achieved only implementing transfer_one_message().

This is already in a function that's operating at the transfer_one()
level, the function is even called transfer_one() and besides it's
clearly not something specific to this hardware so should be factored
out into the core instead of open coded.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/08202a63/attachment.sig>
