From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 26 Apr 2011 23:58:18 +0100
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <BANLkTi=Zn+kDfErZN6tm6yxHTt4v6o7XNw@mail.gmail.com>
References: <201104122052.17453.pwaechtler@mac.com>
	<BANLkTin0NMo7ZDrnTmBghYeRC9wxJu7zrw@mail.gmail.com>
	<20110412203303.GA16019@shareable.org>
	<20110418135243.GB1479@ucw.cz>
	<20110418170752.GQ16019@shareable.org>
	<20110422154344.GA7526@ucw.cz>
	<BANLkTimZZEr8fqXbuBjpYxF1quBFv7Oihg@mail.gmail.com>
	<BANLkTikNqO_xGgsUrZ2fid4ZmA8P6AoHLA@mail.gmail.com>
	<BANLkTi=Zn+kDfErZN6tm6yxHTt4v6o7XNw@mail.gmail.com>
Message-ID: <20110426225818.GD5832@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrei Warkentin wrote:
> Hi Per,
> 
> On Tue, Apr 26, 2011 at 5:33 AM, Per Forlin <per.forlin@linaro.org> wrote:
> > On 23 April 2011 11:23, Linus Walleij <linus.walleij@linaro.org> wrote:
> >> 2011/4/22 Pavel Machek <pavel@ucw.cz>:
> >>
> >>> Plus, I was told new MMC standard has "write reliable" option...
> >>
> >> I think Per F?rlin looked into reliable write. The latest eMMC cards
> >> has this, but OTOMH it was too darn slow to be used on current
> >> chips/"cards".
> >>
> >> Per, Sebastian: any details?
> > I had plans to add reliable writes and do benchmarking but I never got
> > to it. Right now I have no plans to pick it up.
> >
> >>
> 
> Reliable writes are in mmc-next already. As an improvement to that
> path, I have a CMD23-bounded request support patch set which is
> pending.
> 
> Reliable writes are exposed via REQ_FUA.

Are you sure that's appropriate?

Unless I have misunderstood (very possible), REQ_FUA means writes hit
non-volatile storage before acknowledgement, not that they are atomic.
I think the normal users of REQ_FUA don't require or expect large
atomic writes; they use it as a shortcut for (write & flush this
write) without implying anything else is flushed.

> Keep in mind that flash cards don't have a volatile cache, so once an
> MMC transaction goes through the data is in flash.

Does that not mean MMC already provides REQ_FUA semantics on every
transactions?

I don't know much about MMC, but the problems reported with other
flash devices are either volatile cache (so may not apply to
conformant MMCs), or random corruption of data that was supposed to be
stored long ago, even data quite far from the locations being written
at the time, because the flash is presumably reorganising itself.
There are even reports of data loss resulting from power removal while
reading.

> All reliable writes guarantee is flash state if an MMC transaction
> is interrupted in the middle. Additionally, the "new" reliable write
> (as opposed to legacy) is even less useful, since it only provides
> that guarantee at a sector boundary.

Perhaps the sector bondary limitation makes it faster and/or limits
the amount of buffer required, and/or allows the device to accept
larger write transactions.  Which is good if it means reliability
doesn't get switched off or faked.  Or perhaps it's just to align, a
little, with perceived behaviour of hard disks.

Hard disks don't guarantee large atomic writes as far as I know, so
filesystems & databases generally don't assume it, and it's not really
a problem.  Some people say you can rely on a single 512-byte sector
being atomically updated or not on a hard disk, but some don't; I'm
siding with the latter.  (SQLite has a storage flag you can set if you
know the storage has that property, to tweak its commit strategy.)

-- Jamie
