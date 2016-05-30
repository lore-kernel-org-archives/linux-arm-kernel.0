From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 May 2016 16:03:43 +0100
Subject: [PATCH 5/5] RFC spi: sun4i: add DMA support
In-Reply-To: <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
 <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
 <20160530112610.GJ29837@sirena.org.uk>
 <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
Message-ID: <20160530150343.GL29837@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 02:11:51PM +0200, Geert Uytterhoeven wrote:
> On Mon, May 30, 2016 at 1:26 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, May 26, 2016 at 07:25:25PM -0000, Michal Suchanek wrote:
> >>  - fallback to previous behaviour when DMA initialization fails
> >>
> >>    + this has the problem that when the driver happens to load before the dma
> >>      driver it will not use dma - can be addressed with a module parameter

> > No, you should pay attention to the error you are getting and let probe
> > deferral happen if that's the error you get.

> Unfortunately DMA is an optional feature.

> There's no way to distinguish between -EPROBE_DEFER due to the SPI master
> driver being probed before the DMA engine driver, and -EPROBE_DEFER due to
> support for the DMA engine not having been compiled in.

I really don't think it's worth caring too much about cases where the
DMA driver hasn't been compiled in, it's not like SPI is the only thing
that's going to be using it.  I really think it's better to defer the
problem - not getting DMA (or worse, only getting DMA on some boots) is
not great and if people are optimising on that level my feeling is that
they're probably going to be OK with customizing DT to match.  Ideally
we would have something a bit nicer than deferred probe but right now
this seems the more helpful option.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160530/7e494196/attachment.sig>
