From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 19 Apr 2011 01:43:01 +0100
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <07919bf9-f05f-ca1c-c084-c4ee18a9dc58@me.com>
References: <20110418135243.GB1479@ucw.cz>
	<07919bf9-f05f-ca1c-c084-c4ee18a9dc58@me.com>
Message-ID: <20110419004301.GS16019@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Waechtler wrote:
> Hmh,
> 
> I'm not 100% sure, but a lot of people made good experience with JFFS2.
> 
> Is it that hard to get a log structured file system power fail safe?
> Either the end or "commit" block was written or not?

Yes, it's very hard, maybe impossible, on the types of flash media
being discussed,

For a useful filesystem, it's not enough to know that a single
"commit" block is written or not.  The hard part is when the media
writes things out of order, so at the next mount, even though you
confirm the last "commit" is valid, any earlier blocks might not be
valid.  The only way to be sure of the last coherent state that you
still have, is to read everything, and even then a valid filesystem
where random files have acquired holes they didn't have before is not
very useful.

A purely log structured filesystem should at least look like a valid
filesystem after power failure and reboot, but:

- I am not sure that JFFS2 is purely log structured any more, with the
  compact summary information in each block about what's written
  elsewhere in the block.  That's not reliable on media where you
  can't guarantee anything about the order of writes.  If the summary
  information were ignored, it would be reliable, but slower to read.

- A valid filesystem, and valid files on it are a bit different.
  fsync needs to work for applications to have some sanity in what
  they can depend on.  JFFS2 is fine with that on NOR/NAND directly,
  but if the media doesn't guarantee order of writes...

- Write disturb effects, where writing something corrupts data stored
  elsewhere, in other blocks that the filesystem thought was stable.

- On some media, blocks far apart are less likely to disturb each
  other (for example some RAIDs), but not on flash translation media
  where the physical layout and logical layout may be completely
  different.

- Read disturb effects, where reading triggers flash reorganisation
  too, and then you pull the power while the flash is writing
  internally to reorganise, and on the next boot something's gone
  missing that was stable before.

All the problems are avoidable on devices designed to avoid them.
Problem is devices aren't sold on the basis of these
characteristics, and it's not something the next layer up can
workaround reliably, though it might be able to be more robust.

-- Jamie
