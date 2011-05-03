From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 3 May 2011 09:04:14 +0100
Subject: MMC and reliable write - was: since when does ARM map the kernel
	memory in sections?
In-Reply-To: <BANLkTimMvGfkmcXKrM=vtFNGqdoUJpqwcw@mail.gmail.com>
References: <201104122052.17453.pwaechtler@mac.com>
	<201104262100.42670.pwaechtler@mac.com>
	<20110426190719.GA5832@shareable.org>
	<201104262238.02979.pwaechtler@mac.com>
	<20110426224546.GC5832@shareable.org>
	<BANLkTimTsBARiHmbY37bA6oahacs7zbORA@mail.gmail.com>
	<20110427130719.GE5832@shareable.org>
	<BANLkTimMvGfkmcXKrM=vtFNGqdoUJpqwcw@mail.gmail.com>
Message-ID: <20110503080414.GH5832@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrei Warkentin wrote:
> >> b) how do we make sure to not wind up with data corruption and MMCs
> >> for work loads where you know power can be removed at any moment?
> >
> >> We could always turn on reliable writes (not good perf wise). We could
> >> turn on reliable writes for a particular range (enhanced user
> >> partition). ?We could also turn on reliable writes for a specific
> >> hardware partition.
> >
> > It might have to be simply a mount option - let the user decide their
> > priorities.
> 
> So basically add a new REQ_ flag - something like REQ_SAFE, which
> would ensure that data
> on block storage is not corrupted due to interrupting this write (or
> even, after the write, if the card does some optimizations). We
> already have a flag that ensures corruptions don't occur
> because of local-to-disk caches - REQ_FUA, so this would just thinking
> about what effects REQ_FUA  already has that's not considered. On a
> (spinning) disk, I can't image that interrupting a REQ_FUA write would
> cause data loss somewhere other than where data was written.
> 
> Then it would be as simple as a mount flag that would ensure all
> (write) accesses are FUA accesses, to ensure desired behavior for
> platforms where power could be cut at any moment.

I think you're mixing up different concepts.

On a spinning hard disk, _all_ writes don't cause data loss other than
where data is written, rounded up to the sector (512 or 4096 bytes).

The FUA flag doesn't make any difference to this.

Storage durability doesn't depend on FUA.  It makes no difference
except to performance - on disks without FUA support (like my laptop),
filesystems just issue more cache flush commands.  Or you can also
disable the write cache, the effect of which varies between hardly
noticable and awfully slow, depending on the disk.

(Some RAIDs may violate both these principles.  It depends how they
are implemented.  I'm not clear on where Linux software RAID sits with
this.)

So don't think of FUA as having any connection with reliability or
durability.  It's just an optional performance optimisation.

I don't think REQ_SAFE is a useful name for the MMC option as it doesn't
appear to be safe, if later non-reliable writes can randomly clobber
the REQ_SAFE data.

As it has been explained so far, I don't see how filesystems can take
advantage of the reliable/unreliable write distinction, without more
precise constraints on what that means.  So I don't think there's any
point in filesystems issuing both types of request, unless those more
precise constraints appear somewhere.

Hence the idea of making it a block device/partition flag.  Similar to
the way hdparm is used to manage a hard disk's "write cache enabled"
bit, there could be a "mmc use reliable writes" bit, a "mmc has
reliable writes" read-only bit, and a "mmc hard partition is reliable"
bit which may or may not be writable.

If it later emerges that filesystems can benefit from the
distinction, add a REQ_ flag at that time.  Even then, filesystems
may need to know the MMC's hard partition mode, in order to make useful
decisions.

-- Jamie
