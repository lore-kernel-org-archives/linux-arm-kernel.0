From: broonie@kernel.og (Mark Brown)
Date: Tue, 12 Jan 2016 01:21:51 +0000
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <20160111234337.GF28292@lunn.ch>
References: <1440159857.19360.50.camel@debian.org>
 <20150905210846.GF6040@lunn.ch>
 <CAKzmTe0Bq8itvKoOTwZ+ZjY5pTqFYWt0-ihO4jn0qew_NYGhFg@mail.gmail.com>
 <20151011153548.GA9808@lunn.ch>
 <20160111230059.GA12286@jirafa.cyrius.com>
 <20160111232231.GS6588@sirena.org.uk>
 <20160111234337.GF28292@lunn.ch>
Message-ID: <20160112012151.GU6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 12:43:37AM +0100, Andrew Lunn wrote:

> I've done a little testing. What appears to happen is that while the
> cat file > /dev/mtdblockX is going on, all access to filesystems on
> SATA are blocked. I set off a "find ." and it busily prints
> filenames. But as soon as i start the cat, it grinds to a halt, and
> only continues once the cat has finished.

> My guess is that the locking behaviour has changed somehow. SPI or MTD
> is now holding onto a lock so preventing other filesystems making
> progress? Maybe before this change the lock was release and grabbed every
> message?

It's not likely to be the SPI core - it has nothing to do with
filesystems or SATA and the workload being presented to it isn't going
to have changed (that workload generally being single threaded one
message at a time for MTD so SPI will go idle between operations).  What
that commit does is avoid needless context switches before and after we
hand things off to the SPI driver so like I said in the other mail most
likely either the SPI driver is being very rude somehow, the scheduler
isn't coping or some combination of the two.  My guess is that you'd
always have been able to trigger these issues if you did a sufficiently
large flash read at once, or had sufficiently many simultaneous flash
operations going on in parallel to create a queue.

Guessing this is the spi-orion driver it looks like it's busy waiting
for the full transfer, doing register I/O interspersed with udelay()
calls for delays up to 2ms in between words.  That's never going to be
terribly friendly to other users though I don't know if the hardware
allows us to do much better.  

I would expect the scheduler to let the SATA subsystem use the CPU but
it's possible all the register I/O is getting in the way here or the
timeouts are too short.  If it is this then some schedule() calls in the
inner loop for the driver might help (eg, in _wait_till_ready() or
_write_read()), or do the schedule() or even insert artificial sleeps
into the driver at the end of _transfer_one() to simulate previous
behaviour (that'd hurt throughput for other users though).  You could
also artificially slow down the userspace program that accesses the
flash, that seems really undesirable though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160112/3ce6816c/attachment.sig>
