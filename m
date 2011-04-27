From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 27 Apr 2011 14:07:19 +0100
Subject: MMC and reliable write - was: since when does ARM map the kernel
	memory in sections?
In-Reply-To: <BANLkTimTsBARiHmbY37bA6oahacs7zbORA@mail.gmail.com>
References: <201104122052.17453.pwaechtler@mac.com>
	<201104262100.42670.pwaechtler@mac.com>
	<20110426190719.GA5832@shareable.org>
	<201104262238.02979.pwaechtler@mac.com>
	<20110426224546.GC5832@shareable.org>
	<BANLkTimTsBARiHmbY37bA6oahacs7zbORA@mail.gmail.com>
Message-ID: <20110427130719.GE5832@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrei Warkentin wrote:
> I think this basically says - don't end up with corrupt flash if I
> pull the power when doing this MMC transaction.
> If you pull power during a regular write, you could end up with ALL
> erase units affected being wiped.
> 
> Note, that the new definition of reliable writes provides a guarantee
> to a sector boundary. So if you interrupt
> the transaction, you will end up with [new data] followed by [old
> data]. The old definition guaranteed the entire range,
> but the transaction was only reliable when done over a sector or erase unit.

The old definition might not have been implemented in practice, or
might have caused performance problems -- or maybe it just wasn't that
useful, because it's so different from what hard-disk-like filesystems
expect of a block device.

> This means I jumped the gun on implementing REQ_FUA as reliable write,
> as REQ_FUA says nothing about atomicity.
> OTOH, I don't think anything in the block layer expects massive data
> corruption on power loss. In my defence, I saw REQ_FUA
> as being "prevent data corruption during power loss", hence the
> reliable write via REQ_FUA in mmc layer.
> 
> So my question -
> a) how should reliable writes be handled?

If your understanding is this:

   - "Reliable Write" only affects the range being written

   - "Normal Write" can corrupt ANY random part of the flash
     (because you don't know where the physical erase blocks are, or
     what reorganising it might provoke.)

Then the answer's pretty clear.
You have to use "Reliable Write" for everything.

> REQ_META?

No, that's a scheduling hint; you can't assume filesystems
consistently label "metadata needed for filesystem integrity" with
that flag.  (And databases and VMs have similar needs, but don't get
to choose REQ_ flags).

But even if they did, wouldn't a single normal write, from the above
description, potentially corrupt all previously written metadata
anyway, making it pointless?

> b) how do we make sure to not wind up with data corruption and MMCs
> for work loads where you know power can be removed at any moment?

> We could always turn on reliable writes (not good perf wise). We could
> turn on reliable writes for a particular range (enhanced user
> partition).  We could also turn on reliable writes for a specific
> hardware partition. 

It might have to be simply a mount option - let the user decide their
priorities.

What's "enhanced user partition" -- is it a device feature?

> We could even create mapping layer that will occasionally atomically
> flush data to flash, while the actual fs accesses go to RAM.

So using "Reliable Write" all the time, and using a flash-optimised
filesystem (MTD-style like jffs2, ubifs, logfs) to group the writes
consecutively into sensible block sizes?

I guess if the first small "Reliable Write" is quite slow, and a
flash-optimised filesystem that performs write-behind just like disk
filesystems, then will be plenty more data records queued up for
writing after it, automatically making the write sizes increase to
match the media's speed.  Add a little "anticipatory scheduling" perhaps.

I presume "Reliable Write" must be to a contiguous range of the MMC's
logical block presentation?

-- Jamie
