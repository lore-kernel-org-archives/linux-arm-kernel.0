From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Nov 2015 15:29:43 +0000
Subject: [PATCH v2 1/5] spi: introduce mmap read support for spi flash
 devices
In-Reply-To: <563B4BB0.9020206@ti.com>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
 <1446545174-14193-2-git-send-email-vigneshr@ti.com>
 <20151104143915.GI1717@sirena.org.uk> <563B4BB0.9020206@ti.com>
Message-ID: <20151105152943.GP18409@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 05:59:36PM +0530, Vignesh R wrote:
> On 11/04/2015 08:09 PM, Mark Brown wrote:

> > It's a bit worrying that this doesn't sync with the message queue except
> > via the mutex: this means that we might be out of order with respect to
> > any asynchronous transfers that are happening on the device.  I'm not
> > sure that this is a practical problem, though there is some risk of
> > unfair scheduling that would have to be under extreme load and it might
> > make sense to prioritise reads anyway.

> Since mmap interface is used only by mtd flash drivers and since almost
> all mtd flash devices use synchronous transfers (spi_sync()), IMO, there
> wont be out of order problem wrt mtd flashes.
> But mmap read might delay transfers queued for non mtd flash devices. It
> is difficult to wait for all transfers already queued to be pumped out
> by __spi_pump_messages() and then do the mmap transfer. Do you have any
> thoughts on how to sync with message queue?

Like I say I think it probably doesn't matter.  The main issue would be
with other devices sharing the bus with a flash chip.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151105/322f9a50/attachment.sig>
